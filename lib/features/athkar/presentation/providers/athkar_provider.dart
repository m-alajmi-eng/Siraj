import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/athkar_local_datasource.dart';
import '../../domain/entities/athkar_entity.dart';

final athkarDataSourceProvider = Provider<AthkarLocalDataSource>((ref) {
  return AthkarLocalDataSource();
});

final athkarCategoriesProvider = FutureProvider<List<AthkarCategory>>((ref) {
  return ref.watch(athkarDataSourceProvider).getCategories();
});

final athkarByCategoryProvider =
    FutureProvider.family<List<AthkarEntity>, String>((ref, categoryId) {
  return ref.watch(athkarDataSourceProvider).getByCategory(categoryId);
});

class DhikrCounterNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void increment() => state++;
  void reset()     => state = 0;
}

final dhikrCounterProvider =
    NotifierProvider<DhikrCounterNotifier, int>(() {
  return DhikrCounterNotifier();
});