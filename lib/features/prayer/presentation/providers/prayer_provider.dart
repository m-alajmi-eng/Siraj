import 'dart:async';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/datasources/prayer_local_datasource.dart';
import '../../../../core/storage/cache_service.dart';
import '../../domain/entities/prayer_times_entity.dart';

/// إحداثيات الكعبة المشرّفة — تُستخدَم كموقع احتياطي عالمي محايد عند غياب
/// GPS (بدل تحيّز أي مدينة بعينها)، بدل الرياض المثبَّتة سابقاً (ADR/
/// Master Roadmap PHASE C2).
const kMakkahLatitude = 21.4225;
const kMakkahLongitude = 39.8262;

const _rescheduleThresholdMeters = 10000.0; // 10كم — عتبة إعادة الجدولة

/// حالة الموقع المستهلَكة في الواجهة: الإحداثيات + هل هي GPS حقيقي أم
/// سقوط احتياطي على مكة (لعرض شارة توضيحية بدل صمت كامل — ADR C2).
class LocationState {
  final double latitude;
  final double longitude;
  final bool hasRealFix;

  const LocationState({
    required this.latitude,
    required this.longitude,
    required this.hasRealFix,
  });

  static const fallback = LocationState(
    latitude: kMakkahLatitude,
    longitude: kMakkahLongitude,
    hasRealFix: false,
  );
}

/// موقع المستخدم لحساب الصلاة/القبلة. يعطي أولوية للسرعة: يُرجع فوراً
/// آخر موقع محفوظ محلياً إن وُجد (لا انتظار GPS)، ويحدّث المحفوظ بهدوء
/// بالخلفية، ويُعيد بناء حالته فعلياً (invalidate) عند تحرّك المستخدم
/// أكثر من 10كم كي يُعاد جدولة الإشعارات على الموقع الصحيح تلقائياً
/// (كان سابقاً يُرجع فوراً بلا تحديث حيّ — PHASE C1).
class LocationNotifier extends AsyncNotifier<LocationState> {
  @override
  Future<LocationState> build() async {
    if (!Platform.isAndroid && !Platform.isIOS) return LocationState.fallback;

    unawaited(_refreshInBackground());

    final saved = CacheService.getLastLocation();
    if (saved != null) {
      return LocationState(
        latitude: saved['lat']!,
        longitude: saved['lng']!,
        hasRealFix: true,
      );
    }

    final fresh = await _fetchFreshLocation();
    if (fresh == null) return LocationState.fallback;
    await CacheService.saveLastLocation(fresh.latitude, fresh.longitude);
    return LocationState(
      latitude: fresh.latitude,
      longitude: fresh.longitude,
      hasRealFix: true,
    );
  }

  Future<void> _refreshInBackground() async {
    final fresh = await _fetchFreshLocation();
    if (fresh == null) return;
    await CacheService.saveLastLocation(fresh.latitude, fresh.longitude);

    final current = state.value;
    final moved = current == null ||
        !current.hasRealFix ||
        Geolocator.distanceBetween(
              current.latitude,
              current.longitude,
              fresh.latitude,
              fresh.longitude,
            ) >
            _rescheduleThresholdMeters;
    if (!moved) return;

    state = AsyncData(LocationState(
      latitude: fresh.latitude,
      longitude: fresh.longitude,
      hasRealFix: true,
    ));
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
}

final locationProvider =
    AsyncNotifierProvider<LocationNotifier, LocationState>(
  LocationNotifier.new,
);

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

/// المذهب الفقهي المعتمَد لحساب العصر (hanafi/maliki/shafi/hanbali).
/// كان مثبَّتاً على Madhab.shafi في مسار الحساب بلا وصل فعلي بالإعداد
/// المحفوظ من Onboarding/الإعدادات — يُستهلَك الآن هنا فعلياً (ADR-011).
class MadhabNotifier extends Notifier<String> {
  @override
  String build() {
    return CacheService.getSetting('madhab', defaultValue: 'shafi') as String;
  }

  Future<void> setMadhab(String id) async {
    state = id;
    await CacheService.saveSetting('madhab', id);
  }
}

final madhabProvider = NotifierProvider<MadhabNotifier, String>(
  MadhabNotifier.new,
);

final prayerTimesProvider = FutureProvider<PrayerTimesEntity>((ref) async {
  final location   = await ref.watch(locationProvider.future);
  final calcMethod = ref.watch(calcMethodProvider);
  final madhab     = ref.watch(madhabProvider);
  final dataSource = PrayerLocalDataSource();

  return dataSource.getPrayerTimes(
    latitude:      location.latitude,
    longitude:     location.longitude,
    date:          DateTime.now(),
    calcMethodId:  calcMethod,
    madhabId:      madhab,
  );
});
