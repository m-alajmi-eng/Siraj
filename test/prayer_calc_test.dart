// اختبار prayer_calc_resolver.dart (PHASE C3/L3): مصدر الحقيقة الوحيد
// لتحويل معرّفات طريقة الحساب/المذهب المحفوظة في الإعدادات لكائنات
// مكتبة adhan — يستهلكه مسارا العرض والإشعارات معاً؛ أي خطأ هنا يعني
// وقتاً مختلفاً للصلاة نفسها بين الاثنين (السبب الجذري الذي أُصلح).

import 'package:adhan/adhan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:siraj/core/prayer/prayer_calc_resolver.dart';

void main() {
  group('resolveCalculationMethod', () {
    final expected = {
      'MWL': CalculationMethod.muslim_world_league,
      'ISNA': CalculationMethod.north_america,
      'Egypt': CalculationMethod.egyptian,
      'Makkah': CalculationMethod.umm_al_qura,
      'Kuwait': CalculationMethod.kuwait,
      'Qatar': CalculationMethod.qatar,
      'Dubai': CalculationMethod.dubai,
      'Karachi': CalculationMethod.karachi,
      'Singapore': CalculationMethod.singapore,
      'Turkey': CalculationMethod.turkey,
      'MoonSighting': CalculationMethod.moon_sighting_committee,
    };

    expected.forEach((id, method) {
      test('"$id" → $method', () {
        expect(resolveCalculationMethod(id), method);
      });
    });

    test('معرّف غير معروف يسقط آمناً على muslim_world_league', () {
      expect(resolveCalculationMethod('not_a_real_method'),
          CalculationMethod.muslim_world_league);
    });
  });

  group('resolveMadhab', () {
    test('"hanafi" → Madhab.hanafi', () {
      expect(resolveMadhab('hanafi'), Madhab.hanafi);
    });

    test('المذاهب الثلاثة الأخرى (نفس طول الظل مِثلي) → Madhab.shafi', () {
      for (final id in ['maliki', 'shafi', 'hanbali']) {
        expect(resolveMadhab(id), Madhab.shafi, reason: 'المذهب "$id"');
      }
    });

    test('معرّف غير معروف يسقط آمناً على Madhab.shafi', () {
      expect(resolveMadhab('unknown'), Madhab.shafi);
    });
  });

  group('resolvePrayerParameters', () {
    test('يدمج طريقة الحساب والمذهب معاً في كائن واحد', () {
      final params = resolvePrayerParameters(
        calcMethodId: 'Makkah',
        madhabId: 'hanafi',
      );
      expect(params.madhab, Madhab.hanafi);
    });

    test('العصر الحنفي يقع بعد العصر الشافعي لنفس الموقع والتاريخ (نفس فرق ADR-011 المُصلَح)', () {
      final coordinates = Coordinates(24.7136, 46.6753); // الرياض
      final date = DateComponents(2026, 7, 22);

      final shafiParams = resolvePrayerParameters(
        calcMethodId: 'MWL', madhabId: 'shafi');
      final hanafiParams = resolvePrayerParameters(
        calcMethodId: 'MWL', madhabId: 'hanafi');

      final shafiTimes = PrayerTimes(coordinates, date, shafiParams);
      final hanafiTimes = PrayerTimes(coordinates, date, hanafiParams);

      // الحنفي يستخدم طول ظل مضاعف → عصر متأخّر عن الشافعي دائماً.
      expect(hanafiTimes.asr.isAfter(shafiTimes.asr), isTrue,
          reason: 'عصر حنفي: ${hanafiTimes.asr}، عصر شافعي: ${shafiTimes.asr}');
    });
  });
}
