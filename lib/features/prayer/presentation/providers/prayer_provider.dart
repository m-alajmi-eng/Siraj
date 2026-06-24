import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/datasources/prayer_local_datasource.dart';
import '../../domain/entities/prayer_times_entity.dart';

// Provider للموقع
final locationProvider = FutureProvider<Position?>((ref) async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) return null;

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return null;
  }
  if (permission == LocationPermission.deniedForever) return null;

  return await Geolocator.getCurrentPosition(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.medium,
    ),
  );
});

// Provider لأوقات الصلاة مع GPS
final prayerTimesProvider = FutureProvider<PrayerTimesEntity>((ref) async {
  final position = await ref.watch(locationProvider.future);
  final dataSource = PrayerLocalDataSource();

  // إذا لم يتوفر GPS — الرياض افتراضياً
  final lat = position?.latitude  ?? 24.7136;
  final lng = position?.longitude ?? 46.6753;

  return dataSource.getPrayerTimes(
    latitude:  lat,
    longitude: lng,
    date:      DateTime.now(),
  );
});

final nextPrayerProvider = FutureProvider<String>((ref) async {
  final times = await ref.watch(prayerTimesProvider.future);
  return times.nextPrayerName;
});

final countdownProvider = FutureProvider<String>((ref) async {
  final times = await ref.watch(prayerTimesProvider.future);
  final duration = times.timeUntilNextPrayer;
  final hours    = duration.inHours;
  final minutes  = duration.inMinutes % 60;
  if (hours > 0) return 'في $hours ساعة و$minutes دقيقة';
  return 'في $minutes دقيقة';
});