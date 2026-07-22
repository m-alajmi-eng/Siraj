import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// ═══════════════════════════════════════════════════════════
// نماذج البيانات
// ═══════════════════════════════════════════════════════════

class WordMeaning {
  final int    position;
  final String meaningAr;
  final String wordText;
  final String morphology;

  WordMeaning({
    required this.position,
    required this.wordText,
    required this.meaningAr,
    required this.morphology,
  });

  factory WordMeaning.fromJson(Map<String, dynamic> j) => WordMeaning(
    position:   j['word_position'] ?? 0,
    wordText:   j['word_text'] ?? '',
    meaningAr:  j['meaning_ar'] ?? '',
    morphology: j['morphology'] ?? '',
  );
}

class RelatedHadith {
  final int    id;
  final String text;
  final String bookName;
  final int    hadithNumber;

  RelatedHadith({
    required this.id,
    required this.text,
    required this.bookName,
    required this.hadithNumber,
  });

  // ملاحظة: يُبنى من صفوف جدول kg_edges الموحَّد (dst_id يشير لـhadiths.id
  // فعلياً عند edge_type='ayah_hadith') - راجع
  // supabase/migrations/20260716102020_kg_edges_unify_hadith_relations.sql
  factory RelatedHadith.fromJson(Map<String, dynamic> j) {
    final hadith = j['hadiths'] as Map?;
    final book   = hadith?['hadith_books'] as Map?;
    return RelatedHadith(
      id:           j['dst_id'] ?? 0,
      text:         hadith?['text_ar'] ?? '',
      bookName:     book?['name_ar'] ?? '',
      hadithNumber: hadith?['hadith_number'] ?? 0,
    );
  }
}

class AdwaaCitation {
  final int    id;
  final String citationType; // 'authentic_hadith' | 'israiliyyat'
  final String quotedText;
  final String fullParagraph;
  final String sourceReference;
  final String sourceBook;
  final String sourceAuthor;
  final String shamelaUrl;
  final int    shamelaPage;

  AdwaaCitation({
    required this.id,
    required this.citationType,
    required this.quotedText,
    required this.fullParagraph,
    required this.sourceReference,
    required this.sourceBook,
    required this.sourceAuthor,
    required this.shamelaUrl,
    required this.shamelaPage,
  });

  bool get isAuthenticHadith => citationType == 'authentic_hadith';

  // ملاحظة: يُبنى من صفوف جدول kg_edges الموحَّد (edge_type
  // 'authentic_hadith_citation'/'israiliyyat_citation' بدل citation_type
  // الأصلي، وأعمدة citation_* بدل الأسماء القديمة) - راجع
  // supabase/migrations/20260716102020_kg_edges_unify_hadith_relations.sql
  factory AdwaaCitation.fromJson(Map<String, dynamic> j) {
    final edgeType = j['edge_type'] ?? 'authentic_hadith_citation';
    return AdwaaCitation(
      id:              j['id'] ?? 0,
      citationType:    edgeType == 'israiliyyat_citation' ? 'israiliyyat' : 'authentic_hadith',
      quotedText:      j['citation_text'] ?? '',
      fullParagraph:   j['citation_context'] ?? '',
      sourceReference: j['source_reference'] ?? '',
      sourceBook:      j['citation_book'] ?? '',
      sourceAuthor:    j['citation_author'] ?? '',
      shamelaUrl:      j['citation_url'] ?? '',
      shamelaPage:     j['citation_page'] ?? 0,
    );
  }
}

class TafsirEntry {
  final String sourceId;
  final String scholar;
  final String bookTitle;
  final String text;

  TafsirEntry({
    required this.sourceId,
    required this.scholar,
    required this.bookTitle,
    required this.text,
  });
}

class PortalData {
  final int    ayahId;
  final int    surahId;
  final int    ayahNumber;
  final String textUthmani;
  final String surahName;
  final String revelationType;
  final int    ayahCount;
  final List<TafsirEntry>    tafsirs;
  final List<RelatedHadith>  relatedHadiths;
  final List<AdwaaCitation>  adwaaCitations;
  final List<WordMeaning> words;
  final String? asbabAlNuzul;

  PortalData({
    required this.ayahId,
    required this.surahId,
    required this.ayahNumber,
    required this.textUthmani,
    required this.surahName,
    required this.revelationType,
    required this.ayahCount,
    required this.tafsirs,
    required this.relatedHadiths,
    required this.adwaaCitations,
    required this.words,
    this.asbabAlNuzul,
  });
}

// ═══════════════════════════════════════════════════════════
// Repository
// ═══════════════════════════════════════════════════════════

class QkeRepository {
  final SupabaseClient _client = Supabase.instance.client;

