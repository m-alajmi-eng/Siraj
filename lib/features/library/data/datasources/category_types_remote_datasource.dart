import 'dart:convert';
import 'package:http/http.dart' as http;

/// نوع محتوى متوفر داخل قسم (كتب/صوتيات/فيديو/مقالات...)
/// يأتي من IslamHouse عبر get-categroy-types-avaliable، ويحمل عدداً حقيقياً.
class CategoryContentType {
  final String blockName; // books, audios, videos, articles, fatwa, poster, khotab, apps
  final int itemsCount;

  const CategoryContentType({
    required this.blockName,
    required this.itemsCount,
  });

  factory CategoryContentType.fromJson(Map<String, dynamic> json) {
    return CategoryContentType(
      blockName: (json['block_name'] ?? '').toString(),
      itemsCount: json['items_count'] is int
          ? json['items_count']
          : int.tryParse('${json['items_count']}') ?? 0,
    );
  }
}

/// مصدر شبكي: يجلب أنواع المحتوى المتوفرة فعلياً لقسم معيّن، بأعدادها الحقيقية.
class CategoryTypesRemoteDataSource {
  static const String _base = 'https://api3.islamhouse.com/v3';
  static const String _key = 'paV29H2gm56kvLP';

  // الأنواع التي نعرضها للمستخدم (نتجاهل fatwa/poster/apps لبساطة الواجهة)
  static const _relevantTypes = {'books', 'audios', 'videos', 'articles'};

  final http.Client _client;
  CategoryTypesRemoteDataSource({http.Client? client})
      : _client = client ?? http.Client();

  Future<List<CategoryContentType>> getAvailableTypes(
    String categoryId, {
    String lang = 'ar',
  }) async {
    final types = await _fetch(categoryId, lang);
    if (types.isEmpty && lang != 'ar') {
      return _fetch(categoryId, 'ar');
    }
    return types;
  }

  Future<List<CategoryContentType>> _fetch(String categoryId, String lang) async {
    final url = Uri.parse(
      '$_base/$_key/main/get-categroy-types-avaliable/$categoryId/$lang/showall/json',
    );
    try {
      final res = await _client.get(url).timeout(const Duration(seconds: 20));
      if (res.statusCode != 200) return [];
      final decoded = jsonDecode(utf8.decode(res.bodyBytes));
      if (decoded is! List) return [];
      return decoded
          .whereType<Map>()
          .map((e) => CategoryContentType.fromJson(Map<String, dynamic>.from(e)))
          .where((t) => _relevantTypes.contains(t.blockName) && t.itemsCount > 0)
          .toList();
    } catch (_) {
      return [];
    }
  }
}
