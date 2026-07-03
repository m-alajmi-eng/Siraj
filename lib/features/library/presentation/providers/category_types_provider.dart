import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/category_types_remote_datasource.dart';
import '../../../../core/locale/locale_provider.dart';

final categoryTypesDataSourceProvider =
    Provider<CategoryTypesRemoteDataSource>((ref) {
  return CategoryTypesRemoteDataSource();
});

/// أنواع المحتوى المتوفرة فعلياً لقسم معيّن (كتب/صوت/فيديو/مقالات) بأعداد حقيقية.
final categoryTypesProvider =
    FutureProvider.family<List<CategoryContentType>, String>((ref, categoryId) {
  final lang = ref.watch(localeProvider).languageCode;
  return ref
      .watch(categoryTypesDataSourceProvider)
      .getAvailableTypes(categoryId, lang: lang);
});
