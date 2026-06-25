import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:adhan/adhan.dart';

class AdhanService {
  static final AudioPlayer _player = AudioPlayer();
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static const Map<String, String> adhanSounds = {
    'مكي (الحرم المكي)':    'https://www.islamcan.com/audio/adhan/azan1.mp3',
    'مديني (الحرم النبوي)': 'https://www.islamcan.com/audio/adhan/azan2.mp3',
    'مصطفى إسماعيل':        'https://www.islamcan.com/audio/adhan/azan3.mp3',
    'عراقي':                'https://www.islamcan.com/audio/adhan/azan4.mp3',
    'تركي':                 'https://www.islamcan.com/audio/adhan/azan5.mp3',
    'مغربي':                'https://www.islamcan.com/audio/adhan/azan6.mp3',
    'أندونيسي':             'https://www.islamcan.com/audio/adhan/azan7.mp3',
    'كلاسيكي':              'https://www.islamcan.com/audio/adhan/azan8.mp3',
  };

  static Future<void> init() async {
    if (!Platform.isAndroid && !Platform.isIOS) return;

    const android  = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _notifications.initialize(settings);
  }

  static Future<void> playAdhan(String soundUrl) async {
    await _player.stop();
    await _player.play(UrlSource(soundUrl));
  }

  static Future<void> stopAdhan() async {
    await _player.stop();
  }

  static Future<void> schedulePrayerNotifications({
    required double latitude,
    required double longitude,
  }) async {
    if (!Platform.isAndroid && !Platform.isIOS) return;

    await _notifications.cancelAll();

    final coordinates = Coordinates(latitude, longitude);
    final params      = CalculationMethod.muslim_world_league.getParameters();
    params.madhab     = Madhab.shafi;

    final now   = DateTime.now();
    final dates = [now, now.add(const Duration(days: 1))];

    for (final date in dates) {
      final dateComponents = DateComponents.from(date);
      final times = PrayerTimes(coordinates, dateComponents, params);

      final prayers = {
        'الفجر':  times.fajr,
        'الظهر':  times.dhuhr,
        'العصر':  times.asr,
        'المغرب': times.maghrib,
        'العشاء': times.isha,
      };

      int id = date.day * 10;
      for (final entry in prayers.entries) {
        if (entry.value.isAfter(DateTime.now())) {
          await _scheduleNotification(
            id:    id++,
            title: 'حان وقت ${entry.key}',
            body:  'الله أكبر، حي على الصلاة',
            time:  entry.value,
          );
        }
      }
    }
  }

  static Future<void> _scheduleNotification({
    required int      id,
    required String   title,
    required String   body,
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
          priority:   Priority.high,
        ),
      ),
    );
  }

  static void dispose() => _player.dispose();
}