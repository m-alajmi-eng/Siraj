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

     // ── بحث في الآيات ────────────────────────────
     final ayahRes = await _client
         .from('ayahs')
         .select('id, surah_id, ayah_number, text_uthmani, surahs(name_arabic)')
         .ilike('text_uthmani', '%$query%')
         .limit(10);

     for (final r in ayahRes) {
       results.add(SearchResult(
         type:       'ayah',
         surahId:    r['surah_id'],
         ayahNumber: r['ayah_number'],
         surahName:  (r['surahs'] as Map?)?['name_arabic'] ?? '',
         text:       r['text_uthmani'] ?? '',
       ));
     }

     // ── بحث في التفاسير ──────────────────────────
     final tafsirRes = await _client
         .from('tafsir')
         .select('ayah_id, text, source_id, ayahs(surah_id, ayah_number, surahs(name_arabic))')
         .ilike('text', '%$query%')
         .eq('source_id', 'muyassar-ar')
         .limit(5);

     for (final r in tafsirRes) {
       final ayah  = r['ayahs'] as Map?;
       final surah = ayah?['surahs'] as Map?;
       results.add(SearchResult(
         type:       'tafsir',
         surahId:    ayah?['surah_id']    ?? 0,
         ayahNumber: ayah?['ayah_number'] ?? 0,
         surahName:  surah?['name_arabic'] ?? '',
         text:       r['text'] ?? '',
         source:     'التفسير الميسّر',
       ));
     }

     // ── بحث في معاني الكلمات ─────────────────────
     final wordRes = await _client
         .from('word_meanings')
         .select('ayah_id, meaning_ar, ayahs(surah_id, ayah_number, surahs(name_arabic))')
         .ilike('meaning_ar', '%$query%')
         .limit(5);

     for (final r in wordRes) {
       final ayah  = r['ayahs'] as Map?;
       final surah = ayah?['surahs'] as Map?;
       results.add(SearchResult(
         type:       'word',
         surahId:    ayah?['surah_id']    ?? 0,
         ayahNumber: ayah?['ayah_number'] ?? 0,
         surahName:  surah?['name_arabic'] ?? '',
         text:       r['meaning_ar'] ?? '',
         source:     'معاني الكلمات',
       ));
     }


     // ── بحث في الأحاديث ──────────────────────
     final hadithRes = await _client
         .from('hadiths')
         .select('hadith_number, text_ar, book_id, hadith_books(name_ar)')
         .ilike('text_ar', '%$query%')
         .limit(5);

     for (final r in hadithRes) {
       final book = r['hadith_books'] as Map?;
       results.add(SearchResult(
         type:       'hadith',
         surahId:    0,
         ayahNumber: r['hadith_number'] ?? 0,
         surahName:  book?['name_ar'] ?? '',
         text:       r['text_ar'] ?? '',
         source:     book?['name_ar'] ?? '',
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