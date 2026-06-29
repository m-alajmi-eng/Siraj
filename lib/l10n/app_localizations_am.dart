// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class AppLocalizationsAm extends AppLocalizations {
  AppLocalizationsAm([String locale = 'am']) : super(locale);

  @override
  String get appName => 'ሲራጅ';

  @override
  String get prayer_title => 'የሶላት ጊዜዎች';

  @override
  String get prayer_nextPrayer => 'ቀጣይ ሶላት';

  @override
  String get prayer_fajr => 'ፈጅር';

  @override
  String get prayer_sunrise => 'ፀሐይ ወጣ';

  @override
  String get prayer_dhuhr => 'ዙህር';

  @override
  String get prayer_asr => 'ዐስር';

  @override
  String get prayer_maghrib => 'መግሪብ';

  @override
  String get prayer_isha => 'ዒሻ';

  @override
  String prayer_countdown(String time) {
    return 'በ$time ውስጥ';
  }

  @override
  String get prayer_locationGPS => 'የአሁን ቦታዎ';

  @override
  String get prayer_locationDefault => 'ሪያድ (ነባሪ)';

  @override
  String get quran_title => 'ቅዱስ ቁርዓን';

  @override
  String get quran_meccan => 'መካዊ';

  @override
  String get quran_medinan => 'መዲናዊ';

  @override
  String quran_ayahCount(int count) {
    return '$count አያቶች';
  }

  @override
  String get quran_searchHint => 'በቁርዓን ውስጥ ፈልግ...';

  @override
  String get quran_noResults => 'ምንም ውጤት የለም';

  @override
  String get quran_searchPrompt => 'ለመፈለግ ቃል ይፃፉ';

  @override
  String get quran_tapForTafsir => 'ተፍሲር ለማግኘት አያህን ይጫኑ';

  @override
  String quran_tafsirTitle(int number) {
    return 'የ$numberኛ አያህ ተፍሲር';
  }

  @override
  String get quran_tafsirSource => 'አል-ሙያሳር';

  @override
  String get quran_tafsirError => 'ተፍሲር ማስጫን አልተቻለም';

  @override
  String get quran_reciter => 'ቃሪ';

  @override
  String get quran_selectReciter => 'ቃሪ ይምረጡ';

  @override
  String get quran_searchReciter => 'ቃሪ ፈልግ...';

  @override
  String get quran_playPrompt => 'ለማዳመጥ መታ ያድርጉ';

  @override
  String quran_ayahNumber(int number) {
    return '$numberኛ አያህ';
  }

  @override
  String get athkar_title => 'አዝካር';

  @override
  String get athkar_morning => 'የጠዋት አዝካር';

  @override
  String get athkar_evening => 'የምሽት አዝካር';

  @override
  String get athkar_sleep => 'የእንቅልፍ አዝካር';

  @override
  String get athkar_wake => 'የንቃት አዝካር';

  @override
  String get athkar_prayer => 'ሶላት በኋላ አዝካር';

  @override
  String get athkar_general => 'ጠቅላላ አዝካር';

  @override
  String get athkar_tapToCount => 'ለመቁጠር መታ ያድርጉ';

  @override
  String get athkar_transitioning => 'እየቀጠለ...';

  @override
  String athkar_completed(String name) {
    return '$name ተጠናቋል';
  }

  @override
  String get athkar_next => 'ቀጣይ';

  @override
  String get athkar_prev => 'ቀዳሚ';

  @override
  String get athkar_finish => 'ጨርስ';

  @override
  String get athkar_back => 'ተመለስ';

  @override
  String athkar_source(String source) {
    return 'በ$source ተዘግቧል';
  }

  @override
  String get hadith_title => 'ሐዲስ';

  @override
  String get hadith_searchHint => 'ሐዲስ ፈልግ...';

  @override
  String get hadith_noResults => 'ምንም ውጤት የለም';

  @override
  String get hadith_tapForDetail => 'ሙሉ ለማንበብ መታ ያድርጉ';

  @override
  String get hadith_retryButton => 'እንደገና ሞክር';

  @override
  String get hadith_loadError => 'ማስጫን አልተቻለም';

  @override
  String get qibla_title => 'የቅብላ አቅጣጫ';

  @override
  String get qibla_active => 'ኮምፓስ ንቁ ነው';

  @override
  String get qibla_error => 'የቅብላ አቅጣጫ ማወቅ አልተቻለም';

  @override
  String get qibla_errorHint => 'ኮምፓስ እና ቦታ ያብሩ';

  @override
  String get qibla_kaaba => 'ካዕባ';

  @override
  String get qibla_fromNorth => 'ከሰሜን ወደ ቅብላ ዲግሪ';

  @override
  String get stats_title => 'የኔ ስታቲስቲክስ';

  @override
  String get stats_prayerStreak => 'የሶላት ተከታታይ';

  @override
  String get stats_totalPrayers => 'ጠቅላላ ሶላቶች';

  @override
  String get stats_quranPages => 'የቁርዓን ገፆች';

  @override
  String get stats_athkarSessions => 'አዝካር';

  @override
  String get stats_khatma => 'የቁርዓን ጭዳ';

  @override
  String get stats_days => 'ተከታታይ ቀናት';

  @override
  String get stats_prayers => 'ሶላቶች';

  @override
  String get stats_pages => 'ገፆች';

  @override
  String get stats_sessions => 'ክፍለ ጊዜዎች';

  @override
  String get stats_khatmaUnit => 'ጭዳ';

  @override
  String get stats_currentKhatma => 'የአሁን ጭዳ እድገት';

  @override
  String get more_title => 'ተጨማሪ';

  @override
  String get more_qibla => 'የቅብላ አቅጣጫ';

  @override
  String get more_stats => 'የኔ ስታቲስቲክስ';

  @override
  String get common_loading => 'እየጫነ...';

  @override
  String get common_error => 'ዳታ ማስጫን ስህተት';

  @override
  String get common_retry => 'እንደገና ሞክር';

  @override
  String get common_back => 'ተመለስ';

  @override
  String get common_next => 'ቀጣይ';

  @override
  String get common_save => 'አስቀምጥ';

  @override
  String get common_cancel => 'ሰርዝ';

  @override
  String get common_done => 'ተጠናቋል';

  @override
  String get common_search => 'ፈልግ';

  @override
  String get common_noData => 'ምንም ዳታ የለም';

  @override
  String get common_offline => 'የኢንተርኔት ግንኙነት የለም';

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
}
