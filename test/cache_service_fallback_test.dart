// اختبارات وحدة لـ CacheService ولمسار السقوط الآمن (fallback) في
// QuranRemoteDataSource: يضمن ألا يكسر أي تعديل مستقبلي مسار "الأصول
// المحلية أولاً ثم Hive ثم الشبكة" (ADR-006) دون أن يُلمَس أي كود شبكة
// فعلياً - فغياب السورة/الآية من الأصول المحلية يجب أن يسقط تلقائياً
// لذاكرة Hive المُخزَّنة مسبقاً، لا أن يحاول الاتصال بالشبكة.

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:siraj/core/storage/cache_service.dart';
import 'package:siraj/features/quran/data/datasources/quran_remote_datasource.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp('cache_service_test');
    Hive.init(tempDir.path);
    await Hive.openBox('quran_cache');
    await Hive.openBox('prayer_cache');
    await Hive.openBox('settings');
  });

  tearDown(() async {
    await Hive.box('quran_cache').clear();
    await Hive.box('prayer_cache').clear();
    await Hive.box('settings').clear();
  });

  tearDownAll(() async {
    await Hive.close();
    if (await tempDir.exists()) await tempDir.delete(recursive: true);
  });

  group('CacheService: تخزين واسترجاع أساسي', () {
    test('الإعدادات: saveSetting/getSetting round-trip مع defaultValue', () async {
      expect(CacheService.getSetting('missing_key', defaultValue: 'د'), 'د');
      await CacheService.saveSetting('a_key', 'قيمة محفوظة');
      expect(CacheService.getSetting('a_key'), 'قيمة محفوظة');
    });

    test('موضع القراءة: فارغ أول مرة، ثم round-trip صحيح', () async {
      expect(CacheService.getReadingPosition(), isNull);
      await CacheService.saveReadingPosition(2, 5);
      expect(CacheService.getReadingPosition(), {'surahId': 2, 'ayahNumber': 5});
    });

    test('سياق القراءة الموحّد: التبديل لسورة يمسح khatmahId السابق', () async {
      await CacheService.saveLastReadingContext(
          type: 'khatmah_page', page: 10, khatmahId: 'k1');
      expect(CacheService.getLastReadingContext()!['khatmahId'], 'k1');

      // التبديل لموضع سورة عادي (المسار القديم) يمسح السياق الموحّد
      // فيرجع getLastReadingContext لمسار fallback الموروث (type=surah)
      await CacheService.saveReadingPosition(3, 1);
      final ctx = CacheService.getLastReadingContext();
      expect(ctx!['type'], 'surah');
      expect(ctx['surahId'], 3);
    });

    test('خطط الختمة: فارغة أول مرة، ثم round-trip كامل', () async {
      expect(CacheService.getKhatmahPlans(), isEmpty);
      await CacheService.saveKhatmahPlans([
        {'id': '1', 'name': 'خطة تجريبية'},
      ]);
      expect(CacheService.getKhatmahPlans(), [
        {'id': '1', 'name': 'خطة تجريبية'},
      ]);
    });
  });

  group('QuranRemoteDataSource: مسار السقوط الآمن (ADR-006)', () {
    final datasource = QuranRemoteDataSource();

    test(
        'getAyahs: يعتمد على الأصول المحلية أولاً بلا شبكة، ويطابق الملف الخام',
        () async {
      final raw = jsonDecode(
          File('assets/data/quran_uthmani.json').readAsStringSync());
      final surah1Raw = (raw['surahs'] as Map)['1'] as List;

      final ayahs = await datasource.getAyahs(1);

      expect(ayahs.length, surah1Raw.length);
      expect(ayahs.first.textUthmani, (surah1Raw.first as Map)['text']);
    });

    test('getAyahs: يسقط لذاكرة Hive عند غياب السورة من الأصول المحلية',
        () async {
      // سورة 999 غير موجودة في quran_uthmani.json، فيرجع المسار المحلي
      // null بأمان ويسقط النداء لذاكرة Hive مباشرة دون محاولة شبكة.
      await CacheService.cacheAyahs(999, [
        {
          'id': 1,
          'surahId': 999,
          'ayahNumber': 1,
          'textUthmani': 'نص تجريبي محفوظ',
          'juz': 1,
          'page': 1,
          'translation': null,
        }
      ]);

      final ayahs = await datasource.getAyahs(999);
      expect(ayahs.single.textUthmani, 'نص تجريبي محفوظ');
    });

    test('getTafsir: يسقط لذاكرة Hive عند غياب الآية من التفسير المحلي',
        () async {
      // سورة 999 غير موجودة في quran_tafsir.json، فيسقط النداء لذاكرة
      // Hive المخزَّنة مسبقاً دون محاولة الاتصال بـSupabase إطلاقاً.
      const cacheKey = 'tafsir_muyassar_999_1';
      await CacheService.saveSetting(cacheKey, 'تفسير تجريبي محفوظ');

      final tafsir = await datasource.getTafsir(999, 1);
      expect(tafsir, 'تفسير تجريبي محفوظ');
    });
  });
}
