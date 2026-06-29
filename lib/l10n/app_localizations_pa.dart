// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Panjabi Punjabi (`pa`).
class AppLocalizationsPa extends AppLocalizations {
  AppLocalizationsPa([String locale = 'pa']) : super(locale);

  @override
  String get appName => 'ਸਿਰਾਜ';

  @override
  String get prayer_title => 'ਨਮਾਜ਼ ਦੇ ਸਮੇਂ';

  @override
  String get prayer_nextPrayer => 'ਅਗਲੀ ਨਮਾਜ਼';

  @override
  String get prayer_fajr => 'ਫਜ਼ਰ';

  @override
  String get prayer_sunrise => 'ਸੂਰਜ ਚੜ੍ਹਨਾ';

  @override
  String get prayer_dhuhr => 'ਜ਼ੁਹਰ';

  @override
  String get prayer_asr => 'ਅਸਰ';

  @override
  String get prayer_maghrib => 'ਮਗ਼ਰਿਬ';

  @override
  String get prayer_isha => 'ਇਸ਼ਾ';

  @override
  String prayer_countdown(String time) {
    return '$time ਵਿੱਚ';
  }

  @override
  String get prayer_locationGPS => 'ਤੁਹਾਡੀ ਮੌਜੂਦਾ ਸਥਿਤੀ';

  @override
  String get prayer_locationDefault => 'ਰਿਆਦ (ਡਿਫਾਲਟ)';

  @override
  String get quran_title => 'ਪਵਿੱਤਰ ਕੁਰਾਨ';

  @override
  String get quran_meccan => 'ਮੱਕੀ';

  @override
  String get quran_medinan => 'ਮਦਨੀ';

  @override
  String quran_ayahCount(int count) {
    return '$count ਆਇਤਾਂ';
  }

  @override
  String get quran_searchHint => 'ਕੁਰਾਨ ਵਿੱਚ ਖੋਜੋ...';

  @override
  String get quran_noResults => 'ਕੋਈ ਨਤੀਜੇ ਨਹੀਂ';

  @override
  String get quran_searchPrompt => 'ਖੋਜਣ ਲਈ ਸ਼ਬਦ ਟਾਈਪ ਕਰੋ';

  @override
  String get quran_tapForTafsir => 'ਤਫ਼ਸੀਰ ਲਈ ਆਇਤ ਨੂੰ ਦੇਰ ਤੱਕ ਦਬਾਓ';

  @override
  String quran_tafsirTitle(int number) {
    return '$numberਵੀਂ ਆਇਤ ਦੀ ਤਫ਼ਸੀਰ';
  }

  @override
  String get quran_tafsirSource => 'ਅਲ-ਮੁਯੱਸਰ';

  @override
  String get quran_tafsirError => 'ਤਫ਼ਸੀਰ ਲੋਡ ਨਹੀਂ ਹੋ ਸਕੀ';

  @override
  String get quran_reciter => 'ਕ਼ਾਰੀ';

  @override
  String get quran_selectReciter => 'ਕ਼ਾਰੀ ਚੁਣੋ';

  @override
  String get quran_searchReciter => 'ਕ਼ਾਰੀ ਖੋਜੋ...';

  @override
  String get quran_playPrompt => 'ਸੁਣਨ ਲਈ ਟੈਪ ਕਰੋ';

  @override
  String quran_ayahNumber(int number) {
    return '$numberਵੀਂ ਆਇਤ';
  }

  @override
  String get athkar_title => 'ਜ਼ਿਕਰ';

  @override
  String get athkar_morning => 'ਸਵੇਰ ਦੇ ਜ਼ਿਕਰ';

  @override
  String get athkar_evening => 'ਸ਼ਾਮ ਦੇ ਜ਼ਿਕਰ';

  @override
  String get athkar_sleep => 'ਸੌਣ ਦੇ ਜ਼ਿਕਰ';

  @override
  String get athkar_wake => 'ਜਾਗਣ ਦੇ ਜ਼ਿਕਰ';

  @override
  String get athkar_prayer => 'ਨਮਾਜ਼ ਤੋਂ ਬਾਅਦ ਜ਼ਿਕਰ';

  @override
  String get athkar_general => 'ਆਮ ਜ਼ਿਕਰ';

  @override
  String get athkar_tapToCount => 'ਗਿਣਨ ਲਈ ਟੈਪ ਕਰੋ';

  @override
  String get athkar_transitioning => 'ਜਾਰੀ ਹੈ...';

  @override
  String athkar_completed(String name) {
    return '$name ਮੁਕੰਮਲ';
  }

