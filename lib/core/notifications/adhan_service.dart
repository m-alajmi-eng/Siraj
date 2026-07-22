import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:adhan/adhan.dart';
import '../../l10n/app_localizations.dart';
import '../prayer/prayer_calc_resolver.dart';
import '../storage/cache_service.dart';
import 'notification_service.dart';

class AdhanService {
  /// مفاتيح أصوات الأذان الثمانية -> مسار الأصل المحلي (لا اعتماد خارجي).
  /// العرض المترجم للاسم يتم عبر [labelFor] وقت الاستخدام في الواجهة.
  /// نفس المفاتيح موجودة كموارد Android خام (`android/.../res/raw/adhan_<key>`)
  /// لاستخدامها كصوت قناة إشعار حقيقي (راجع [_channelIdFor]).
  static const Map<String, String> adhanSounds = {
    'makkah': 'assets/audio/adhan/makkah.mp3',
    'madinah': 'assets/audio/adhan/madinah.mp3',
    'mustafa_ismail': 'assets/audio/adhan/mustafa_ismail.mp3',
    'iraqi': 'assets/audio/adhan/iraqi.mp3',
    'turkish': 'assets/audio/adhan/turkish.mp3',
    'moroccan': 'assets/audio/adhan/moroccan.mp3',
    'indonesian': 'assets/audio/adhan/indonesian.mp3',
    'classic': 'assets/audio/adhan/classic.mp3',
  };

  /// الاسم المترجم لصوت أذان معيّن بحسب لغة الواجهة الحالية.
  static String labelFor(String soundKey, AppLocalizations t) {
    switch (soundKey) {
      case 'makkah': return t.adhan_makkah;
      case 'madinah': return t.adhan_madinah;
      case 'mustafa_ismail': return t.adhan_mustafa_ismail;
      case 'iraqi': return t.adhan_iraqi;
      case 'turkish': return t.adhan_turkish;
      case 'moroccan': return t.adhan_moroccan;
      case 'indonesian': return t.adhan_indonesian;
      case 'classic': return t.adhan_classic;
      default: return soundKey;
    }
  }

  static Future<void> init() => NotificationService.init();

  // ─── معرّفات الإشعارات ──────────────────────────────────────────
  // 7 أيام × 5 صلوات = مدى 0-69 لإشعارات الأذان، و4000-4069 للإقامة
  // (ضمن المدى الموصى به 4000-7999 في خارطة التنفيذ). لا تعارض بين
  // المدَيين ولا مع معرّفات KhatmahReminderService (1000000+).
  static int prayerNotificationId(int dayOffset, int prayerIndex) =>
      dayOffset * 10 + prayerIndex;
  static int iqamaNotificationId(int dayOffset, int prayerIndex) =>
      4000 + dayOffset * 10 + prayerIndex;

  static const int daysAhead = 7;

  /// يلغي كل إشعارات الأذان/الإقامة المجدولة سلفاً (لا يمسّ تذكيرات
  /// الختمة، معرّفاتها في مدى مختلف تماماً).
  static Future<void> _cancelAllScheduled() async {
    for (var day = 0; day < daysAhead; day++) {
      for (var i = 0; i < 5; i++) {
        await NotificationService.plugin.cancel(id: prayerNotificationId(day, i));
        await NotificationService.plugin.cancel(id: iqamaNotificationId(day, i));
      }
    }
  }

