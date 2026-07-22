import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../providers/stats_provider.dart';

class StatsScreen extends ConsumerWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t       = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);
    final stats   = ref.watch(statsProvider);

    return AppScaffold(
      title: t.stats_title,
      child: ListView(
        children: [
          _StatCard(
            palette: palette,
            icon: Icons.local_fire_department,
            title: t.stats_prayerStreak,
            value: '${stats.prayerStreak}',
            unit: t.stats_daysStreak,
            color: const Color(0xFFE8956D),
          ),
          const SizedBox(height: SirajSpacing.s3),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  palette: palette,
                  icon: Icons.mosque_outlined,
                  title: t.stats_totalPrayers,
                  value: '${stats.totalPrayers}',
                  unit: t.stats_prayersUnit,
                  color: palette.accentPrimary,
                ),
              ),
              const SizedBox(width: SirajSpacing.s3),
              Expanded(
                child: _StatCard(
                  palette: palette,
                  icon: Icons.menu_book_outlined,
                  title: t.stats_quranPages,
                  value: '${stats.quranPagesRead}',
                  unit: t.stats_pagesUnit,
                  color: palette.accentPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: SirajSpacing.s3),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  palette: palette,
                  icon: Icons.spa_outlined,
                  title: t.stats_athkar,
                  value: '${stats.athkarCompleted}',
                  unit: t.stats_sessionsUnit,
                  color: palette.accentPrimary,
                ),
              ),
              const SizedBox(width: SirajSpacing.s3),
              Expanded(
                child: _StatCard(
                  palette: palette,
                  icon: Icons.auto_stories_outlined,
                  title: t.stats_khatma,
                  value: '${stats.quranKhatma}',
                  unit: t.stats_khatmaUnit,
                  color: const Color(0xFFC49A38),
                ),
              ),
            ],
          ),
          const SizedBox(height: SirajSpacing.s6),
          Container(
            padding: const EdgeInsets.all(SirajSpacing.s5),
            decoration: BoxDecoration(
              color: palette.surface,
              borderRadius: BorderRadius.circular(SirajRadiusFull.lg),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(t.stats_currentKhatma, style: AppText.headline.copyWith(
                  color: palette.textPrimary)),
                const SizedBox(height: SirajSpacing.s3),
                ClipRRect(
                  borderRadius: BorderRadius.circular(SirajRadiusFull.xs),
                  child: LinearProgressIndicator(
                    value: (stats.quranPagesRead % 604) / 604,
                    backgroundColor: palette.background,
                    valueColor: AlwaysStoppedAnimation(palette.accentPrimary),
                    minHeight: 8,
                  ),
                ),
                const SizedBox(height: SirajSpacing.s2),
                Text(t.stats_pagesOf(stats.quranPagesRead % 604, 604),
                  style: AppText.bodySmall.copyWith(color: palette.textSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final dynamic palette;
  final IconData icon;
  final String title;
  final String value;
  final String unit;
  final Color color;

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
      padding: const EdgeInsets.all(SirajSpacing.s4),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(SirajRadiusFull.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: SirajSpacing.s2),
          Text(value, style: AppText.displayMedium.copyWith(
            color: palette.textPrimary)),
          Text(unit, style: AppText.caption.copyWith(color: palette.textSecondary)),
          const SizedBox(height: SirajSpacing.s1),
          Text(title, style: AppText.caption.copyWith(
            color: palette.textSecondary, fontSize: SirajSizes.sSm)),
        ],
      ),
    );
  }
}