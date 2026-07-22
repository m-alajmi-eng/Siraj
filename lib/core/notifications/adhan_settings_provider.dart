import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../storage/cache_service.dart';

/// طبقة استهلاك موحّدة لإعدادات الأذان السلوكية الأربعة التي كانت تُحفَظ
/// في Hive بلا أي provider يقرؤها (ADR-003/011): adhan_enabled، adhan_sound،
/// vibration، iqama_alert. كل تغيير من شاشة الإعدادات ينعكس هنا فوراً
/// ويُعاد جدولة إشعارات الأذان تبعاً له (عبر مستمع في MainShell).

class AdhanEnabledNotifier extends Notifier<bool> {
  @override
  bool build() =>
      CacheService.getSetting('adhan_enabled', defaultValue: true) as bool;

  Future<void> setEnabled(bool value) async {
    state = value;
    await CacheService.saveSetting('adhan_enabled', value);
  }
}

final adhanEnabledProvider = NotifierProvider<AdhanEnabledNotifier, bool>(
  AdhanEnabledNotifier.new,
);

/// المفتاح الافتراضي كان نصاً عربياً ثابتاً ('مكي (الحرم المكي)') لا
/// يطابق أي مفتاح فعلي في `AdhanService.adhanSounds` — يفشل صامتاً في
/// مطابقة صوت القناة حتى يختار المستخدم يدوياً. الافتراضي الصحيح الآن
/// 'makkah' (نفس المفتاح المستخدَم في AdhanService.adhanSounds).
class AdhanSoundNotifier extends Notifier<String> {
  @override
  String build() =>
      CacheService.getSetting('adhan_sound', defaultValue: 'makkah') as String;

  Future<void> setSound(String key) async {
    state = key;
    await CacheService.saveSetting('adhan_sound', key);
  }
}

final adhanSoundProvider = NotifierProvider<AdhanSoundNotifier, String>(
  AdhanSoundNotifier.new,
);

class VibrationNotifier extends Notifier<bool> {
  @override
  bool build() =>
      CacheService.getSetting('vibration', defaultValue: false) as bool;

  Future<void> setEnabled(bool value) async {
    state = value;
    await CacheService.saveSetting('vibration', value);
  }
}

final vibrationProvider = NotifierProvider<VibrationNotifier, bool>(
  VibrationNotifier.new,
);

class IqamaAlertNotifier extends Notifier<int> {
  @override
  int build() =>
      CacheService.getSetting('iqama_alert', defaultValue: 10) as int;

  Future<void> setMinutes(int minutes) async {
    state = minutes;
    await CacheService.saveSetting('iqama_alert', minutes);
  }
}

final iqamaAlertProvider = NotifierProvider<IqamaAlertNotifier, int>(
  IqamaAlertNotifier.new,
);