  /// يجدول إشعارات الصلاة (والإقامة) لأسبوع متجدد، باحترام كامل لإعدادات
  /// المستخدم (ADR-003/011): calc_method، madhab، adhan_enabled،
  /// adhan_sound، iqama_alert، vibration. يُستدعى عند: فتح التطبيق، تغيّر
  /// الموقع الفعلي بأكثر من 10كم، أو تغيّر أي من هذه الإعدادات.
  static Future<void> schedulePrayerNotifications({
    required double latitude,
    required double longitude,
    required AppLocalizations t,
  }) async {
    if (!Platform.isAndroid && !Platform.isIOS) return;
    await NotificationService.init();
    await _cancelAllScheduled();

    final adhanEnabled =
        CacheService.getSetting('adhan_enabled', defaultValue: true) as bool;
    if (!adhanEnabled) return;

    final calcMethodId =
        CacheService.getSetting('calc_method', defaultValue: 'MWL') as String;
    final madhabId =
        CacheService.getSetting('madhab', defaultValue: 'shafi') as String;
    var soundKey =
        CacheService.getSetting('adhan_sound', defaultValue: 'makkah')
            as String;
    if (!adhanSounds.containsKey(soundKey)) soundKey = 'makkah';
    final vibration =
        CacheService.getSetting('vibration', defaultValue: false) as bool;
    final iqamaMinutes =
        CacheService.getSetting('iqama_alert', defaultValue: 10) as int;

    final coordinates = Coordinates(latitude, longitude);
    final params = resolvePrayerParameters(
      calcMethodId: calcMethodId,
      madhabId: madhabId,
    );
    final scheduleMode = await NotificationService.scheduleMode();
    final now = DateTime.now();

    for (var dayOffset = 0; dayOffset < daysAhead; dayOffset++) {
      final date = now.add(Duration(days: dayOffset));
      final dateComponents = DateComponents.from(date);
      final times = PrayerTimes(coordinates, dateComponents, params);

      final prayers = [
        (t.prayer_fajr, times.fajr),
        (t.prayer_dhuhr, times.dhuhr),
        (t.prayer_asr, times.asr),
        (t.prayer_maghrib, times.maghrib),
        (t.prayer_isha, times.isha),
      ];

      for (var i = 0; i < prayers.length; i++) {
        final (name, time) = prayers[i];
        if (time.isBefore(now)) continue;
        final tzTime = tz.TZDateTime.from(time, tz.local);

        await NotificationService.plugin.zonedSchedule(
          id: prayerNotificationId(dayOffset, i),
          title: t.prayer_notification_title(name),
          body: t.prayer_notification_body,
          scheduledDate: tzTime,
          notificationDetails: _detailsFor(
            forIqama: false,
            soundKey: soundKey,
            vibration: vibration,
          ),
          androidScheduleMode: scheduleMode,
        );

        if (iqamaMinutes > 0) {
          final iqamaTime = tzTime.add(Duration(minutes: iqamaMinutes));
          await NotificationService.plugin.zonedSchedule(
            id: iqamaNotificationId(dayOffset, i),
            title: t.iqama_notification_title,
            body: t.iqama_notification_body(iqamaMinutes, name),
            scheduledDate: iqamaTime,
            notificationDetails: _detailsFor(
              forIqama: true,
              soundKey: soundKey,
              vibration: vibration,
            ),
            androidScheduleMode: scheduleMode,
          );
        }
      }
    }
  }

  /// معرّف قناة Android مُصدَّر (v1) لأن صوت/اهتزاز القناة يثبت بعد إنشائها
  /// أول مرة على الجهاز — تغييره لاحقاً يتطلّب معرّفاً جديداً لا تعديل
  /// القناة القديمة (قيد نظام Android، لا مكتبة الإشعارات).
  static String _channelIdFor({
    required bool forIqama,
    required String soundKey,
    required bool vibration,
  }) {
    final prefix = forIqama ? 'iqama' : 'adhan';
    final variant = vibration ? 'vibrate' : soundKey;
    return '${prefix}_${variant}_v1';
  }

  static final Int64List _vibrationPattern =
      Int64List.fromList([0, 500, 250, 500]);

  static NotificationDetails _detailsFor({
    required bool forIqama,
    required String soundKey,
    required bool vibration,
  }) {
    final channelId = _channelIdFor(
      forIqama: forIqama,
      soundKey: soundKey,
      vibration: vibration,
    );
    final channelName = forIqama
        ? (vibration ? 'تنبيه الإقامة (اهتزاز)' : 'تنبيه الإقامة')
        : (vibration ? 'أوقات الصلاة (اهتزاز)' : 'أوقات الصلاة — $soundKey');

    final android = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: forIqama
          ? 'تنبيه قبل إقامة الصلاة بالوقت المحدَّد في الإعدادات'
          : 'إشعار دخول وقت الصلاة بصوت الأذان المختار',
      importance: Importance.high,
      priority: Priority.high,
      playSound: !vibration,
      sound: (!vibration && !forIqama)
          ? RawResourceAndroidNotificationSound('adhan_$soundKey')
          : null,
      enableVibration: true,
      vibrationPattern: vibration ? _vibrationPattern : null,
    );

    const darwin = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    return NotificationDetails(android: android, iOS: darwin);
  }
}
