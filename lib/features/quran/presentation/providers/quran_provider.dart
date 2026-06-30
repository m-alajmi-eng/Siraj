import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/quran_remote_datasource.dart';
import '../../domain/entities/surah_entity.dart';
import '../../domain/entities/ayah_entity.dart';
import '../../../../core/locale/locale_provider.dart';

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
  final lang       = ref.watch(localeProvider).languageCode;
  return dataSource.getAyahs(surahId, lang: lang);
});

final tafsirProvider =
    FutureProvider.family<String, Map<String, int>>((ref, params) async {
  final dataSource = ref.watch(quranDataSourceProvider);
  return dataSource.getTafsir(
    params['surahId']!,
    params['ayahNumber']!,
  );
});


// ترجمة آية اليوم — المفتاح: "surah:ayah:lang"
final dailyAyahTranslationProvider =
    FutureProvider.family<String?, String>((ref, key) async {
  final parts = key.split(':');
  final surah = int.parse(parts[0]);
  final ayah  = int.parse(parts[1]);
  final lang  = parts[2];
  final dataSource = ref.watch(quranDataSourceProvider);
  return dataSource.getAyahTranslation(surah, ayah, lang);
});
