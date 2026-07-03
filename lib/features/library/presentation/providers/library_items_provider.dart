import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../gateway/data/datasources/islamhouse_remote_datasource.dart';
import '../../../../core/locale/locale_provider.dart';

/// إعادة استخدام مصدر IslamHouse الشبكي من ميزة البوابة (لا تكرار).
final libraryIslamHouseDataSourceProvider =
    Provider<IslamHouseRemoteDataSource>((ref) {
  return IslamHouseRemoteDataSource();
});

/// معاملات جلب عناصر تصنيف: المعرّف + نوع المحتوى (كتب/صوت/فيديو/مقالات).
class LibraryItemsParams {
  final String categoryId;
  final String type;
  const LibraryItemsParams({required this.categoryId, this.type = 'showall'});

  @override
  bool operator ==(Object other) =>
      other is LibraryItemsParams &&
      other.categoryId == categoryId &&
      other.type == type;

  @override
  int get hashCode => Object.hash(categoryId, type);
}

/// عناصر تصنيف فرعي معيّن، مُفلترة حسب نوع المحتوى (المستوى 3 في المكتبة الشاملة).
final librarySectionItemsProvider =
    FutureProvider.family<List<LibraryItem>, LibraryItemsParams>((ref, params) {
  final lang = ref.watch(localeProvider).languageCode;
  return ref
      .watch(libraryIslamHouseDataSourceProvider)
      .getCategoryItems(params.categoryId, lang: lang, type: params.type);
});
