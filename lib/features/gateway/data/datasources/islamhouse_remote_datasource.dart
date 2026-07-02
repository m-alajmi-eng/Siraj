import 'dart:convert';
import 'package:http/http.dart' as http;

/// عنصر من مكتبة IslamHouse (كتاب/مقال/صوت).
class LibraryItem {
  final String id;
  final String title;
  final String description;
  final String type;
  final List<LibraryAttachment> attachments;

  const LibraryItem({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.attachments,
  });

  factory LibraryItem.fromJson(Map<String, dynamic> json) {
    final atts = <LibraryAttachment>[];
    if (json['attachments'] is List) {
      for (final a in (json['attachments'] as List)) {
        if (a is Map) {
          atts.add(LibraryAttachment.fromJson(Map<String, dynamic>.from(a)));
        }
      }
    }
    return LibraryItem(
      id: (json['id'] ?? '').toString(),
      title: (json['title'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      attachments: atts,
    );
  }
}

class LibraryAttachment {
  final String extension;
  final String size;
  final String url;

  const LibraryAttachment({
    required this.extension,
    required this.size,
    required this.url,
  });

  factory LibraryAttachment.fromJson(Map<String, dynamic> json) {
    return LibraryAttachment(
      extension: (json['extension_type'] ?? '').toString(),
      size: (json['size'] ?? '').toString(),
      url: (json['url'] ?? '').toString(),
    );
  }
}

/// مصدر شبكي لمكتبة IslamHouse (دار الإسلام) — معتمد وموثوق.
/// المفتاح العام المجاني ثابت. الجلب حسب اللغة الحالية، فإن لم تتوفّر
/// مواد باللغة يسقط للعربية.
class IslamHouseRemoteDataSource {
  static const String _base = 'https://api3.islamhouse.com/v3';
  static const String _key = 'paV29H2gm56kvLP';

  final http.Client _client;
  IslamHouseRemoteDataSource({http.Client? client})
      : _client = client ?? http.Client();

  Future<List<LibraryItem>> getCategoryItems(
    String categoryId, {
    String lang = 'ar',
    int page = 1,
    int limit = 25,
  }) async {
    final items = await _fetch(categoryId, lang, page, limit);
    if (items.isEmpty && lang != 'ar') {
      return _fetch(categoryId, 'ar', page, limit);
    }
    return items;
  }

  Future<List<LibraryItem>> _fetch(
    String categoryId,
    String lang,
    int page,
    int limit,
  ) async {
    final url = Uri.parse(
      '$_base/$_key/main/get-category-items/$categoryId/showall/$lang/$lang/$page/$limit/json',
    );
    try {
      final res = await _client.get(url).timeout(const Duration(seconds: 20));
      if (res.statusCode != 200) return [];
      final decoded = jsonDecode(utf8.decode(res.bodyBytes));
      if (decoded is! Map || decoded['data'] is! List) return [];
      return (decoded['data'] as List)
          .whereType<Map>()
          .map((e) => LibraryItem.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (_) {
      return [];
    }
  }
}
