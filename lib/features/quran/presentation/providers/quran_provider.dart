import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/quran_remote_datasource.dart';
import '../../domain/entities/surah_entity.dart';
import '../../domain/entities/ayah_entity.dart';

final quranDataSourceProvider = Provider<QuranRemoteDataSource>((ref) {
  return QuranRemoteDataSource();
});

final surahsProvider = FutureProvider<List<SurahEntity>>((ref) async {
  final dataSource = ref.watch(quranDataSourceProvider);
  return dataSource.getSurahs();
});

final ayahsProvider =
    FutureProvider.family<List<AyahEntity>, int>((ref, surahId) async {
  final dataSource = ref.watch(quranDataSourceProvider);
  return dataSource.getAyahs(surahId);
});

final tafsirProvider =
    FutureProvider.family<String, Map<String, int>>((ref, params) async {
  final dataSource = ref.watch(quranDataSourceProvider);
  return dataSource.getTafsir(
    params['surahId']!,
    params['ayahNumber']!,
  );
});