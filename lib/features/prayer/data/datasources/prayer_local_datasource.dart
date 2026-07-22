import '../../../../core/prayer/prayer_calc_resolver.dart';
import '../../domain/entities/prayer_times_entity.dart';
import 'package:adhan/adhan.dart';

class PrayerLocalDataSource {
  PrayerTimesEntity getPrayerTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
    String calcMethodId = 'MWL',
    String madhabId = 'shafi',
  }) {
    final coordinates = Coordinates(latitude, longitude);
    final params = resolvePrayerParameters(
      calcMethodId: calcMethodId,
      madhabId: madhabId,
    );

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
