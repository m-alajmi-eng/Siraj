import 'app_mode.dart';

class FeatureFlags {
  final AppMode mode;
  const FeatureFlags(this.mode);

  bool get isLite => mode == AppMode.lite;
  bool get isFull => mode == AppMode.full;

  // ─── الأساسيات (كلا الوضعين) ──────────────────────
  bool get showPrayer       => true;
  bool get showQibla        => true;
  bool get showAthkar       => true;
  bool get showQuranReader  => true;
  bool get showCalendar     => true;
  bool get showShareCards   => true;
  bool get showDailyNiyyah  => true;

  // ─── الوضع الكامل فقط ─────────────────────────────
  bool get showHadith       => isFull;
  bool get showRadio        => isFull;
  bool get showHifz         => isFull;
  bool get showKhatmah      => isFull;
  bool get showLibrary      => isFull;
  bool get showMosques      => isFull;
  bool get showRuqyah       => isFull;
  bool get showDuaJournal   => isFull;
  bool get showMihrab       => isFull;
  bool get showQKE          => isFull;
  bool get showTimeline     => isFull;
  bool get showNewMuslim    => isFull;
}