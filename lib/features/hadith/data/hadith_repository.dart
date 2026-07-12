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

/// حديث واحد كامل (نص، درجة، شرح، تخريج).
class Hadith {
  final int id;
  final String title;
  final String textAr;
  final String? narrator;
  final String? grade;
  final String? explanation;

  Hadith({
    required this.id,
    required this.title,
    required this.textAr,
    this.narrator,
    this.grade,
    this.explanation,
  });

  factory Hadith.fromJson(Map<String, dynamic> j) {
    return Hadith(
      id: j['id'] as int,
      title: j['title'] as String? ?? '',
      textAr: j['text_ar'] as String? ?? '',
      narrator: j['narrator'] as String?,
      grade: j['grade'] as String?,
      explanation: j['explanation'] as String?,
    );
  }
}

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
        .select('id, title, text_ar, narrator, grade, explanation')
        .inFilter('id', hadithIds);

    return (res as List).map((j) => Hadith.fromJson(j)).toList();
  }
}
