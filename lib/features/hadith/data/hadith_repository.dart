import 'package:supabase_flutter/supabase_flutter.dart';

/// فئة موضوعية للأحاديث (مثال: الفقه وأصوله، السيرة والتاريخ).
class HadithCategory {
  final int id;
  final String titleAr;
  final int hadeethsCount;

  HadithCategory({
    required this.id,
    required this.titleAr,
    required this.hadeethsCount,
  });

  factory HadithCategory.fromJson(Map<String, dynamic> j) {
    return HadithCategory(
      id: j['id'] as int,
      titleAr: j['title_ar'] as String? ?? '',
      hadeethsCount: j['hadeeths_count'] as int? ?? 0,
    );
  }
}

/// حكم عالِم واحد على الحديث (من عمود grades JSONB - عدة آراء متساوية
/// بلا ترجيح، راجع supabase/migrations/20260909060000_add_hadith_grades_jsonb.sql).
class HadithGrade {
  final String? scholar;
  final String gradeAr;

  HadithGrade({this.scholar, required this.gradeAr});

  factory HadithGrade.fromJson(Map<String, dynamic> j) {
    return HadithGrade(
      scholar: j['scholar'] as String?,
      gradeAr: j['grade_ar'] as String? ?? '',
    );
  }
}

/// آية مرتبطة بالحديث (من kg_edges، edge_type='ayah_hadith') - كافية
/// لعرض معاينة قصيرة والتنقل إلى VersePortalScreen عند الضغط.
class AyahLink {
  final int surahId;
  final int ayahNumber;
  final String surahName;
  final String ayahText;

  AyahLink({
    required this.surahId,
    required this.ayahNumber,
    required this.surahName,
    required this.ayahText,
  });
}

/// حديث واحد كامل (نص، درجة، شرح، تخريج، مراجع، ربط بآية إن وُجد).
class Hadith {
  final int id;
  final String title;
  final String textAr;
  final String? narrator;
  final String? grade;
  final String? explanation;
  final String? bookId;
  final List<HadithGrade>? grades;
  final List<String>? references;
  final AyahLink? linkedAyah;
  // اسم الكتاب/رقم الحديث المعروضان بسياقات تجمع أحاديث من عدة كتب معاً
  // (مثل تبويب "أحاديث" ببوابة الآية) - لا حاجة لهما بقائمة أحاديث فئة
  // واحدة (يبقيان null هناك، غير مُستعلَم عنهما أصلاً بذلك الاستعلام).
  final String? bookNameAr;
  final int? hadithNumber;

  Hadith({
    required this.id,
    required this.title,
    required this.textAr,
    this.narrator,
    this.grade,
    this.explanation,
    this.bookId,
    this.grades,
    this.references,
    this.linkedAyah,
    this.bookNameAr,
    this.hadithNumber,
  });

  factory Hadith.fromJson(Map<String, dynamic> j) {
    final book = j['hadith_books'] as Map<String, dynamic>?;
    return Hadith(
      id: j['id'] as int,
      title: j['title'] as String? ?? '',
      textAr: j['text_ar'] as String? ?? '',
      narrator: j['narrator'] as String?,
      grade: j['grade'] as String?,
      explanation: j['explanation'] as String?,
      bookId: j['book_id'] as String?,
      grades: (j['grades'] as List?)
          ?.map((g) => HadithGrade.fromJson(g as Map<String, dynamic>))
          .toList(),
      references: (j['references'] as List?)?.map((r) => r as String).toList(),
      bookNameAr: book?['name_ar'] as String?,
      hadithNumber: j['hadith_number'] as int?,
    );
  }

  Hadith copyWithAyahLink(AyahLink? link) {
    return Hadith(
      id: id,
      title: title,
      textAr: textAr,
      narrator: narrator,
      grade: grade,
      explanation: explanation,
      bookId: bookId,
      grades: grades,
      references: references,
      linkedAyah: link,
      bookNameAr: bookNameAr,
      hadithNumber: hadithNumber,
    );
  }
}

