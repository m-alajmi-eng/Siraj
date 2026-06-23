import 'package:adhan/adhan.dart';
import '../../domain/entities/prayer_times_entity.dart';

class PrayerLocalDataSource {
  PrayerTimesEntity getPrayerTimes({
    required double latitude,
    required double longitude,
    required DateTime date,
  }) {
    final coordinates = Coordinates(latitude, longitude);
    final params = CalculationMethod.muslim_world_league.getParameters();
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