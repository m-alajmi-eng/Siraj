// اختبارات وحدة لـ KhatmahPlan: المنطق الرياضي الخالص وراء خطة الختمة.
// يغطي dailyPortion و pagesAheadOrBehind و todayPortionRange بحالات حدّية:
// بدء الخطة، منتصفها، يومها الأخير، وتجاوز مدتها، وسجل قراءة فارغ.

import 'package:flutter_test/flutter_test.dart';
import 'package:siraj/features/khatmah/domain/entities/khatmah_plan.dart';

String _dateKey(DateTime d) => '${d.year.toString().padLeft(4, '0')}-'
    '${d.month.toString().padLeft(2, '0')}-'
    '${d.day.toString().padLeft(2, '0')}';

KhatmahPlan _plan({
  required int totalDays,
  required int currentPage,
  int startPage = 1,
  int endPage = 604,
  int daysSinceStart = 0,
  Map<String, int> dailyLog = const {},
}) {
  return KhatmahPlan(
    id: 'test-plan',
    name: 'خطة اختبار',
    startDate: DateTime.now().subtract(Duration(days: daysSinceStart)),
    totalDays: totalDays,
    startPage: startPage,
    endPage: endPage,
    currentPage: currentPage,
    dailyLog: dailyLog,
    createdAt: DateTime.now(),
  );
}

void main() {
  group('dailyPortion', () {
    test('يقرّب لأعلى عند عدم القسمة الصحيحة (604/30)', () {
      final plan = _plan(totalDays: 30, currentPage: 1);
      expect(plan.dailyPortion, 21); // ceil(604 / 30) = 21
    });

    test('قسمة صحيحة بلا تقريب (600/30)', () {
      final plan = _plan(totalDays: 30, currentPage: 1, endPage: 600);
      expect(plan.dailyPortion, 20);
    });

    test('خطة يوم واحد: الورد يساوي كل الصفحات', () {
      final plan = _plan(totalDays: 1, currentPage: 1);
      expect(plan.dailyPortion, 604);
    });

    test('نطاق فرعي مخصص (10 صفحات على 3 أيام)', () {
      final plan =
          _plan(totalDays: 3, currentPage: 50, startPage: 50, endPage: 59);
      expect(plan.dailyPortion, 4); // ceil(10 / 3) = 4
    });
  });

  group('pagesAheadOrBehind', () {
    test('اليوم الأول ولم تُقرأ أي صفحة: متأخر بمقدار الورد الكامل', () {
      final plan = _plan(totalDays: 30, currentPage: 0, daysSinceStart: 0);
      expect(plan.pagesAheadOrBehind, -21);
    });

    test('بدء منتصف الخطة (اليوم 15 من 30) بالضبط حسب المخطط', () {
      final plan =
          _plan(totalDays: 30, currentPage: 315, daysSinceStart: 14);
      expect(plan.pagesAheadOrBehind, 0);
    });

    test('بدء منتصف الخطة ومتقدّم عن المخطط', () {
      final plan =
          _plan(totalDays: 30, currentPage: 340, daysSinceStart: 14);
      expect(plan.pagesAheadOrBehind, 25);
    });

    test('بدء منتصف الخطة ومتأخّر عن المخطط', () {
      final plan =
          _plan(totalDays: 30, currentPage: 300, daysSinceStart: 14);
      expect(plan.pagesAheadOrBehind, -15);
    });

    test('اليوم الأخير والختمة اكتملت بالضبط', () {
      final plan =
          _plan(totalDays: 30, currentPage: 604, daysSinceStart: 29);
      expect(plan.pagesAheadOrBehind, 0);
      expect(plan.isCompleted, isTrue);
    });

    test('تجاوز مدة الخطة المخططة دون اكتمال القراءة', () {
      final plan =
          _plan(totalDays: 30, currentPage: 500, daysSinceStart: 40);
      // اليوم الحالي يُقيَّد بحد أقصى totalDays، فالمتوقع = كل الصفحات
      expect(plan.pagesAheadOrBehind, -104);
    });
  });

  group('todayPortionRange', () {
    test('سجل فارغ: لم تُقرأ أي صفحة اليوم، النطاق يبدأ من الصفحة الحالية+1',
        () {
      final plan = _plan(
        totalDays: 30,
        currentPage: 100,
        dailyLog: const {},
      );
      expect(plan.pagesReadToday, 0);
      expect(plan.todayPortionRange, [101, 121]); // 21 صفحة ورد اليوم
    });

    test('اكتمل ورد اليوم بالفعل: النطاق فارغ/معكوس (from > to)', () {
      final yesterday =
          _dateKey(DateTime.now().subtract(const Duration(days: 1)));
      final today = KhatmahPlan.todayKey();
      final plan = _plan(
        totalDays: 30,
        currentPage: 121,
        dailyLog: {yesterday: 100, today: 121},
      );
      expect(plan.pagesReadToday, 21);
      expect(plan.todayPortionDone, isTrue);
      expect(plan.todayPortionRange, [122, 121]);
    });

    test('قرب نهاية المصحف: النطاق يتوقف عند آخر صفحة ولا يتجاوزها', () {
      final plan = _plan(
        totalDays: 30,
        currentPage: 590,
        dailyLog: const {},
      );
      // الورد اليومي 21 صفحة يتجاوز 604، فيجب أن يُقيَّد عند 604
      expect(plan.todayPortionRange, [591, 604]);
    });
  });
}
