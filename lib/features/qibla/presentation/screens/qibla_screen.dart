import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../prayer/presentation/providers/prayer_provider.dart';
import '../providers/qibla_heading_provider.dart';

// إحداثيات الكعبة المشرَّفة (نفس الثابت المستخدَم كموقع احتياطي عالمي
// في locationProvider — مصدر واحد بلا تكرار للرقم السحري).
const _kaabaLat = kMakkahLatitude;
const _kaabaLng = kMakkahLongitude;

class _QiblaResult {
  final double bearingDeg; // من الشمال (0-360) باتجاه القبلة
  final double distanceKm;
  const _QiblaResult({required this.bearingDeg, required this.distanceKm});
}

/// اتجاه القبلة (bearing) والمسافة إلى الكعبة عبر صيغ الدائرة العظمى
/// (great-circle) القياسية - يحتاج فقط إحداثيات الموقع الحالي (نفس ما
/// تستخدمه أوقات الصلاة فعلاً). اتجاه الجهاز الحيّ (البوصلة) منفصل تماماً
/// ويأتي من qiblaHeadingProvider (PHASE F).
_QiblaResult _computeQibla(double lat, double lng) {
  final phi1  = lat * math.pi / 180;
  final phi2  = _kaabaLat * math.pi / 180;
  final dLambda = (_kaabaLng - lng) * math.pi / 180;

  final y = math.sin(dLambda) * math.cos(phi2);
  final x = math.cos(phi1) * math.sin(phi2) -
      math.sin(phi1) * math.cos(phi2) * math.cos(dLambda);
  final bearing = (math.atan2(y, x) * 180 / math.pi + 360) % 360;

  const earthRadiusKm = 6371.0;
  final dPhi = phi2 - phi1;
  final a = math.sin(dPhi / 2) * math.sin(dPhi / 2) +
      math.cos(phi1) * math.cos(phi2) * math.sin(dLambda / 2) * math.sin(dLambda / 2);
  final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  final distanceKm = earthRadiusKm * c;

  return _QiblaResult(bearingDeg: bearing, distanceKm: distanceKm);
}

class QiblaScreen extends ConsumerWidget {
  const QiblaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t          = AppLocalizations.of(context);
    final palette    = ref.watch(timeThemeProvider);
    final locationAsync = ref.watch(locationProvider);
    final headingAsync  = ref.watch(qiblaHeadingProvider);

    return AppScaffold(
      title: t.qibla_title,
      child: locationAsync.when(
        loading: () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: palette.accentPrimary),
              const SizedBox(height: SirajSpacing.s3),
              Text(t.common_loading, style: AppText.body.copyWith(color: palette.textSecondary)),
            ],
          ),
        ),
        error: (_, _) => _QiblaContent(
          palette: palette, t: t, hasGps: false,
          result: _computeQibla(_kaabaLat, _kaabaLng),
          heading: headingAsync.value,
        ),
        data: (location) => _QiblaContent(
          palette: palette, t: t, hasGps: location.hasRealFix,
          result: _computeQibla(location.latitude, location.longitude),
          heading: headingAsync.value,
        ),
      ),
    );
  }
}

class _QiblaContent extends StatefulWidget {
  final dynamic palette;
  final AppLocalizations t;
  final bool hasGps;
  final _QiblaResult result;
  /// null = لا بوصلة حيّة متاحة (منصة غير مدعومة أو لا مستشعر) — سهم ثابت
  /// عند bearing المطلق كما كان الوضع الوحيد سابقاً.
  final QiblaHeading? heading;

  const _QiblaContent({
    required this.palette,
    required this.t,
    required this.hasGps,
    required this.result,
    required this.heading,
  });

  @override
  State<_QiblaContent> createState() => _QiblaContentState();
}

class _QiblaContentState extends State<_QiblaContent> with SingleTickerProviderStateMixin {
  late final AnimationController _entrance;

