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

  static Future<void> cacheAyahs(int surahId, List data,
      {String lang = 'ar'}) async {
    final box = Hive.box(_quranBox);
    await box.put('ayahs_${surahId}_$lang', data);
  }

  static List? getCachedAyahs(int surahId, {String lang = 'ar'}) {
    final box = Hive.box(_quranBox);
    return box.get('ayahs_${surahId}_$lang');
  }

  // ─── Reading Position ─────────────────────────────────────
  static Future<void> saveReadingPosition(
      int surahId, int ayahNumber) async {
    final box = Hive.box(_settingsBox);
    await box.put('last_surah', surahId);
    await box.put('last_ayah', ayahNumber);
    // مصدر الحقيقة الموحّد: نمسح أي سياق آخر (صفحة/ختمة) كي لا يتعارضا
    await box.delete('last_context_type');
  }

  static Map<String, int>? getReadingPosition() {
    final box = Hive.box(_settingsBox);
    final surah = box.get('last_surah');
    final ayah = box.get('last_ayah');
    if (surah == null) return null;
    return {'surahId': surah, 'ayahNumber': ayah ?? 1};
  }

  /// موضع القراءة الموحّد (المرحلة 6 من KHATMAH_DESIGN.md): يسجّل
  /// آخر سياق نشط بغضّ النظر عن نوعه (سورة/صفحة/صفحة ضمن ختمة)،
  /// لتوجيه "متابعة القراءة" من أي نقطة دخول للمكان الصحيح تماماً.
  static Future<void> saveLastReadingContext({
    required String type, // 'surah' | 'page' | 'khatmah_page'
    int? surahId,
    int? ayahNumber,
    int? page,
    String? khatmahId,
  }) async {
    final box = Hive.box(_settingsBox);
    await box.put('last_context_type', type);
    if (surahId != null) await box.put('last_surah', surahId);
    if (ayahNumber != null) await box.put('last_ayah', ayahNumber);
    if (page != null) await box.put('last_page', page);
    if (khatmahId != null) {
      await box.put('last_khatmah_id', khatmahId);
    } else {
      await box.delete('last_khatmah_id');
    }
  }

  /// يقرأ آخر سياق قراءة موحّد. يرجع null إن لم يُسجَّل شيء بعد.
  static Map<String, dynamic>? getLastReadingContext() {
    final box = Hive.box(_settingsBox);
    final type = box.get('last_context_type') as String?;
    if (type == null) {
      final legacy = getReadingPosition();
      if (legacy == null) return null;
      return {'type': 'surah', ...legacy};
    }
    return {
      'type': type,
      'surahId': box.get('last_surah') as int?,
      'ayahNumber': box.get('last_ayah') as int?,
      'page': box.get('last_page') as int?,
      'khatmahId': box.get('last_khatmah_id') as String?,
    };
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

  // ─── Khatmah Plans ────────────────────────────────────────
  // تُخزَّن كل الخطط كقائمة JSON تحت مفتاح واحد (يدعم خطط متعددة).
  static const String _khatmahKey = 'khatmah_plans';

  static Future<void> saveKhatmahPlans(List<Map<String, dynamic>> plans) async {
    final box = Hive.box(_settingsBox);
    await box.put(_khatmahKey, plans);
  }

  static List<Map<String, dynamic>> getKhatmahPlans() {
    final box = Hive.box(_settingsBox);
    final raw = box.get(_khatmahKey);
    if (raw == null) return [];
    return (raw as List)
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
  }
}