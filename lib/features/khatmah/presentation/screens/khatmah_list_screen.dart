import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../providers/khatmah_provider.dart';
import '../../domain/entities/khatmah_plan.dart';

class KhatmahListScreen extends ConsumerWidget {
  const KhatmahListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);
    final plans = ref.watch(khatmahProvider);
    final active = plans.where((p) => p.isActive && !p.isCompleted).toList();
    final done = plans.where((p) => p.isCompleted || !p.isActive).toList();

    return AppScaffold(
      title: t.khatmah_title,
      padding: EdgeInsets.zero,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: palette.accentPrimary,
        onPressed: () => context.push('/khatmah/create'),
        icon: const Icon(Icons.add),
        label: Text(t.khatmah_new),
      ),
      child: plans.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(SirajSpacing.s8),
                child: Text(t.khatmah_empty,
                    textAlign: TextAlign.center,
                    style: AppText.body
                        .copyWith(color: palette.textSecondary)),
              ),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(
                  horizontal: SirajLayout.pagePadding),
              children: [
                ...active.map((p) => _KhatmahCard(plan: p, palette: palette, t: t)),
                if (done.isNotEmpty) ...[
                  const SizedBox(height: SirajSpacing.s4),
                  Text(t.khatmah_status_completed,
                      style: AppText.caption
                          .copyWith(color: palette.textSecondary)),
                  const SizedBox(height: SirajSpacing.s2),
                  ...done.map((p) => _KhatmahCard(plan: p, palette: palette, t: t)),
                ],
                const SizedBox(height: SirajSpacing.s16),
              ],
            ),
    );
  }
}

class _KhatmahCard extends StatelessWidget {
  final KhatmahPlan plan;
  final SirajPalette palette;
  final AppLocalizations t;

  const _KhatmahCard({required this.plan, required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    final statusText = plan.isCompleted
        ? t.khatmah_status_completed
        : plan.pagesAheadOrBehind >= 0
            ? (plan.pagesAheadOrBehind == 0
                ? t.khatmah_status_ontrack
                : t.khatmah_status_ahead)
            : t.khatmah_status_behind;
    final statusColor = plan.isCompleted
        ? palette.accentPrimary
        : plan.pagesAheadOrBehind >= 0
            ? Colors.green
            : Colors.orange;

    return GestureDetector(
      onTap: () => context.push('/khatmah/detail/${plan.id}'),
      child: Container(
        margin: const EdgeInsets.only(bottom: SirajSpacing.s3),
        padding: const EdgeInsets.all(SirajSpacing.s4),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(SirajRadiusFull.md),
        ),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(plan.name,
                        style: AppText.body.copyWith(
                            color: palette.textPrimary,
                            fontWeight: FontWeight.w600)),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: SirajSpacing.s2, vertical: 2),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(SirajRadiusFull.xs),
                    ),
                    child: Text(statusText,
                        style: AppText.caption.copyWith(color: statusColor)),
                  ),
                ],
              ),
              const SizedBox(height: SirajSpacing.s3),
              ClipRRect(
                borderRadius: BorderRadius.circular(SirajRadiusFull.pill),
                child: LinearProgressIndicator(
                  value: plan.progress,
                  minHeight: 8,
                  backgroundColor: palette.background,
                  valueColor: AlwaysStoppedAnimation(palette.accentPrimary),
                ),
              ),
              const SizedBox(height: SirajSpacing.s2),
              Text(
                '${(plan.progress * 100).round()}% · '
                '${t.khatmah_day_of(plan.currentDayNumber.clamp(1, plan.totalDays), plan.totalDays)}',
                style: AppText.caption.copyWith(color: palette.textSecondary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
