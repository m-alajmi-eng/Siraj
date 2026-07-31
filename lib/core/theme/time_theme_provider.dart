import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_colors.dart';
import '../../features/prayer/presentation/providers/prayer_provider.dart';
import '../../features/prayer/domain/entities/prayer_times_entity.dart';

/// الثيم الزمني يعتمد الآن على أوقات الصلاة الفعلية لموقع المستخدم
/// (prayerTimesProvider، مستهلَك أصلاً في home_screen.dart فيطلب صلاحية
/// الموقع هناك أول مرة) بدل ساعة عامة ثابتة لا تراعي اختلاف التوقيت
/// الفعلي حسب خط الطول/الفصل. المنطق المبني على الساعة يبقى فقط كسقوط
/// احتياطي (fallback) عند تعذّر الوصول لموقع/وقت صلاة فعلي (لا شبكة،
/// صلاحية موقع مرفوضة، أو الحالة لا تزال قيد التحميل).
final timeThemeProvider = Provider<SirajPalette>((ref) {
  final prayerTimesAsync = ref.watch(prayerTimesProvider);
  final now = DateTime.now();

  return prayerTimesAsync.maybeWhen(
    data: (times) => _paletteForPrayerTimes(times, now),
    orElse: () => _paletteForHour(now.hour),
  );
});

SirajPalette _paletteForPrayerTimes(PrayerTimesEntity times, DateTime now) {
  if (now.isBefore(times.fajr))    return SirajColors.isha;
  if (now.isBefore(times.sunrise)) return SirajColors.fajr;
  if (now.isBefore(times.dhuhr))   return SirajColors.morning;
  if (now.isBefore(times.asr))     return SirajColors.dhuhr;
  if (now.isBefore(times.maghrib)) return SirajColors.asr;
  if (now.isBefore(times.isha))    return SirajColors.maghrib;
  return SirajColors.isha;
}

SirajPalette _paletteForHour(int hour) {
  if (hour >= 4 && hour < 7) return SirajColors.fajr;
  if (hour >= 7 && hour < 12) return SirajColors.morning;
  if (hour >= 12 && hour < 15) return SirajColors.dhuhr;
  if (hour >= 15 && hour < 18) return SirajColors.asr;
  if (hour >= 18 && hour < 20) return SirajColors.maghrib;
  return SirajColors.isha;
}