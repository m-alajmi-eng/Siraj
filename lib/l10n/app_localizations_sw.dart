// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get appName => 'Siraj';

  @override
  String get prayer_title => 'Nyakati za Sala';

  @override
  String get prayer_nextPrayer => 'Sala Inayofuata';

  @override
  String get prayer_fajr => 'Alfajiri';

  @override
  String get prayer_sunrise => 'Machweo ya Jua';

  @override
  String get prayer_dhuhr => 'Adhuhuri';

  @override
  String get prayer_asr => 'Alasiri';

  @override
  String get prayer_maghrib => 'Magharibi';

  @override
  String get prayer_isha => 'Isha';

  @override
  String prayer_countdown(String time) {
    return 'Katika $time';
  }

  @override
  String get prayer_locationGPS => 'Mahali pako sasa hivi';

  @override
  String get prayer_locationDefault => 'Riyadh (chaguo-msingi)';

  @override
  String get quran_title => 'Qurani Tukufu';

  @override
  String get quran_meccan => 'Makkiya';

  @override
  String get quran_medinan => 'Madaniya';

  @override
  String quran_ayahCount(int count) {
    return 'Aya $count';
  }

  @override
  String get quran_searchHint => 'Tafuta katika Qurani...';

  @override
  String get quran_noResults => 'Hakuna matokeo';

  @override
  String get quran_searchPrompt => 'Andika neno kutafuta';

  @override
  String get quran_tapForTafsir => 'Bonyeza kwa muda mrefu aya kwa tafsiri';

  @override
  String quran_tafsirTitle(int number) {
    return 'Tafsiri ya Aya $number';
  }

  @override
  String get quran_tafsirSource => 'Al-Muyassar';

  @override
  String get quran_tafsirError => 'Imeshindwa kupakia tafsiri';

  @override
  String get quran_reciter => 'Msomaji';

  @override
  String get quran_selectReciter => 'Chagua Msomaji';

  @override
  String get quran_searchReciter => 'Tafuta msomaji...';

  @override
  String get quran_playPrompt => 'Gusa kusikiliza';

  @override
  String quran_ayahNumber(int number) {
    return 'Aya $number';
  }

  @override
  String get athkar_title => 'Adhkari';

  @override
  String get athkar_morning => 'Adhkari ya Asubuhi';

  @override
  String get athkar_evening => 'Adhkari ya Jioni';

  @override
  String get athkar_sleep => 'Adhkari ya Kulala';

  @override
  String get athkar_wake => 'Adhkari ya Kuamka';

  @override
  String get athkar_prayer => 'Adhkari Baada ya Sala';

  @override
  String get athkar_general => 'Adhkari ya Jumla';

  @override
  String get athkar_tapToCount => 'Gusa kuhesabu';

  @override
  String get athkar_transitioning => 'Inaendelea...';

  @override
  String athkar_completed(String name) {
    return '$name imekamilika';
  }

  @override
  String get athkar_next => 'Inayofuata';

  @override
  String get athkar_prev => 'Iliyotangulia';

  @override
  String get athkar_finish => 'Maliza';

  @override
  String get athkar_back => 'Rudi';

  @override
  String athkar_source(String source) {
    return 'Iliyosimuliwa na $source';
  }

  @override
  String get hadith_title => 'Hadithi';

  @override
  String get hadith_searchHint => 'Tafuta hadithi...';

  @override
  String get hadith_noResults => 'Hakuna matokeo';

  @override
  String get hadith_tapForDetail => 'Gusa kusoma kamili';

  @override
  String get hadith_retryButton => 'Jaribu Tena';

  @override
  String get hadith_loadError => 'Imeshindwa kupakia';

  @override
  String get qibla_title => 'Mwelekeo wa Qibla';

  @override
  String get qibla_active => 'Dira inafanya kazi';

  @override
  String get qibla_error => 'Imeshindwa kuamua mwelekeo wa Qibla';

  @override
  String get qibla_errorHint => 'Washa dira na eneo';

  @override
  String get qibla_kaaba => 'Kaaba';

  @override
  String get qibla_fromNorth => 'Digrii kutoka Kaskazini kwenda Qibla';

  @override
  String get stats_title => 'Takwimu Zangu';

  @override
  String get stats_prayerStreak => 'Mfululizo wa Sala';

  @override
  String get stats_totalPrayers => 'Jumla ya Sala';

  @override
  String get stats_quranPages => 'Kurasa za Qurani';

  @override
  String get stats_athkarSessions => 'Adhkari';

  @override
  String get stats_khatma => 'Ukamilishaji wa Qurani';

  @override
  String get stats_days => 'siku mfululizo';

  @override
  String get stats_prayers => 'sala';

  @override
  String get stats_pages => 'kurasa';

  @override
  String get stats_sessions => 'vikao';

  @override
  String get stats_khatmaUnit => 'ukamilishaji';

  @override
  String get stats_currentKhatma => 'Maendeleo ya Ukamilishaji wa Sasa';

  @override
  String get more_title => 'Zaidi';

  @override
  String get more_qibla => 'Mwelekeo wa Qibla';

  @override
  String get more_stats => 'Takwimu Zangu';

  @override
  String get common_loading => 'Inapakia...';

  @override
  String get common_error => 'Hitilafu ya kupakia data';

  @override
  String get common_retry => 'Jaribu Tena';

  @override
  String get common_back => 'Rudi';

  @override
  String get common_next => 'Inayofuata';

  @override
  String get common_save => 'Hifadhi';

  @override
  String get common_cancel => 'Ghairi';

  @override
  String get common_done => 'Imekamilika';

  @override
  String get common_search => 'Tafuta';

  @override
  String get common_noData => 'Hakuna data';

  @override
  String get common_offline => 'Hakuna muunganisho wa intaneti';

  @override
  String get nav_home => 'Nyumbani';

  @override
  String get nav_quran => 'Quran';

  @override
  String get nav_athkar => 'Adhkari';

  @override
  String get nav_hadith => 'Hadithi';

  @override
  String get nav_more => 'Zaidi';

  @override
  String get home_greetingNight => 'Usiku mwema,';

  @override
  String get home_greetingFajr => 'Amani ya alfajiri,';

  @override
  String get home_greetingMorning => 'Habari za asubuhi,';

  @override
  String get home_greetingNoon => 'Habari za mchana,';

  @override
  String get home_greetingAsr => 'Alasiri njema,';

  @override
  String get home_greetingEvening => 'Habari za jioni,';

  @override
  String get home_greetingLateNight => 'Usiku wa amani,';

  @override
  String get home_welcome => 'Karibu';

  @override
  String get home_nextPrayer => 'Sala Inayofuata';

  @override
  String get home_qiblaDirection => 'Mwelekeo wa Kibla';

  @override
  String get home_continueReading => 'ENDELEA KUSOMA';

  @override
  String home_surah(int id) {
    return 'سورة #$id';
  }

  @override
  String home_ayah(int number) {
    return 'آية $number';
  }

  @override
  String get home_dailyAyah => 'Aya ya Leo';

  @override
  String get home_quickAccess => 'Ufikiaji wa Haraka';

  @override
  String get home_searchHint => 'Unatafuta nini...';

  @override
  String get home_radio => 'Redio';

  @override
  String get home_calendar => 'Kalenda';

  @override
  String get home_stories => 'Hadithi';

  @override
  String get home_children => 'Watoto';

  @override
  String get settings_title => 'Mipangilio';

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

  @override
  String get reader_tapToListen => 'اضغط للاستماع';

  @override
  String reader_ayahNum(int n) {
    return 'الآية $n';
  }

  @override
  String get reader_reciter => 'القارئ';

  @override
  String get reader_chooseReciter => 'اختر القارئ';

  @override
  String get reader_searchReciter => 'ابحث عن قارئ...';

  @override
  String get reader_longPressHint =>
      'اضغط مطولاً على أي آية للبوابة والتفسير والمشاركة';

  @override
  String get reader_versePortal => 'بوابة الآية';

  @override
  String get reader_portalSub => 'تفسير · كلمات · سياق';

  @override
  String get reader_showTafsir => 'عرض التفسير';

  @override
  String get reader_shareAyah => 'مشاركة الآية';

  @override
  String get reader_copyAyah => 'نسخ الآية';

  @override
  String get reader_ayahCopied => 'تم نسخ الآية';

  @override
  String reader_tafsirOf(int n) {
    return 'تفسير الآية $n';
  }

  @override
  String get reader_muyassar => 'الميسر';

  @override
  String get reader_tafsirError => 'تعذّر تحميل التفسير';

  @override
  String get reader_shareTitle => 'آية كريمة';

  @override
  String reader_shareSubtitle(String surah, int n) {
    return '$surah · آية $n';
  }
}
