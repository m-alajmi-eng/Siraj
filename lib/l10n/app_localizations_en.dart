// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Siraj';

  @override
  String get prayer_title => 'Prayer Times';

  @override
  String get prayer_nextPrayer => 'Next Prayer';

  @override
  String get prayer_fajr => 'Fajr';

  @override
  String get prayer_sunrise => 'Sunrise';

  @override
  String get prayer_dhuhr => 'Dhuhr';

  @override
  String get prayer_asr => 'Asr';

  @override
  String get prayer_maghrib => 'Maghrib';

  @override
  String get prayer_isha => 'Isha';

  @override
  String prayer_countdown(String time) {
    return 'In $time';
  }

  @override
  String get prayer_locationGPS => 'Your current location';

  @override
  String get prayer_locationDefault => 'Riyadh (default)';

  @override
  String get quran_title => 'The Holy Quran';

  @override
  String get quran_meccan => 'Meccan';

  @override
  String get quran_medinan => 'Medinan';

  @override
  String quran_ayahCount(int count) {
    return '$count verses';
  }

  @override
  String get quran_searchHint => 'Search the Holy Quran...';

  @override
  String get quran_noResults => 'No results found';

  @override
  String get quran_searchPrompt => 'Type a word to search';

  @override
  String get quran_tapForTafsir => 'Long press any verse for tafsir';

  @override
  String quran_tafsirTitle(int number) {
    return 'Tafsir of Verse $number';
  }

  @override
  String get quran_tafsirSource => 'Al-Muyassar';

  @override
  String get quran_tafsirError => 'Could not load tafsir';

  @override
  String get quran_reciter => 'Reciter';

  @override
  String get quran_selectReciter => 'Select Reciter';

  @override
  String get quran_searchReciter => 'Search for a reciter...';

  @override
  String get quran_playPrompt => 'Tap to listen';

  @override
  String quran_ayahNumber(int number) {
    return 'Verse $number';
  }

  @override
  String get athkar_title => 'Athkar';

  @override
  String get athkar_morning => 'Morning Athkar';

  @override
  String get athkar_evening => 'Evening Athkar';

  @override
  String get athkar_sleep => 'Sleep Athkar';

  @override
  String get athkar_wake => 'Waking Athkar';

  @override
  String get athkar_prayer => 'Post-Prayer Athkar';

  @override
  String get athkar_general => 'General Athkar';

  @override
  String get athkar_tapToCount => 'Tap to count';

  @override
  String get athkar_transitioning => 'Moving to next...';

  @override
  String athkar_completed(String name) {
    return '$name completed';
  }

  @override
  String get athkar_next => 'Next';

  @override
  String get athkar_prev => 'Previous';

  @override
  String get athkar_finish => 'Finish';

  @override
  String get athkar_back => 'Back';

  @override
  String athkar_source(String source) {
    return 'Narrated by $source';
  }

  @override
  String get hadith_title => 'Hadith';

  @override
  String get hadith_searchHint => 'Search hadiths...';

  @override
  String get hadith_noResults => 'No results found';

  @override
  String get hadith_tapForDetail => 'Tap to read full hadith';

  @override
  String get hadith_retryButton => 'Try Again';

  @override
  String get hadith_loadError => 'Failed to load';

  @override
  String get qibla_title => 'Qibla Direction';

  @override
  String get qibla_active => 'Compass active';

  @override
  String get qibla_error => 'Could not determine Qibla direction';

  @override
  String get qibla_errorHint => 'Make sure compass and location are enabled';

  @override
  String get qibla_kaaba => 'Kaaba';

  @override
  String get qibla_fromNorth => 'Degrees from North toward Qibla';

  @override
  String get stats_title => 'My Stats';

  @override
  String get stats_prayerStreak => 'Prayer Streak';

  @override
  String get stats_totalPrayers => 'Total Prayers';

  @override
  String get stats_quranPages => 'Quran Pages';

  @override
  String get stats_athkarSessions => 'Athkar';

  @override
  String get stats_khatma => 'Quran Completions';

  @override
  String get stats_days => 'consecutive days';

  @override
  String get stats_prayers => 'prayers';

  @override
  String get stats_pages => 'pages';

  @override
  String get stats_sessions => 'sessions';

  @override
  String get stats_khatmaUnit => 'completion';

  @override
  String get stats_currentKhatma => 'Current Khatma Progress';

  @override
  String get more_title => 'More';

  @override
  String get more_qibla => 'Qibla Direction';

  @override
  String get more_stats => 'My Stats';

  @override
  String get common_loading => 'Loading...';

  @override
  String get common_error => 'Error loading data';

  @override
  String get common_retry => 'Try Again';

  @override
  String get common_back => 'Back';

  @override
  String get common_next => 'Next';

  @override
  String get common_save => 'Save';

  @override
  String get common_cancel => 'Cancel';

  @override
  String get common_done => 'Done';

  @override
  String get common_search => 'Search';

  @override
  String get common_noData => 'No data available';

  @override
  String get common_offline => 'No internet connection';
}
