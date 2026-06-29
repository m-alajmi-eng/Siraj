// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Telugu (`te`).
class AppLocalizationsTe extends AppLocalizations {
  AppLocalizationsTe([String locale = 'te']) : super(locale);

  @override
  String get appName => 'సిరాజ్';

  @override
  String get prayer_title => 'నమాజ్ వేళలు';

  @override
  String get prayer_nextPrayer => 'తర్వాత నమాజ్';

  @override
  String get prayer_fajr => 'ఫజ్ర్';

  @override
  String get prayer_sunrise => 'సూర్యోదయం';

  @override
  String get prayer_dhuhr => 'జుహ్ర్';

  @override
  String get prayer_asr => 'అస్ర్';

  @override
  String get prayer_maghrib => 'మగ్రిబ్';

  @override
  String get prayer_isha => 'ఇషా';

  @override
  String prayer_countdown(String time) {
    return '$time లో';
  }

  @override
  String get prayer_locationGPS => 'మీ ప్రస్తుత స్థానం';

  @override
  String get prayer_locationDefault => 'రియాద్ (డిఫాల్ట్)';

  @override
  String get quran_title => 'పవిత్ర ఖురాన్';

  @override
  String get quran_meccan => 'మక్కీ';

  @override
  String get quran_medinan => 'మదనీ';

  @override
  String quran_ayahCount(int count) {
    return '$count ఆయాలు';
  }

  @override
  String get quran_searchHint => 'ఖురాన్‌లో వెతకండి...';

  @override
  String get quran_noResults => 'ఫలితాలు లేవు';

  @override
  String get quran_searchPrompt => 'వెతకడానికి ఒక పదం టైప్ చేయండి';

  @override
  String get quran_tapForTafsir => 'తఫ్సీర్ కోసం ఆయత్‌ను నొక్కి పట్టుకోండి';

  @override
  String quran_tafsirTitle(int number) {
    return '$numberవ ఆయత్ తఫ్సీర్';
  }

  @override
  String get quran_tafsirSource => 'అల్-ముయస్సర్';

  @override
  String get quran_tafsirError => 'తఫ్సీర్ లోడ్ చేయడం సాధ్యం కాలేదు';

  @override
  String get quran_reciter => 'ఖారీ';

  @override
  String get quran_selectReciter => 'ఖారీని ఎంచుకోండి';

  @override
  String get quran_searchReciter => 'ఖారీని వెతకండి...';

  @override
  String get quran_playPrompt => 'వినడానికి నొక్కండి';

  @override
  String quran_ayahNumber(int number) {
    return '$numberవ ఆయత్';
  }

  @override
  String get athkar_title => 'జిక్ర్';

  @override
  String get athkar_morning => 'తెల్లవారు జిక్ర్';

  @override
  String get athkar_evening => 'సాయంత్రం జిక్ర్';

  @override
  String get athkar_sleep => 'నిద్ర జిక్ర్';

  @override
  String get athkar_wake => 'నిద్రలేపే జిక్ర్';

  @override
  String get athkar_prayer => 'నమాజ్ తర్వాత జిక్ర్';

  @override
  String get athkar_general => 'సాధారణ జిక్ర్';

  @override
  String get athkar_tapToCount => 'లెక్కించడానికి నొక్కండి';

  @override
  String get athkar_transitioning => 'కొనసాగుతోంది...';

  @override
  String athkar_completed(String name) {
    return '$name పూర్తయింది';
  }

  @override
  String get athkar_next => 'తర్వాత';

  @override
  String get athkar_prev => 'మునుపటి';

  @override
  String get athkar_finish => 'ముగించు';

  @override
  String get athkar_back => 'వెనక్కి';

  @override
  String athkar_source(String source) {
    return '$source ఉల్లేఖించారు';
  }

  @override
  String get hadith_title => 'హదీస్';

  @override
  String get hadith_searchHint => 'హదీస్ వెతకండి...';

  @override
  String get hadith_noResults => 'ఫలితాలు లేవు';

  @override
  String get hadith_tapForDetail => 'పూర్తిగా చదవడానికి నొక్కండి';

  @override
  String get hadith_retryButton => 'మళ్ళీ ప్రయత్నించు';

  @override
  String get hadith_loadError => 'లోడ్ విఫలమైంది';

  @override
  String get qibla_title => 'ఖిబ్లా దిశ';

  @override
  String get qibla_active => 'కంపాస్ సక్రియంగా ఉంది';

  @override
  String get qibla_error => 'ఖిబ్లా దిశను నిర్ణయించడం సాధ్యం కాలేదు';

  @override
  String get qibla_errorHint => 'కంపాస్ మరియు స్థానాన్ని ప్రారంభించండి';

  @override
  String get qibla_kaaba => 'కాబా';

  @override
  String get qibla_fromNorth => 'ఉత్తరం నుండి ఖిబ్లా వరకు డిగ్రీలు';

  @override
  String get stats_title => 'నా గణాంకాలు';

  @override
  String get stats_prayerStreak => 'నమాజ్ శ్రేణి';

  @override
  String get stats_totalPrayers => 'మొత్తం నమాజ్లు';

  @override
  String get stats_quranPages => 'ఖురాన్ పేజీలు';

  @override
  String get stats_athkarSessions => 'జిక్ర్';

  @override
  String get stats_khatma => 'ఖురాన్ పూర్తి';

  @override
  String get stats_days => 'వరుస రోజులు';

  @override
  String get stats_prayers => 'నమాజ్లు';

  @override
  String get stats_pages => 'పేజీలు';

  @override
  String get stats_sessions => 'సెషన్లు';

  @override
  String get stats_khatmaUnit => 'పూర్తి';

  @override
  String get stats_currentKhatma => 'ప్రస్తుత పూర్తి పురోగతి';

  @override
  String get more_title => 'మరిన్ని';

  @override
  String get more_qibla => 'ఖిబ్లా దిశ';

  @override
  String get more_stats => 'నా గణాంకాలు';

  @override
  String get common_loading => 'లోడ్ అవుతోంది...';

  @override
  String get common_error => 'డేటా లోడ్ చేయడంలో లోపం';

  @override
  String get common_retry => 'మళ్ళీ ప్రయత్నించు';

  @override
  String get common_back => 'వెనక్కి';

  @override
  String get common_next => 'తర్వాత';

  @override
  String get common_save => 'సేవ్ చేయి';

  @override
  String get common_cancel => 'రద్దు చేయి';

  @override
  String get common_done => 'పూర్తయింది';

  @override
  String get common_search => 'వెతకు';

  @override
  String get common_noData => 'డేటా లేదు';

  @override
  String get common_offline => 'ఇంటర్నెట్ కనెక్షన్ లేదు';

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
