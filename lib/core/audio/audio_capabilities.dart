import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;

/// قدرات المنصة الحالية لطبقة الصوت (SIRAJ_Audio_Platform_Matrix.md §2).
/// الميزات تستهلك هذا للتحكّم بإظهار عناصر واجهة (مثل وعود شاشة القفل)
/// بدل تفرّع `if (Platform.isX)` مبعثر في كل ميزة.
class AudioCapabilities {
  final bool hasBackground;
  final bool hasLockScreen;
  final bool hasMediaSession;

  const AudioCapabilities({
    required this.hasBackground,
    required this.hasLockScreen,
    required this.hasMediaSession,
  });

  /// الجوال (Android/iOS): التجربة الكاملة. الويب: بلا خلفية حقيقية (قيد
  /// المتصفّح). Linux/Windows المفعَّلان حالياً: تشغيل يعمل بلا خلفية/قفل
  /// حقيقيين (النافذة تبقى تشغّل الصوت طالما مفتوحة فقط — مقبول لسطح
  /// المكتب). macOS جاهزة نظرياً (audio_service يدعم Control Center) لكن
  /// غير مفعَّلة في المشروع بعد.
  static AudioCapabilities current() {
    if (kIsWeb) {
      return const AudioCapabilities(
        hasBackground: false, hasLockScreen: false, hasMediaSession: false);
    }
    if (Platform.isAndroid || Platform.isIOS) {
      return const AudioCapabilities(
        hasBackground: true, hasLockScreen: true, hasMediaSession: true);
    }
    return const AudioCapabilities(
      hasBackground: false, hasLockScreen: false, hasMediaSession: false);
  }
}
