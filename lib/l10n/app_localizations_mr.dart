// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Marathi (`mr`).
class AppLocalizationsMr extends AppLocalizations {
  AppLocalizationsMr([String locale = 'mr']) : super(locale);

  @override
  String get appName => 'सिराज';

  @override
  String get prayer_title => 'नमाज वेळा';

  @override
  String get prayer_nextPrayer => 'पुढची नमाज';

  @override
  String get prayer_fajr => 'फज्र';

  @override
  String get prayer_sunrise => 'सूर्योदय';

  @override
  String get prayer_dhuhr => 'जुह्र';

  @override
  String get prayer_asr => 'अस्र';

  @override
  String get prayer_maghrib => 'मग्रिब';

  @override
  String get prayer_isha => 'इशा';

  @override
  String prayer_countdown(String time) {
    return '$time मध्ये';
  }

  @override
  String get prayer_locationGPS => 'तुमचे सध्याचे स्थान';

  @override
  String get prayer_locationDefault => 'रियाद (डीफॉल्ट)';

  @override
  String get quran_title => 'पवित्र कुराण';

  @override
  String get quran_meccan => 'मक्की';

  @override
  String get quran_medinan => 'मदनी';

  @override
  String quran_ayahCount(int count) {
    return '$count आयत';
  }

  @override
  String get quran_searchHint => 'कुराणमध्ये शोधा...';

  @override
  String get quran_noResults => 'कोणताही निकाल नाही';

  @override
  String get quran_searchPrompt => 'शोधण्यासाठी शब्द टाइप करा';

  @override
  String get quran_tapForTafsir => 'तफ्सीरसाठी आयतवर दीर्घ दाबा';

  @override
  String quran_tafsirTitle(int number) {
    return '$numberव्या आयतचा तफ्सीर';
  }

  @override
  String get quran_tafsirSource => 'अल-मुयस्सर';

  @override
  String get quran_tafsirError => 'तफ्सीर लोड करता आला नाही';

  @override
  String get quran_reciter => 'क़ारी';

  @override
  String get quran_selectReciter => 'क़ारी निवडा';

  @override
  String get quran_searchReciter => 'क़ारी शोधा...';

  @override
  String get quran_playPrompt => 'ऐकण्यासाठी टॅप करा';

  @override
  String quran_ayahNumber(int number) {
    return '$numberवी आयत';
  }

  @override
  String get athkar_title => 'जिक्र';

  @override
  String get athkar_morning => 'सकाळचे जिक्र';

  @override
  String get athkar_evening => 'संध्याकाळचे जिक्र';

  @override
  String get athkar_sleep => 'झोपेचे जिक्र';

  @override
  String get athkar_wake => 'जागण्याचे जिक्र';

  @override
  String get athkar_prayer => 'नमाजनंतरचे जिक्र';

  @override
  String get athkar_general => 'सामान्य जिक्र';

  @override
  String get athkar_tapToCount => 'मोजण्यासाठी टॅप करा';

  @override
  String get athkar_transitioning => 'चालू आहे...';

  @override
  String athkar_completed(String name) {
    return '$name पूर्ण झाले';
  }

  @override
  String get athkar_next => 'पुढे';

  @override
  String get athkar_prev => 'मागे';

  @override
  String get athkar_finish => 'समाप्त';

  @override
  String get athkar_back => 'परत';

  @override
  String athkar_source(String source) {
    return '$source यांनी सांगितले';
  }

  @override
  String get hadith_title => 'हदीस';

  @override
  String get hadith_searchHint => 'हदीस शोधा...';

  @override
  String get hadith_noResults => 'कोणताही निकाल नाही';

  @override
  String get hadith_tapForDetail => 'पूर्ण वाचण्यासाठी टॅप करा';

  @override
  String get hadith_retryButton => 'पुन्हा प्रयत्न करा';

  @override
  String get hadith_loadError => 'लोड अयशस्वी';

  @override
  String get qibla_title => 'किब्ला दिशा';

  @override
  String get qibla_active => 'कंपास सक्रिय';

  @override
  String get qibla_error => 'किब्ला दिशा निर्धारित करता आली नाही';

  @override
  String get qibla_errorHint => 'कंपास आणि स्थान चालू करा';

  @override
  String get qibla_kaaba => 'काबा';

  @override
  String get qibla_fromNorth => 'उत्तरेकडून किब्लाकडे अंश';

  @override
  String get stats_title => 'माझी आकडेवारी';

  @override
  String get stats_prayerStreak => 'नमाज मालिका';

  @override
  String get stats_totalPrayers => 'एकूण नमाज';

  @override
  String get stats_quranPages => 'कुराण पृष्ठे';

  @override
  String get stats_athkarSessions => 'जिक्र';

  @override
  String get stats_khatma => 'कुराण खतम';

  @override
  String get stats_days => 'सलग दिवस';

  @override
  String get stats_prayers => 'नमाज';

  @override
  String get stats_pages => 'पृष्ठे';

  @override
  String get stats_sessions => 'सत्र';

  @override
  String get stats_khatmaUnit => 'खतम';

  @override
  String get stats_currentKhatma => 'सध्याची खतम प्रगती';

  @override
  String get more_title => 'अधिक';

  @override
  String get more_qibla => 'किब्ला दिशा';

  @override
  String get more_stats => 'माझी आकडेवारी';

  @override
  String get common_loading => 'लोड होत आहे...';

  @override
  String get common_error => 'डेटा लोड करण्यात त्रुटी';

  @override
  String get common_retry => 'पुन्हा प्रयत्न करा';

  @override
  String get common_back => 'परत';

  @override
  String get common_next => 'पुढे';

  @override
  String get common_save => 'जतन करा';

  @override
  String get common_cancel => 'रद्द करा';

  @override
  String get common_done => 'झाले';

  @override
  String get common_search => 'शोधा';

  @override
  String get common_noData => 'कोणताही डेटा नाही';

  @override
  String get common_offline => 'इंटरनेट कनेक्शन नाही';

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
