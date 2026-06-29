// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appName => 'Siraj';

  @override
  String get prayer_title => 'Orari di Preghiera';

  @override
  String get prayer_nextPrayer => 'Prossima Preghiera';

  @override
  String get prayer_fajr => 'Fajr';

  @override
  String get prayer_sunrise => 'Alba';

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
    return 'Tra $time';
  }

  @override
  String get prayer_locationGPS => 'La tua posizione attuale';

  @override
  String get prayer_locationDefault => 'Riyadh (predefinito)';

  @override
  String get quran_title => 'Il Santo Corano';

  @override
  String get quran_meccan => 'Meccana';

  @override
  String get quran_medinan => 'Medinese';

  @override
  String quran_ayahCount(int count) {
    return '$count versetti';
  }

  @override
  String get quran_searchHint => 'Cerca nel Corano...';

  @override
  String get quran_noResults => 'Nessun risultato';

  @override
  String get quran_searchPrompt => 'Digita una parola per cercare';

  @override
  String get quran_tapForTafsir => 'Tieni premuto un versetto per il tafsir';

  @override
  String quran_tafsirTitle(int number) {
    return 'Tafsir del Versetto $number';
  }

  @override
  String get quran_tafsirSource => 'Al-Muyassar';

  @override
  String get quran_tafsirError => 'Impossibile caricare il tafsir';

  @override
  String get quran_reciter => 'Recitatore';

  @override
  String get quran_selectReciter => 'Seleziona Recitatore';

  @override
  String get quran_searchReciter => 'Cerca recitatore...';

  @override
  String get quran_playPrompt => 'Tocca per ascoltare';

  @override
  String quran_ayahNumber(int number) {
    return 'Versetto $number';
  }

  @override
  String get athkar_title => 'Athkar';

  @override
  String get athkar_morning => 'Athkar del Mattino';

  @override
  String get athkar_evening => 'Athkar della Sera';

  @override
  String get athkar_sleep => 'Athkar per Dormire';

  @override
  String get athkar_wake => 'Athkar al Risveglio';

  @override
  String get athkar_prayer => 'Athkar dopo la Preghiera';

  @override
  String get athkar_general => 'Athkar Generali';

  @override
  String get athkar_tapToCount => 'Tocca per contare';

  @override
  String get athkar_transitioning => 'Avanzando...';

  @override
  String athkar_completed(String name) {
    return '$name completato';
  }

  @override
  String get athkar_next => 'Successivo';

  @override
  String get athkar_prev => 'Precedente';

  @override
  String get athkar_finish => 'Fine';

  @override
  String get athkar_back => 'Indietro';

  @override
  String athkar_source(String source) {
    return 'Tramandato da $source';
  }

  @override
  String get hadith_title => 'Hadith';

  @override
  String get hadith_searchHint => 'Cerca hadith...';

  @override
  String get hadith_noResults => 'Nessun risultato';

  @override
  String get hadith_tapForDetail => 'Tocca per leggere completo';

  @override
  String get hadith_retryButton => 'Riprova';

  @override
  String get hadith_loadError => 'Caricamento fallito';

  @override
  String get qibla_title => 'Direzione della Qibla';

  @override
  String get qibla_active => 'Bussola attiva';

  @override
  String get qibla_error => 'Impossibile determinare la direzione della Qibla';

  @override
  String get qibla_errorHint => 'Attiva la bussola e la posizione';

  @override
  String get qibla_kaaba => 'Kaaba';

  @override
  String get qibla_fromNorth => 'Gradi dal Nord verso la Qibla';

  @override
  String get stats_title => 'Le Mie Statistiche';

  @override
  String get stats_prayerStreak => 'Serie di Preghiere';

  @override
  String get stats_totalPrayers => 'Preghiere Totali';

  @override
  String get stats_quranPages => 'Pagine del Corano';

  @override
  String get stats_athkarSessions => 'Athkar';

  @override
  String get stats_khatma => 'Completamenti del Corano';

  @override
  String get stats_days => 'giorni consecutivi';

  @override
  String get stats_prayers => 'preghiere';

  @override
  String get stats_pages => 'pagine';

  @override
  String get stats_sessions => 'sessioni';

  @override
  String get stats_khatmaUnit => 'completamento';

  @override
  String get stats_currentKhatma => 'Progresso del Khatm Attuale';

  @override
  String get more_title => 'Altro';

  @override
  String get more_qibla => 'Direzione della Qibla';

  @override
  String get more_stats => 'Le Mie Statistiche';

  @override
  String get common_loading => 'Caricamento...';

  @override
  String get common_error => 'Errore nel caricamento';

  @override
  String get common_retry => 'Riprova';

  @override
  String get common_back => 'Indietro';

  @override
  String get common_next => 'Successivo';

  @override
  String get common_save => 'Salva';

  @override
  String get common_cancel => 'Annulla';

  @override
  String get common_done => 'Fatto';

  @override
  String get common_search => 'Cerca';

  @override
  String get common_noData => 'Nessun dato';

  @override
  String get common_offline => 'Nessuna connessione internet';

  @override
  String get nav_home => 'الرئيسية';

  @override
  String get nav_quran => 'القرآن';

  @override
  String get nav_athkar => 'الأذكار';

  @override
  String get nav_hadith => 'الحديث';

  @override
  String get nav_more => 'المزيد';

  @override
  String get home_greetingNight => 'ليلة مباركة،';

  @override
  String get home_greetingFajr => 'السلام على الفجر،';

  @override
  String get home_greetingMorning => 'صباح الخير،';

  @override
  String get home_greetingNoon => 'مساء النور،';

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
  String get home_quickAccess => 'وصول سريع';

  @override
  String get home_searchHint => 'ما الذي تبحث عنه...';

  @override
  String get home_radio => 'الراديو';

  @override
  String get home_calendar => 'التقويم';

  @override
  String get home_stories => 'القصص';

  @override
  String get home_children => 'الأطفال';

  @override
  String get settings_title => 'الإعدادات';

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

  @override
  String get search_hint => 'ابحث في القرآن والتفاسير...';

  @override
  String get search_empty => 'ابحث في القرآن الكريم والتفاسير ومعاني الكلمات';

  @override
  String search_noResults(String query) {
    return 'لا نتائج لـ \"$query\"';
  }

  @override
  String get search_typeAyah => 'آية';

  @override
  String get search_typeTafsir => 'تفسير';

  @override
  String get search_typeWord => 'كلمة';

  @override
  String get search_typeHadith => 'حديث';

  @override
  String get stats_daysStreak => 'يوم متتالي';

  @override
  String get stats_prayersUnit => 'صلاة';

  @override
  String get stats_pagesUnit => 'صفحة';

  @override
  String get stats_athkar => 'الأذكار';

  @override
  String get stats_sessionsUnit => 'جلسة';

  @override
  String stats_pagesOf(int read, int total) {
    return '$read / $total صفحة';
  }
}
