// اختبار MushafPageMap (PHASE K، ADR-005): يتحقّق أن تحويل صفحة↔آية
// المبني على quran_uthmani.json صحيح ومتّسق قبل الاعتماد عليه لإزالة
// المصحف المطبوع. أي كسر هنا يعني كسر استئناف القراءة/تقدّم الختمة
// القديمَين المبنيَّين على أرقام الصفحات.

import 'package:flutter_test/flutter_test.dart';
import 'package:siraj/features/quran/data/datasources/mushaf_page_map.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MushafPageMap', () {
    test('أول آية في الصفحة 1 هي الفاتحة 1:1', () async {
      final ref = await MushafPageMap.firstAyahOfPage(1);
      expect(ref.surahId, 1);
      expect(ref.ayahNumber, 1);
    });

    test('صفحة الفاتحة 1:1 هي الصفحة 1', () async {
      final page = await MushafPageMap.pageOfAyah(1, 1);
      expect(page, 1);
    });

    test('آخر آية في القرآن (114:6) تقع ضمن الصفحة الأخيرة 604', () async {
      final page = await MushafPageMap.pageOfAyah(114, 6);
      expect(page, 604);
    });

    test('كل صفحة من 1 إلى 604 لها آية بداية صالحة', () async {
      for (var page = 1; page <= 604; page++) {
        final ref = await MushafPageMap.firstAyahOfPage(page);
        expect(ref.surahId, inInclusiveRange(1, 114));
        expect(ref.ayahNumber, greaterThanOrEqualTo(1));
      }
    });

    test('التحويل ذهاباً وإياباً متّسق لعيّنة من الصفحات', () async {
      for (final page in [1, 2, 50, 300, 500, 603, 604]) {
        final ref = await MushafPageMap.firstAyahOfPage(page);
        final roundTrip = await MushafPageMap.pageOfAyah(ref.surahId, ref.ayahNumber);
        expect(roundTrip, page,
            reason: 'الصفحة $page → آية ${ref.surahId}:${ref.ayahNumber} '
                'يجب أن تعود لنفس الصفحة');
      }
    });

    test('معرّف آية غير صالح يسقط آمناً على الصفحة 1 لا يرمي استثناءً', () async {
      final page = await MushafPageMap.pageOfAyah(999, 999);
      expect(page, 1);
    });
  });
}
