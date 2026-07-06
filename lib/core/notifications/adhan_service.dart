import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:adhan/adhan.dart';
import '../../l10n/app_localizations.dart';

class AdhanService {
  static final AudioPlayer _player = AudioPlayer();
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  /// مفاتيح أصوات الأذان الثمانية -> مسار الأصل المحلي (لا اعتماد خارجي).
  /// العرض المترجم للاسم يتم عبر [labelFor] وقت الاستخدام في الواجهة.
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

  static Future<void> init() async {
    if (!Platform.isAndroid && !Platform.isIOS) return;

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _notifications.initialize(settings);
  }

  /// يشغّل صوت أذان محلي بمفتاحه (لا رابط خارجي).
  static Future<void> playAdhan(String soundKey) async {
    final assetPath = adhanSounds[soundKey];
    if (assetPath == null) return;
    await _player.stop();
    await _player.play(AssetSource(assetPath.replaceFirst('assets/', '')));
  }

  static Future<void> stopAdhan() async {
    await _player.stop();
  }

  static Future<void> schedulePrayerNotifications({
    required double latitude,
    required double longitude,
    required AppLocalizations t,
  }) async {
    if (!Platform.isAndroid && !Platform.isIOS) return;

    await _notifications.cancelAll();

    final coordinates = Coordinates(latitude, longitude);
    final params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.shafi;

    final now = DateTime.now();
    final dates = [now, now.add(const Duration(days: 1))];

    for (final date in dates) {
      final dateComponents = DateComponents.from(date);
      final times = PrayerTimes(coordinates, dateComponents, params);

      final prayers = {
        t.prayer_fajr: times.fajr,
        t.prayer_dhuhr: times.dhuhr,
        t.prayer_asr: times.asr,
        t.prayer_maghrib: times.maghrib,
        t.prayer_isha: times.isha,
      };

      int id = date.day * 10;
      for (final entry in prayers.entries) {
        if (entry.value.isAfter(DateTime.now())) {
          await _scheduleNotification(
            id: id++,
            title: t.prayer_notification_title(entry.key),
            body: t.prayer_notification_body,
            time: entry.value,
          );
        }
      }
    }
  }

  static Future<void> _scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime time,
  }) async {
    await _notifications.show(
      id,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'prayer_channel',
          'أوقات الصلاة',
          channelDescription: 'إشعارات أوقات الصلاة',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  static void dispose() => _player.dispose();
}
