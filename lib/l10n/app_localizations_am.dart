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
}
