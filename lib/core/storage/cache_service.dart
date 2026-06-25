import 'package:hive_flutter/hive_flutter.dart';

class CacheService {
  static const String _quranBox      = 'quran_cache';
  static const String _prayerBox     = 'prayer_cache';
  static const String _settingsBox   = 'settings';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_quranBox);
    await Hive.openBox(_prayerBox);
    await Hive.openBox(_settingsBox);
  }

  // ─── Quran ───────────────────────────────────────────────
  static Future<void> cacheSurahs(List data) async {
    final box = Hive.box(_quranBox);
    await box.put('surahs', data);
  }

  static List? getCachedSurahs() {
    final box = Hive.box(_quranBox);
    return box.get('surahs');
  }

  static Future<void> cacheAyahs(int surahId, List data) async {
    final box = Hive.box(_quranBox);
    await box.put('ayahs_$surahId', data);
  }

  static List? getCachedAyahs(int surahId) {
    final box = Hive.box(_quranBox);
    return box.get('ayahs_$surahId');
  }

  // ─── Reading Position ─────────────────────────────────────
  static Future<void> saveReadingPosition(
      int surahId, int ayahNumber) async {
    final box = Hive.box(_settingsBox);
    await box.put('last_surah', surahId);
    await box.put('last_ayah',  ayahNumber);
  }

  static Map<String, int>? getReadingPosition() {
    final box = Hive.box(_settingsBox);
    final surah = box.get('last_surah');
    final ayah  = box.get('last_ayah');
    if (surah == null) return null;
    return {'surahId': surah, 'ayahNumber': ayah ?? 1};
  }

  // ─── Settings ─────────────────────────────────────────────
  static Future<void> saveSetting(String key, dynamic value) async {
    final box = Hive.box(_settingsBox);
    await box.put(key, value);
  }

  static dynamic getSetting(String key, {dynamic defaultValue}) {
    final box = Hive.box(_settingsBox);
    return box.get(key, defaultValue: defaultValue);
  }
}