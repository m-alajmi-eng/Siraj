// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'সিরাজ';

  @override
  String get prayer_title => 'নামাজের সময়';

  @override
  String get prayer_nextPrayer => 'পরবর্তী নামাজ';

  @override
  String get prayer_fajr => 'ফজর';

  @override
  String get prayer_sunrise => 'সূর্যোদয়';

  @override
  String get prayer_dhuhr => 'যোহর';

  @override
  String get prayer_asr => 'আসর';

  @override
  String get prayer_maghrib => 'মাগরিব';

  @override
  String get prayer_isha => 'এশা';

  @override
  String prayer_countdown(String time) {
    return '$time এর মধ্যে';
  }

  @override
  String get prayer_locationGPS => 'আপনার বর্তমান অবস্থান';

  @override
  String get prayer_locationDefault => 'রিয়াদ (ডফল্ট)';

  @override
  String get quran_title => 'পবিত্র কুরআন';

  @override
  String get quran_meccan => 'মক';

  @override
  String get quran_medinan => 'মাদানী';

  @override
  String quran_ayahCount(int count) {
    return '$count আয়াত';
  }

  @override
  String get quran_searchHint => 'কুরআনে অনসন্ধান করুন...';

  @override
  String get quran_noResults => 'কোনো ফলাফল নেই';

  @override
  String get quran_searchPrompt => 'অনুসন্ধানের জন্য একটি শব্দ টাইপ করুন';

  @override
  String get quran_tapForTafsir => 'তাফসীরের জন্য আয়াতে দীর্ঘ চপ দিন';

  @override
  String quran_tafsirTitle(int number) {
    return '$number নম্বর আয়াতর তাফসীর';
  }

  @override
  String get quran_tafsirSource => 'আল-মুয়াস্সার';

  @override
  String get quran_tafsirError => 'তাফসীর লড করা যায়নি';

  @override
  String get quran_reciter => 'ক্বরী';

  @override
  String get quran_selectReciter => 'ক্বারী নির্বাচন করুন';

  @override
  String get quran_searchReciter => 'ক্রী অনুসন্ধান করুন...';

  @override
  String get quran_playPrompt => 'শুনতে স্পর্শ করুন';

  @override
  String quran_ayahNumber(int number) {
    return '$number নম্বর আয়াত';
  }

  @override
  String get athkar_title => 'যিকর';

  @override
  String get athkar_morning => 'সকালের যিকর';

  @override
  String get athkar_evening => 'সন্ধ্যার যিকর';

  @override
  String get athkar_sleep => 'ঘুমের যিকর';

  @override
  String get athkar_wake => 'জাগ্রত হওয়ার যিকর';

  @override
  String get athkar_prayer => 'নামাজ পরবর্তী যিকর';

  @override
  String get athkar_general => 'সাধারণ যিকর';

  @override
  String get athkar_tapToCount => 'গণনার জন্য সর্শ করুন';

  @override
  String get athkar_transitioning => 'পরবর্তীতে যাচ্ছে...';

  @override
  String athkar_completed(String name) {
    return '$name সম্পন্ন';
  }

  @override
  String get athkar_next => 'পরবর্তী';

  @override
  String get athkar_prev => 'পূর্ববর্তী';

  @override
  String get athkar_finish => 'শেষ করুন';

  @override
  String get athkar_back => 'ফিরে যান';

  @override
  String athkar_source(String source) {
    return '$source কর্তৃক বর্ণিত';
  }

  @override
  String get hadith_title => 'হাদীস শরীফ';

  @override
  String get hadith_searchHint => 'হাদীস অনুসন্ধান করুন...';

  @override
  String get hadith_noResults => 'কনো ফলাফল নেই';

  @override
  String get hadith_tapForDetail => 'সম্পূর্ণ হাদীস পড়ত স্পর্শ করুন';

  @override
  String get hadith_retryButton => 'আবার চেষ্টা করুন';

  @override
  String get hadith_loadError => 'লোড করা যায়নি';

  @override
  String get qibla_title => 'কিবলার দিক';

  @override
  String get qibla_active => 'কমস সক্রিয়';

  @override
  String get qibla_error => 'কিবলার দিক নির্ধারণ করা যায়নি';

  @override
  String get qibla_errorHint => 'কম্পাস এবং অবস্থান সক্রিয় করুন';

  @override
  String get qibla_kaaba => 'কাবা';

  @override
  String get qibla_fromNorth => 'উত্তর থেকে কিবলার দিক ডিগ্রি';

  @override
  String get stats_title => 'আমার পরিসখ্যান';

  @override
  String get stats_prayerStreak => 'নামাজের ধারাবাহিকতা';

  @override
  String get stats_totalPrayers => 'মোট নামাজ';

  @override
  String get stats_quranPages => 'কুরআনের পৃষ্ঠা';

  @override
  String get stats_athkarSessions => 'যকর';

  @override
  String get stats_khatma => 'কুরআন খতম';

  @override
  String get stats_days => 'ধারাবাহিক দিন';

  @override
  String get stats_prayers => 'নামাজ';

  @override
  String get stats_pages => 'পৃষ্ঠা';

  @override
  String get stats_sessions => 'সেশন';

  @override
  String get stats_khatmaUnit => 'খতম';

  @override
  String get stats_currentKhatma => 'বর্তমান খতমর অগ্রগতি';

  @override
  String get more_title => 'আরও';

  @override
  String get more_qibla => 'কিবলার দিক';

  @override
  String get more_stats => 'আমর পরিসংখ্যান';

  @override
  String get common_loading => 'লোড হচ্ছে...';

  @override
  String get common_error => 'ডেটা লোড করতে ত্রুটি';

  @override
  String get common_retry => 'আবার চেষ্টা করুন';

  @override
  String get common_back => 'ফিরে যান';

  @override
  String get common_next => 'পরবর্তী';

  @override
  String get common_save => 'সংরক্ষণ করুন';

  @override
  String get common_cancel => 'বাতিল করুন';

  @override
  String get common_done => 'সম্পন্ন';

  @override
  String get common_search => 'অনুসন্ধান';

  @override
  String get common_noData => 'কোনো ডেটা নেই';

  @override
  String get common_offline => 'ইন্টারনেট সংযোগ নেই';

  @override
  String get nav_home => 'হোম';

  @override
  String get nav_quran => 'কুরআন';

  @override
  String get nav_athkar => 'যকর';

  @override
  String get nav_hadith => 'হাদিস';

  @override
  String get nav_more => 'আরও';

  @override
  String get home_greetingNight => 'বরকতময় রাত,';

  @override
  String get home_greetingFajr => 'ফজরর শান্তি,';

  @override
  String get home_greetingMorning => 'শুভ সকাল,';

  @override
  String get home_greetingNoon => 'শভ দুপুর,';

  @override
  String get home_greetingAsr => 'বরকতময় বিকেল,';

  @override
  String get home_greetingEvening => 'শুভ সন্ধ,';

  @override
  String get home_greetingLateNight => 'শান্তিময় রাত,';

  @override
  String get home_welcome => 'স্বাগতম';

  @override
  String get home_nextPrayer => 'পরবর্তী নামাজ';

  @override
  String get home_qiblaDirection => 'কিবলর দিক';

  @override
  String get home_continueReading => 'পড়া চালিয়ে যান';

  @override
  String home_surah(int id) {
    return 'سورة #$id';
  }

  @override
  String home_ayah(int number) {
    return 'آية $number';
  }

  @override
  String get home_dailyAyah => 'আজকের আয়াত';

  @override
  String get home_quickAccess => 'দ্রুত অ্যাক্সেস';

  @override
  String get home_searchHint => 'আপনি কী খুঁজছেন...';

  @override
  String get home_radio => 'রেডিও';

  @override
  String get home_calendar => 'ক্যালেন্ডার';

  @override
  String get home_stories => 'গল্প';

  @override
  String get home_children => 'শশুরা';

  @override
  String get settings_title => 'সেটিংস';

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
