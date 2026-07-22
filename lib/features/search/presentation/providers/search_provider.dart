import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/storage/cache_service.dart';
import '../../../athkar/data/datasources/athkar_local_datasource.dart';
import '../../../quran/data/datasources/quran_remote_datasource.dart';

class SearchResult {
 final String  type; // ayah | tafsir | word | hadith | athkar
 final int     surahId;
 final int     ayahNumber;
 final String  surahName;
 final String  text;
 final String? source;

 SearchResult({
   required this.type,
   required this.surahId,
   required this.ayahNumber,
   required this.surahName,
   required this.text,
   this.source,
 });
}

class SearchState {
 final String             query;
 final List<SearchResult> results;
 final bool               isLoading;
 final String?            error;
 /// أنواع فشلت مصادرها في آخر بحث (عزل لكل مصدر — PHASE L2): نتائج
 /// المصادر الأخرى تبقى ظاهرة، لا فشل كامل بسبب مصدر واحد بطيء/معطَّل.
 final Set<String>        failedTypes;
 /// فلتر نوع محدَّد (null = كل الأنواع).
 final String?            typeFilter;

 const SearchState({
   this.query      = '',
   this.results    = const [],
   this.isLoading  = false,
   this.error,
   this.failedTypes = const {},
   this.typeFilter,
 });

 List<SearchResult> get filteredResults => typeFilter == null
     ? results
     : results.where((r) => r.type == typeFilter).toList();

 SearchState copyWith({
   String?             query,
   List<SearchResult>? results,
   bool?               isLoading,
   String?             error,
   Set<String>?        failedTypes,
   String?             typeFilter,
   bool                clearTypeFilter = false,
 }) => SearchState(
   query:       query       ?? this.query,
   results:     results     ?? this.results,
   isLoading:   isLoading   ?? this.isLoading,
   error:       error,
   failedTypes: failedTypes ?? this.failedTypes,
   typeFilter:  clearTypeFilter ? null : (typeFilter ?? this.typeFilter),
 );
}

class SearchNotifier extends Notifier<SearchState> {
 final _client = Supabase.instance.client;
 Timer? _debounce;
 int _requestId = 0;

 @override
 SearchState build() {
   ref.onDispose(() => _debounce?.cancel());
   return const SearchState();
 }

 /// بحث بـdebounce داخلي 350ms — الواجهة تستدعيه على كل تغيير نص مباشرة
 /// بلا مؤقّت خاص بها، مصدر واحد للحقيقة.
 void search(String query) {
   _debounce?.cancel();
   if (query.trim().isEmpty) {
     state = const SearchState();
     return;
   }

   state = state.copyWith(query: query, isLoading: true, error: null);
   _debounce = Timer(const Duration(milliseconds: 350), () {
     _performSearch(query);
   });
 }

 void setTypeFilter(String? type) {
   state = type == null
       ? state.copyWith(clearTypeFilter: true)
       : state.copyWith(typeFilter: type);
 }

 Future<void> _performSearch(String query) async {
   final requestId = ++_requestId;

   try {
     // كل مصدر معزول بـtry/catch خاص به (PHASE L2) — فشل واحد لا يُسقط
     // البحث كله، بخلاف try/catch واحد يلفّ الاستدعاءات الأربعة سابقاً.
     final results = await Future.wait([
       _searchAyahs(query),
       _searchTafsir(query),
       _searchWords(query),
       _searchHadiths(query),
       _searchAthkar(query),
     ]);

     // تجاهل نتيجة طلب قديم إن كتب المستخدم استعلاماً جديداً أثناء الانتظار.
     if (requestId != _requestId) return;

     final failed = <String>{};
     for (final r in results) {
       if (r.failed) failed.add(r.type);
     }

     state = state.copyWith(
       isLoading: false,
       results: results.expand((r) => r.items).toList(),
       failedTypes: failed,
     );
   } catch (e) {
     // شبكة صمام أمان: كل مصدر يعزل أخطاءه بنفسه، فهذا يلتقط فقط عطلاً
     // غير متوقَّع خارج تلك المسارات (نادر جداً) بدل ترك isLoading عالقاً.
     if (requestId != _requestId) return;
     state = state.copyWith(isLoading: false, error: e.toString());
   }
 }

