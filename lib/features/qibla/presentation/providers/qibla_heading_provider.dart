import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

/// اتجاه البوصلة الحيّ (0-360°، الشمال المغناطيسي) + مؤشّر معايرة إرشادي.
class QiblaHeading {
  final double headingDeg;
  final bool needsCalibration;
  const QiblaHeading({required this.headingDeg, required this.needsCalibration});
}

/// بث اتجاه البوصلة الحيّ (tilt-compensated) من مستشعري المغناطيسية
/// والتسارع معاً (PHASE F). `null` = لا مستشعر متاح فعلياً — إما منصة لا
/// تدعم sensors_plus أصلاً (Linux/Windows/macOS — الحزمة لا تعلن تنفيذاً
/// لها في pubspec.yaml الخاص بها إطلاقاً)، أو جهاز محمول بلا مغناطيسية
/// فعلية (لا يرمي استثناءً بالضرورة، فقط لا يُصدر أي حدث — مهلة 3 ثوانٍ
/// تكشف هذه الحالة). في كلتا الحالتين: الشاشة تسقط على الوضع الثابت
/// المسمّى بوضوح بدل التظاهر ببوصلة تعمل.
final qiblaHeadingProvider = StreamProvider.autoDispose<QiblaHeading?>((ref) {
  if (!Platform.isAndroid && !Platform.isIOS) {
    return Stream.value(null);
  }

  final controller = StreamController<QiblaHeading?>();
  AccelerometerEvent? lastAccel;
  double? smoothedHeading;
  var gotFirstEvent = false;

  void handleMagnetometer(MagnetometerEvent m) {
    final a = lastAccel;
    if (a == null) return;
    gotFirstEvent = true;

    // بوصلة معوَّضة بالميلان (tilt-compensated) — نفس صيغة
    // Android SensorManager.getRotationMatrix + getOrientation القياسية،
    // مطبَّقة يدوياً لأن sensors_plus يوفّر تسارع/مغناطيسية خام فقط.
    double hx = m.y * a.z - m.z * a.y;
    double hy = m.z * a.x - m.x * a.z;
    double hz = m.x * a.y - m.y * a.x;
    final normH = math.sqrt(hx * hx + hy * hy + hz * hz);
    if (normH < 0.1) return; // عيّنة لحظية غير صالحة (نادرة) — تجاهل فقط

    hx /= normH;
    hy /= normH;
    hz /= normH;

    final invA = 1 / math.sqrt(a.x * a.x + a.y * a.y + a.z * a.z);
    final ax = a.x * invA, az = a.z * invA;
    final my = az * hx - ax * hz;

    final rawHeadingRad = math.atan2(hy, my);
    final headingDeg = (rawHeadingRad * 180 / math.pi + 360) % 360;

    // تنعيم دائري (متوسّط أسّي عبر أقصر مسار زاوي) لتخفيف اهتزاز القراءات
    // الخام بلا تأخّر ملحوظ في الاستجابة.
    if (smoothedHeading == null) {
      smoothedHeading = headingDeg;
    } else {
      var delta = headingDeg - smoothedHeading!;
      delta = ((delta + 540) % 360) - 180;
      smoothedHeading = (smoothedHeading! + delta * 0.25 + 360) % 360;
    }

    // قوة المجال المغناطيسي الطبيعية على سطح الأرض تقريباً 25-65 ميكروتسلا؛
    // خارج هذا النطاق تلميح عملي على تداخل مغناطيسي/معايرة سيئة — sensors_plus
    // لا يوفّر Sensor.accuracy الحقيقي من النظام، فهذا تقدير إرشادي بديل لا
    // بديل دقيق كامل.
    final fieldStrength = math.sqrt(m.x * m.x + m.y * m.y + m.z * m.z);
    final needsCalibration = fieldStrength < 15 || fieldStrength > 100;

    controller.add(QiblaHeading(
      headingDeg: smoothedHeading!,
      needsCalibration: needsCalibration,
    ));
  }

  final accelSub = accelerometerEventStream(
    samplingPeriod: SensorInterval.uiInterval,
  ).listen((e) => lastAccel = e, onError: (_) {
    if (!controller.isClosed) controller.add(null);
  });

  final magSub = magnetometerEventStream(
    samplingPeriod: SensorInterval.uiInterval,
  ).listen(handleMagnetometer, onError: (_) {
    if (!controller.isClosed) controller.add(null);
  });

  final noSensorTimer = Timer(const Duration(seconds: 3), () {
    if (!gotFirstEvent && !controller.isClosed) controller.add(null);
  });

  ref.onDispose(() {
    accelSub.cancel();
    magSub.cancel();
    noSensorTimer.cancel();
    controller.close();
  });

  return controller.stream;
});
