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
  final List<TafsirEntry> tafsirs;
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
    final wordsRes = await _client
        .from('word_meanings')
        .select('word_position, word_text, meaning_ar, morphology')
        .eq('ayah_id', ayahId)
        .order('word_position');

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