// أسماء الكتب المعروفة لشارة "من الصحيحين" - تعريف ببليوغرافي بحت
// لاسم الكتاب نفسه، لا حكم مخترَع (bukhari/muslim فقط بلا grades
// بقرار متعمَّد سابق - راجع الـmigration المذكورة أعلاه).
const Map<String, String> sahihaynBookNames = {
  'bukhari': 'صحيح البخاري',
  'muslim': 'صحيح مسلم',
};

class HadithRepository {
  final SupabaseClient _client;
  HadithRepository(this._client);

  /// كل الفئات الرئيسية (بلا فئات فرعية حالياً).
  Future<List<HadithCategory>> getCategories() async {
    final res = await _client
        .from('hadith_categories')
        .select('id, title_ar, hadeeths_count')
        .order('id');
    return (res as List).map((j) => HadithCategory.fromJson(j)).toList();
  }

  /// أحاديث فئة محددة، عبر جدول الربط (حديث قد ينتمي لعدة فئات).
  Future<List<Hadith>> getHadithsByCategory(int categoryId) async {
    final links = await _client
        .from('hadith_category_links')
        .select('hadith_id')
        .eq('category_id', categoryId);

    final hadithIds = (links as List).map((l) => l['hadith_id'] as int).toList();
    if (hadithIds.isEmpty) return [];

    final res = await _client
        .from('hadiths')
        .select(
          'id, title, text_ar, narrator, grade, explanation, book_id, '
          'grades, references',
        )
        .inFilter('id', hadithIds);

    final hadiths = (res as List).map((j) => Hadith.fromJson(j)).toList();

    final ayahLinks = await _getAyahLinks(hadithIds);
    if (ayahLinks.isEmpty) return hadiths;

    return hadiths
        .map((h) => h.copyWithAyahLink(ayahLinks[h.id]))
        .toList();
  }

  /// روابط الآيات المرتبطة (kg_edges) لمجموعة أحاديث دفعة واحدة (لا
  /// استعلام منفصل لكل حديث). edge_type='authentic_hadith_citation' -
  /// وليس 'ayah_hadith' (الأخير 0 صف فعلياً بالقاعدة؛ مشروع ربط
  /// حديث↔آية استخدم authentic_hadith_citation عمداً ليخضع لقيد
  /// reviewed بدل تجاوزه - راجع PROGRESS.md "دفعة تجريبية أولى لربط
  /// حديث↔آية"). كل الروابط الـ476 reviewed=true فعلياً فتظهر لـanon
  /// بسياسة RLS الحالية بلا حاجة لشرط إضافي هنا.
  Future<Map<int, AyahLink>> _getAyahLinks(List<int> hadithIds) async {
    try {
      final res = await _client
          .from('kg_edges')
          .select(
            'dst_id, ayahs!kg_edges_src_ayah_fkey(surah_id, ayah_number, '
            'text_uthmani, surahs(name_arabic))',
          )
          .eq('dst_type', 'hadith')
          .eq('edge_type', 'authentic_hadith_citation')
          .inFilter('dst_id', hadithIds);

      final map = <int, AyahLink>{};
      for (final j in (res as List)) {
        final ayah = j['ayahs'] as Map<String, dynamic>?;
        final hadithId = j['dst_id'] as int?;
        if (ayah == null || hadithId == null) continue;
        final surah = ayah['surahs'] as Map<String, dynamic>? ?? {};
        map[hadithId] = AyahLink(
          surahId: ayah['surah_id'] as int,
          ayahNumber: ayah['ayah_number'] as int,
          surahName: surah['name_arabic'] as String? ?? '',
          ayahText: ayah['text_uthmani'] as String? ?? '',
        );
      }
      return map;
    } catch (_) {
      return {};
    }
  }
}
