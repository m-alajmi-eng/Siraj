import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/prayer_local_datasource.dart';
import '../../domain/entities/prayer_times_entity.dart';

final prayerTimesProvider = Provider<PrayerTimesEntity>((ref) {
  final dataSource = PrayerLocalDataSource();
  
  // الرياض كموقع افتراضي — سنضيف GPS لاحقاً
  return dataSource.getPrayerTimes(
    latitude:  24.7136,
    longitude: 46.6753,
    date:      DateTime.now(),
  );
});

final nextPrayerProvider = Provider<String>((ref) {
  final times = ref.watch(prayerTimesProvider);
  return times.nextPrayerName;
});

final countdownProvider = Provider<String>((ref) {
  final times = ref.watch(prayerTimesProvider);
  final duration = times.timeUntilNextPrayer;
  final hours   = duration.inHours;
  final minutes = duration.inMinutes % 60;
  
  if (hours > 0) {
    return 'في $hours ساعة و$minutes دقيقة';
  }
  return 'في $minutes دقيقة';
});