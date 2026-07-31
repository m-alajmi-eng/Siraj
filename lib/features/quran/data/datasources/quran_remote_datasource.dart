import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entities/surah_entity.dart';
import '../../domain/entities/ayah_entity.dart';
import '../../../../core/storage/cache_service.dart';

// دوال تفكيك JSON على مستوى الملف (لا داخل الصنف) - compute() يتطلب دالة
// top-level أو static قابلة للإرسال لـIsolate منفصل. القراءة (rootBundle.
// loadString) تبقى في الخيط الرئيسي (I/O غير حاجب فعلياً)، والتفكيك الثقيل
// (jsonDecode) وحده ينتقل للـIsolate - فتفادينا مشاكل قنوات المنصّة
// (platform channels) التي لا تعمل مباشرة داخل Isolates ثانوية بلا تهيئة
// إضافية (BackgroundIsolateBinaryMessenger).
Map<String, dynamic> _parseUthmaniIsolate(String raw) {
  final data = jsonDecode(raw) as Map<String, dynamic>;
  return data['surahs'] as Map<String, dynamic>;
}

Map<String, dynamic> _parseTranslationsIsolate(String raw) {
  final data = jsonDecode(raw) as Map<String, dynamic>;
  return data['translations'] as Map<String, dynamic>;
}

Map<String, dynamic> _parseTafsirIsolate(String raw) {
  final data = jsonDecode(raw) as Map<String, dynamic>;
  return data['tafsir'] as Map<String, dynamic>;
}

class QuranRemoteDataSource {
 static const String _baseUrl = 'https://api.alquran.cloud/v1';

 // ذاكرة تخزين مؤقت في العملية نفسها لملفي القرآن المحليين (يُحمَّلان مرة واحدة)
 static Map<String, dynamic>? _localUthmaniCache;
 static Map<String, dynamic>? _localTranslationsCache;

 static Future<Map<String, dynamic>> _loadLocalUthmani() async {
   if (_localUthmaniCache != null) return _localUthmaniCache!;
   final raw = await rootBundle.loadString('assets/data/quran_uthmani.json');
   _localUthmaniCache = await compute(_parseUthmaniIsolate, raw);
   return _localUthmaniCache!;
 }

 static Future<Map<String, dynamic>> _loadLocalTranslations() async {
   if (_localTranslationsCache != null) return _localTranslationsCache!;
   final raw = await rootBundle.loadString('assets/data/quran_translations.json');
   _localTranslationsCache = await compute(_parseTranslationsIsolate, raw);
   return _localTranslationsCache!;
 }

 static Map<String, dynamic>? _localTafsirCache;

 static Future<Map<String, dynamic>> _loadLocalTafsir() async {
   if (_localTafsirCache != null) return _localTafsirCache!;
   final raw = await rootBundle.loadString('assets/data/quran_tafsir.json');
   _localTafsirCache = await compute(_parseTafsirIsolate, raw);
   return _localTafsirCache!;
 }

 /// يحاول جلب تفسير آية من الأصول المحلية. يرجع null بأمان عند أي
 /// غياب/خلل، ليسقط النداء للمسار القديم (cache ثم Supabase) دون كسر.
 Future<String?> _getTafsirFromLocalAssets(int surahId, int ayahNumber) async {
   try {
     final tafsirSurahs = await _loadLocalTafsir();
     final ayahsList = tafsirSurahs[surahId.toString()] as List?;
     if (ayahsList == null) return null;
     for (final a in ayahsList) {
       final m = Map<String, dynamic>.from(a as Map);
       if (m['n'] == ayahNumber) return m['text'] as String;
     }
     return null;
   } catch (_) {
     return null;
   }
 }

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

