// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Persian (`fa`).
class AppLocalizationsFa extends AppLocalizations {
  AppLocalizationsFa([String locale = 'fa']) : super(locale);

  @override
  String get appName => 'سراج';

  @override
  String get prayer_title => 'اوقات نماز';

  @override
  String get prayer_nextPrayer => 'نماز بعدی';

  @override
  String get prayer_fajr => 'صبح';

  @override
  String get prayer_sunrise => 'طلوع آفتاب';

  @override
  String get prayer_dhuhr => 'ظهر';

  @override
  String get prayer_asr => 'عصر';

  @override
  String get prayer_maghrib => 'مغرب';

  @override
  String get prayer_isha => 'عشاء';

  @override
  String prayer_countdown(String time) {
    return 'در $time';
  }

  @override
  String get prayer_locationGPS => 'موقعیت فعلی شما';

  @override
  String get prayer_locationDefault => 'ریاض (پیش‌فرض)';

  @override
  String get quran_title => 'قرآن کریم';

  @override
  String get quran_meccan => 'مکی';

  @override
  String get quran_medinan => 'مدنی';

  @override
  String quran_ayahCount(int count) {
    return '$count آیه';
  }

  @override
  String get quran_searchHint => 'جستجو در قرآن...';

  @override
  String get quran_noResults => 'نتیجه‌ای یافت نشد';

  @override
  String get quran_searchPrompt => 'کلمه‌ای برای جستجو بنویسید';

  @override
  String get quran_tapForTafsir => 'برای تفسیر روی آیه نگه دارید';

  @override
  String quran_tafsirTitle(int number) {
    return 'تفسیر آیه $number';
  }

  @override
  String get quran_tafsirSource => 'المیسر';

  @override
  String get quran_tafsirError => 'بارگذاری تفسیر ناموفق بود';

  @override
  String get quran_reciter => 'قاری';

  @override
  String get quran_selectReciter => 'انتخاب قاری';

  @override
  String get quran_searchReciter => 'جستجوی قاری...';

  @override
  String get quran_playPrompt => 'برای شنیدن لمس کنید';

  @override
  String quran_ayahNumber(int number) {
    return 'آیه $number';
  }

  @override
  String get athkar_title => 'اذکار';

  @override
  String get athkar_morning => 'اذکار صبح';

  @override
  String get athkar_evening => 'اذکار شام';

  @override
  String get athkar_sleep => 'اذکار خواب';

  @override
  String get athkar_wake => 'اذکار بیداری';

  @override
  String get athkar_prayer => 'اذکار بعد از نماز';

  @override
  String get athkar_general => 'اذکار عمومی';

  @override
  String get athkar_tapToCount => 'برای شمارش لمس کنید';

  @override
  String get athkar_transitioning => 'در حال انتقال...';

  @override
  String athkar_completed(String name) {
    return '$name تکمیل شد';
  }

  @override
  String get athkar_next => 'بعدی';

  @override
  String get athkar_prev => 'قبلی';

  @override
  String get athkar_finish => 'پایان';

  @override
  String get athkar_back => 'بازگشت';

  @override
  String athkar_source(String source) {
    return 'روایت از $source';
  }

  @override
  String get hadith_title => 'حدیث شریف';

  @override
  String get hadith_searchHint => 'جستجو در احادیث...';

  @override
  String get hadith_noResults => 'نتیجه‌ای یافت نشد';

  @override
  String get hadith_tapForDetail => 'برای خواندن کامل لمس کنید';

  @override
  String get hadith_retryButton => 'تلاش مجدد';

  @override
  String get hadith_loadError => 'بارگذاری ناموفق';

  @override
  String get qibla_title => 'جهت قبله';

  @override
  String get qibla_active => 'قطب‌نما فعال است';

  @override
  String get qibla_error => 'تعیین جهت قبله ممکن نیست';

  @override
  String get qibla_errorHint => 'قطب‌نما و موقعیت را فعال کنید';

  @override
  String get qibla_kaaba => 'کعبه';

  @override
  String get qibla_fromNorth => 'درجه از شمال به سمت قبله';

  @override
  String get stats_title => 'آمار من';

  @override
  String get stats_prayerStreak => 'رشته نماز';

  @override
  String get stats_totalPrayers => 'مجموع نمازها';

  @override
  String get stats_quranPages => 'صفحات قرآن';

  @override
  String get stats_athkarSessions => 'اذکار';

  @override
  String get stats_khatma => 'ختم قرآن';

  @override
  String get stats_days => 'روز متوالی';

  @override
  String get stats_prayers => 'نماز';

  @override
  String get stats_pages => 'صفحه';

