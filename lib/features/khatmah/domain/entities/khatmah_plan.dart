import 'dart:math' as math;

/// خطة ختمة واحدة. كائن غير قابل للتغيير (immutable).
/// يدعم النظام خططاً متعددة متزامنة (كل خطة مستقلة تماماً).
///
/// الفلسفة: النظام يدور حول "الوِرد اليومي" لا "رقم الصفحة".
class KhatmahPlan {
  final String id;
  final String name;
  final DateTime startDate;
  final int totalDays;
  final int startPage;
  final int endPage;
  final int currentPage;
  final Map<String, int> dailyLog;
  final String? reminderTime;
  final bool isActive;
  final DateTime createdAt;

  const KhatmahPlan({
    required this.id,
    required this.name,
    required this.startDate,
    required this.totalDays,
    required this.currentPage,
    required this.createdAt,
    this.startPage = 1,
    this.endPage = 604,
    this.dailyLog = const {},
    this.reminderTime,
    this.isActive = true,
  });

  int get totalPages => endPage - startPage + 1;

  int get dailyPortion => (totalPages / totalDays).ceil();

  int get pagesCompleted => (currentPage - startPage + 1).clamp(0, totalPages);

  int get pagesRemaining => totalPages - pagesCompleted;

  double get progress =>
      totalPages == 0 ? 0 : (pagesCompleted / totalPages).clamp(0.0, 1.0);

  bool get isCompleted => pagesCompleted >= totalPages;

  int get currentDayNumber {
    final today = _dateOnly(DateTime.now());
    final start = _dateOnly(startDate);
    return today.difference(start).inDays + 1;
  }

  int get expectedPagesByToday {
    final day = currentDayNumber.clamp(1, totalDays);
    return (dailyPortion * day).clamp(0, totalPages);
  }

  int get pagesAheadOrBehind => pagesCompleted - expectedPagesByToday;

  int get pagesReadToday {
    final todayK = _dateKey(DateTime.now());
    final todayEnd = dailyLog[todayK];
    if (todayEnd == null) return 0;
    int prevEnd = startPage - 1;
    final sortedKeys = dailyLog.keys.toList()..sort();
    for (final k in sortedKeys) {
      if (k.compareTo(todayK) < 0) prevEnd = dailyLog[k]!;
    }
    return (todayEnd - prevEnd).clamp(0, totalPages);
  }

  bool get todayPortionDone => pagesReadToday >= dailyPortion;

  int get todayPortionRemaining =>
      (dailyPortion - pagesReadToday).clamp(0, dailyPortion);

  List<int> get todayPortionRange {
    final from = math.min(currentPage + 1, endPage);
    final to = math.min(currentPage + todayPortionRemaining, endPage);
    return [from, to];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'startDate': startDate.toIso8601String(),
        'totalDays': totalDays,
        'startPage': startPage,
        'endPage': endPage,
        'currentPage': currentPage,
        'dailyLog': dailyLog,
        'reminderTime': reminderTime,
        'isActive': isActive,
        'createdAt': createdAt.toIso8601String(),
      };

  factory KhatmahPlan.fromJson(Map<String, dynamic> json) => KhatmahPlan(
        id: json['id'] as String,
        name: json['name'] as String,
        startDate: DateTime.parse(json['startDate'] as String),
        totalDays: json['totalDays'] as int,
        startPage: json['startPage'] as int? ?? 1,
        endPage: json['endPage'] as int? ?? 604,
        currentPage: json['currentPage'] as int,
        dailyLog: (json['dailyLog'] as Map?)?.map(
              (k, v) => MapEntry(k as String, v as int),
            ) ??
            const {},
        reminderTime: json['reminderTime'] as String?,
        isActive: json['isActive'] as bool? ?? true,
        createdAt: DateTime.parse(json['createdAt'] as String),
      );

  KhatmahPlan copyWith({
    String? name,
    int? currentPage,
    Map<String, int>? dailyLog,
    String? reminderTime,
    bool? isActive,
  }) =>
      KhatmahPlan(
        id: id,
        name: name ?? this.name,
        startDate: startDate,
        totalDays: totalDays,
        startPage: startPage,
        endPage: endPage,
        currentPage: currentPage ?? this.currentPage,
        dailyLog: dailyLog ?? this.dailyLog,
        reminderTime: reminderTime ?? this.reminderTime,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt,
      );

  static DateTime _dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  static String _dateKey(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-'
      '${d.month.toString().padLeft(2, '0')}-'
      '${d.day.toString().padLeft(2, '0')}';

  static String todayKey() => _dateKey(DateTime.now());
}
