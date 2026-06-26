import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../providers/calendar_provider.dart';

class CalendarScreen extends ConsumerWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette     = ref.watch(timeThemeProvider);
    final hijriToday  = ref.watch(hijriTodayProvider);
    final todayEvents = ref.watch(todayEventsProvider);
    final nextEvent   = ref.watch(nextEventProvider);
    final now         = DateTime.now();

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [

            // ─── Header ─────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text(
                'التقويم الإسلامي',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color:      palette.textPrimary,
                  fontSize:   28,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),

            // ─── اليوم الهجري ────────────────────────────
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color:        palette.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: palette.accentPrimary.withOpacity(0.3)),
              ),
              child: Column(
                children: [
                  Text(
                    '${hijriToday.day}',
                    style: TextStyle(
                      color:      palette.accentPrimary,
                      fontSize:   72,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                  Text(
                    hijriToday.monthName,
                    style: TextStyle(
                      color:      palette.textPrimary,
                      fontSize:   24,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Text(
                    '${hijriToday.year} هـ',
                    style: TextStyle(
                      color:    palette.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Divider(
                    color: palette.accentPrimary.withOpacity(0.2)),
                  const SizedBox(height: 12),
                  Text(
                    '${now.day} ${_monthName(now.month)} ${now.year} م',
                    style: TextStyle(
                      color:    palette.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    HijriDate.dayNames[now.weekday % 7],
                    style: TextStyle(
                      color:    palette.accentPrimary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ─── مناسبات اليوم ───────────────────────────
            if (todayEvents.isNotEmpty) ...[
              _SectionTitle(
                title: 'مناسبات اليوم', palette: palette),
              ...todayEvents.map((e) => _EventCard(
                event: e, palette: palette)),
              const SizedBox(height: 8),
            ],

            // ─── القادم ──────────────────────────────────
            _SectionTitle(
              title: 'المناسبة القادمة', palette: palette),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color:        palette.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color:        palette.accentPrimary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${nextEvent['days']} يوم',
                      style: TextStyle(
                        color:      palette.background,
                        fontSize:   13,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        (nextEvent['event'] as IslamicEvent).title,
                        style: TextStyle(
                          color:      palette.textPrimary,
                          fontSize:   16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${(nextEvent['event'] as IslamicEvent).hijriDay} '
                        '${HijriDate.monthNames[(nextEvent['event'] as IslamicEvent).hijriMonth - 1]}',
                        style: TextStyle(
                          color:    palette.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ─── كل المناسبات ────────────────────────────
            _SectionTitle(
              title: 'المناسبات الإسلامية', palette: palette),

            ...islamicEvents.map((e) => _EventCard(
              event: e, palette: palette)),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو',
      'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر',
    ];
    return months[month - 1];
  }
}

// ─── Section Title ────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String  title;
  final dynamic palette;
  const _SectionTitle({required this.title, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Text(
        title,
        textAlign: TextAlign.right,
        style: TextStyle(
          color:    palette.accentPrimary,
          fontSize: 13,
        ),
      ),
    );
  }
}

// ─── Event Card ───────────────────────────────────────────
class _EventCard extends StatelessWidget {
  final IslamicEvent event;
  final dynamic      palette;
  const _EventCard({required this.event, required this.palette});

  Color _eventColor() {
    switch (event.type) {
      case 'eid':     return Colors.green;
      case 'fast':    return Colors.blue;
      case 'blessed': return Colors.amber;
      default:        return Colors.grey;
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
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color:        palette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          right: BorderSide(
            color: _eventColor(),
            width: 3,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${event.hijriDay} ${HijriDate.monthNames[event.hijriMonth - 1]}',
            style: TextStyle(
              color:    palette.textSecondary,
              fontSize: 12,
            ),
          ),
          Row(
            children: [
              Text(
                event.title,
                style: TextStyle(
                  color:    palette.textPrimary,
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 8),
              Text(_eventIcon(), style: const TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
} 