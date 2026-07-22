import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import '../../../../core/notifications/notification_service.dart';
import '../../domain/entities/khatmah_plan.dart';

/// خدمة تذكيرات الختمة اليومية: إشعار محلي متكرر يومياً في وقت
/// [KhatmahPlan.reminderTime] لكل خطة نشطة (المرحلة 5 من KHATMAH_DESIGN.md).
///
/// يستخدم zonedSchedule + matchDateTimeComponents.time للتكرار اليومي
/// الحقيقي، عبر نفس [NotificationService.plugin] المشترك مع الأذان
/// (instance واحد للتطبيق كله بدل نسخة منفصلة لكل خدمة).
class KhatmahReminderService {
  static FlutterLocalNotificationsPlugin get _notifications =>
      NotificationService.plugin;

  static Future<void> _ensureInit() => NotificationService.init();

  /// معرّف إشعار ثابت ومميّز لكل خطة (يعتمد على hashCode للـid النصي
  /// كي لا يتعارض مع معرّفات AdhanService الرقمية البسيطة).
  static int _notificationIdFor(String planId) =>
      1000000 + (planId.hashCode.abs() % 900000);

  /// يجدول تذكيراً يومياً متكرراً لخطة واحدة عند وقتها المحدَد.
  /// إن لم يكن للخطة reminderTime أو كانت غير نشطة، لا يجدوَل شيء.
  static Future<void> scheduleForPlan(
    KhatmahPlan plan, {
    required String titlePrefix,
    required String bodyTemplate,
  }) async {
    if (!Platform.isAndroid && !Platform.isIOS) return;
    await _ensureInit();

    final id = _notificationIdFor(plan.id);
    await _notifications.cancel(id: id);

    if (!plan.isActive || plan.reminderTime == null || plan.isCompleted) {
      return;
    }

    final parts = plan.reminderTime!.split(':');
    if (parts.length != 2) return;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return;

    final scheduled = _nextInstanceOf(hour, minute);
    final scheduleMode = await NotificationService.scheduleMode();

    await _notifications.zonedSchedule(
      id: id,
      title: '$titlePrefix ${plan.name}',
      body: bodyTemplate.replaceAll('{pages}', '${plan.dailyPortion}'),
      scheduledDate: scheduled,
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'khatmah_reminder_channel',
          'تذكيرات الختمة',
          channelDescription: 'تذكير يومي بورد القراءة',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: scheduleMode,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// يلغي تذكير خطة معيّنة (عند حذفها أو إيقافها أو اكتمالها).
  static Future<void> cancelForPlan(String planId) async {
    if (!Platform.isAndroid && !Platform.isIOS) return;
    await _ensureInit();
    await _notifications.cancel(id: _notificationIdFor(planId));
  }

  static tz.TZDateTime _nextInstanceOf(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }
    return scheduled;
  }
}
