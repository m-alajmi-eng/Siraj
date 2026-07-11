import 'app_mode.dart';

/// أعلام الميزات: تجمع بين الوضع العام (خفيف/كامل) وتخصيص المستخدم
/// الفردي (أقسام عطّلها يدوياً من الإعدادات، حتى في الوضع الكامل).
///
/// منطق كل قسم من "الوضع الكامل": يظهر فقط إن كان الوضع Full
/// ولم يُعطّله المستخدم صراحة (disabledSections لا تحويه).
class FeatureFlags {
  final AppMode mode;
  final Set<String> disabledSections;

  const FeatureFlags(this.mode, {this.disabledSections = const {}});

  bool get isLite => mode == AppMode.lite;
  bool get isFull => mode == AppMode.full;

  bool _fullSection(String id) => isFull && !disabledSections.contains(id);

  // ─── النواة (تظهر دائماً في كلا الوضعين، لا تعطَّل) ─────
  bool get showPrayer      => true;
  bool get showQibla       => true;
  bool get showAthkar      => true;
  bool get showQuranReader => true;
  bool get showAdhan       => true;

  // ─── أقسام الوضع الكامل (قابلة للتخصيص فردياً) ───────────
  bool get showHadith      => _fullSection('hadith');
  bool get showRadio       => _fullSection('radio');
  bool get showHifz        => _fullSection('hifz');
  bool get showKhatmah     => _fullSection('khatmah');
  bool get showLibrary     => _fullSection('library');
  bool get showMosques     => _fullSection('mosques');
  bool get showRuqyah      => _fullSection('ruqyah');
  bool get showDuaJournal  => _fullSection('dua_journal');
  bool get showMihrab      => _fullSection('mihrab');
  bool get showQKE         => _fullSection('qke');
  bool get showTimeline    => _fullSection('timeline');
  bool get showNewMuslim   => _fullSection('new_muslim');
  bool get showCalendar    => _fullSection('calendar');
  bool get showShareCards  => _fullSection('share_cards');

  /// كل الأقسام القابلة للتخصيص (لبناء شاشة الإعدادات) مع تسمية
  /// معرّف كل قسم + دالة القراءة المطابقة لها.
  static const List<(String id, String labelKey)> customizableSections = [
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
  ];
}