  @override
  String get athkar_next => 'ਅਗਲਾ';

  @override
  String get athkar_prev => 'ਪਿਛਲਾ';

  @override
  String get athkar_finish => 'ਸਮਾਪਤ';

  @override
  String get athkar_back => 'ਵਾਪਸ';

  @override
  String athkar_source(String source) {
    return '$source ਨੇ ਬਿਆਨ ਕੀਤਾ';
  }

  @override
  String get hadith_title => 'ਹਦੀਸ';

  @override
  String get hadith_searchHint => 'ਹਦੀਸ ਖੋਜੋ...';

  @override
  String get hadith_noResults => 'ਕੋਈ ਨਤੀਜੇ ਨਹੀਂ';

  @override
  String get hadith_tapForDetail => 'ਪੂਰਾ ਪੜ੍ਹਨ ਲਈ ਟੈਪ ਕਰੋ';

  @override
  String get hadith_retryButton => 'ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ';

  @override
  String get hadith_loadError => 'ਲੋਡ ਅਸਫਲ';

  @override
  String get qibla_title => 'ਕਿਬਲਾ ਦਿਸ਼ਾ';

  @override
  String get qibla_active => 'ਕੰਪਾਸ ਸਰਗਰਮ';

  @override
  String get qibla_error => 'ਕਿਬਲਾ ਦਿਸ਼ਾ ਨਿਰਧਾਰਿਤ ਨਹੀਂ ਕੀਤੀ ਜਾ ਸਕੀ';

  @override
  String get qibla_errorHint => 'ਕੰਪਾਸ ਅਤੇ ਸਥਾਨ ਚਾਲੂ ਕਰੋ';

  @override
  String get qibla_kaaba => 'ਕਾਬਾ';

  @override
  String get qibla_fromNorth => 'ਉੱਤਰ ਤੋਂ ਕਿਬਲਾ ਤੱਕ ਡਿਗਰੀ';

  @override
  String get stats_title => 'ਮੇਰੇ ਅੰਕੜੇ';

  @override
  String get stats_prayerStreak => 'ਨਮਾਜ਼ ਕ੍ਰਮ';

  @override
  String get stats_totalPrayers => 'ਕੁੱਲ ਨਮਾਜ਼ਾਂ';

  @override
  String get stats_quranPages => 'ਕੁਰਾਨ ਦੇ ਪੰਨੇ';

  @override
  String get stats_athkarSessions => 'ਜ਼ਿਕਰ';

  @override
  String get stats_khatma => 'ਕੁਰਾਨ ਖਤਮ';

  @override
  String get stats_days => 'ਲਗਾਤਾਰ ਦਿਨ';

  @override
  String get stats_prayers => 'ਨਮਾਜ਼ਾਂ';

  @override
  String get stats_pages => 'ਪੰਨੇ';

  @override
  String get stats_sessions => 'ਸੈਸ਼ਨ';

  @override
  String get stats_khatmaUnit => 'ਖਤਮ';

  @override
  String get stats_currentKhatma => 'ਮੌਜੂਦਾ ਖਤਮ ਪ੍ਰਗਤੀ';

  @override
  String get more_title => 'ਹੋਰ';

  @override
  String get more_qibla => 'ਕਿਬਲਾ ਦਿਸ਼ਾ';

  @override
  String get more_stats => 'ਮੇਰੇ ਅੰਕੜੇ';

  @override
  String get common_loading => 'ਲੋਡ ਹੋ ਰਿਹਾ ਹੈ...';

  @override
  String get common_error => 'ਡੇਟਾ ਲੋਡ ਕਰਨ ਵਿੱਚ ਗਲਤੀ';

  @override
  String get common_retry => 'ਦੁਬਾਰਾ ਕੋਸ਼ਿਸ਼ ਕਰੋ';

  @override
  String get common_back => 'ਵਾਪਸ';

  @override
  String get common_next => 'ਅਗਲਾ';

  @override
  String get common_save => 'ਸੁਰੱਖਿਅਤ ਕਰੋ';

  @override
  String get common_cancel => 'ਰੱਦ ਕਰੋ';

  @override
  String get common_done => 'ਹੋ ਗਿਆ';

  @override
  String get common_search => 'ਖੋਜੋ';

  @override
  String get common_noData => 'ਕੋਈ ਡੇਟਾ ਨਹੀਂ';

  @override
  String get common_offline => 'ਇੰਟਰਨੈੱਟ ਕਨੈਕਸ਼ਨ ਨਹੀਂ';

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
}
