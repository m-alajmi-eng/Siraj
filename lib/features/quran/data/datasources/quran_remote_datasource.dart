import 'dart:convert';
import 'package:http/http.dart' as http;
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

  // جلب التفسير لآية واحدة
  Future<String> getTafsir(int surahId, int ayahNumber) async {
    final globalAyah = _getGlobalAyahNumber(surahId, ayahNumber);
    final cacheKey   = 'tafsir_$globalAyah';
    final cached     = CacheService.getSetting(cacheKey);
    if (cached != null) return cached;

    final response = await http.get(
      Uri.parse('$_baseUrl/ayah/$globalAyah/ar.muyassar'));
    if (response.statusCode == 200) {
      final data   = jsonDecode(response.body);
      final tafsir = data['data']['text'] as String;
      await CacheService.saveSetting(cacheKey, tafsir);
      return tafsir;
    }
    throw Exception('Failed to load tafsir');
  }

  int _getGlobalAyahNumber(int surahId, int ayahNumber) {
    const ayahCounts = [
      0,7,286,200,176,120,165,206,75,129,109,123,111,43,52,99,128,111,
      110,98,135,112,78,118,64,77,227,93,88,69,60,34,30,73,54,45,83,
      54,53,92,68,60,52,55,78,96,45,26,47,60,52,82,32,54,84,54,31,
      20,45,33,30,35,25,17,26,30,25,25,27,20,25,25,20,20,28,22,40,
      39,29,27,26,25,23,22,24,24,22,26,29,27,26,25,24,22,23,22,23,
      21,21,23,20,22,22,21,22,21,22,22,21,20,20,20,18,26,14,17,19,
      18,15,19
    ];
    int global = 0;
    for (int i = 1; i < surahId; i++) {
      global += ayahCounts[i];
    }
    return global + ayahNumber;
  }
}