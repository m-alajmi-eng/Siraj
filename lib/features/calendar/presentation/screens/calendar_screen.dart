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

Color eventColor(String type) {
  switch (type) {
    case 'eid':     return const Color(0xFF50B478);
    case 'fast':    return const Color(0xFF6EB4D0);
    case 'blessed': return SirajGold.pure;
    default:        return SirajWhite.w40;
  }
}

String eventIcon(String type) {
  switch (type) {
    case 'eid':     return '🎉';
    case 'fast':    return '🌙';
    case 'blessed': return '✨';
    default:        return '📅';
  }
}

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late DateTime _viewedMonth;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _viewedMonth = DateTime(now.year, now.month, 1);
  }

  void _prevMonth() => setState(() =>
      _viewedMonth = DateTime(_viewedMonth.year, _viewedMonth.month - 1, 1));
  void _nextMonth() => setState(() =>
      _viewedMonth = DateTime(_viewedMonth.year, _viewedMonth.month + 1, 1));

  void _showEventDetail(BuildContext context, IslamicEvent event, dynamic palette, AppLocalizations t) {
    showModalBottomSheet(
      context: context,
      backgroundColor: palette.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(SirajRadiusFull.xl)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(SirajSpacing.s5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(eventIcon(event.type), style: const TextStyle(fontSize: 28)),
                const SizedBox(width: SirajSpacing.s3),
                Expanded(
                  child: Text(eventName(t, event), style: AppText.title.copyWith(
                    color: palette.textPrimary)),
                ),
              ],
            ),
            const SizedBox(height: SirajSpacing.s2),
            Text(
              '${event.hijriDay} ${hijriMonthName(t, event.hijriMonth)}',
              style: AppText.body.copyWith(color: palette.textSecondary),
            ),
            const SizedBox(height: SirajSpacing.s4),
            // ملاحظة صادقة: لا محتوى ديني إضافي (آية/حديث/وصف) مُدرَج هنا
            // بعد - أي إضافة كهذه تحتاج مراجعة دينية معتمَدة (ADR-008)
            // قبل عرضها، فلا تُخترَع الآن. راجع docs/DESIGN_MIGRATION_PLAN.md.
            Container(
              padding: const EdgeInsets.all(SirajSpacing.s3),
              decoration: BoxDecoration(
                color: palette.background,
                borderRadius: BorderRadius.circular(SirajRadiusFull.md),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: palette.textSecondary),
                  const SizedBox(width: SirajSpacing.s2),
                  Expanded(
                    child: Text(t.cal_detailPending, style: AppText.caption.copyWith(
                      color: palette.textSecondary)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t           = AppLocalizations.of(context);
    final palette     = ref.watch(timeThemeProvider);
    final hijriToday  = ref.watch(hijriTodayProvider);
    final todayEvents = ref.watch(todayEventsProvider);
    final hijriOffset = ref.watch(hijriOffsetProvider);
    final now         = DateTime.now();

    final sortedEvents = ref.watch(sortedEventsProvider);
    final nextEvent = sortedEvents.first;
    final nextEventDays = daysUntilEvent(hijriToday, nextEvent);

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
                const SizedBox(height: SirajSpacing.s3),
                _HijriOffsetControl(palette: palette, t: t, offset: hijriOffset,
                  onChanged: (v) =>
                      ref.read(hijriOffsetProvider.notifier).setOffset(v)),
              ],
            ),
          ),
          const SizedBox(height: SirajSpacing.s4),

          // ─── شبكة التقويم الشهرية ───
          _MonthGrid(
            viewedMonth: _viewedMonth,
            palette: palette,
            t: t,
            hijriOffset: hijriOffset,
            onPrev: _prevMonth,
            onNext: _nextMonth,
            onDayTap: (hijri) {
              final match = islamicEvents.where(
                (e) => e.hijriMonth == hijri.month && e.hijriDay == hijri.day);
              if (match.isNotEmpty) {
                _showEventDetail(context, match.first, palette, t);
              }
            },
          ),
          const SizedBox(height: SirajSpacing.s4),

          // ─── مناسبات اليوم ───
          if (todayEvents.isNotEmpty) ...[
            _SectionTitle(title: t.cal_todayEvents, palette: palette),
            ...todayEvents.map((e) =>
              _EventCard(event: e, palette: palette, t: t,
                onTap: () => _showEventDetail(context, e, palette, t))),
            const SizedBox(height: SirajSpacing.s2),
          ],

          // ─── المناسبة القادمة ───
          _SectionTitle(title: t.cal_nextEvent, palette: palette),
          GestureDetector(
            onTap: () => _showEventDetail(context, nextEvent, palette, t),
            child: Container(
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
                    child: Text(t.cal_daysUntil(nextEventDays),
                      style: AppText.bodySmall.copyWith(
                        color: palette.background, fontWeight: FontWeight.w600)),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(eventName(t, nextEvent),
                          style: AppText.body.copyWith(
                            color: palette.textPrimary, fontWeight: FontWeight.w500)),
                        Text('${nextEvent.hijriDay} ${hijriMonthName(t, nextEvent.hijriMonth)}',
                          style: AppText.caption.copyWith(color: palette.textSecondary)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: SirajSpacing.s4),

          // ─── كل المناسبات (مرتَّبة حسب الأقرب زمنياً) ───
          _SectionTitle(title: t.cal_allEvents, palette: palette),
          ...sortedEvents.map((e) =>
            _EventCard(event: e, palette: palette, t: t,
              onTap: () => _showEventDetail(context, e, palette, t))),
          const SizedBox(height: SirajSpacing.s8),
        ],
      ),
    );
  }
}

