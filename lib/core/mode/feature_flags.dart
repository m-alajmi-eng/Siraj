import 'app_mode.dart';

/// أعلام الميزات — منطق الوضعين المُصحَّح (يوليو 2026):
///
/// - **الوضع الكامل (Full):** كل الأقسام مفعَّلة دائماً وتلقائياً،
///   بلا أي قائمة أو قرار من المستخدم.
/// - **الوضع الخفيف (Lite):** المستخدم يبني قائمته الخاصة يدوياً من
///   بين *كل* الأقسام الموجودة في التطبيق (بما فيها القرآن والأذان
///   وأوقات الصلاة أنفسها) — لا نواة مفروضة من المطوّر. الافتراضي
///   عند أول تفعيل للوضع الخفيف: القرآن + الأذان + أوقات الصلاة فقط
///   (enabledSections الفارغة تعني هذا الافتراضي، لا "لا شيء").
class FeatureFlags {
  final AppMode mode;

  /// في الوضع الخفيف فقط: الأقسام التي فعّلها المستخدم صراحة.
  /// فارغة = لم يخصّص بعد، يُطبَّق الافتراضي (قرآن+أذان+صلاة).
  final Set<String> enabledSections;

  const FeatureFlags(this.mode, {this.enabledSections = const {}});

  bool get isLite => mode == AppMode.lite;
  bool get isFull => mode == AppMode.full;

  /// الأقسام الافتراضية عند أول دخول للوضع الخفيف (قبل أي تخصيص).
  static const Set<String> defaultLiteSections = {
    'quran_reader',
    'adhan',
    'prayer',
  };

  bool _section(String id) {
    if (isFull) return true;
    final effective =
        enabledSections.isEmpty ? defaultLiteSections : enabledSections;
    return effective.contains(id);
  }

  // ─── كل الأقسام قابلة للتخصيص في الوضع الخفيف الآن ───────
  bool get showPrayer      => _section('prayer');
  bool get showQibla       => _section('qibla');
  bool get showAthkar      => _section('athkar');
  bool get showQuranReader => _section('quran_reader');
  bool get showAdhan       => _section('adhan');
  bool get showHadith      => _section('hadith');
  bool get showRadio       => _section('radio');
  bool get showHifz        => _section('hifz');
  bool get showKhatmah     => _section('khatmah');
  bool get showLibrary     => _section('library');
  bool get showMosques     => _section('mosques');
  bool get showRuqyah      => _section('ruqyah');
  bool get showDuaJournal  => _section('dua_journal');
  bool get showMihrab      => _section('mihrab');
  bool get showQKE         => _section('qke');
  bool get showTimeline    => _section('timeline');
  bool get showNewMuslim   => _section('new_muslim');
  bool get showCalendar    => _section('calendar');
  bool get showShareCards  => _section('share_cards');
  bool get showGateway     => _section('gateway');
  bool get showStories     => _section('stories');
  bool get showChildrenStories => _section('children_stories');

  /// كل الأقسام القابلة للتخصيص (لبناء شاشة الإعدادات) — تُعرض في
  /// الوضع الخفيف فقط، فالوضع الكامل لا يحتاج قائمة إطلاقاً.
  static const List<(String id, String labelKey)> allSections = [
    ('quran_reader', 'section_quran_reader'),
    ('adhan', 'section_adhan'),
    ('prayer', 'section_prayer'),
    ('qibla', 'section_qibla'),
    ('athkar', 'section_athkar'),
    ('hadith', 'section_hadith'),
    ('radio', 'section_radio'),
    ('hifz', 'section_hifz'),
    ('khatmah', 'section_khatmah'),
    ('library', 'section_library'),
    ('mosques', 'section_mosques'),
    ('ruqyah', 'section_ruqyah'),
    ('dua_journal', 'section_dua_journal'),
    ('mihrab', 'section_mihrab'),
    ('qke', 'section_qke'),
    ('timeline', 'section_timeline'),
    ('new_muslim', 'section_new_muslim'),
    ('calendar', 'section_calendar'),
    ('share_cards', 'section_share_cards'),
    ('gateway', 'section_gateway'),
    ('stories', 'section_stories'),
    ('children_stories', 'section_children_stories'),
  ];
}
