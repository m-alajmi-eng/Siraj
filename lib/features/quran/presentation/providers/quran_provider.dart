import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/quran_remote_datasource.dart';
import '../../data/datasources/surah_names_datasource.dart';
import '../../domain/entities/surah_entity.dart';
import '../../domain/entities/ayah_entity.dart';
import '../../domain/entities/tajweed_entity.dart';
import '../../data/datasources/tajweed_local_datasource.dart';
import '../../../../core/locale/locale_provider.dart';

final quranDataSourceProvider = Provider<QuranRemoteDataSource>((ref) {
  return QuranRemoteDataSource();
});

final pageAyahsProvider =
    FutureProvider.family<List<Map<String, dynamic>>, int>((ref, page) async {
  final dataSource = ref.watch(quranDataSourceProvider);
  return dataSource.getPageAyahs(page);
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

// يضمن تحميل أسماء السور المترجمة
final surahNamesLoadedProvider = FutureProvider<bool>((ref) async {
  await SurahNamesDataSource.ensureLoaded();
  return true;
});

// ═══════════════════════════════════════════════════════
// التجويد الملوّن — محلي بالكامل (ADR-006)
// ═══════════════════════════════════════════════════════
final tajweedDataSourceProvider = Provider<TajweedLocalDataSource>((ref) {
  return TajweedLocalDataSource();
});

/// آيات سورة معيّنة بصيغة التجويد (نص نظيف + annotations).
final tajweedSurahProvider =
    FutureProvider.family<List<TajweedAyah>, int>((ref, surahId) {
  return ref.watch(tajweedDataSourceProvider).getSurahTajweed(surahId);
});

/// كل ألوان قواعد التجويد دفعة واحدة.
final tajweedColorsProvider = FutureProvider<Map<String, Color>>((ref) {
  return ref.watch(tajweedDataSourceProvider).getAllColors();
});
