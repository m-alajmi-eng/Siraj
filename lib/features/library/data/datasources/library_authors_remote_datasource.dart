import 'package:supabase_flutter/supabase_flutter.dart';

/// مؤلف من جدول public.library_authors (محصود تدريجياً من IslamHouse
/// أثناء تصفّح المكتبة العادي - انظر IslamHouseRemoteDataSource._harvestAuthors
/// وupsert_harvested_author). title/description نسخ حرفي من IslamHouse
/// (استثناء ضيّق موثَّق في ADR-013)، قراءة مباشرة من الجدول بلا RPC.
class LibraryAuthor {
  final int authorId;
  final String title;
  final String description;
  final int? itemsCount;

  const LibraryAuthor({
    required this.authorId,
    required this.title,
    required this.description,
    required this.itemsCount,
  });
}

class LibraryAuthorsRemoteDataSource {
  final SupabaseClient _client;
  LibraryAuthorsRemoteDataSource({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  Future<List<LibraryAuthor>> getAuthors({required String lang}) async {
    final rows = await _client
        .from('library_authors')
        .select('islamhouse_author_id, localized, items_count')
        .order('items_count', ascending: false, nullsFirst: false);

    return rows
        .map((row) => _toAuthor(Map<String, dynamic>.from(row), lang))
        .where((a) => a.title.isNotEmpty)
        .toList();
  }

  LibraryAuthor _toAuthor(Map<String, dynamic> row, String lang) {
    final localized = row['localized'] is Map
        ? Map<String, dynamic>.from(row['localized'] as Map)
        : <String, dynamic>{};
    final entry = _resolveLocalizedEntry(localized, lang);
    return LibraryAuthor(
      authorId: row['islamhouse_author_id'] as int,
      title: (entry['title'] ?? '').toString(),
      description: (entry['description'] ?? '').toString(),
      itemsCount: row['items_count'] as int?,
    );
  }

  // يعرض لغة الواجهة الحالية إن حُصدت، وإلا يسقط لأي لغة مُحصودة متاحة
  // (لا نُخفي مؤلفاً بأكمله لمجرّد غياب لغة العرض الحالية لسيرته).
  Map<String, dynamic> _resolveLocalizedEntry(
    Map<String, dynamic> localized,
    String lang,
  ) {
    if (localized[lang] is Map) {
      return Map<String, dynamic>.from(localized[lang] as Map);
    }
    for (final value in localized.values) {
      if (value is Map) return Map<String, dynamic>.from(value);
    }
    return const {};
  }
}
