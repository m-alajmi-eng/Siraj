import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../providers/prayer_provider.dart';

class PrayerScreen extends ConsumerWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette     = ref.watch(timeThemeProvider);
    final times       = ref.watch(prayerTimesProvider);
    final nextPrayer  = ref.watch(nextPrayerProvider);
    final countdown   = ref.watch(countdownProvider);

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // Next Prayer Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      nextPrayer,
                      style: TextStyle(
                        color: palette.textPrimary,
                        fontSize: 32,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      countdown,
                      style: TextStyle(
                        color: palette.accentPrimary,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // 5 Prayers
              _PrayerRow(name: 'الفجر',   time: times.fajr,    palette: palette),
              _PrayerRow(name: 'الظهر',   time: times.dhuhr,   palette: palette),
              _PrayerRow(name: 'العصر',   time: times.asr,     palette: palette),
              _PrayerRow(name: 'المغرب',  time: times.maghrib, palette: palette),
              _PrayerRow(name: 'العشاء',  time: times.isha,    palette: palette),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrayerRow extends StatelessWidget {
  final String name;
  final DateTime time;
  final palette;

  const _PrayerRow({
    required this.name,
    required this.time,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    final hour   = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            name,
            style: TextStyle(
              color: palette.textPrimary,
              fontSize: 18,
            ),
          ),
          Text(
            '$hour:$minute',
            style: TextStyle(
              color: palette.textSecondary,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}