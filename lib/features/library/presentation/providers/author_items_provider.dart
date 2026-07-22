import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../../gateway/data/datasources/islamhouse_remote_datasource.dart';
import 'library_items_provider.dart' show libraryIslamHouseDataSourceProvider;

/// أعمال مؤلف معيّن، تُجلَب حيّاً عبر get-author-items (لا تخزين وسيط).
final authorItemsProvider =
    FutureProvider.family<List<LibraryItem>, String>((ref, authorId) {
  final lang = ref.watch(localeProvider).languageCode;
  return ref
      .watch(libraryIslamHouseDataSourceProvider)
      .getAuthorItems(authorId, lang: lang);
});
