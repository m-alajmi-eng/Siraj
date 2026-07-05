import 'package:flutter/material.dart';
import '../../domain/entities/tajweed_entity.dart';

/// يعرض نص آية ملوّناً بحسب قواعد التجويد.
/// يبني TextSpan متداخلة بأمان حتى مع تراكب/تجاور المواضع.
class TajweedText extends StatelessWidget {
  final TajweedAyah ayah;
  final Map<String, Color> ruleColors;
  final TextStyle baseStyle;
  final TextAlign textAlign;

  const TajweedText({
    super.key,
    required this.ayah,
    required this.ruleColors,
    required this.baseStyle,
    this.textAlign = TextAlign.right,
  });

  @override
  Widget build(BuildContext context) {
    final spans = _buildSpans();
    return RichText(
      textAlign: textAlign,
      textDirection: TextDirection.rtl,
      text: TextSpan(style: baseStyle, children: spans),
    );
  }

  List<InlineSpan> _buildSpans() {
    final text = ayah.plain;
    if (ayah.annotations.isEmpty) {
      return [TextSpan(text: text)];
    }

    final breakpoints = <int>{0, text.length};
    for (final a in ayah.annotations) {
      breakpoints.add(a.start.clamp(0, text.length));
      breakpoints.add(a.end.clamp(0, text.length));
    }
    final sorted = breakpoints.toList()..sort();

    final spans = <InlineSpan>[];
    for (int i = 0; i < sorted.length - 1; i++) {
      final start = sorted[i];
      final end = sorted[i + 1];
      if (start >= end) continue;

      Color? color;
      for (final a in ayah.annotations) {
        if (a.start <= start && a.end >= end) {
          color = ruleColors[a.rule];
        }
      }

      spans.add(TextSpan(
        text: text.substring(start, end),
        style: color != null ? TextStyle(color: color) : null,
      ));
    }
    return spans;
  }
}
