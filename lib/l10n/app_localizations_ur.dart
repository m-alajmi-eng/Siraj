// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appName => 'سراج';

  @override
  String get prayer_title => 'نماز کے اوقات';

  @override
  String get prayer_nextPrayer => 'اگلی نماز';

  @override
  String get prayer_fajr => 'فجر';

  @override
  String get prayer_sunrise => 'اشراق';

  @override
  String get prayer_dhuhr => 'ظہر';

  @override
  String get prayer_asr => 'عصر';

  @override
  String get prayer_maghrib => 'مغرب';

  @override
  String get prayer_isha => 'عشاء';

  @override
  String prayer_countdown(String time) {
    return '$time میں';
  }

  @override
  String get prayer_locationGPS => 'آپ کا موجودہ مقام';

  @override
  String get prayer_locationDefault => 'ریاض (پہلے سے طے شدہ)';

  @override
  String get quran_title => 'قرآن کریم';

  @override
  String get quran_meccan => 'مکی';

  @override
  String get quran_medinan => 'مدنی';

  @override
  String quran_ayahCount(int count) {
    return '$count آیات';
  }

  @override
  String get quran_searchHint => 'قرآن میں تلاش کریں...';

  @override
  String get quran_noResults => 'کوئی نتیجہ نہیں';

  @override
  String get quran_searchPrompt => 'تلاش کے لیے لفظ لکھیں';

  @override
  String get quran_tapForTafsir => 'تفسیر کے لیے آیت کو دیر تک دبائیں';

  @override
  String quran_tafsirTitle(int number) {
    return 'آیت $number کی تفسیر';
  }

  @override
  String get quran_tafsirSource => 'المیسر';

  @override
  String get quran_tafsirError => 'تفسیر لوڈ نہیں ہو سکی';

  @override
  String get quran_reciter => 'قاری';

  @override
  String get quran_selectReciter => 'قاری منتخب کریں';

  @override
  String get quran_searchReciter => 'قاری تلاش کریں...';

  @override
  String get quran_playPrompt => 'سننے کے لیے دبائیں';

  @override
  String quran_ayahNumber(int number) {
    return 'آیت $number';
  }

  @override
  String get athkar_title => 'اذکار';

  @override
  String get athkar_morning => 'صبح کے اذکار';

  @override
  String get athkar_evening => 'شام کے اذکار';

  @override
  String get athkar_sleep => 'سونے کے اذکار';

  @override
  String get athkar_wake => 'جاگنے کے اذکار';

  @override
  String get athkar_prayer => 'نماز کے بعد کے اذکار';

  @override
  String get athkar_general => 'عمومی اذکار';

  @override
  String get athkar_tapToCount => 'گنتی کے لیے دبائیں';

  @override
  String get athkar_transitioning => 'منتقل ہو رہا ہے...';

  @override
  String athkar_completed(String name) {
    return '$name مکمل';
  }

  @override
  String get athkar_next => 'اگلا';

  @override
  String get athkar_prev => 'پچھلا';

  @override
  String get athkar_finish => 'ختم کریں';

  @override
  String get athkar_back => 'واپس';

  @override
  String athkar_source(String source) {
    return '$source نے روایت کیا';
  }

  @override
  String get hadith_title => 'حدیث شریف';

  @override
  String get hadith_searchHint => 'احادیث میں تلاش کریں...';

  @override
  String get hadith_noResults => 'کوئی نتیجہ نہیں';

  @override
  String get hadith_tapForDetail => 'مکمل حدیث پڑھنے کے لیے دبائیں';

  @override
  String get hadith_retryButton => 'دوبارہ کوشش کریں';

  @override
  String get hadith_loadError => 'لوڈ نہیں ہو سکا';

  @override
  String get qibla_title => 'قبلہ کی سمت';

  @override
  String get qibla_active => 'کمپاس فعال ہے';

  @override
  String get qibla_error => 'قبلہ کی سمت معلوم نہیں ہو سکی';

  @override
  String get qibla_errorHint => 'کمپاس اور مقام کو فعال کریں';

  @override
  String get qibla_kaaba => 'کعبہ';

  @override
  String get qibla_fromNorth => 'شمال سے قبلہ کی طرف ڈگری';

  @override
  String get stats_title => 'میری اعداد و شمار';

  @override
  String get stats_prayerStreak => 'نماز کا سلسلہ';

  @override
  String get stats_totalPrayers => 'کل نمازیں';

  @override
  String get stats_quranPages => 'قرآن کے صفحات';

  @override
  String get stats_athkarSessions => 'اذکار';

  @override
  String get stats_khatma => 'قرآن ختم';

  @override
  String get stats_days => 'مسلسل دن';

  @override
  String get stats_prayers => 'نمازیں';

  @override
  String get stats_pages => 'صفحات';

  @override
  String get stats_sessions => 'سیشن';

  @override
  String get stats_khatmaUnit => 'ختم';

  @override
  String get stats_currentKhatma => 'موجودہ ختم کی پیشرفت';

  @override
  String get more_title => 'مزید';

  @override
  String get more_qibla => 'قبلہ کی سمت';

  @override
  String get more_stats => 'میری اعداد و شمار';

  @override
  String get common_loading => 'لوڈ ہو رہا ہے...';

  @override
  String get common_error => 'ڈیٹا لوڈ کرنے میں خطا';

  @override
  String get common_retry => 'دوبارہ کوشش کریں';

  @override
  String get common_back => 'واپس';

  @override
  String get common_next => 'اگلا';

  @override
  String get common_save => 'محفوظ کریں';

  @override
  String get common_cancel => 'منسوخ کریں';

  @override
  String get common_done => 'ہو گیا';

  @override
  String get common_search => 'تلاش';

  @override
  String get common_noData => 'کوئی ڈیٹا نہیں';

  @override
  String get common_offline => 'انٹرنیٹ کنکشن نہیں';

  @override
  String get nav_home => 'ہوم';

  @override
  String get nav_quran => 'قرآن';

  @override
  String get nav_athkar => 'اذکار';

  @override
  String get nav_hadith => 'حدیث';

  @override
  String get nav_more => 'مزید';

  @override
  String get home_greetingNight => 'مبارک رات،';

  @override
  String get home_greetingFajr => 'فجر کی سلامتی،';

  @override
  String get home_greetingMorning => 'صبح بخیر،';

  @override
  String get home_greetingNoon => 'دوپہر بخیر،';

  @override
  String get home_greetingAsr => 'مبارک سہ پہر،';

  @override
  String get home_greetingEvening => 'شام بخیر،';

  @override
  String get home_greetingLateNight => 'پرسکون رات،';

  @override
  String get home_welcome => 'خوش آمدید';

  @override
  String get home_nextPrayer => 'اگلی نماز';

  @override
  String get home_qiblaDirection => 'قبلہ کی سمت';

  @override
  String get home_continueReading => 'پڑھنا جاری رکھیں';

  @override
  String home_surah(int id) {
    return 'سورة #$id';
  }

  @override
  String home_ayah(int number) {
    return 'آية $number';
  }

  @override
  String get home_dailyAyah => 'آج کی آیت';

  @override
  String get home_quickAccess => 'فوری رسائی';

  @override
  String get home_searchHint => 'آپ کیا تلاش کر رہے ہیں...';

  @override
  String get home_radio => 'ریڈیو';

  @override
  String get home_calendar => 'کیلنڈر';

  @override
  String get home_stories => 'کہانیاں';

  @override
  String get home_children => 'بچے';

  @override
  String get settings_title => 'ترتیبات';

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
}
