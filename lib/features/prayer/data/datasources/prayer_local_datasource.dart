import 'package:adhan/adhan.dart';
import '../../domain/entities/prayer_times_entity.dart';

/// يحوّل معرّف طريقة الحساب المخزَّن في الإعدادات (نفس القيم المستخدمة
/// في settings_screen: MWL, ISNA, Egypt, Makkah, Kuwait, Qatar, Dubai)
/// إلى CalculationMethod الفعلية من مكتبة adhan.
CalculationMethod _resolveCalculationMethod(String id) {
  switch (id) {
    case 'ISNA':
      return CalculationMethod.north_america;
    case 'Egypt':
      return CalculationMethod.egyptian;
    case 'Makkah':
      return CalculationMethod.umm_al_qura;
    case 'Kuwait':
      return CalculationMethod.kuwait;
    case 'Qatar':
      return CalculationMethod.qatar;
    case 'Dubai':
      return CalculationMethod.dubai;
    case 'Karachi':
      return CalculationMethod.karachi;
    case 'Singapore':
      return CalculationMethod.singapore;
    case 'Turkey':
      return CalculationMethod.turkey;
    case 'MoonSighting':
      return CalculationMethod.moon_sighting_committee;
    case 'MWL':
    default:
      return CalculationMethod.muslim_world_league;
  }
}

class PrayerLocalDataSource {
  PrayerTimesEntity getPrayerTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
    String calcMethodId = 'MWL',
  }) {
    final coordinates = Coordinates(latitude, longitude);
    final params = _resolveCalculationMethod(calcMethodId).getParameters();
    params.madhab = Madhab.shafi;

    final dateComponents = DateComponents.from(date);
    final prayerTimes = PrayerTimes(coordinates, dateComponents, params);

    return PrayerTimesEntity(
      fajr:    prayerTimes.fajr,
      sunrise: prayerTimes.sunrise,
      dhuhr:   prayerTimes.dhuhr,
      asr:     prayerTimes.asr,
      maghrib: prayerTimes.maghrib,
      isha:    prayerTimes.isha,
      date:    date,
    );
  }
}