 /// يحاول بناء آيات سورة من الأصول المحلية (نص عربي + ترجمة إن وُجدت).
 /// يرجع null بأمان عند أي غياب/خلل في البيانات المحلية، ليسقط النداء
 /// للمسار القديم (cache ثم شبكة) دون أي كسر.
 Future<List<AyahEntity>?> _getAyahsFromLocalAssets(
     int surahId, {String lang = 'ar'}) async {
   try {
     final uthmaniSurahs = await _loadLocalUthmani();
     final arabicList = uthmaniSurahs[surahId.toString()] as List?;
     if (arabicList == null || arabicList.isEmpty) return null;

     // خريطة رقم الآية -> بيانات النص العربي (juz/page/text)
     final arabicByNumber = <int, Map<String, dynamic>>{};
     for (final a in arabicList) {
       final m = Map<String, dynamic>.from(a as Map);
       arabicByNumber[m['n'] as int] = m;
     }

     Map<int, String>? translationByNumber;
     if (lang != 'ar' && _translationEditions.containsKey(lang)) {
       final translations = await _loadLocalTranslations();
       final langData = translations[lang] as Map<String, dynamic>?;
       final transList = langData?[surahId.toString()] as List?;
       if (transList != null) {
         translationByNumber = {
           for (final t in transList)
             (t['n'] as int): (t['text'] as String)
         };
       }
     }

     final result = arabicByNumber.entries.map((entry) {
       final n = entry.key;
       final a = entry.value;
       return AyahEntity(
         id: n, // لا يوجد رقم إجمالي في الملف المحلي، رقم السورة كافٍ للاستخدام الحالي
         surahId: surahId,
         ayahNumber: n,
         textUthmani: a['text'] as String,
         juz: a['juz'] as int,
         page: a['page'] as int,
         translation: translationByNumber?[n],
       );
     }).toList()
       ..sort((a, b) => a.ayahNumber.compareTo(b.ayahNumber));

     return result;
   } catch (_) {
     return null;
   }
 }

 Future<List<AyahEntity>> getAyahs(int surahId, {String lang = 'ar'}) async {
   // المسار المحلي أولاً (ADR-006): لا اعتماد على الشبكة لعرض القرآن
   final local = await _getAyahsFromLocalAssets(surahId, lang: lang);
   if (local != null) return local;

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
 /// يُرجع كل آيات صفحة مصحف معيّنة (1..604) مرتبة، عبر كل السور.
 /// كل عنصر: {surahId, ayahNumber, text, surahName?}. محلي بالكامل.
 Future<List<Map<String, dynamic>>> getPageAyahs(int pageNumber) async {
   final uthmaniSurahs = await _loadLocalUthmani();
   final result = <Map<String, dynamic>>[];
   uthmaniSurahs.forEach((surahIdStr, ayahList) {
     final surahId = int.parse(surahIdStr);
     for (final a in (ayahList as List)) {
       final m = Map<String, dynamic>.from(a as Map);
       if (m['page'] == pageNumber) {
         result.add({
           'surahId': surahId,
           'ayahNumber': m['n'],
           'text': m['text'],
         });
       }
     }
   });
   result.sort((x, y) {
     final s = (x['surahId'] as int).compareTo(y['surahId'] as int);
     if (s != 0) return s;
     return (x['ayahNumber'] as int).compareTo(y['ayahNumber'] as int);
   });
   return result;
 }

 /// بحث نصي محلي مباشر (تطابق فرعي بسيط، بلا تطبيع/tsvector) عبر كل
 /// آيات القرآن من الأصل المحلي — احتياطي عند انقطاع الشبكة أو فشل بحث
 /// Supabase الأساسي (PHASE L2)، لا بديل دائم له (لا يطبّع التشكيل/الهمزات
 /// كما تفعل دالة `search_ayahs` الخادمية).
 Future<List<AyahEntity>> searchLocalAyahs(String query, {int limit = 10}) async {
   final uthmaniSurahs = await _loadLocalUthmani();
   final result = <AyahEntity>[];
   for (final entry in uthmaniSurahs.entries) {
     final surahId = int.parse(entry.key);
     for (final a in (entry.value as List)) {
       final m = Map<String, dynamic>.from(a as Map);
       final text = m['text'] as String;
       if (text.contains(query)) {
         result.add(AyahEntity(
           id: m['n'] as int,
           surahId: surahId,
           ayahNumber: m['n'] as int,
           textUthmani: text,
           juz: m['juz'] as int,
           page: m['page'] as int,
         ));
         if (result.length >= limit) return result;
       }
     }
   }
   return result;
 }

 Future<String> getTafsir(int surahId, int ayahNumber) async {
   // المسار المحلي أولاً (ADR-006): لا اعتماد على Supabase لعرض التفسير
   final local = await _getTafsirFromLocalAssets(surahId, ayahNumber);
   if (local != null) return local;

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
     debugPrint('getTafsir error: $e');
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