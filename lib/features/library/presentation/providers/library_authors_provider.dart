import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/library_authors_remote_datasource.dart';
import '../../../../core/locale/locale_provider.dart';

final libraryAuthorsDataSourceProvider =
    Provider<LibraryAuthorsRemoteDataSource>((ref) {
  return LibraryAuthorsRemoteDataSource();
});

/// مؤلفو المكتبة المحصودون، مرتَّبون حسب items_count تنازلياً، بلغة
/// الواجهة الحالية (مع سقوط لأي لغة مُحصودة أخرى عند غيابها).
final libraryAuthorsProvider = FutureProvider<List<LibraryAuthor>>((ref) {
  final lang = ref.watch(localeProvider).languageCode;
  return ref.watch(libraryAuthorsDataSourceProvider).getAuthors(lang: lang);
});