class _MonthGrid extends StatelessWidget {
  final DateTime viewedMonth;
  final dynamic palette;
  final AppLocalizations t;
  final int hijriOffset;
  final VoidCallback onPrev;
  final VoidCallback onNext;
  final void Function(HijriDate hijri) onDayTap;

  const _MonthGrid({
    required this.viewedMonth,
    required this.palette,
    required this.t,
    required this.hijriOffset,
    required this.onPrev,
    required this.onNext,
    required this.onDayTap,
  });

  List<String> _weekdayLabels(AppLocalizations t) => [
    t.cal_wd_sun, t.cal_wd_mon, t.cal_wd_tue, t.cal_wd_wed,
    t.cal_wd_thu, t.cal_wd_fri, t.cal_wd_sat,
  ];

  @override
  Widget build(BuildContext context) {
    final daysInMonth = DateTime(viewedMonth.year, viewedMonth.month + 1, 0).day;
    // Flutter: Monday=1..Sunday=7 → نريد الأحد=0..السبت=6
    final leadingBlanks = viewedMonth.weekday % 7;
    final now = DateTime.now();
    final isCurrentMonth = now.year == viewedMonth.year && now.month == viewedMonth.month;

    final monthLabel = '${_gregorianMonthName(viewedMonth.month)} ${viewedMonth.year}';

    return Container(
      padding: const EdgeInsets.all(SirajSpacing.s4),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(SirajRadiusFull.xl),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Semantics(
                button: true,
                label: t.cal_prevMonth,
                child: GestureDetector(
                  onTap: onPrev,
                  child: Container(
                    width: 32, height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: palette.background,
                    ),
                    child: Icon(Icons.chevron_right, size: 18, color: palette.textSecondary),
                  ),
                ),
              ),
              Text(monthLabel, style: AppText.body.copyWith(
                color: palette.textPrimary, fontWeight: FontWeight.w600)),
              Semantics(
                button: true,
                label: t.cal_nextMonth,
                child: GestureDetector(
                  onTap: onNext,
                  child: Container(
                    width: 32, height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: palette.background,
                    ),
                    child: Icon(Icons.chevron_left, size: 18, color: palette.textSecondary),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: SirajSpacing.s3),
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              for (final label in _weekdayLabels(t))
                Center(
                  child: Text(label, style: AppText.caption.copyWith(
                    color: palette.textSecondary, fontSize: 10)),
                ),
              for (var i = 0; i < leadingBlanks; i++) const SizedBox(),
              for (var day = 1; day <= daysInMonth; day++)
                _DayCell(
                  date: DateTime(viewedMonth.year, viewedMonth.month, day),
                  isToday: isCurrentMonth && day == now.day,
                  palette: palette,
                  hijriOffset: hijriOffset,
                  onTap: onDayTap,
                ),
            ],
          ),
          const SizedBox(height: SirajSpacing.s3),
          // مفتاح الألوان (Legend)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _LegendDot(color: eventColor('eid'), label: t.cal_legendEid, palette: palette),
              const SizedBox(width: SirajSpacing.s3),
              _LegendDot(color: eventColor('fast'), label: t.cal_legendFast, palette: palette),
              const SizedBox(width: SirajSpacing.s3),
              _LegendDot(color: eventColor('blessed'), label: t.cal_legendBlessed, palette: palette),
            ],
          ),
        ],
      ),
    );
  }

  String _gregorianMonthName(int m) {
    const names = [
      'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
    ];
    return names[m - 1];
  }
}

