// اختبار يفتح أصول القرآن الفعلية (assets/data/*.json) ويتحقق من ثوابتها
// الرياضية والبنيوية: 6236 آية، 604 صفحة، 114 سورة، 14 لغة ترجمة، صفر
// نصوص فارغة. هذا صمام أمان ديني (بند P0 من 03_MASTER_CHECKLIST) - أي كسر
// في بيانات المصحف أو الترجمات يجب أن يفشل هذا الاختبار فوراً، لا أن يمر
// بمقارنة ثوابت بنفسها.

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

Map<String, dynamic> _loadJson(String path) =>
    jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;

void main() {
  group('quran_uthmani.json', () {
    final data = _loadJson('assets/data/quran_uthmani.json');
    final surahs = data['surahs'] as Map<String, dynamic>;

    test('114 سورة بالضبط', () {
      expect(surahs.length, 114);
    });

    test('6236 آية بالضبط عبر كل السور', () {
      final total = surahs.values
          .map((v) => (v as List).length)
          .fold<int>(0, (a, b) => a + b);
      expect(total, 6236);
    });

    test('604 صفحة بالضبط، من 1 إلى 604 بلا فجوات', () {
      final pages = <int>{};
      for (final ayahs in surahs.values) {
        for (final ayah in ayahs as List) {
          pages.add((ayah as Map<String, dynamic>)['page'] as int);
        }
      }
      expect(pages.length, 604);
      expect(pages.reduce((a, b) => a < b ? a : b), 1);
      expect(pages.reduce((a, b) => a > b ? a : b), 604);
    });

    test('صفر نصوص آيات فارغة', () {
      var emptyCount = 0;
      for (final ayahs in surahs.values) {
        for (final ayah in ayahs as List) {
          final text = (ayah as Map<String, dynamic>)['text'] as String;
          if (text.trim().isEmpty) emptyCount++;
        }
      }
      expect(emptyCount, 0);
    });
  });

  group('quran_translations.json', () {
    final data = _loadJson('assets/data/quran_translations.json');
    final translations = data['translations'] as Map<String, dynamic>;

    test('14 لغة ترجمة بالضبط', () {
      expect(translations.length, 14);
    });

    test('كل لغة تغطي 114 سورة و6236 آية بلا نصوص فارغة', () {
      for (final entry in translations.entries) {
        final lang = entry.key;
        final surahs = entry.value as Map<String, dynamic>;
        expect(surahs.length, 114, reason: 'لغة $lang يجب أن تغطي 114 سورة');

        var totalAyahs = 0;
        var emptyCount = 0;
        for (final ayahs in surahs.values) {
          for (final ayah in ayahs as List) {
            totalAyahs++;
            final text = (ayah as Map<String, dynamic>)['text'] as String;
            if (text.trim().isEmpty) emptyCount++;
          }
        }
        expect(totalAyahs, 6236, reason: 'لغة $lang يجب أن تغطي 6236 آية');
        expect(emptyCount, 0, reason: 'لغة $lang لا يجب أن تحوي نصاً فارغاً');
      }
    });
  });

  group('surah_names.json', () {
    final data = _loadJson('assets/data/surah_names.json');

    test('114 سورة بالضبط، وكل سورة لها اسم عربي ونقل صوتي', () {
      expect(data.length, 114);
      for (final entry in data.entries) {
        final surah = entry.value as Map<String, dynamic>;
        expect(
          (surah['ar'] as String).trim(),
          isNotEmpty,
          reason: 'السورة ${entry.key} بلا اسم عربي',
        );
        expect(
          (surah['translit'] as String).trim(),
          isNotEmpty,
          reason: 'السورة ${entry.key} بلا نقل صوتي',
        );
      }
    });
  });
}
