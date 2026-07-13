import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/datasources/prayer_local_datasource.dart';
import '../../../../core/storage/cache_service.dart';
import '../../domain/entities/prayer_times_entity.dart';

/// موقع المستخدم لحساب الصلاة/القبلة. يعطي أولوية للسرعة: يُرجع فوراً
/// آخر موقع محفوظ محلياً إن وُجد (لا انتظار GPS)، ويحدّث المحفوظ بهدوء
/// بالخلفية لاستخدامه في المرة القادمة - بلا أي تخزين أو مشاركة خارجية.
final locationProvider = FutureProvider<Position?>((ref) async {
  if (!Platform.isAndroid && !Platform.isIOS) return null;

  // تحديث هادئ بالخلفية بلا حجب العرض (لا ننتظر نتيجته هنا)
  unawaited(_refreshLocationInBackground());

  final saved = CacheService.getLastLocation();
  if (saved != null) {
    return Position(
      latitude: saved['lat']!,
      longitude: saved['lng']!,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0,
    );
  }

  // لا موقع محفوظ بعد (أول تشغيل) - ننتظر GPS مرة واحدة فقط هنا
  return _fetchFreshLocation();
});

Future<void> _refreshLocationInBackground() async {
  final fresh = await _fetchFreshLocation();
  if (fresh != null) {
    await CacheService.saveLastLocation(fresh.latitude, fresh.longitude);
  }
}

Future<Position?> _fetchFreshLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) return null;

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return null;
  }
  if (permission == LocationPermission.deniedForever) return null;

  try {
    return await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.medium,
      ),
    );
  } catch (_) {
    return null;
  }
}

/// طريقة حساب أوقات الصلاة (نفس المفتاح والقيم المستخدمة في
/// settings_screen.dart: MWL, ISNA, Egypt, Makkah, Kuwait, Qatar, Dubai).
/// مصدر حقيقة واحد موحّد بين شاشة الإعدادات وحساب الصلاة الفعلي -
/// أي تغيير من الإعدادات ينعكس هنا فوراً عبر هذا الـ provider.
class CalcMethodNotifier extends Notifier<String> {
  @override
  String build() {
    return CacheService.getSetting('calc_method', defaultValue: 'MWL') as String;
  }

  Future<void> setMethod(String id) async {
    state = id;
    await CacheService.saveSetting('calc_method', id);
  }
}

final calcMethodProvider = NotifierProvider<CalcMethodNotifier, String>(
  CalcMethodNotifier.new,
);

final prayerTimesProvider = FutureProvider<PrayerTimesEntity>((ref) async {
  final position   = await ref.watch(locationProvider.future);
  final calcMethod = ref.watch(calcMethodProvider);
  final dataSource = PrayerLocalDataSource();

  final lat = position?.latitude  ?? 24.7136;
  final lng = position?.longitude ?? 46.6753;

  return dataSource.getPrayerTimes(
    latitude:      lat,
    longitude:     lng,
    date:          DateTime.now(),
    calcMethodId:  calcMethod,
  );
});

final nextPrayerProvider = FutureProvider<String>((ref) async {
  final times = await ref.watch(prayerTimesProvider.future);
  return times.nextPrayerName;
});

final countdownProvider = FutureProvider<String>((ref) async {
  final times    = await ref.watch(prayerTimesProvider.future);
  final duration = times.timeUntilNextPrayer;
  final hours    = duration.inHours;
  final minutes  = duration.inMinutes % 60;
  if (hours > 0) return 'في $hours ساعة و$minutes دقيقة';
  return 'في $minutes دقيقة';
});