  @override
  String get stats_sessions => 'جلسه';

  @override
  String get stats_khatmaUnit => 'ختم';

  @override
  String get stats_currentKhatma => 'پیشرفت ختم فعلی';

  @override
  String get more_title => 'بیشتر';

  @override
  String get more_qibla => 'جهت قبله';

  @override
  String get more_stats => 'آمار من';

  @override
  String get common_loading => 'در حال بارگذاری...';

  @override
  String get common_error => 'خطا در بارگذاری داده';

  @override
  String get common_retry => 'تلاش مجدد';

  @override
  String get common_back => 'بازگشت';

  @override
  String get common_next => 'بعدی';

  @override
  String get common_save => 'ذخیره';

  @override
  String get common_cancel => 'لغو';

  @override
  String get common_done => 'انجام شد';

  @override
  String get common_search => 'جستجو';

  @override
  String get common_noData => 'داده‌ای موجود نیست';

  @override
  String get common_offline => 'اتصال به اینترنت وجود ندارد';

  @override
  String get nav_home => 'خانه';

  @override
  String get nav_quran => 'قرآن';

  @override
  String get nav_athkar => 'اذکار';

  @override
  String get nav_hadith => 'حدیث';

  @override
  String get nav_more => 'بیشتر';

  @override
  String get home_greetingNight => 'شب مبارک،';

  @override
  String get home_greetingFajr => 'سلام بر سپیده،';

  @override
  String get home_greetingMorning => 'صبح بخیر،';

  @override
  String get home_greetingNoon => 'ظهر بخیر،';

  @override
  String get home_greetingAsr => 'عصر مبارک،';

  @override
  String get home_greetingEvening => 'عصر بخیر،';

  @override
  String get home_greetingLateNight => 'شب آرام،';

  @override
  String get home_welcome => 'خوش آمدید';

  @override
  String get home_nextPrayer => 'نماز بعدی';

  @override
  String get home_qiblaDirection => 'جهت قبله';

  @override
  String get home_continueReading => 'ادامه خواندن';

  @override
  String home_surah(int id) {
    return 'سوره #$id';
  }

  @override
  String home_ayah(int number) {
    return 'آیه $number';
  }

  @override
  String get home_dailyAyah => 'آیه روز';

  @override
  String get home_quickAccess => 'دسترسی سریع';

  @override
  String get home_searchHint => 'دنبال چه می‌گردید...';

  @override
  String get home_radio => 'رادیو';

  @override
  String get home_calendar => 'تقویم';

  @override
  String get home_stories => 'داستان‌ها';

  @override
  String get home_children => 'کودکان';

  @override
  String get settings_title => 'تنظیمات';

  @override
  String get radio_title => 'رادیو سراج';

  @override
  String get radio_all => 'همه';

  @override
  String get radio_quran => 'قرآن';

  @override
  String get radio_translations => 'ترجمهها';

  @override
  String get radio_tafsir => 'تفسیر و فتوا';

  @override
  String get radio_athkar => 'اذکار';

  @override
  String get radio_international => 'بینالمللی';

  @override
  String get cal_title => 'تقویم اسلامی';

  @override
  String get cal_todayEvents => 'رویدادهای امروز';

  @override
  String get cal_nextEvent => 'رویداد بعدی';

  @override
  String get cal_allEvents => 'مناسبتهای اسلامی';

  @override
  String cal_daysUntil(int days) {
    return '$days روز';
  }

  @override
  String get cal_gregorian => 'میلادی';

  @override
  String get cal_hijri => 'هجری';

  @override
  String get hm_1 => 'محرم';

  @override
  String get hm_2 => 'صفر';

  @override
  String get hm_3 => 'ربیع‌الاول';

  @override
  String get hm_4 => 'ربیع‌الثانی';

  @override
  String get hm_5 => 'جمادی‌الاول';

  @override
  String get hm_6 => 'جمادی‌الثانی';

  @override
  String get hm_7 => 'رجب';

  @override
  String get hm_8 => 'شعبان';

  @override
  String get hm_9 => 'رمضان';

  @override
  String get hm_10 => 'شوال';

  @override
  String get hm_11 => 'ذوالقعده';

  @override
  String get hm_12 => 'ذوالحجه';

  @override
  String get ev_new_year => 'سال نو هجری';

  @override
  String get ev_ashura => 'روز عاشورا';

  @override
  String get ev_mawlid => 'میلاد پیامبرﷺ';

  @override
  String get ev_isra => 'شب اسراء و معراج';

  @override
  String get ev_ramadan_start => 'اول رمضان';

  @override
  String get ev_laylat_qadr => 'شب قدر';

