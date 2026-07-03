import 'dart:convert';
import 'package:http/http.dart' as http;

/// تصنيف فرعي (المستوى 2 في المكتبة الشاملة) — يأتي مباشرة من IslamHouse.
class SubCategory {
  final String id;
  final String title;
  final String description;
  final int itemsCount;

  const SubCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.itemsCount,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      itemsCount: json['items_count'] is int
          ? json['items_count']
          : int.tryParse('${json['items_count']}') ?? 0,
    );
  }
}

/// مصدر شبكي لجلب التصنيفات الفرعية لقسم معيّن من دار الإسلام (IslamHouse).
/// بعض التصنيفات لا تملك عنواناً مُترجماً بلغة معيّنة (title: null من المصدر)،
/// لذا نجلب اللغة المطلوبة والعربية معاً وندمجهما: عنوان اللغة المطلوبة إن وجد،
/// وإلا نسقط للعربية لكل عنصر على حدة (لا للقائمة كاملة).
class SubCategoryRemoteDataSource {
  static const String _base = 'https://api3.islamhouse.com/v3';
  static const String _key = 'paV29H2gm56kvLP';

  final http.Client _client;
  SubCategoryRemoteDataSource({http.Client? client})
      : _client = client ?? http.Client();

  Future<List<SubCategory>> getSubCategories(
    String parentCategoryId, {
    String lang = 'ar',
  }) async {
    final requested = await _fetch(parentCategoryId, lang);
    if (lang == 'ar') return requested;

    // نجلب العربية دوماً كنسخة احتياطية للعناوين الفارغة
    final arabic = await _fetch(parentCategoryId, 'ar');
    if (requested.isEmpty) return arabic;

    final arById = {for (final s in arabic) s.id: s};
    return requested.map((s) {
      if (s.title.isNotEmpty) return s;
      final fallback = arById[s.id];
      if (fallback != null && fallback.title.isNotEmpty) {
        return SubCategory(
          id: s.id,
          title: fallback.title,
          description: s.description.isNotEmpty ? s.description : fallback.description,
          itemsCount: s.itemsCount,
        );
      }
      return s;
    }).toList();
  }

  Future<List<SubCategory>> _fetch(String parentId, String lang) async {
    final url = Uri.parse(
      '$_base/$_key/main/get-sub-categories/$parentId/$lang/json',
    );
    try {
      final res = await _client.get(url).timeout(const Duration(seconds: 20));
      if (res.statusCode != 200) return [];
      final decoded = jsonDecode(utf8.decode(res.bodyBytes));
      List? list;
      if (decoded is List) {
        list = decoded;
      } else if (decoded is Map && decoded['sub_categories'] is List) {
        list = decoded['sub_categories'];
      } else if (decoded is Map && decoded['data'] is List) {
        list = decoded['data'];
      }
      if (list == null) return [];
      return list
          .whereType<Map>()
          .map((e) => SubCategory.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (_) {
      return [];
    }
  }
}
