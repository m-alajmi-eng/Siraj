// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Siraj';

  @override
  String get prayer_title => 'Gebetszeiten';

  @override
  String get prayer_nextPrayer => 'Nächstes Gebet';

  @override
  String get prayer_fajr => 'Fadschr';

  @override
  String get prayer_sunrise => 'Sonnenaufgang';

  @override
  String get prayer_dhuhr => 'Dhuhr';

  @override
  String get prayer_asr => 'Asr';

  @override
  String get prayer_maghrib => 'Maghrib';

  @override
  String get prayer_isha => 'Isha';

  @override
  String prayer_countdown(String time) {
    return 'In $time';
  }

  @override
  String get prayer_locationGPS => 'Ihr aktueller Standort';

  @override
  String get prayer_locationDefault => 'Riad (Standard)';

  @override
  String get quran_title => 'Der Heilige Koran';

  @override
  String get quran_meccan => 'Mekkanisch';

  @override
  String get quran_medinan => 'Medinensisch';

  @override
  String quran_ayahCount(int count) {
    return '$count Verse';
  }

  @override
  String get quran_searchHint => 'Im Koran suchen...';

  @override
  String get quran_noResults => 'Keine Ergebnisse';

  @override
  String get quran_searchPrompt => 'Wort eingeben zum Suchen';

  @override
  String get quran_tapForTafsir => 'Vers gedrückt halten für Tafsir';

  @override
  String quran_tafsirTitle(int number) {
    return 'Tafsir von Vers $number';
  }

  @override
  String get quran_tafsirSource => 'Al-Muyassar';

  @override
  String get quran_tafsirError => 'Tafsir konnte nicht geladen werden';

  @override
  String get quran_reciter => 'Rezitator';

  @override
  String get quran_selectReciter => 'Rezitator auswählen';

  @override
  String get quran_searchReciter => 'Rezitator suchen...';

  @override
  String get quran_playPrompt => 'Tippen zum Anhören';

  @override
  String quran_ayahNumber(int number) {
    return 'Vers $number';
  }

  @override
  String get athkar_title => 'Athkar';

  @override
  String get athkar_morning => 'Morgen-Athkar';

  @override
  String get athkar_evening => 'Abend-Athkar';

  @override
  String get athkar_sleep => 'Schlaf-Athkar';

  @override
  String get athkar_wake => 'Aufwach-Athkar';

  @override
  String get athkar_prayer => 'Athkar nach dem Gebet';

  @override
  String get athkar_general => 'Allgemeine Athkar';

  @override
  String get athkar_tapToCount => 'Tippen zum Zählen';

  @override
  String get athkar_transitioning => 'Weiter...';

  @override
  String athkar_completed(String name) {
    return '$name abgeschlossen';
  }

  @override
  String get athkar_next => 'Weiter';

  @override
  String get athkar_prev => 'Zurück';

  @override
  String get athkar_finish => 'Beenden';

  @override
  String get athkar_back => 'Zurück';

  @override
  String athkar_source(String source) {
    return 'Überliefert von $source';
  }

  @override
  String get hadith_title => 'Hadith';

  @override
  String get hadith_searchHint => 'Hadithe suchen...';

  @override
  String get hadith_noResults => 'Keine Ergebnisse';

  @override
  String get hadith_tapForDetail => 'Tippen für vollständigen Hadith';

  @override
  String get hadith_retryButton => 'Erneut versuchen';

  @override
  String get hadith_loadError => 'Laden fehlgeschlagen';

  @override
  String get qibla_title => 'Qibla-Richtung';

  @override
  String get qibla_active => 'Kompass aktiv';

  @override
  String get qibla_error => 'Qibla-Richtung konnte nicht bestimmt werden';

  @override
  String get qibla_errorHint => 'Kompass und Standort aktivieren';

  @override
  String get qibla_kaaba => 'Kaaba';

  @override
  String get qibla_fromNorth => 'Grad vom Norden zur Qibla';

  @override
  String get stats_title => 'Meine Statistiken';

  @override
  String get stats_prayerStreak => 'Gebets-Streak';

  @override
  String get stats_totalPrayers => 'Gebete gesamt';

  @override
  String get stats_quranPages => 'Koran-Seiten';

  @override
  String get stats_athkarSessions => 'Athkar';

  @override
  String get stats_khatma => 'Koran-Vollendungen';

  @override
  String get stats_days => 'aufeinanderfolgende Tage';

  @override
  String get stats_prayers => 'Gebete';

  @override
  String get stats_pages => 'Seiten';

  @override
  String get stats_sessions => 'Sitzungen';

  @override
  String get stats_khatmaUnit => 'Vollendung';

  @override
  String get stats_currentKhatma => 'Aktueller Khatm-Fortschritt';

  @override
  String get more_title => 'Mehr';

  @override
  String get more_qibla => 'Qibla-Richtung';

  @override
  String get more_stats => 'Meine Statistiken';

  @override
  String get common_loading => 'Wird geladen...';

  @override
  String get common_error => 'Fehler beim Laden';

  @override
  String get common_retry => 'Erneut versuchen';

  @override
  String get common_back => 'Zurück';

  @override
  String get common_next => 'Weiter';

  @override
  String get common_save => 'Speichern';

  @override
  String get common_cancel => 'Abbrechen';

  @override
  String get common_done => 'Fertig';

  @override
  String get common_search => 'Suchen';

  @override
  String get common_noData => 'Keine Daten';

  @override
  String get common_offline => 'Keine Internetverbindung';

  @override
  String get nav_home => 'Start';

  @override
  String get nav_quran => 'Koran';

  @override
  String get nav_athkar => 'Athkar';

  @override
  String get nav_hadith => 'Hadith';

  @override
  String get nav_more => 'Mehr';

  @override
  String get home_greetingNight => 'Gesegnete Nacht,';

  @override
  String get home_greetingFajr => 'Friede über der Morgendämmerung,';

  @override
  String get home_greetingMorning => 'Guten Morgen,';

  @override
  String get home_greetingNoon => 'Guten Tag,';

  @override
  String get home_greetingAsr => 'عصر مبارك،';

  @override
  String get home_greetingEvening => 'مساء الخير،';

  @override
  String get home_greetingLateNight => 'ليلة هادئة،';

  @override
  String get home_welcome => 'أهلاً وسهلاً';

  @override
  String get home_nextPrayer => 'الصلاة القادمة';

  @override
  String get home_qiblaDirection => 'اتجاه القبلة';

  @override
  String get home_continueReading => 'متابعة القراءة';

  @override
  String home_surah(int id) {
    return 'سورة #$id';
  }

  @override
  String home_ayah(int number) {
    return 'آية $number';
  }

  @override
  String get home_dailyAyah => 'آية اليوم';

  @override
  String get home_quickAccess => 'Acceso Rápido';

  @override
  String get home_searchHint => 'Qué estás buscando...';

  @override
  String get home_radio => 'Radio';

  @override
  String get home_calendar => 'Calendario';

  @override
  String get home_stories => 'Historias';

  @override
  String get home_children => 'Niños';

  @override
  String get settings_title => 'Ajustes';

  @override
  String get radio_title => 'إذاعات سراج';

  @override
  String get radio_all => 'الكل';

  @override
  String get radio_quran => 'قرآن';

  @override
  String get radio_translations => 'تراجم';

  @override
  String get radio_tafsir => 'تفسير وفتاوى';

  @override
  String get radio_athkar => 'أذكار';

  @override
  String get radio_international => 'إذاعات دولية';

  @override
  String get cal_title => 'التقويم الإسلامي';

  @override
  String get cal_todayEvents => 'مناسبات اليوم';

  @override
  String get cal_nextEvent => 'المناسبة القادمة';

  @override
  String get cal_allEvents => 'المناسبات الإسلامية';

  @override
  String cal_daysUntil(int days) {
    return '$days يوم';
  }

  @override
  String get cal_gregorian => 'ميلادي';

  @override
  String get cal_hijri => 'هجري';

  @override
  String get hm_1 => 'محرم';

  @override
  String get hm_2 => 'صفر';

  @override
  String get hm_3 => 'ربيع الأول';

  @override
  String get hm_4 => 'ربيع الآخر';

  @override
  String get hm_5 => 'جمادى الأولى';

  @override
  String get hm_6 => 'جمادى الآخرة';

  @override
  String get hm_7 => 'رجب';

  @override
  String get hm_8 => 'شعبان';

  @override
  String get hm_9 => 'رمضان';

  @override
  String get hm_10 => 'شوال';

  @override
  String get hm_11 => 'ذو القعدة';

  @override
  String get hm_12 => 'ذو الحجة';

  @override
  String get ev_new_year => 'رأس السنة الهجرية';

  @override
  String get ev_ashura => 'يوم عاشوراء';

  @override
  String get ev_mawlid => 'المولد النبوي';

  @override
  String get ev_isra => 'ليلة الإسراء والمعراج';

  @override
  String get ev_ramadan_start => 'أول رمضان';

  @override
  String get ev_laylat_qadr => 'ليلة القدر';

  @override
  String get ev_eid_fitr => 'عيد الفطر';

  @override
  String get ev_arafah => 'يوم عرفة';

  @override
  String get ev_eid_adha => 'عيد الأضحى';

  @override
  String get ev_tashreeq => 'أيام التشريق';

  @override
  String get stories_title => 'القصص والسير';

  @override
  String get stories_prophets => 'الأنبياء';

  @override
  String get stories_companions => 'الصحابة';

  @override
  String get stories_scholars => 'العلماء';

  @override
  String get stories_comingSoon => 'قريباً';

  @override
  String get stories_comingSoonMsg => 'قريباً — نعمل على إضافة المحتوى';

  @override
  String get children_title => 'قصص الأطفال';

  @override
  String get settings_secIdentity => 'الهوية';

  @override
  String get settings_secAdhan => 'الأذان';

  @override
  String get settings_secApp => 'التطبيق';

  @override
  String get settings_secPrivacy => 'الخصوصية';

  @override
  String get settings_secAbout => 'عن التطبيق';

  @override
  String get settings_language => 'اللغة';

  @override
  String get settings_chooseLanguage => 'اختر اللغة';

  @override
  String get settings_madhab => 'المذهب';

  @override
  String get settings_chooseMadhab => 'اختر المذهب';

  @override
  String get settings_calcMethod => 'طريقة حساب الصلاة';

  @override
  String get settings_chooseCalc => 'طريقة الحساب';

  @override
  String get settings_enableAdhan => 'تفعيل الأذان';

  @override
  String get settings_muezzinVoice => 'صوت المؤذن';

  @override
  String get settings_vibration => 'اهتزاز بدل صوت';

  @override
  String get settings_iqamaAlert => 'تنبيه قبل الإقامة';

  @override
  String settings_minutes(int n) {
    return '$n د';
  }

  @override
  String get settings_appMode => 'وضع التطبيق';

  @override
  String get settings_fullMode => 'الوضع الكامل';

  @override
  String get settings_liteMode => 'الوضع الخفيف';

  @override
  String get settings_fullModeDesc => 'كل الميزات متاحة';

  @override
  String get settings_liteModeDesc => 'الأساسيات فقط — بدون إنترنت';

  @override
  String get settings_quranFont => 'خط القرآن';

  @override
  String get settings_fontUthmani => 'عثماني';

  @override
  String get settings_fontHafs => 'حفص';

  @override
  String get settings_quranFontSize => 'حجم خط القرآن';

  @override
  String get settings_privacyNote => 'موقعك يبقى على جهازك فقط';

  @override
  String get settings_clearCache => 'حذف بيانات الكاش';

  @override
  String get settings_clearCacheTitle => 'حذف الكاش';

  @override
  String get settings_clearCacheMsg =>
      'سيتم حذف البيانات المحفوظة محلياً. هل أنت متأكد؟';

  @override
  String get settings_cancel => 'إلغاء';

  @override
  String get settings_delete => 'حذف';

  @override
  String get settings_version => 'الإصدار';

  @override
  String get settings_shareApp => 'مشاركة التطبيق';

  @override
  String get settings_tagline => 'سراج — نور على نور';

  @override
  String get madhab_hanafi => 'الحنفي';

  @override
  String get madhab_maliki => 'المالكي';

  @override
  String get madhab_shafi => 'الشافعي';

  @override
  String get madhab_hanbali => 'الحنبلي';

  @override
  String get calc_MWL => 'رابطة العالم الإسلامي';

  @override
  String get calc_ISNA => 'أمريكا الشمالية (ISNA)';

  @override
  String get calc_Egypt => 'الهيئة المصرية';

  @override
  String get calc_Makkah => 'أم القرى (مكة)';

  @override
  String get calc_Kuwait => 'الكويت';

  @override
  String get calc_Qatar => 'قطر';

  @override
  String get calc_Dubai => 'دبي';
}
