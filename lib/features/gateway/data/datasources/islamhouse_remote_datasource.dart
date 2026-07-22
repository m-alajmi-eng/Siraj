import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

  // حصاد عضوي: أرقام المؤلفين الذين استُدعي لهم RPC الحصاد بالفعل في هذه
  // الجلسة (عبر أي مثيل من هذا الصنف) — تفادياً لاستدعاءات مكرّرة لا فائدة
  // منها لنفس المؤلف أثناء تصفّح واحد. الحصاد التراكمي عبر الزمن يكفي.
  static final Set<int> _harvestedAuthorIds = <int>{};

  Future<List<LibraryItem>> getCategoryItems(
    String categoryId, {
    String lang = 'ar',
    int page = 1,
    int limit = 25,
    String type = 'showall',
  }) async {
    final items = await _fetch(categoryId, lang, page, limit, type);
    if (items.isEmpty && lang != 'ar') {
      return _fetch(categoryId, 'ar', page, limit, type);
    }
    return items;
  }

  /// أعمال مؤلف معيّن عبر get-author-items - نفس شكل استجابة
  /// get-category-items تماماً (مصفوفة "data" بعناصر LibraryItem)، فقط
  /// مُفلترة حسب المؤلف بدل التصنيف. لا حصاد هنا (النطاق محصور بمصدر
  /// get-category-items وحده).
  Future<List<LibraryItem>> getAuthorItems(
    String authorId, {
    String lang = 'ar',
    int page = 1,
    int limit = 25,
    String type = 'showall',
  }) async {
    final url = Uri.parse(
      '$_base/$_key/main/get-author-items/$authorId/$type/$lang/$lang/$page/$limit/json',
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

  Future<List<LibraryItem>> _fetch(
    String categoryId,
    String lang,
    int page,
    int limit,
    String type,
  ) async {
    final url = Uri.parse(
      '$_base/$_key/main/get-category-items/$categoryId/$type/$lang/$lang/$page/$limit/json',
    );
    try {
      final res = await _client.get(url).timeout(const Duration(seconds: 20));
      if (res.statusCode != 200) return [];
      final decoded = jsonDecode(utf8.decode(res.bodyBytes));
      if (decoded is! Map || decoded['data'] is! List) return [];
      final rawItems = decoded['data'] as List;
      _harvestAuthors(rawItems, lang, categoryId);
      return rawItems
          .whereType<Map>()
          .map((e) => LibraryItem.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    } catch (_) {
      return [];
    }
  }

  // يمرّ على عناصر استجابة get-category-items ويحصد مؤلفي prepared_by
  // (kind == "author") بصمت، دون أي تأثير على عرض العناصر نفسها. حصاد
  // صامت بجانب المسار الحالي — لا يُبطئ التمرير ولا يُظهر أي خطأ للمستخدم.
  void _harvestAuthors(List rawItems, String lang, String categoryId) {
    final parsedCategoryId = int.tryParse(categoryId);
    for (final item in rawItems) {
      if (item is! Map) continue;
      final preparedBy = item['prepared_by'];
      if (preparedBy is! List) continue;
      for (final author in preparedBy) {
        if (author is! Map || author['kind'] != 'author') continue;
        final rawId = author['id'];
        final authorId = rawId is int ? rawId : int.tryParse('$rawId');
        if (authorId == null) continue;
        if (!_harvestedAuthorIds.add(authorId)) continue;
        final title = (author['title'] ?? '').toString();
        if (title.isEmpty) continue;
        final description = (author['description'] ?? '').toString();
        unawaited(_harvestOneAuthor(
          authorId: authorId,
          lang: lang,
          title: title,
          description: description,
          categoryId: parsedCategoryId,
        ));
      }
    }
  }

  Future<void> _harvestOneAuthor({
    required int authorId,
    required String lang,
    required String title,
    required String description,
    int? categoryId,
  }) async {
    try {
      await Supabase.instance.client.rpc('upsert_harvested_author', params: {
        'p_author_id': authorId,
        'p_lang': lang,
        'p_title': title,
        'p_description': description,
        'p_items_count': null,
        'p_category_id': categoryId,
      });
    } catch (e, st) {
      debugPrint('upsert_harvested_author فشل للمؤلف $authorId: $e');
      if (Sentry.isEnabled) {
        unawaited(Sentry.captureException(e, stackTrace: st));
      }
    }
  }
}
