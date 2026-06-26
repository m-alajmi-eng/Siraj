import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/hadith_remote_datasource.dart';
import '../../domain/entities/hadith_entity.dart';

final hadithDataSourceProvider = Provider<HadithRemoteDataSource>((ref) {
  return HadithRemoteDataSource();
});

class SelectedCollectionNotifier extends Notifier<String> {
  @override
  String build() => 'bukhari';
  void select(String collection) => state = collection;
}

final selectedCollectionProvider =
    NotifierProvider<SelectedCollectionNotifier, String>(() {
  return SelectedCollectionNotifier();
});

final hadithsProvider = FutureProvider.family<List<HadithEntity>, String>(
  (ref, collection) async {
    final dataSource = ref.watch(hadithDataSourceProvider);
    return dataSource.getHadiths(collection);
  },
); 