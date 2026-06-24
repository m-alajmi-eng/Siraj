import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../providers/prayer_provider.dart';

class PrayerScreen extends ConsumerWidget {
  const PrayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette    = ref.watch(timeThemeProvider);
    final timesAsync = ref.watch(prayerTimesProvider);
    final location   = ref.watch(locationProvider);

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: timesAsync.when(
            loading: () => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: palette.accentPrimary),
                  const SizedBox(height: 16),
                  Text(
                    'جارٍ تحديد موقعك...',
                    style: TextStyle(
                      color: palette.textSecondary, fontSize: 14),
                  ),
                ],
              ),
            ),
            error: (e, _) => _buildContent(
              palette, null, false),
            data: (times) => _buildContent(
              palette, times, location.value != null),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(palette, times, bool hasGPS) {
    final nextPrayer = times?.nextPrayerName ?? '---';
    final countdown  = times != null
        ? _formatCountdown(times.timeUntilNextPrayer)
        : '---';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),

        // الموقع
        Row(
          children: [
            Icon(
              hasGPS ? Icons.location_on : Icons.location_off_outlined,
              color: hasGPS
                  ? palette.accentPrimary
                  : palette.textSecondary,
              size: 14,
            ),
            const SizedBox(width: 4),
            Text(
              hasGPS ? 'موقعك الحالي' : 'الرياض (افتراضي)',
              style: TextStyle(
                color: palette.textSecondary, fontSize: 12),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Next Prayer Card
        Container(
          width:   double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color:        palette.surface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                nextPrayer,
                style: TextStyle(
                  color:      palette.textPrimary,
                  fontSize:   32,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                countdown,
                style: TextStyle(
                  color:    palette.accentPrimary,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // 5 Prayers
        if (times != null) ...[
          _PrayerRow(name: 'الفجر',  time: times.fajr,    palette: palette),
          _PrayerRow(name: 'الشروق', time: times.sunrise, palette: palette),
          _PrayerRow(name: 'الظهر',  time: times.dhuhr,   palette: palette),
          _PrayerRow(name: 'العصر',  time: times.asr,     palette: palette),
          _PrayerRow(name: 'المغرب', time: times.maghrib, palette: palette),
          _PrayerRow(name: 'العشاء', time: times.isha,    palette: palette),
        ],
      ],
    );
  }

  String _formatCountdown(Duration duration) {
    final hours   = duration.inHours;
    final minutes = duration.inMinutes % 60;
    if (hours > 0) return 'في $hours ساعة و$minutes دقيقة';
    return 'في $minutes دقيقة';
  }
}

class _PrayerRow extends StatelessWidget {
  final String   name;
  final DateTime time;
  final dynamic  palette;

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
          Text(name,
            style: TextStyle(
              color: palette.textPrimary, fontSize: 18)),
          Text('$hour:$minute',
            style: TextStyle(
              color: palette.textSecondary, fontSize: 18)),
        ],
      ),
    );
  }
}