// اختبار مخطَّط معرّفات الإشعارات (PHASE L3): يتحقّق أن مدَيات الأذان
// (0-69)، الإقامة (4000-4069)، والختمة (1000000+) لا تتقاطع أبداً، وأن
// كل معرّف داخل مداه فريد. أي تصادم هنا يعني إشعارَين مختلفَين يُلغي
// أحدهما الآخر صامتاً (نفس id عند flutter_local_notifications).

import 'package:flutter_test/flutter_test.dart';
import 'package:siraj/core/notifications/adhan_service.dart';
import 'package:siraj/features/khatmah/data/services/khatmah_reminder_service.dart';

void main() {
  group('معرّفات إشعارات الأذان', () {
    test('كل معرّفات الصلاة عبر 7 أيام × 5 صلوات فريدة', () {
      final ids = <int>{};
      for (var day = 0; day < AdhanService.daysAhead; day++) {
        for (var prayer = 0; prayer < 5; prayer++) {
          final id = AdhanService.prayerNotificationId(day, prayer);
          expect(ids.contains(id), isFalse,
              reason: 'تصادم معرّف صلاة: يوم $day صلاة $prayer → $id');
          ids.add(id);
        }
      }
      expect(ids.length, AdhanService.daysAhead * 5);
    });

    test('كل معرّفات الإقامة عبر 7 أيام × 5 صلوات فريدة', () {
      final ids = <int>{};
      for (var day = 0; day < AdhanService.daysAhead; day++) {
        for (var prayer = 0; prayer < 5; prayer++) {
          final id = AdhanService.iqamaNotificationId(day, prayer);
          expect(ids.contains(id), isFalse,
              reason: 'تصادم معرّف إقامة: يوم $day صلاة $prayer → $id');
          ids.add(id);
        }
      }
      expect(ids.length, AdhanService.daysAhead * 5);
    });

    test('مدى معرّفات الصلاة (0-69) لا يتقاطع مع مدى الإقامة (4000-4069)', () {
      for (var day = 0; day < AdhanService.daysAhead; day++) {
        for (var prayer = 0; prayer < 5; prayer++) {
          final prayerId = AdhanService.prayerNotificationId(day, prayer);
          final iqamaId = AdhanService.iqamaNotificationId(day, prayer);
          expect(prayerId, lessThan(4000));
          expect(iqamaId, greaterThanOrEqualTo(4000));
          expect(iqamaId, lessThan(1000000));
        }
      }
    });
  });

  group('معرّفات تذكير الختمة', () {
    test('لا تتقاطع مع مدَيي الأذان/الإقامة (0-4069) مهما كان معرّف الخطة', () {
      final samplePlanIds = [
        'plan-1', 'plan-2', 'a', 'خطة رمضان', '', 'x' * 50,
      ];
      for (final planId in samplePlanIds) {
        final id = KhatmahReminderService.notificationIdFor(planId);
        expect(id, greaterThanOrEqualTo(1000000),
            reason: 'معرّف ختمة "$planId" = $id يجب أن يكون ≥ 1000000');
      }
    });

    test('معرّفات مختلفة لمعرّفات خطط مختلفة (لا تصادم عملي شائع)', () {
      final planIds = List.generate(200, (i) => 'plan-$i');
      final ids = planIds.map(KhatmahReminderService.notificationIdFor).toSet();
      // hashCode % مدى كبير (900000) يجعل التصادم بين 200 معرّف مستبعَداً
      // عملياً، لكن ليس مستحيلاً رياضياً — نتحقّق من نسبة تفرّد عالية جداً
      // بدل المساواة الصارمة بـ200 لتفادي اختبار هشّ نظرياً.
      expect(ids.length, greaterThan(195));
    });
  });
}
