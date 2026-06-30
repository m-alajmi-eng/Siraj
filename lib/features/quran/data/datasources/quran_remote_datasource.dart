import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/surah_entity.dart';
import '../../domain/entities/ayah_entity.dart';
import '../../../../core/storage/cache_service.dart';

class QuranRemoteDataSource {
 static const String _baseUrl = 'https://api.alquran.cloud/v1';

 static const Map<String, String> _translationEditions = {
   'en': 'en.sahih',
   'ur': 'ur.jalandhry',
   'fa': 'fa.makarem',
   'id': 'id.indonesian',
   'tr': 'tr.diyanet',
   'fr': 'fr.hamidullah',
   'bn': 'bn.bengali',
   'ms': 'ms.basmeih',
   'ha': 'ha.gumi',
   'sw': 'sw.barwani',
   'de': 'de.bubenheim',
   'ru': 'ru.kuliev',
   'zh': 'zh.jian',
   'es': 'es.garcia',
 };

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

 Future<List<AyahEntity>> getAyahs(int surahId, {String lang = 'ar'}) async {
   final cached = CacheService.getCachedAyahs(surahId, lang: lang);
   if (cached != null) {
     return cached.map((a) => AyahEntity(
       id:          a['id'],
       surahId:     a['surahId'],
       ayahNumber:  a['ayahNumber'],
       textUthmani: a['textUthmani'],
       juz:         a['juz'],
       page:        a['page'],
       translation: a['translation'],
     )).toList();
   }

   final edition = _translationEditions[lang];

   // العربية أو لغة بلا ترجمة: النص العثماني فقط
   if (edition == null) {
     final response = await http.get(
       Uri.parse('$_baseUrl/surah/$surahId/quran-uthmani'));
     if (response.statusCode == 200) {
       final data       = jsonDecode(response.body);
       final List ayahs = data['data']['ayahs'];
       final result     = ayahs.map((a) => AyahEntity(
         id:          a['number'],
         surahId:     surahId,
         ayahNumber:  a['numberInSurah'],
         textUthmani: a['text'],
         juz:         a['juz'],
         page:        a['page'],
       )).toList();
       await _cacheResult(surahId, result, lang);
       return result;
     }
     throw Exception('Failed to load ayahs');
   }

   // لغة بترجمة: نجلب النص + الترجمة معاً
   final response = await http.get(
     Uri.parse('$_baseUrl/surah/$surahId/editions/quran-uthmani,$edition'));
   if (response.statusCode == 200) {
     final data         = jsonDecode(response.body);
     final List editions = data['data'];
     final List arabic  = editions[0]['ayahs'];
     final List trans   = editions[1]['ayahs'];
     final result = <AyahEntity>[];
     for (var i = 0; i < arabic.length; i++) {
       result.add(AyahEntity(
         id:          arabic[i]['number'],
         surahId:     surahId,
         ayahNumber:  arabic[i]['numberInSurah'],
         textUthmani: arabic[i]['text'],
         juz:         arabic[i]['juz'],
         page:        arabic[i]['page'],
         translation: trans[i]['text'],
       ));
     }
     await _cacheResult(surahId, result, lang);
     return result;
   }
   throw Exception('Failed to load ayahs');
 }

 Future<void> _cacheResult(int surahId, List<AyahEntity> result, String lang) async {
   await CacheService.cacheAyahs(surahId, result.map((a) => {
     'id':          a.id,
     'surahId':     a.surahId,
     'ayahNumber':  a.ayahNumber,
     'textUthmani': a.textUthmani,
     'juz':         a.juz,
     'page':        a.page,
     'translation': a.translation,
   }).toList(), lang: lang);
 }

 // جلب التفسير الميسّر من Supabase
 Future<String> getTafsir(int surahId, int ayahNumber) async {
   final cacheKey = 'tafsir_muyassar_${surahId}_$ayahNumber';
   final cached   = CacheService.getSetting(cacheKey);
   if (cached != null) return cached;

   try {
     final client = Supabase.instance.client;

     final ayahRes = await client
         .from('ayahs')
         .select('id')
         .eq('surah_id', surahId)
         .eq('ayah_number', ayahNumber)
         .maybeSingle();

     if (ayahRes == null) throw Exception('آية غير موجودة');
     final ayahId = ayahRes['id'] as int;

     final tafsirRes = await client
         .from('tafsir')
         .select('text')
         .eq('ayah_id', ayahId)
         .eq('source_id', 'muyassar-ar')
         .limit(1);

    if (tafsirRes.isEmpty) throw Exception("تفسير غير موجود");
    final tafsir = tafsirRes[0]["text"] as String;
     await CacheService.saveSetting(cacheKey, tafsir);
     return tafsir;
   } catch (e) {
     print('getTafsir error: $e');
     throw Exception('تعذّر تحميل التفسير: $e');
   }
 }

 // جلب ترجمة آية مفردة (لآية اليوم) — رشيقة: ترجع null عند الفشل
 Future<String?> getAyahTranslation(int surah, int ayah, String lang) async {
   final edition = _translationEditions[lang];
   if (edition == null) return null; // العربية أو لغة بلا ترجمة

   final cacheKey = 'daily_trans_${surah}_${ayah}_$lang';
   final cached   = CacheService.getSetting(cacheKey);
   if (cached != null) return cached as String;

   try {
     final response = await http.get(
       Uri.parse('$_baseUrl/ayah/$surah:$ayah/$edition'));
     if (response.statusCode == 200) {
       final data = jsonDecode(response.body);
       final text = data['data']['text'] as String;
       await CacheService.saveSetting(cacheKey, text);
       return text;
     }
   } catch (_) {}
   return null;
 }

}