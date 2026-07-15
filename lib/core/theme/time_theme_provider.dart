import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_colors.dart';

final timeThemeProvider = Provider<SirajPalette>((ref) {
  final now = DateTime.now();
  final hour = now.hour;

  // Default based on hour if no prayer times available
  if (hour >= 4 && hour < 7) return SirajColors.fajr;
  if (hour >= 7 && hour < 12) return SirajColors.morning;
  if (hour >= 12 && hour < 15) return SirajColors.dhuhr;
  if (hour >= 15 && hour < 18) return SirajColors.asr;
  if (hour >= 18 && hour < 20) return SirajColors.maghrib;
  return SirajColors.isha;
}); 