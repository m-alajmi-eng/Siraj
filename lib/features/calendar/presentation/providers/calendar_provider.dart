import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/storage/cache_service.dart';

// ─── تحويل ميلادي → هجري ─────────────────────────────────
class HijriDate {
  final int day;
  final int month;
  final int year;

  const HijriDate({
    required this.day,
    required this.month,
    required this.year,
  });

  static const List<String> monthNames = [
    'محرم', 'صفر', 'ربيع الأول', 'ربيع الآخر',
    'جمادى الأولى', 'جمادى الآخرة', 'رجب', 'شعبان',
    'رمضان', 'شوال', 'ذو القعدة', 'ذو الحجة',
  ];

  static const List<String> dayNames = [
    'الأحد', 'الاثنين', 'الثلاثاء', 'الأربعاء',
    'الخميس', 'الجمعة', 'السبت',
  ];

  String get monthName => monthNames[month - 1];

  /// [dayOffset] تصحيح اجتهاد الرؤية اليدوي (عادة ±2 يوماً) — الخوارزمية
  /// الجدولية (Kuwaiti) قد تنحرف عن إعلان رؤية الهلال الرسمي محلياً؛
  /// الإزاحة تُطبَّق على التاريخ الميلادي قبل التحويل، فتنسحب تلقائياً
  /// على الشهر/السنة الهجريَّين بلا حساب لفّ يدوي.
  static HijriDate fromGregorian(DateTime date, {int dayOffset = 0}) {
    final shifted =
        dayOffset == 0 ? date : date.add(Duration(days: dayOffset));
    int y = shifted.year;
    int m = shifted.month;
    int d = shifted.day;

    int jd = ((1461 * (y + 4800 + (m - 14) ~/ 12)) ~/ 4) +
             ((367 * (m - 2 - 12 * ((m - 14) ~/ 12))) ~/ 12) -
             ((3 * ((y + 4900 + (m - 14) ~/ 12) ~/ 100)) ~/ 4) +
             d - 32075;

    int l  = jd - 1948440 + 10632;
    int n  = (l - 1) ~/ 10631;
    l      = l - 10631 * n + 354;
    int j  = ((10985 - l) ~/ 5316) * ((50 * l) ~/ 17719) +
             (l ~/ 5670) * ((43 * l) ~/ 15238);
    l      = l - ((30 - j) ~/ 15) * ((17719 * j) ~/ 50) -
             (j ~/ 16) * ((15238 * j) ~/ 43) + 29;
    int hm = (24 * l) ~/ 709;
    int hd = l - (709 * hm) ~/ 24;
    int hy = 30 * n + j - 30;

    return HijriDate(day: hd, month: hm, year: hy);
  }
}

// ─── المناسبات الإسلامية ──────────────────────────────────
class IslamicEvent {
  final String id;
  final String title;
  final int    hijriMonth;
  final int    hijriDay;
  final String type;

  const IslamicEvent({
    required this.id,
    required this.title,
    required this.hijriMonth,
    required this.hijriDay,
    required this.type,
  });
}

const List<IslamicEvent> islamicEvents = [
  IslamicEvent(id: 'new_year', title: 'رأس السنة الهجرية', hijriMonth: 1, hijriDay: 1, type: 'blessed'),
  IslamicEvent(id: 'ashura', title: 'يوم عاشوراء',           hijriMonth: 1,  hijriDay: 10, type: 'fast'),
  IslamicEvent(id: 'mawlid', title: 'المولد النبوي',          hijriMonth: 3,  hijriDay: 12, type: 'blessed'),
  IslamicEvent(id: 'isra', title: 'ليلة الإسراء والمعراج', hijriMonth: 7, hijriDay: 27, type: 'blessed'),
  IslamicEvent(id: 'ramadan_start', title: 'أول رمضان',             hijriMonth: 9,  hijriDay: 1,  type: 'eid'),
  IslamicEvent(id: 'laylat_qadr', title: 'ليلة القدر (27)',        hijriMonth: 9,  hijriDay: 27, type: 'blessed'),
  IslamicEvent(id: 'eid_fitr', title: 'عيد الفطر',             hijriMonth: 10, hijriDay: 1,  type: 'eid'),
  IslamicEvent(id: 'arafah', title: 'يوم عرفة',              hijriMonth: 12, hijriDay: 9,  type: 'fast'),
  IslamicEvent(id: 'eid_adha', title: 'عيد الأضحى',            hijriMonth: 12, hijriDay: 10, type: 'eid'),
  IslamicEvent(id: 'tashreeq', title: 'أيام التشريق',          hijriMonth: 12, hijriDay: 11, type: 'eid'),
  IslamicEvent(id: 'tashreeq', title: 'أيام التشريق',          hijriMonth: 12, hijriDay: 12, type: 'eid'),
  IslamicEvent(id: 'tashreeq', title: 'أيام التشريق',          hijriMonth: 12, hijriDay: 13, type: 'eid'),
];

// ─── Providers ────────────────────────────────────────────
class SelectedDateNotifier extends Notifier<DateTime> {
  @override
  DateTime build() => DateTime.now();
  void select(DateTime date) => state = date;
}

final selectedDateProvider =
    NotifierProvider<SelectedDateNotifier, DateTime>(() {
  return SelectedDateNotifier();
});

/// تصحيح الهجري اليدوي (ADR PHASE L §I): -2..+2 يوماً، محفوظ في الإعدادات.
class HijriOffsetNotifier extends Notifier<int> {
  @override
  int build() =>
      (CacheService.getSetting('hijri_offset', defaultValue: 0) as int)
          .clamp(-2, 2);

  Future<void> setOffset(int offset) async {
    final clamped = offset.clamp(-2, 2);
    state = clamped;
    await CacheService.saveSetting('hijri_offset', clamped);
  }
}

final hijriOffsetProvider =
    NotifierProvider<HijriOffsetNotifier, int>(HijriOffsetNotifier.new);

final hijriTodayProvider = Provider<HijriDate>((ref) {
  final offset = ref.watch(hijriOffsetProvider);
  return HijriDate.fromGregorian(DateTime.now(), dayOffset: offset);
});

final todayEventsProvider = Provider<List<IslamicEvent>>((ref) {
  final hijri = ref.watch(hijriTodayProvider);
  return islamicEvents.where((e) =>
    e.hijriMonth == hijri.month && e.hijriDay == hijri.day
  ).toList();
});

final monthEventsProvider =
    Provider.family<List<IslamicEvent>, int>((ref, month) {
  return islamicEvents.where((e) => e.hijriMonth == month).toList();
});

final nextEventProvider = Provider<Map<String, dynamic>>((ref) {
  final today = ref.watch(hijriTodayProvider);
  final events = islamicEvents.where((e) =>
    e.hijriMonth > today.month ||
    (e.hijriMonth == today.month && e.hijriDay > today.day)
  ).toList();

  if (events.isEmpty) return {'event': islamicEvents.first, 'days': 30};

  final next     = events.first;
  final daysLeft = (next.hijriMonth - today.month) * 29 +
                   (next.hijriDay  - today.day);

  return {'event': next, 'days': daysLeft};
});