  Future<PortalData> getPortal(int surahId, int ayahNumber) async {
    // 1. جلب الآية + السورة
    final ayahRes = await _client
        .from('ayahs')
        .select('id, surah_id, ayah_number, text_uthmani, surahs(name_arabic, revelation_type, ayah_count)')
        .eq('surah_id', surahId)
        .eq('ayah_number', ayahNumber)
        .single();

    final ayahId = ayahRes['id'] as int;

    // 2. التفاسير + مصادرها
    final tafsirRes = await _client
        .from('tafsir')
        .select('source_id, text, tafsir_sources(scholar, book_title)')
        .eq('ayah_id', ayahId);

    final tafsirs = (tafsirRes as List).map((t) {
      final src = t['tafsir_sources'] ?? {};
      return TafsirEntry(
        sourceId:  t['source_id'] ?? '',
        scholar:   src['scholar'] ?? '',
        bookTitle: src['book_title'] ?? '',
        text:      t['text'] ?? '',
      );
    }).toList();

    // ترتيب التفاسير: الميسّر أولاً ثم المختصر ثم الباقي
    tafsirs.sort((a, b) {
      int order(String id) {
        if (id == 'muyassar-ar')  return 0;
        if (id == 'mukhtasar-ar') return 1;
        if (id == 'saadi-ar')     return 2;
        return 3;
      }
      return order(a.sourceId).compareTo(order(b.sourceId));
    });

    // 3. معاني الكلمات
    // postgrest .order() الافتراضي ascending:false (تنازلي) ما لم يُحدَّد
    // صراحة — بدون هذا كانت الكلمات تصل معكوسة (آخر كلمة أولاً).
    final wordsRes = await _client
        .from('word_meanings')
        .select('word_position, word_text, meaning_ar, morphology')
        .eq('ayah_id', ayahId)
        .order('word_position', ascending: true);

    final words = (wordsRes as List)
        .map((w) => WordMeaning.fromJson(w))
        .toList();

    // 4. أسباب النزول (قد لا توجد)
    String? asbab;
    try {
      final asbabRes = await _client
          .from('asbab_al_nuzul')
          .select('event_text')
          .eq('ayah_id', ayahId)
          .limit(1)
          .maybeSingle();
      asbab = asbabRes?['event_text'];
    } catch (_) {}

    final surah = ayahRes['surahs'] ?? {};

      // جلب الأحاديث المرتبطة + استشهادات أضواء البيان معاً من جدول
      // kg_edges الموحَّد (بدل ayah_hadiths وverse_hadith_relations
      // مباشرة) - راجع
      // supabase/migrations/20260716102020_kg_edges_unify_hadith_relations.sql
      // سياسة RLS على kg_edges نفسها تكفل عرض ayah_hadith دوماً
      // واستشهادات أضواء البيان فقط عند reviewed=true (لا حاجة لتكرار
      // شرط reviewed هنا - الاستعلام .eq('reviewed', true) القديم على
      // verse_hadith_relations كان تكراراً دفاعياً لنفس قيد RLS أصلاً).
      List<RelatedHadith> relatedHadiths = [];
      List<AdwaaCitation> adwaaCitations = [];
      try {
        final edgesRes = await _client
            .from('kg_edges')
            .select(
              'id, edge_type, dst_id, source_reference, citation_text, '
              'citation_context, citation_book, citation_author, '
              'citation_url, citation_page, '
              'hadiths(text_ar, hadith_number, hadith_books(name_ar))',
            )
            .eq('src_id', ayahId)
            .eq('src_type', 'ayah')
            .order('id');

        for (final j in (edgesRes as List)) {
          if (j['edge_type'] == 'ayah_hadith') {
            if (relatedHadiths.length < 5) {
              relatedHadiths.add(RelatedHadith.fromJson(j));
            }
          } else {
            adwaaCitations.add(AdwaaCitation.fromJson(j));
          }
        }
      } catch (_) {}

      // جلب تفسير أضواء البيان الكامل لهذه الآية (نطاق صفحات من فهرس
      // الكتاب: من بداية تفسير هذه الآية حتى بداية الآية التالية
      // المفهرَسة، أياً كانت سورتها - سقف أمان 40 صفحة لتفادي نطاقات
      // شاذة نادرة قرب نهاية الكتاب).
      try {
        final tocRes = await _client
            .from('adwaa_al_bayan_toc')
            .select('start_page')
            .eq('surah_id', surahId)
            .eq('ayah_number', ayahNumber)
            .maybeSingle();

        if (tocRes != null) {
          final startPage = tocRes['start_page'] as int;

          final nextRes = await _client
              .from('adwaa_al_bayan_toc')
              .select('start_page')
              .gt('start_page', startPage)
              .order('start_page')
              .limit(1)
              .maybeSingle();

          final rawEndPage = nextRes != null
              ? nextRes['start_page'] as int
              : startPage + 1;
          final endPage = (rawEndPage - startPage > 40)
              ? startPage + 40
              : rawEndPage;

          final pagesRes = await _client
              .from('adwaa_al_bayan_pages')
              .select('page_text')
              .gte('page_number', startPage)
              .lt('page_number', endPage)
              .order('page_number');

          final combinedText = (pagesRes as List)
              .map((p) => p['page_text'] as String)
              .join('\n\n');

          if (combinedText.isNotEmpty) {
            tafsirs.add(TafsirEntry(
              sourceId:  'adwaa-al-bayan-ar',
              scholar:   'محمد الأمين الشنقيطي',
              bookTitle: 'أضواء البيان في إيضاح القرآن بالقرآن',
              text:      combinedText,
            ));
          }
        }
      } catch (_) {}

    return PortalData(
      ayahId:         ayahId,
      surahId:        surahId,
      ayahNumber:     ayahNumber,
      textUthmani:    ayahRes['text_uthmani'] ?? '',
      surahName:      surah['name_arabic'] ?? '',
      revelationType: surah['revelation_type'] ?? '',
      ayahCount:       (surah['ayah_count'] as int?) ?? 0,
      tafsirs:        tafsirs,
      words:          words,
      asbabAlNuzul:   asbab,
      relatedHadiths: relatedHadiths,
      adwaaCitations: adwaaCitations,
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Providers
// ═══════════════════════════════════════════════════════════

final qkeRepositoryProvider = Provider<QkeRepository>((ref) => QkeRepository());

final portalProvider = FutureProvider.family<PortalData, ({int surahId, int ayahNumber})>(
  (ref, params) async {
    final repo = ref.read(qkeRepositoryProvider);
    return repo.getPortal(params.surahId, params.ayahNumber);
  },
);