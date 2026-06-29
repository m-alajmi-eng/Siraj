import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../providers/calendar_provider.dart';

// ترجمة اسم الشهر الهجري حسب رقمه
String hijriMonthName(AppLocalizations t, int m) {
  switch (m) {
    case 1:  return t.hm_1;
    case 2:  return t.hm_2;
    case 3:  return t.hm_3;
    case 4:  return t.hm_4;
    case 5:  return t.hm_5;
    case 6:  return t.hm_6;
    case 7:  return t.hm_7;
    case 8:  return t.hm_8;
    case 9:  return t.hm_9;
    case 10: return t.hm_10;
    case 11: return t.hm_11;
    default: return t.hm_12;
  }
}

// ترجمة اسم الحدث حسب id (مع fallback للعربي)
String eventName(AppLocalizations t, IslamicEvent e) {
  switch (e.id) {
    case 'new_year':      return t.ev_new_year;
    case 'ashura':        return t.ev_ashura;
    case 'mawlid':        return t.ev_mawlid;
    case 'isra':          return t.ev_isra;
    case 'ramadan_start': return t.ev_ramadan_start;
    case 'laylat_qadr':   return t.ev_laylat_qadr;
    case 'eid_fitr':      return t.ev_eid_fitr;
    case 'arafah':        return t.ev_arafah;
    case 'eid_adha':      return t.ev_eid_adha;
    case 'tashreeq':      return t.ev_tashreeq;
    default:              return e.title;
  }
}

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t           = AppLocalizations.of(context);
    final palette     = ref.watch(timeThemeProvider);
    final hijriToday  = ref.watch(hijriTodayProvider);
    final todayEvents = ref.watch(todayEventsProvider);
    final nextEvent   = ref.watch(nextEventProvider);
    final now         = DateTime.now();

    return AppScaffold(
      title: t.cal_title,
      padding: EdgeInsets.zero,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s4),
        children: [
          // ─── بطاقة اليوم الهجري ───
          Container(
            padding: const EdgeInsets.all(SirajSpacing.s6),
            decoration: BoxDecoration(
              color: palette.surface,
              borderRadius: BorderRadius.circular(SirajRadiusFull.xl),
              border: Border.all(
                color: palette.accentPrimary.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                Text('${hijriToday.day}', style: AppText.displayLarge.copyWith(
                  color: palette.accentPrimary, fontSize: 72,
                  fontWeight: FontWeight.w200)),
                Text(hijriMonthName(t, hijriToday.month),
                  style: AppText.title.copyWith(color: palette.textPrimary)),
                Text('${hijriToday.year} ${t.cal_hijri}',
                  style: AppText.body.copyWith(color: palette.textSecondary)),
                const SizedBox(height: SirajSpacing.s3),
                Divider(color: palette.accentPrimary.withValues(alpha: 0.2)),
                const SizedBox(height: SirajSpacing.s3),
                Text('${now.day} / ${now.month} / ${now.year}',
                  style: AppText.bodySmall.copyWith(color: palette.textSecondary)),
              ],
            ),
          ),
          const SizedBox(height: SirajSpacing.s4),

          // ─── مناسبات اليوم ───
          if (todayEvents.isNotEmpty) ...[
            _SectionTitle(title: t.cal_todayEvents, palette: palette),
            ...todayEvents.map((e) =>
              _EventCard(event: e, palette: palette, t: t)),
            const SizedBox(height: SirajSpacing.s2),
          ],

          // ─── المناسبة القادمة ───
          _SectionTitle(title: t.cal_nextEvent, palette: palette),
          Container(
            padding: const EdgeInsets.all(SirajSpacing.s4),
            decoration: BoxDecoration(
              color: palette.surface,
              borderRadius: BorderRadius.circular(SirajRadiusFull.md),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SirajSpacing.s3, vertical: SirajSpacing.s1),
                  decoration: BoxDecoration(
                    color: palette.accentPrimary,
                    borderRadius: BorderRadius.circular(SirajRadiusFull.xl),
                  ),
                  child: Text(t.cal_daysUntil(nextEvent['days'] as int),
                    style: AppText.bodySmall.copyWith(
                      color: palette.background, fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(eventName(t, nextEvent['event'] as IslamicEvent),
                        style: AppText.body.copyWith(
                          color: palette.textPrimary, fontWeight: FontWeight.w500)),
                      Text('${(nextEvent['event'] as IslamicEvent).hijriDay} '
                          '${hijriMonthName(t, (nextEvent['event'] as IslamicEvent).hijriMonth)}',
                        style: AppText.caption.copyWith(color: palette.textSecondary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: SirajSpacing.s4),

          // ─── كل المناسبات ───
          _SectionTitle(title: t.cal_allEvents, palette: palette),
          ...islamicEvents.map((e) =>
            _EventCard(event: e, palette: palette, t: t)),
          const SizedBox(height: SirajSpacing.s8),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  final dynamic palette;
  const _SectionTitle({required this.title, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: SirajSpacing.s2, top: SirajSpacing.s1),
      child: Align(
        alignment: AlignmentDirectional.centerStart,
        child: Text(title, style: AppText.bodySmall.copyWith(
          color: palette.accentPrimary)),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final IslamicEvent event;
  final dynamic palette;
  final AppLocalizations t;
  const _EventCard({required this.event, required this.palette, required this.t});

  Color _eventColor() {
    switch (event.type) {
      case 'eid':     return const Color(0xFF50B478);
      case 'fast':    return const Color(0xFF6EB4D0);
      case 'blessed': return SirajGold.pure;
      default:        return SirajWhite.w40;
    }
  }

  String _eventIcon() {
    switch (event.type) {
      case 'eid':     return '🎉';
      case 'fast':    return '🌙';
      case 'blessed': return '✨';
      default:        return '📅';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: SirajSpacing.s2),
      padding: const EdgeInsets.all(SirajSpacing.s4),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(SirajRadiusFull.md),
        border: BorderDirectional(
          start: BorderSide(color: _eventColor(), width: 3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('${event.hijriDay} ${hijriMonthName(t, event.hijriMonth)}',
            style: AppText.caption.copyWith(color: palette.textSecondary)),
          Row(
            children: [
              Text(eventName(t, event), style: AppText.bodySmall.copyWith(
                color: palette.textPrimary)),
              const SizedBox(width: SirajSpacing.s2),
              Text(_eventIcon(), style: const TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}
