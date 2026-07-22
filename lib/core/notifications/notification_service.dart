import 'dart:io';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// نقطة التهيئة والأذونات المشتركة لكل الإشعارات المجدولة في التطبيق
/// (الأذان + الإقامة + تذكير الختمة) — instance واحد مشترك بدل نسخة
/// منفصلة لكل خدمة، حتى لا تتضارب التهيئة (PHASE B، مبني على
/// SIRAJ_Architecture_Review.md §4-B).
class NotificationService {
  static final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static Future<void> init() async {
    if (!Platform.isAndroid && !Platform.isIOS) return;
    if (_initialized) return;

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const darwin = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: darwin);
    await plugin.initialize(settings: settings);
    _initialized = true;

    if (Platform.isAndroid) {
      final impl = plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      // POST_NOTIFICATIONS وقت التشغيل (Android 13+، لا أثر على ما قبلها).
      await impl?.requestNotificationsPermission();
      // SCHEDULE_EXACT_ALARM يتطلّب موافقة صريحة من المستخدم على Android 14+
      // رغم إعلانه في Manifest؛ نطلبها فقط إن لم تكن ممنوحة أصلاً.
      final canExact = await impl?.canScheduleExactNotifications() ?? false;
      if (!canExact) {
        await impl?.requestExactAlarmsPermission();
      }
    }
  }

  /// وضع الجدولة الآمن: exact عند توفّر الإذن، وإلا inexact — بدل أن يفشل
  /// `zonedSchedule` بالكامل لغياب SCHEDULE_EXACT_ALARM (Android 14+ بلا
  /// موافقة). Fallback على inexact أفضل من عدم الجدولة إطلاقاً.
  static Future<AndroidScheduleMode> scheduleMode() async {
    if (!Platform.isAndroid) return AndroidScheduleMode.exactAllowWhileIdle;
    final impl = plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    final canExact = await impl?.canScheduleExactNotifications() ?? false;
    return canExact
        ? AndroidScheduleMode.exactAllowWhileIdle
        : AndroidScheduleMode.inexactAllowWhileIdle;
  }
}