  @override
  String get ev_eid_fitr => 'عید فطر';

  @override
  String get ev_arafah => 'روز عرفه';

  @override
  String get ev_eid_adha => 'عید قربان';

  @override
  String get ev_tashreeq => 'ایام تشریق';

  @override
  String get stories_title => 'داستان‌ها و سیره';

  @override
  String get stories_prophets => 'پیامبران';

  @override
  String get stories_companions => 'صحابه';

  @override
  String get stories_scholars => 'علما';

  @override
  String get stories_comingSoon => 'به‌زودی';

  @override
  String get stories_comingSoonMsg => 'به‌زودی — محتوا در حال آماده‌سازی است';

  @override
  String get children_title => 'داستان‌های کودکان';

  @override
  String get settings_secIdentity => 'هویت';

  @override
  String get settings_secAdhan => 'اذان';

  @override
  String get settings_secApp => 'برنامه';

  @override
  String get settings_secPrivacy => 'حریم خصوصی';

  @override
  String get settings_secAbout => 'درباره';

  @override
  String get settings_language => 'زبان';

  @override
  String get settings_chooseLanguage => 'انتخاب زبان';

  @override
  String get settings_madhab => 'مذهب';

  @override
  String get settings_chooseMadhab => 'انتخاب مذهب';

  @override
  String get settings_calcMethod => 'روش محاسبه اوقات نماز';

  @override
  String get settings_chooseCalc => 'روش محاسبه';

  @override
  String get settings_enableAdhan => 'فعال‌سازی اذان';

  @override
  String get settings_muezzinVoice => 'صدای مؤذن';

  @override
  String get settings_vibration => 'لرزش به‌جای صدا';

  @override
  String get settings_iqamaAlert => 'هشدار پیش از اقامه';

  @override
  String settings_minutes(int n) {
    return '$n دقیقه';
  }

  @override
  String get settings_appMode => 'حالت برنامه';

  @override
  String get settings_fullMode => 'حالت کامل';

  @override
  String get settings_liteMode => 'حالت سبک';

  @override
  String get settings_fullModeDesc => 'همه امکانات در دسترس';

  @override
  String get settings_liteModeDesc => 'فقط ضروریات — آفلاین';

  @override
  String get settings_quranFont => 'فونت قرآن';

  @override
  String get settings_fontUthmani => 'عثمانی';

  @override
  String get settings_fontHafs => 'حفص';

  @override
  String get settings_quranFontSize => 'اندازه فونت قرآن';

  @override
  String get settings_privacyNote => 'موقعیت شما فقط روی دستگاه شما می‌ماند';

  @override
  String get settings_clearCache => 'پاکسازی داده‌های کش';

  @override
  String get settings_clearCacheTitle => 'پاک‌سازی کش';

  @override
  String get settings_clearCacheMsg =>
      'داده‌های ذخیره‌شده محلی حذف می‌شوند. مطمئن هستید؟';

  @override
  String get settings_cancel => 'لغو';

  @override
  String get settings_delete => 'حذف';

  @override
  String get settings_version => 'نسخه';

  @override
  String get settings_shareApp => 'اشتراک برنامه';

  @override
  String get settings_tagline => 'سراج — نور علی نور';

  @override
  String get madhab_hanafi => 'حنفی';

  @override
  String get madhab_maliki => 'مالکی';

  @override
  String get madhab_shafi => 'شافعی';

  @override
  String get madhab_hanbali => 'حنبلی';

  @override
  String get calc_MWL => 'رابطه جهانی اسلام';

  @override
  String get calc_ISNA => 'امریکای شمالی (ISNA)';

  @override
  String get calc_Egypt => 'سازمان مصر';

  @override
  String get calc_Makkah => 'ام‌القری (مکه)';

  @override
  String get calc_Kuwait => 'کویت';

  @override
  String get calc_Qatar => 'قطر';

  @override
  String get calc_Dubai => 'دبی';

  @override
  String get search_hint => 'جستجو در قرآن و تفسیر...';

  @override
  String get search_empty => 'جستجو در قرآن کریم، تفسیر و معانی کلمات';

  @override
  String search_noResults(String query) {
    return 'نتیجه‌ای برای «$query» یافت نشد';
  }

  @override
  String get search_typeAyah => 'آیه';

  @override
  String get search_typeTafsir => 'تفسیر';

  @override
  String get search_typeWord => 'واژه';

  @override
  String get search_typeHadith => 'حدیث';

  @override
  String get stats_daysStreak => 'روز پیاپی';

  @override
  String get stats_prayersUnit => 'نماز';

  @override
  String get stats_pagesUnit => 'صفحه';

  @override
  String get stats_athkar => 'اذکار';

