import 'package:flutter/material.dart';
import '../theme/design_tokens.dart';
import '../theme/app_text.dart';

// ═══════════════════════════════════════════════════════
// SectionLabel — عنوان القسم الصغير مع النقطة الذهبية
// ═══════════════════════════════════════════════════════
class SectionLabel extends StatelessWidget {
  final String label;
  const SectionLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 3, height: 3,
          decoration: const BoxDecoration(
            color: SirajGold.muted, shape: BoxShape.circle),
        ),
        const SizedBox(width: SirajSpacing.s2),
        Text(label.toUpperCase(), style: AppText.label),
      ],
    );
  }
}
