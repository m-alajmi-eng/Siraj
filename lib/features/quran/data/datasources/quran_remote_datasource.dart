import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/surah_entity.dart';
import '../../domain/entities/ayah_entity.dart';
import '../../../../core/storage/cache_service.dart';

class QuranRemoteDataSource {
  static const String _baseUrl = 'https://api.alquran.cloud/v1';

  Future<List<SurahEntity>> getSurahs() async {
    final cached = CacheService.getCachedSurahs();
    if (cached != null) {
      return cached.map((s) => SurahEntity(
        id:                  s['id'],
        nameArabic:          s['nameArabic'],
        nameTransliteration: s['nameTransliteration'],
        nameTranslationEn:   s['nameTranslationEn'],
        revelationType:      s['revelationType'],
        ayahCount:           s['ayahCount'],
      )).toList();
    }

    final response = await http.get(Uri.parse('$_baseUrl/surah'));
    if (response.statusCode == 200) {
      final data        = jsonDecode(response.body);
      final List surahs = data['data'];
      final result      = surahs.map((s) => SurahEntity(
        id:                  s['number'],
        nameArabic:          s['name'],
        nameTransliteration: s['englishName'],
        nameTranslationEn:   s['englishNameTranslation'],
        revelationType:      s['revelationType'],
        ayahCount:           s['numberOfAyahs'],
      )).toList();

      await CacheService.cacheSurahs(result.map((s) => {
        'id':                  s.id,
        'nameArabic':          s.nameArabic,
        'nameTransliteration': s.nameTransliteration,
        'nameTranslationEn':   s.nameTranslationEn,
        'revelationType':      s.revelationType,
        'ayahCount':           s.ayahCount,
      }).toList());

      return result;
    }
    throw Exception('Failed to load surahs');
  }

  Future<List<AyahEntity>> getAyahs(int surahId) async {
    final cached = CacheService.getCachedAyahs(surahId);
    if (cached != null) {
      return cached.map((a) => AyahEntity(
        id:          a['id'],
        surahId:     a['surahId'],
        ayahNumber:  a['ayahNumber'],
        textUthmani: a['textUthmani'],
        juz:         a['juz'],
        page:        a['page'],
      )).toList();
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/surah/$surahId/quran-uthmani'));
    if (response.statusCode == 200) {
      final data        = jsonDecode(response.body);
      final List ayahs  = data['data']['ayahs'];
      final result      = ayahs.map((a) => AyahEntity(
        id:          a['number'],
        surahId:     surahId,
        ayahNumber:  a['numberInSurah'],
        textUthmani: a['text'],
        juz:         a['juz'],
        page:        a['page'],
      )).toList();

      await CacheService.cacheAyahs(surahId, result.map((a) => {
        'id':          a.id,
        'surahId':     a.surahId,
        'ayahNumber':  a.ayahNumber,
        'textUthmani': a.textUthmani,
        'juz':         a.juz,
        'page':        a.page,
      }).toList());

      return result;
    }
    throw Exception('Failed to load ayahs');
  }

  // جلب التفسير الميسّر لآية واحدة من Supabase
  Future<String> getTafsir(int surahId, int ayahNumber) async {
    final cacheKey = 'tafsir_muyassar_${surahId}_$ayahNumber';
    final cached   = CacheService.getSetting(cacheKey);
    if (cached != null) return cached;

    final client = Supabase.instance.client;

    // جلب ayah_id
    final ayahRes = await client
        .from('ayahs')
        .select('id')
        .eq('surah_id', surahId)
        .eq('ayah_number', ayahNumber)
        .single();

    final ayahId = ayahRes['id'] as int;

    // جلب الميسّر
    final tafsirRes = await client
        .from('tafsir')
        .select('text')
        .eq('ayah_id', ayahId)
        .eq('source_id', 'muyassar-ar')
        .single();

    final tafsir = tafsirRes['text'] as String;
    await CacheService.saveSetting(cacheKey, tafsir);
    return tafsir;
  }
}