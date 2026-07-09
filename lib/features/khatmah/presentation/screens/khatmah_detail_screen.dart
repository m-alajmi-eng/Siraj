import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/khatmah_plan.dart';
import '../providers/khatmah_provider.dart';

/// شاشة تفاصيل ختمة واحدة: شريط تقدّم + ورد اليوم + حالة + زر متابعة.
/// المرحلة 4 من KHATMAH_DESIGN.md.
class KhatmahDetailScreen extends ConsumerWidget {
  final String khatmahId;

  const KhatmahDetailScreen({super.key, required this.khatmahId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(timeThemeProvider);
    final t = AppLocalizations.of(context);
    final plans = ref.watch(khatmahProvider);

    final plan = plans.where((p) => p.id == khatmahId).firstOrNull;

    if (plan == null) {
      return Scaffold(
        appBar: AppBar(leading: BackButton(onPressed: () => context.pop())),
        body: Center(
          child: Text(t.khatmah_empty,
              style: TextStyle(color: palette.textSecondary)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        backgroundColor: palette.background,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: palette.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(plan.name, style: TextStyle(color: palette.textPrimary)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(SirajSpacing.s4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _ProgressCard(plan: plan, palette: palette, t: t),
              const SizedBox(height: SirajSpacing.s4),
              _TodayPortionCard(plan: plan, palette: palette, t: t),
              const SizedBox(height: SirajSpacing.s4),
              _StatusRow(plan: plan, palette: palette, t: t),
            ],
          ),
        ),
      ),
    );
  }
}

/// بطاقة شريط التقدّم الكبير: نسبة مئوية + صفحات مكتملة/إجمالي.
class _ProgressCard extends StatelessWidget {
  final KhatmahPlan plan;
  final dynamic palette;
  final AppLocalizations t;

  const _ProgressCard({required this.plan, required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SirajSpacing.s5),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(SirajRadiusFull.lg),
      ),
      child: Column(
        children: [
          Text(t.khatmah_progress,
              style: TextStyle(color: palette.textSecondary, fontSize: 14)),
          const SizedBox(height: SirajSpacing.s3),
          ClipRRect(
            borderRadius: BorderRadius.circular(SirajRadiusFull.pill),
            child: LinearProgressIndicator(
              value: plan.progress.clamp(0.0, 1.0),
              minHeight: 12,
              backgroundColor: palette.accentPrimary.withValues(alpha: 0.15),
              valueColor: AlwaysStoppedAnimation(palette.accentPrimary),
            ),
          ),
          const SizedBox(height: SirajSpacing.s3),
          Text(
            '${plan.pagesCompleted} / ${plan.totalPages}',
            style: TextStyle(
                color: palette.textPrimary,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: SirajSpacing.s1),
          Text(
            t.khatmah_day_of(
              plan.currentDayNumber.toString(),
              plan.totalDays.toString(),
            ),
            style: TextStyle(color: palette.textSecondary, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

/// بطاقة "وِردك اليوم": نطاق الصفحات + حالة الإنجاز + زر متابعة القراءة.
class _TodayPortionCard extends StatelessWidget {
  final KhatmahPlan plan;
  final dynamic palette;
  final AppLocalizations t;

  const _TodayPortionCard({required this.plan, required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    final range = plan.todayPortionRange;
    final rangeText = range.isEmpty
        ? '—'
        : range.length == 1
            ? '${t.khatmah_page} ${range.first}'
            : '${t.khatmah_page} ${range.first} - ${range.last}';

    return Container(
      padding: const EdgeInsets.all(SirajSpacing.s5),
      decoration: BoxDecoration(
        color: plan.todayPortionDone
            ? palette.accentPrimary.withValues(alpha: 0.12)
            : palette.surface,
        borderRadius: BorderRadius.circular(SirajRadiusFull.lg),
        border: Border.all(
          color: plan.todayPortionDone
              ? palette.accentPrimary
              : palette.accentPrimary.withValues(alpha: 0.25),
          width: plan.todayPortionDone ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                plan.todayPortionDone
                    ? Icons.check_circle
                    : Icons.menu_book_outlined,
                color: palette.accentPrimary,
              ),
              const SizedBox(width: SirajSpacing.s2),
              Text(t.khatmah_today_portion,
                  style: TextStyle(
                      color: palette.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: SirajSpacing.s2),
          Text(rangeText,
              style: TextStyle(color: palette.textSecondary, fontSize: 15)),
          const SizedBox(height: SirajSpacing.s4),
          if (!plan.todayPortionDone)
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  final startPage = range.isNotEmpty ? range.first : plan.currentPage;
                  context.push('/page-reader?page=$startPage&khatmah=${plan.id}');
                },
                child: Text(t.khatmah_read_now),
              ),
            ),
        ],
      ),
    );
  }
}

/// صف الحالة: على المسار / متأخر / متقدّم / مكتملة - مع عدد الأيام/الصفحات.
class _StatusRow extends StatelessWidget {
  final KhatmahPlan plan;
  final dynamic palette;
  final AppLocalizations t;

  const _StatusRow({required this.plan, required this.palette, required this.t});

  String _statusText() {
    if (plan.isCompleted) return t.khatmah_status_completed;
    if (plan.pagesAheadOrBehind > 0) return t.khatmah_status_ahead;
    if (plan.pagesAheadOrBehind < 0) return t.khatmah_status_behind;
    return t.khatmah_status_ontrack;
  }

  Color _statusColor() {
    if (plan.isCompleted) return const Color(0xFF4CAF50);
    if (plan.pagesAheadOrBehind > 0) return const Color(0xFF4CAF50);
    if (plan.pagesAheadOrBehind < 0) return const Color(0xFFE57373);
    return palette.accentPrimary;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: SirajSpacing.s4, vertical: SirajSpacing.s3),
      decoration: BoxDecoration(
        color: _statusColor().withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(SirajRadiusFull.md),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    color: _statusColor(), shape: BoxShape.circle),
              ),
              const SizedBox(width: SirajSpacing.s2),
              Text(_statusText(),
                  style: TextStyle(
                      color: palette.textPrimary,
                      fontWeight: FontWeight.w600)),
            ],
          ),
          if (!plan.isCompleted && plan.pagesAheadOrBehind != 0)
            Text(
              '${plan.pagesAheadOrBehind.abs()} ${t.khatmah_page}',
              style: TextStyle(color: palette.textSecondary, fontSize: 13),
            ),
        ],
      ),
    );
  }
}
