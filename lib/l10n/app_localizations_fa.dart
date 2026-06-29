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
    return 'سورة #$id';
  }

  @override
  String home_ayah(int number) {
    return 'آية $number';
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
}