  @override
  void initState() {
    super.initState();
    _entrance = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 600))..forward();
  }

  @override
  void dispose() {
    _entrance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = widget.palette;
    final t       = widget.t;
    final bearing = widget.result.bearingDeg;
    final distKm  = widget.result.distanceKm;
    final heading = widget.heading;
    final isLive  = heading != null;

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: SirajSpacing.s6),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // موقع GPS أم مكة الافتراضية (نفس نمط شاشة الصلاة تماماً)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.hasGps ? Icons.location_on : Icons.location_off_outlined,
                    color: widget.hasGps ? palette.accentPrimary : palette.textSecondary,
                    size: 14,
                  ),
                  const SizedBox(width: SirajSpacing.s1),
                  Text(
                    widget.hasGps ? t.prayer_locationGPS : t.prayer_locationDefault,
                    style: AppText.caption.copyWith(color: palette.textSecondary),
                  ),
                ],
              ),
              const SizedBox(height: SirajSpacing.s2),

              // حالة البوصلة: حيّة ودقيقة، أم وضع ثابت (لا مستشعر)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isLive ? Icons.explore : Icons.explore_off_outlined,
                    color: isLive ? palette.accentPrimary : palette.textSecondary,
                    size: 14,
                  ),
                  const SizedBox(width: SirajSpacing.s1),
                  Text(
                    isLive ? t.qibla_active : t.qibla_staticMode,
                    style: AppText.caption.copyWith(color: palette.textSecondary),
                  ),
                ],
              ),
              if (isLive && heading.needsCalibration) ...[
                const SizedBox(height: SirajSpacing.s1),
                Text(
                  t.qibla_calibrationHint,
                  textAlign: TextAlign.center,
                  style: AppText.caption.copyWith(color: Colors.amber),
                ),
              ],

              const SizedBox(height: SirajSpacing.s6),

              AnimatedBuilder(
                animation: _entrance,
                builder: (context, child) {
                  final curved = Curves.easeOutBack.transform(_entrance.value);
                  return Opacity(
                    opacity: _entrance.value.clamp(0.0, 1.0),
                    child: Transform.scale(scale: 0.8 + 0.2 * curved, child: child),
                  );
                },
                child: TweenAnimationBuilder<double>(
                  // دوران القرص بالكامل بعكس اتجاه الجهاز الحيّ (0 عند عدم
                  // توفّر بوصلة = يبقى السهم عند bearing المطلق كما في
                  // الوضع الثابت السابق تماماً). تحريك سلس بين القراءات
                  // المتتالية بدل قفزات مفاجئة.
                  tween: Tween<double>(
                    begin: 0,
                    end: isLive ? -heading.headingDeg : 0,
                  ),
                  duration: const Duration(milliseconds: 150),
                  builder: (context, dialRotationDeg, child) {
                    return Transform.rotate(
                      angle: dialRotationDeg * math.pi / 180,
                      child: child,
                    );
                  },
                  child: SizedBox(
                    width: 260, height: 260,
                    child: CustomPaint(
                      painter: _CompassPainter(
                        bearingDeg: bearing,
                        accent: palette.accentPrimary,
                        ring: palette.textSecondary.withValues(alpha: 0.25),
                        textColor: palette.textPrimary,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: SirajSpacing.s6),

              Text('${bearing.round()}°',
                style: AppText.title.copyWith(
                  color: palette.textPrimary, fontSize: SirajSizes.s4xl, fontWeight: FontWeight.w700)),
              const SizedBox(height: SirajSpacing.s1),
              Text(t.qibla_fromNorth,
                style: AppText.bodySmall.copyWith(color: palette.textSecondary)),

              const SizedBox(height: SirajSpacing.s5),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SirajSpacing.s4, vertical: SirajSpacing.s2),
                decoration: BoxDecoration(
                  color: palette.accentPrimary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(SirajRadiusFull.xl),
                ),
                child: Text(
                  t.qibla_distanceKm(distKm.round(), t.qibla_kaaba),
                  style: AppText.bodySmall.copyWith(
                    color: palette.accentPrimary, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── بوصلة ─────────────────────────────────────────────────
// ترسم القرص (علامات الاتجاهات N/E/S/W + السهم عند bearing القبلة
// المطلق). يدور القرص كاملاً حول مركزه بعكس اتجاه الجهاز الحيّ (عبر
// Transform.rotate في الودجت الأب) عند توفّر بوصلة فعلية، فيبقى السهم
// دوماً مشيراً فعلياً نحو القبلة الحقيقية بصرف النظر عن اتجاه حمل
// الجهاز — تماماً كسلوك أي تطبيق بوصلة قياسي. بلا بوصلة (وضع ثابت):
// لا دوران، السهم يشير لـbearing المطلق كما كان الوضع الوحيد سابقاً.
class _CompassPainter extends CustomPainter {
  final double bearingDeg;
  final Color accent;
  final Color ring;
  final Color textColor;

  _CompassPainter({
    required this.bearingDeg,
    required this.accent,
    required this.ring,
    required this.textColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    final ringPaint = Paint()
      ..color = ring
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius - 4, ringPaint);
    canvas.drawCircle(center, radius * 0.7, ringPaint);

    // علامات الاتجاهات الأربع الرئيسية
    for (var i = 0; i < 4; i++) {
      final angle = i * math.pi / 2;
      final p1 = center + Offset(math.sin(angle), -math.cos(angle)) * (radius - 4);
      final p2 = center + Offset(math.sin(angle), -math.cos(angle)) * (radius - 14);
      canvas.drawLine(p1, p2, ringPaint..strokeWidth = 2);
    }
    const labels = ['N', 'E', 'S', 'W'];
    for (var i = 0; i < 4; i++) {
      final angle = i * math.pi / 2;
      final pos = center + Offset(math.sin(angle), -math.cos(angle)) * (radius - 24);
      final tp = TextPainter(
        text: TextSpan(text: labels[i], style: TextStyle(
          color: textColor.withValues(alpha: 0.6), fontSize: 12, fontWeight: FontWeight.w600)),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, pos - Offset(tp.width / 2, tp.height / 2));
    }

    // السهم نحو القبلة عند bearing الفعلي
    final rad = bearingDeg * math.pi / 180;
    final tip  = center + Offset(math.sin(rad), -math.cos(rad)) * (radius * 0.68);
    final tail = center - Offset(math.sin(rad), -math.cos(rad)) * (radius * 0.22);

    final arrowPaint = Paint()
      ..color = accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(tail, tip, arrowPaint);

    // رأس السهم
    final headAngle1 = rad + math.pi - 0.4;
    final headAngle2 = rad + math.pi + 0.4;
    final head1 = tip + Offset(math.sin(headAngle1), -math.cos(headAngle1)) * 16;
    final head2 = tip + Offset(math.sin(headAngle2), -math.cos(headAngle2)) * 16;
    final headPaint = Paint()..color = accent..style = PaintingStyle.fill;
    canvas.drawPath(
      Path()
        ..moveTo(tip.dx, tip.dy)
        ..lineTo(head1.dx, head1.dy)
        ..lineTo(head2.dx, head2.dy)
        ..close(),
      headPaint,
    );

    // نقطة المركز
    canvas.drawCircle(center, 5, Paint()..color = accent);
  }

  @override
  bool shouldRepaint(covariant _CompassPainter oldDelegate) =>
      oldDelegate.bearingDeg != bearingDeg ||
      oldDelegate.accent     != accent ||
      oldDelegate.textColor  != textColor;
}
