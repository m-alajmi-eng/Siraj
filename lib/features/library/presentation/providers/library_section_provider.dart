import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/library_local_datasource.dart';
import '../../data/datasources/subcategory_remote_datasource.dart';
import '../../domain/entities/library_section_entity.dart';
import '../../../../core/locale/locale_provider.dart';

final libraryLocalDataSourceProvider = Provider<LibraryLocalDataSource>((ref) {
  return LibraryLocalDataSource();
});

/// الطبقة 1: الأقسام الرئيسية السبعة.
final librarySectionsProvider = FutureProvider<List<LibrarySection>>((ref) {
  return ref.watch(libraryLocalDataSourceProvider).getSections();
});

/// قسم واحد بالمعرّف.
final librarySectionProvider =
    FutureProvider.family<LibrarySection?, String>((ref, id) {
  return ref.watch(libraryLocalDataSourceProvider).getSection(id);
});

final subCategoryDataSourceProvider =
    Provider<SubCategoryRemoteDataSource>((ref) {
  return SubCategoryRemoteDataSource();
});

/// الطبقة 2: التصنيفات الفرعية لقسم معيّن، باللغة الحالية.
final subCategoriesProvider =
    FutureProvider.family<List<SubCategory>, String>((ref, parentCategoryId) {
  final lang = ref.watch(localeProvider).languageCode;
  return ref
      .watch(subCategoryDataSourceProvider)
      .getSubCategories(parentCategoryId, lang: lang);
});
