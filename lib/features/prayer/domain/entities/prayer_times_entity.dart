class PrayerTimesEntity {
  final DateTime fajr;
  final DateTime sunrise;
  final DateTime dhuhr;
  final DateTime asr;
  final DateTime maghrib;
  final DateTime isha;
  final DateTime date;

  const PrayerTimesEntity({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
    required this.date,
  });

  String get nextPrayerName {
    final now = DateTime.now();
    if (now.isBefore(fajr))    return 'الفجر';
    if (now.isBefore(dhuhr))   return 'الظهر';
    if (now.isBefore(asr))     return 'العصر';
    if (now.isBefore(maghrib)) return 'المغرب';
    if (now.isBefore(isha))    return 'العشاء';
    return 'الفجر';
  }

  DateTime get nextPrayerTime {
    final now = DateTime.now();
    if (now.isBefore(fajr))    return fajr;
    if (now.isBefore(dhuhr))   return dhuhr;
    if (now.isBefore(asr))     return asr;
    if (now.isBefore(maghrib)) return maghrib;
    if (now.isBefore(isha))    return isha;
    return fajr.add(const Duration(days: 1));
  }

  Duration get timeUntilNextPrayer {
    return nextPrayerTime.difference(DateTime.now());
  }

  String get nextPrayerNameAr => nextPrayerName;

  String get nextPrayerNameEn {
    final now = DateTime.now();
    if (now.isBefore(fajr))    return 'Fajr';
    if (now.isBefore(dhuhr))   return 'Dhuhr';
    if (now.isBefore(asr))     return 'Asr';
    if (now.isBefore(maghrib)) return 'Maghrib';
    if (now.isBefore(isha))    return 'Isha';
    return 'Fajr';
  }

  String get nextPrayerTimeStr {
    final t = nextPrayerTime;
    return t.hour.toString().padLeft(2, '0') + ':' + t.minute.toString().padLeft(2, '0');
  }
}