  @override
  String get stats_sessionsUnit => 'جلسه';

  @override
  String stats_pagesOf(int read, int total) {
    return '$read / $total صفحه';
  }

  @override
  String get reader_tapToListen => 'برای شنیدن بزنید';

  @override
  String reader_ayahNum(int n) {
    return 'آیه $n';
  }

  @override
  String get reader_reciter => 'قاری';

  @override
  String get reader_chooseReciter => 'انتخاب قاری';

  @override
  String get reader_searchReciter => 'جستجوی قاری...';

  @override
  String get reader_longPressHint =>
      'روی هر آیه نگه دارید — درگاه، تفسیر و اشتراک';

  @override
  String get reader_versePortal => 'درگاه آیه';

  @override
  String get reader_portalSub => 'تفسیر · واژگان · سیاق';

  @override
  String get reader_showTafsir => 'نمایش تفسیر';

  @override
  String get reader_shareAyah => 'اشتراک آیه';

  @override
  String get reader_copyAyah => 'کپی آیه';

  @override
  String get reader_ayahCopied => 'آیه کپی شد';

  @override
  String reader_tafsirOf(int n) {
    return 'تفسیر آیه $n';
  }

  @override
  String get reader_muyassar => 'المیسر';

  @override
  String get reader_tafsirError => 'بارگذاری تفسیر ناموفق بود';

  @override
  String get reader_shareTitle => 'آیه کریمه';

  @override
  String reader_shareSubtitle(String surah, int n) {
    return '$surah · آیه $n';
  }

  @override
  String get portal_muyassar => 'تفسیر المیسر';

  @override
  String get portal_words => 'تحلیل واژگان';

  @override
  String get portal_hadiths => 'احادیث';

  @override
  String get portal_stories => 'داستان‌ها و سیره';

  @override
  String get portal_arabicTafsir => 'تفاسیر عربی';

  @override
  String get portal_foreignTafsir => 'تفاسیر به زبان‌های دیگر';

  @override
  String get portal_asbab => 'شأن نزول';

  @override
  String get portal_searchLang => 'جستجوی زبان...';

  @override
  String get portal_error => 'درگاه باز نشد';

  @override
  String get portal_back => 'بازگشت';

  @override
  String get portal_noTafsir => 'تفسیری موجود نیست';

  @override
  String get portal_loadError => 'بارگذاری ناموفق بود';

  @override
  String get portal_comingSoon => 'به‌زودی';

  @override
  String get portal_noHadiths => 'هنوز حدیثی به این آیه پیوند نخورده است';

  @override
  String get portal_addingContent => 'محتوا به‌تدریج افزوده می‌شود';

  @override
  String get more_search => 'جستجوی یکپارچه';

  @override
  String get more_settings => 'تنظیمات';

  @override
  String get more_calendar => 'تقویم اسلامی';

  @override
  String get more_shareCards => 'کارت‌های اشتراک';

  @override
  String get more_fullMode => 'حالت کامل';

  @override
  String get more_radio => 'رادیو قرآن';

  @override
  String get more_mosques => 'مساجد نزدیک';

  @override
  String get athkarcat_error => 'خطا';

  @override
  String get athkarcat_empty => 'ذکری موجود نیست';

  @override
  String athkarcat_completed(String name) {
    return '$name کامل شد';
  }

  @override
  String get athkarcat_back => 'بازگشت';

  @override
  String get athkarcat_next => 'بعدی';

  @override
  String get athkarcat_finish => 'پایان';

  @override
  String get athkarcat_prev => 'قبلی';

  @override
  String athkarcat_repeat(int count, String source) {
    return 'تکرار: $count · $source';
  }

  @override
  String athkarcat_narrated(String source) {
    return 'راوی: $source';
  }

  @override
  String get athkarcat_moving => 'در حال انتقال...';

  @override
  String get athkarcat_tapCount => 'برای شمارش بزنید';

  @override
  String get athkar_allSections => 'همه بخش‌ها';

  @override
  String get gateway_entry_title => 'با اسلام آشنا شوید';

  @override
  String get gateway_intro_title => 'سفر آگاهی معنوی';

  @override
  String get gateway_journey_title => 'سفر';

  @override
  String get gateway_principles_title => 'اصول اسلام';

  @override
  String get gateway_library_title => 'کتابخانه';

  @override
  String get gateway_begin => 'آغاز سفر';

  @override
  String get gateway_next => 'بعدی';

  @override
  String get gateway_prev => 'قبلی';

  @override
  String get app_tagline => 'راهنمای اسلامی شما';

  @override
  String get app_brand_name => 'SIRAJ';
}