 Future<_SourceResult> _searchAyahs(String query) async {
   try {
     final res = await _client.rpc('search_ayahs', params: {
       'search_query': query,
       'match_limit':  10,
     });
     final items = (res as List).map((r) => SearchResult(
       type:       'ayah',
       surahId:    r['surah_id'],
       ayahNumber: r['ayah_number'],
       surahName:  r['surah_name'] ?? '',
       text:       r['text_uthmani'] ?? '',
     )).toList();
     return _SourceResult('ayah', items, failed: false);
   } catch (_) {
     // احتياطي محلي بلا اتصال (PHASE L2) — تطابق فرعي بسيط، لا يُعتبر
     // فشلاً كاملاً طالما أعاد نتائج فعلية.
     try {
       final ds = QuranRemoteDataSource();
       final localAyahs = await ds.searchLocalAyahs(query, limit: 10);
       final surahs = CacheService.getCachedSurahs();
       String surahName(int id) {
         if (surahs == null) return '';
         final match = surahs.where((s) => s['id'] == id);
         return match.isEmpty ? '' : (match.first['nameArabic'] as String? ?? '');
       }
       final items = localAyahs.map((a) => SearchResult(
         type: 'ayah',
         surahId: a.surahId,
         ayahNumber: a.ayahNumber,
         surahName: surahName(a.surahId),
         text: a.textUthmani,
       )).toList();
       return _SourceResult('ayah', items, failed: items.isEmpty);
     } catch (_) {
       return const _SourceResult('ayah', [], failed: true);
     }
   }
 }

 Future<_SourceResult> _searchTafsir(String query) async {
   try {
     final res = await _client.rpc('search_tafsir', params: {
       'search_query':  query,
       'match_limit':   5,
       'source_filter': 'muyassar-ar',
     });
     final items = (res as List).map((r) => SearchResult(
       type:       'tafsir',
       surahId:    r['surah_id']    ?? 0,
       ayahNumber: r['ayah_number'] ?? 0,
       surahName:  r['surah_name'] ?? '',
       text:       r['tafsir_text'] ?? '',
       source:     'muyassar',
     )).toList();
     return _SourceResult('tafsir', items, failed: false);
   } catch (_) {
     return const _SourceResult('tafsir', [], failed: true);
   }
 }

 Future<_SourceResult> _searchWords(String query) async {
   try {
     final res = await _client.rpc('search_word_meanings', params: {
       'search_query': query,
       'match_limit':  5,
     });
     final items = (res as List).map((r) => SearchResult(
       type:       'word',
       surahId:    r['surah_id']    ?? 0,
       ayahNumber: r['ayah_number'] ?? 0,
       surahName:  r['surah_name'] ?? '',
       text:       r['meaning_ar'] ?? '',
       source:     'word_meanings',
     )).toList();
     return _SourceResult('word', items, failed: false);
   } catch (_) {
     return const _SourceResult('word', [], failed: true);
   }
 }

 Future<_SourceResult> _searchHadiths(String query) async {
   try {
     final res = await _client.rpc('search_hadiths', params: {
       'search_query': query,
       'match_limit':  5,
     });
     final items = (res as List).map((r) => SearchResult(
       type:       'hadith',
       surahId:    0,
       ayahNumber: r['hadith_number'] ?? 0,
       surahName:  r['book_name'] ?? '',
       text:       r['text_ar'] ?? '',
       source:     r['book_name'] ?? '',
     )).toList();
     return _SourceResult('hadith', items, failed: false);
   } catch (_) {
     return const _SourceResult('hadith', [], failed: true);
   }
 }

 /// أذكار محلية (JSON، لا شبكة) — لم تكن مغطاة إطلاقاً في البحث الموحّد
 /// سابقاً (PHASE L2).
 Future<_SourceResult> _searchAthkar(String query) async {
   try {
     final ds = AthkarLocalDataSource();
     final all = await ds.getAll();
     final items = all
         .where((a) => a.arabic.contains(query))
         .take(5)
         .map((a) => SearchResult(
               type: 'athkar',
               surahId: 0,
               ayahNumber: a.id,
               surahName: '',
               text: a.arabic,
               source: a.source,
             ))
         .toList();
     return _SourceResult('athkar', items, failed: false);
   } catch (_) {
     return const _SourceResult('athkar', [], failed: true);
   }
 }

 void clear() {
   _debounce?.cancel();
   state = const SearchState();
 }
}

class _SourceResult {
 final String type;
 final List<SearchResult> items;
 final bool failed;
 const _SourceResult(this.type, this.items, {required this.failed});
}

final searchProvider =
   NotifierProvider<SearchNotifier, SearchState>(() => SearchNotifier());
