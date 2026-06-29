import 'package:flutter/material.dart';
import '../theme/design_tokens.dart';

// ═══════════════════════════════════════════════════════
// GlassCard — البطاقة الزجاجية المشتركة
// تستخدم في كل الشاشات. لا تُكرّر في أي ملف.
// ═══════════════════════════════════════════════════════
class GlassCard extends StatelessWidget {
  final Widget child;
  final double radius;
  final double alpha;
  final EdgeInsetsGeometry? padding;

  const GlassCard({
    super.key,
    required this.child,
    this.radius = SirajRadiusFull.xl,
    this.alpha  = 0.068,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color:  Colors.white.withValues(alpha: alpha),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.10), width: 0.5),
        boxShadow: SirajElevation.e2,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: padding != null
            ? Padding(padding: padding!, child: child)
            : child,
      ),
    );
    return card;
  }
}
