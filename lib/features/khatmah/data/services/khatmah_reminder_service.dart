import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;
import '../../domain/entities/khatmah_plan.dart';

/// خدمة تذكيرات الختمة اليومية: إشعار محلي متكرر يومياً في وقت
/// [KhatmahPlan.reminderTime] لكل خطة نشطة (المرحلة 5 من KHATMAH_DESIGN.md).
///
/// يستخدم zonedSchedule + matchDateTimeComponents.time للتكرار اليومي
/// الحقيقي (بخلاف AdhanService الحالي الذي يستخدم .show() الفوري).
class KhatmahReminderService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  static bool _tzInitialized = false;

  static Future<void> _ensureInit() async {
    if (!Platform.isAndroid && !Platform.isIOS) return;
    if (!_tzInitialized) {
      tz_data.initializeTimeZones();
      _tzInitialized = true;
    }
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _notifications.initialize(settings);
  }

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
    await _notifications.cancel(id);

    if (!plan.isActive || plan.reminderTime == null || plan.isCompleted) {
      return;
    }

    final parts = plan.reminderTime!.split(':');
    if (parts.length != 2) return;
    final hour = int.tryParse(parts[0]);
    final minute = int.tryParse(parts[1]);
    if (hour == null || minute == null) return;

    final scheduled = _nextInstanceOf(hour, minute);

    await _notifications.zonedSchedule(
      id,
      '$titlePrefix ${plan.name}',
      bodyTemplate.replaceAll('{pages}', '${plan.dailyPortion}'),
      scheduled,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'khatmah_reminder_channel',
          'تذكيرات الختمة',
          channelDescription: 'تذكير يومي بورد القراءة',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// يلغي تذكير خطة معيّنة (عند حذفها أو إيقافها أو اكتمالها).
  static Future<void> cancelForPlan(String planId) async {
    if (!Platform.isAndroid && !Platform.isIOS) return;
    await _ensureInit();
    await _notifications.cancel(_notificationIdFor(planId));
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
