import 'package:flutter/material.dart';

enum SirajTimeOfDay { fajr, morning, dhuhr, asr, maghrib, isha }

class SirajPalette {
  final Color background;
  final Color surface;
  final Color accentPrimary;
  final Color textPrimary;
  final Color textSecondary;
  final String label;

  const SirajPalette({
    required this.background,
    required this.surface,
    required this.accentPrimary,
    required this.textPrimary,
    required this.textSecondary,
    required this.label,
  });
}

class SirajColors {
  static const fajr = SirajPalette(
    background:    Color(0xFF0D1B2A),
    surface:       Color(0xFF152232),
    accentPrimary: Color(0xFF5B8FB9),
    textPrimary:   Color(0xFFD6E8F2),
    textSecondary: Color(0xFF7A9EB8),
    label:         'الفجر',
  );

  static const morning = SirajPalette(
    background:    Color(0xFFF5F1EA),
    surface:       Color(0xFFFFFFFF),
    accentPrimary: Color(0xFF3D6B4F),
    textPrimary:   Color(0xFF1A1208),
    textSecondary: Color(0xFF6B5F50),
    label:         'الصباح',
  );

  static const dhuhr = SirajPalette(
    background:    Color(0xFFF2EDE0),
    surface:       Color(0xFFFEFAF2),
    accentPrimary: Color(0xFFA07030),
    textPrimary:   Color(0xFF1A1000),
    textSecondary: Color(0xFF7A6040),
    label:         'الظهر',
  );

  static const asr = SirajPalette(
    background:    Color(0xFFEDE5D8),
    surface:       Color(0xFFFAF5EE),
    accentPrimary: Color(0xFFC06020),
    textPrimary:   Color(0xFF1A0800),
    textSecondary: Color(0xFF8C6030),
    label:         'العصر',
  );

  static const maghrib = SirajPalette(
    background:    Color(0xFF1A0F1E),
    surface:       Color(0xFF261A30),
    accentPrimary: Color(0xFFE8956D),
    textPrimary:   Color(0xFFF2E8DC),
    textSecondary: Color(0xFFB088A0),
    label:         'المغرب',
  );

  static const isha = SirajPalette(
    background:    Color(0xFF070A0E),
    surface:       Color(0xFF0F1520),
    accentPrimary: Color(0xFF4A6FA5),
    textPrimary:   Color(0xFFC8D8E8),
    textSecondary: Color(0xFF5A7090),
    label:         'العشاء',
  );

  static SirajPalette paletteFor(SirajTimeOfDay t) {
    switch (t) {
      case SirajTimeOfDay.fajr:    return fajr;
      case SirajTimeOfDay.morning: return morning;
      case SirajTimeOfDay.dhuhr:   return dhuhr;
      case SirajTimeOfDay.asr:     return asr;
      case SirajTimeOfDay.maghrib: return maghrib;
      case SirajTimeOfDay.isha:    return isha;
    }
  }
}