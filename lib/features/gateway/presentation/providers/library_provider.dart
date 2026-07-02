import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/islamhouse_remote_datasource.dart';
import '../../../../core/locale/locale_provider.dart';

final islamHouseDataSourceProvider =
    Provider<IslamHouseRemoteDataSource>((ref) {
  return IslamHouseRemoteDataSource();
});

/// عناصر مكتبة تصنيف معيّن، باللغة الحالية للتطبيق.
/// نمرّر categoryId فقط؛ اللغة تُقرأ داخلياً من localeProvider.
final libraryItemsProvider =
    FutureProvider.family<List<LibraryItem>, String>((ref, categoryId) {
  final lang = ref.watch(localeProvider).languageCode;
  return ref
      .watch(islamHouseDataSourceProvider)
      .getCategoryItems(categoryId, lang: lang);
});
