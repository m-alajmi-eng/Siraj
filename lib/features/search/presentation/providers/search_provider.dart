import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SearchResult {
 final String  type;
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

 const SearchState({
   this.query     = '',
   this.results   = const [],
   this.isLoading = false,
   this.error,
 });

 SearchState copyWith({
   String?             query,
   List<SearchResult>? results,
   bool?               isLoading,
   String?             error,
 }) => SearchState(
   query:     query     ?? this.query,
   results:   results   ?? this.results,
   isLoading: isLoading ?? this.isLoading,
   error:     error,
 );
}

class SearchNotifier extends Notifier<SearchState> {
 final _client = Supabase.instance.client;

 @override
 SearchState build() => const SearchState();

 Future<void> search(String query) async {
   if (query.trim().isEmpty) {
     state = const SearchState();
     return;
   }

   state = state.copyWith(
     query:     query,
     isLoading: true,
     results:   [],
     error:     null,
   );

   try {
     final results = <SearchResult>[];

     // ── بحث نصي كامل عبر PostgreSQL (tsvector + GIN + تطبيع عربي) ──
     // يستبدل ILIKE '%...%' السابق: يتجاهل التشكيل، ويوحّد صور الألف/
     // الهمزة/الياء/التاء المربوطة، ويدعم كلمات جزئية (بادئة) أثناء
     // الكتابة. راجع migration: 20260716101040_arabic_fulltext_search.sql

     // ── بحث في الآيات ────────────────────────────
     final ayahRes = await _client.rpc('search_ayahs', params: {
       'search_query': query,
       'match_limit':  10,
     });

     for (final r in (ayahRes as List)) {
       results.add(SearchResult(
         type:       'ayah',
         surahId:    r['surah_id'],
         ayahNumber: r['ayah_number'],
         surahName:  r['surah_name'] ?? '',
         text:       r['text_uthmani'] ?? '',
       ));
     }

     // ── بحث في التفاسير ──────────────────────────
     final tafsirRes = await _client.rpc('search_tafsir', params: {
       'search_query':  query,
       'match_limit':   5,
       'source_filter': 'muyassar-ar',
     });

     for (final r in (tafsirRes as List)) {
       results.add(SearchResult(
         type:       'tafsir',
         surahId:    r['surah_id']    ?? 0,
         ayahNumber: r['ayah_number'] ?? 0,
         surahName:  r['surah_name'] ?? '',
         text:       r['tafsir_text'] ?? '',
         source:     'التفسير الميسّر',
       ));
     }

     // ── بحث في معاني الكلمات ─────────────────────
     final wordRes = await _client.rpc('search_word_meanings', params: {
       'search_query': query,
       'match_limit':  5,
     });

     for (final r in (wordRes as List)) {
       results.add(SearchResult(
         type:       'word',
         surahId:    r['surah_id']    ?? 0,
         ayahNumber: r['ayah_number'] ?? 0,
         surahName:  r['surah_name'] ?? '',
         text:       r['meaning_ar'] ?? '',
         source:     'معاني الكلمات',
       ));
     }

     // ── بحث في الأحاديث ──────────────────────
     final hadithRes = await _client.rpc('search_hadiths', params: {
       'search_query': query,
       'match_limit':  5,
     });

     for (final r in (hadithRes as List)) {
       results.add(SearchResult(
         type:       'hadith',
         surahId:    0,
         ayahNumber: r['hadith_number'] ?? 0,
         surahName:  r['book_name'] ?? '',
         text:       r['text_ar'] ?? '',
         source:     r['book_name'] ?? '',
       ));
     }

     state = state.copyWith(
       isLoading: false,
       results:   results,
     );

   } catch (e) {
     state = state.copyWith(
       isLoading: false,
       error:     'تعذّر البحث: $e',
     );
   }
 }

 void clear() => state = const SearchState();
}

final searchProvider =
   NotifierProvider<SearchNotifier, SearchState>(() => SearchNotifier());