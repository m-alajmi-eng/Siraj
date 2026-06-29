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
}