/// تصحيح الهجري اليدوي (ADR PHASE L §I): ±2 يوماً — الخوارزمية الجدولية
/// (Kuwaiti) قد تنحرف عن إعلان رؤية الهلال الرسمي محلياً.
class _HijriOffsetControl extends StatelessWidget {
  final dynamic palette;
  final AppLocalizations t;
  final int offset;
  final ValueChanged<int> onChanged;

  const _HijriOffsetControl({
    required this.palette,
    required this.t,
    required this.offset,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final label = offset == 0 ? '0' : (offset > 0 ? '+$offset' : '$offset');
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(t.cal_hijriOffset, style: AppText.caption.copyWith(
          color: palette.textSecondary)),
        const SizedBox(width: SirajSpacing.s2),
        Semantics(
          button: true,
          label: t.common_prevPage,
          child: GestureDetector(
            onTap: offset > -2 ? () => onChanged(offset - 1) : null,
            child: Icon(Icons.remove_circle_outline, size: 18,
              color: offset > -2
                  ? palette.accentPrimary
                  : palette.textSecondary.withValues(alpha: 0.3)),
          ),
        ),
        SizedBox(
          width: 28,
          child: Text(label, textAlign: TextAlign.center,
            style: AppText.caption.copyWith(
              color: palette.textPrimary, fontWeight: FontWeight.w600)),
        ),
        Semantics(
          button: true,
          label: t.common_nextPage,
          child: GestureDetector(
            onTap: offset < 2 ? () => onChanged(offset + 1) : null,
            child: Icon(Icons.add_circle_outline, size: 18,
              color: offset < 2
                  ? palette.accentPrimary
                  : palette.textSecondary.withValues(alpha: 0.3)),
          ),
        ),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  final dynamic palette;
  const _LegendDot({required this.color, required this.label, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6, height: 6,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 4),
        Text(label, style: AppText.caption.copyWith(
          color: palette.textSecondary, fontSize: 10)),
      ],
    );
  }
}

class _DayCell extends StatelessWidget {
  final DateTime date;
  final bool isToday;
  final dynamic palette;
  final int hijriOffset;
  final void Function(HijriDate hijri) onTap;

  const _DayCell({
    required this.date,
    required this.isToday,
    required this.palette,
    required this.hijriOffset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hijri = HijriDate.fromGregorian(date, dayOffset: hijriOffset);
    final matchingEvents = islamicEvents.where(
      (e) => e.hijriMonth == hijri.month && e.hijriDay == hijri.day);
    final hasEvent = matchingEvents.isNotEmpty;

    // الرقمان معاً (ADR PHASE L §I): هجري بارز + ميلادي ثانوي صغير أسفله
    // بدل الميلادي وحده كما كان سابقاً رغم حساب hijri فعلياً لكل خلية.
    return GestureDetector(
      onTap: hasEvent ? () => onTap(hijri) : null,
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isToday
              ? Border.all(color: SirajGold.pure, width: 1.5)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${hijri.day}', style: AppText.caption.copyWith(
              color: isToday ? SirajGold.pure : palette.textPrimary,
              fontWeight: isToday ? FontWeight.w700 : FontWeight.w400,
            )),
            Text('${date.day}', style: AppText.caption.copyWith(
              color: palette.textSecondary, fontSize: 8)),
            if (hasEvent)
              Container(
                width: 4, height: 4,
                margin: const EdgeInsets.only(top: 1),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: eventColor(matchingEvents.first.type),
                ),
              )
            else
              const SizedBox(height: 5),
          ],
        ),
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
  final VoidCallback onTap;
  const _EventCard({
    required this.event,
    required this.palette,
    required this.t,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: SirajSpacing.s2),
        padding: const EdgeInsets.all(SirajSpacing.s4),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(SirajRadiusFull.md),
          border: BorderDirectional(
            start: BorderSide(color: eventColor(event.type), width: 3),
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
                Text(eventIcon(event.type), style: const TextStyle(fontSize: 16)),
                const SizedBox(width: SirajSpacing.s1),
                Icon(Icons.chevron_left, size: 14, color: palette.textSecondary),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
