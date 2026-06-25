import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../providers/stats_provider.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(timeThemeProvider);
    final stats   = ref.watch(statsProvider);

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'إحصائياتي',
                style: TextStyle(
                  color:      palette.textPrimary,
                  fontSize:   28,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 24),

              // Streak
              _StatCard(
                palette: palette,
                icon:    Icons.local_fire_department,
                title:   'سلسلة الصلوات',
                value:   '${stats.prayerStreak}',
                unit:    'يوم متتالي',
                color:   const Color(0xFFE8956D),
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      palette: palette,
                      icon:    Icons.mosque_outlined,
                      title:   'إجمالي الصلوات',
                      value:   '${stats.totalPrayers}',
                      unit:    'صلاة',
                      color:   palette.accentPrimary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      palette: palette,
                      icon:    Icons.menu_book_outlined,
                      title:   'صفحات القرآن',
                      value:   '${stats.quranPagesRead}',
                      unit:    'صفحة',
                      color:   palette.accentPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      palette: palette,
                      icon:    Icons.spa_outlined,
                      title:   'الأذكار',
                      value:   '${stats.athkarCompleted}',
                      unit:    'جلسة',
                      color:   palette.accentPrimary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      palette: palette,
                      icon:    Icons.auto_stories_outlined,
                      title:   'ختمات القرآن',
                      value:   '${stats.quranKhatma}',
                      unit:    'ختمة',
                      color:   const Color(0xFFC49A38),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // تقدم الختمة
              Container(
                padding:     const EdgeInsets.all(20),
                decoration:  BoxDecoration(
                  color:        palette.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'تقدم الختمة الحالية',
                      style: TextStyle(
                        color:      palette.textPrimary,
                        fontSize:   16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: (stats.quranPagesRead % 604) / 604,
                        backgroundColor: palette.background,
                        valueColor: AlwaysStoppedAnimation(
                          palette.accentPrimary),
                        minHeight: 8,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${stats.quranPagesRead % 604} / 604 صفحة',
                      style: TextStyle(
                        color:    palette.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final dynamic  palette;
  final IconData icon;
  final String   title;
  final String   value;
  final String   unit;
  final Color    color;

  const _StatCard({
    required this.palette,
    required this.icon,
    required this.title,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:    const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:        palette.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color:      palette.textPrimary,
              fontSize:   28,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            unit,
            style: TextStyle(
              color:    palette.textSecondary,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              color:    palette.textSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}