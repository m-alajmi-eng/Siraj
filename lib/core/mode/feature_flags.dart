import 'app_mode.dart';

class FeatureFlags {
  final AppMode mode;
  const FeatureFlags(this.mode);

  bool get isLite => mode == AppMode.lite;
  bool get isFull => mode == AppMode.full;

  // ─── الوضع الخفيف (offline كامل — لا إنترنت) ─────────
  bool get showPrayer      => true;
  bool get showQibla       => true;
  bool get showAthkar      => true;
  bool get showQuranReader => true;
  bool get showAdhan       => true;

  // ─── الوضع الكامل فقط ─────────────────────────────────
  bool get showHadith      => isFull;
  bool get showRadio       => isFull;
  bool get showHifz        => isFull;
  bool get showKhatmah     => isFull;
  bool get showLibrary     => isFull;
  bool get showMosques     => isFull;
  bool get showRuqyah      => isFull;
  bool get showDuaJournal  => isFull;
  bool get showMihrab      => isFull;
  bool get showQKE         => isFull;
  bool get showTimeline    => isFull;
  bool get showNewMuslim   => isFull;
  bool get showCalendar    => isFull;
  bool get showShareCards  => isFull;
} 