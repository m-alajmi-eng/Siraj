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

  @override
  String get nav_home => 'Home';

  @override
  String get nav_quran => 'Quran';

  @override
  String get nav_athkar => 'Athkar';

  @override
  String get nav_hadith => 'Hadith';

  @override
  String get nav_more => 'More';

  @override
  String get home_greetingNight => 'Blessed night,';

  @override
  String get home_greetingFajr => 'Peace upon the dawn,';

  @override
  String get home_greetingMorning => 'Good morning,';

  @override
  String get home_greetingNoon => 'Good afternoon,';

  @override
  String get home_greetingAsr => 'Blessed afternoon,';

  @override
  String get home_greetingEvening => 'Good evening,';

  @override
  String get home_greetingLateNight => 'Peaceful night,';

  @override
  String get home_welcome => 'Welcome';

  @override
  String get home_nextPrayer => 'Next Prayer';

  @override
  String get home_qiblaDirection => 'Qibla Direction';

  @override
  String get home_continueReading => 'CONTINUE READING';

  @override
  String home_surah(int id) {
    return 'Surah #$id';
  }

  @override
  String home_ayah(int number) {
    return 'Verse $number';
  }

  @override
  String get home_dailyAyah => 'Verse of the Day';

  @override
  String get home_quickAccess => 'Quick Access';

  @override
  String get home_searchHint => 'What are you looking for...';

  @override
  String get home_radio => 'Radio';

  @override
  String get home_calendar => 'Calendar';

  @override
  String get home_stories => 'Stories';

  @override
  String get home_children => 'Kids';

  @override
  String get settings_title => 'Settings';

  @override
  String get radio_title => 'Siraj Radio';

  @override
  String get radio_all => 'All';

  @override
  String get radio_quran => 'Quran';

  @override
  String get radio_translations => 'Translations';

  @override
  String get radio_tafsir => 'Tafsir & Fatwa';

  @override
  String get radio_athkar => 'Athkar';

  @override
  String get radio_international => 'International';

  @override
  String get cal_title => 'Islamic Calendar';

  @override
  String get cal_todayEvents => 'Today\'s Events';

  @override
  String get cal_nextEvent => 'Next Event';

  @override
  String get cal_allEvents => 'Islamic Events';

  @override
  String cal_daysUntil(int days) {
    return '$days days';
  }

  @override
  String get cal_gregorian => 'Gregorian';

  @override
  String get cal_hijri => 'Hijri';

  @override
  String get hm_1 => 'Muharram';

  @override
  String get hm_2 => 'Safar';

  @override
  String get hm_3 => 'Rabi\' al-Awwal';

  @override
  String get hm_4 => 'Rabi\' al-Thani';

  @override
  String get hm_5 => 'Jumada al-Ula';

  @override
  String get hm_6 => 'Jumada al-Akhira';

  @override
  String get hm_7 => 'Rajab';

  @override
  String get hm_8 => 'Sha\'ban';

  @override
  String get hm_9 => 'Ramadan';

  @override
  String get hm_10 => 'Shawwal';

  @override
  String get hm_11 => 'Dhu al-Qi\'dah';

  @override
  String get hm_12 => 'Dhu al-Hijjah';

  @override
  String get ev_new_year => 'Islamic New Year';

  @override
  String get ev_ashura => 'Day of Ashura';

  @override
  String get ev_mawlid => 'Mawlid al-Nabi';

  @override
  String get ev_isra => 'Isra\' and Mi\'raj';

  @override
  String get ev_ramadan_start => 'First of Ramadan';

  @override
  String get ev_laylat_qadr => 'Laylat al-Qadr';

  @override
  String get ev_eid_fitr => 'Eid al-Fitr';

  @override
  String get ev_arafah => 'Day of Arafah';

  @override
  String get ev_eid_adha => 'Eid al-Adha';

  @override
  String get ev_tashreeq => 'Days of Tashreeq';

  @override
  String get stories_title => 'Stories & Seerah';

  @override
  String get stories_prophets => 'Prophets';

  @override
  String get stories_companions => 'Companions';

  @override
  String get stories_scholars => 'Scholars';

  @override
  String get stories_comingSoon => 'Soon';

  @override
  String get stories_comingSoonMsg => 'Coming soon — content in progress';

  @override
  String get children_title => 'Children\'s Stories';

  @override
  String get settings_secIdentity => 'Identity';

  @override
  String get settings_secAdhan => 'Adhan';

  @override
  String get settings_secApp => 'App';

  @override
  String get settings_secPrivacy => 'Privacy';

  @override
  String get settings_secAbout => 'About';

  @override
  String get settings_language => 'Language';

  @override
  String get settings_chooseLanguage => 'Choose Language';

  @override
  String get settings_madhab => 'Madhab';

  @override
  String get settings_chooseMadhab => 'Choose Madhab';

  @override
  String get settings_calcMethod => 'Prayer Calculation Method';

  @override
  String get settings_chooseCalc => 'Calculation Method';

  @override
  String get settings_enableAdhan => 'Enable Adhan';

  @override
  String get settings_muezzinVoice => 'Muezzin Voice';

  @override
  String get settings_vibration => 'Vibrate instead of sound';

  @override
  String get settings_iqamaAlert => 'Pre-Iqama Alert';

  @override
  String settings_minutes(int n) {
    return '$n min';
  }

  @override
  String get settings_appMode => 'App Mode';

  @override
  String get settings_fullMode => 'Full Mode';

  @override
  String get settings_liteMode => 'Lite Mode';

  @override
  String get settings_fullModeDesc => 'All features available';

  @override
  String get settings_liteModeDesc => 'Essentials only — offline';

  @override
  String get settings_quranFont => 'Quran Font';

  @override
  String get settings_fontUthmani => 'Uthmani';

  @override
  String get settings_fontHafs => 'Hafs';

  @override
  String get settings_quranFontSize => 'Quran Font Size';

  @override
  String get settings_privacyNote => 'Your location stays on your device only';

  @override
  String get settings_clearCache => 'Clear Cache Data';

  @override
  String get settings_clearCacheTitle => 'Clear Cache';

  @override
  String get settings_clearCacheMsg =>
      'Locally saved data will be deleted. Are you sure?';

  @override
  String get settings_cancel => 'Cancel';

  @override
  String get settings_delete => 'Delete';

  @override
  String get settings_version => 'Version';

  @override
  String get settings_shareApp => 'Share App';

  @override
  String get settings_tagline => 'Siraj — Light upon Light';

  @override
  String get madhab_hanafi => 'Hanafi';

  @override
  String get madhab_maliki => 'Maliki';

  @override
  String get madhab_shafi => 'Shafi\'i';

  @override
  String get madhab_hanbali => 'Hanbali';

  @override
  String get calc_MWL => 'Muslim World League';

  @override
  String get calc_ISNA => 'North America (ISNA)';

  @override
  String get calc_Egypt => 'Egyptian Authority';

  @override
  String get calc_Makkah => 'Umm al-Qura (Makkah)';

  @override
  String get calc_Kuwait => 'Kuwait';

  @override
  String get calc_Qatar => 'Qatar';

  @override
  String get calc_Dubai => 'Dubai';

  @override
  String get search_hint => 'Search Quran & tafsir...';

  @override
  String get search_empty => 'Search the Holy Quran, tafsir, and word meanings';

  @override
  String search_noResults(String query) {
    return 'No results for \"$query\"';
  }

  @override
  String get search_typeAyah => 'Ayah';

  @override
  String get search_typeTafsir => 'Tafsir';

  @override
  String get search_typeWord => 'Word';

  @override
  String get search_typeHadith => 'Hadith';

  @override
  String get stats_daysStreak => 'days in a row';

  @override
  String get stats_prayersUnit => 'prayers';

  @override
  String get stats_pagesUnit => 'pages';

  @override
  String get stats_athkar => 'Athkar';

  @override
  String get stats_sessionsUnit => 'sessions';

  @override
  String stats_pagesOf(int read, int total) {
    return '$read / $total pages';
  }

  @override
  String get reader_tapToListen => 'Tap to listen';

  @override
  String reader_ayahNum(int n) {
    return 'Ayah $n';
  }

  @override
  String get reader_reciter => 'Reciter';

  @override
  String get reader_chooseReciter => 'Choose Reciter';

  @override
  String get reader_searchReciter => 'Search reciter...';

  @override
  String get reader_longPressHint =>
      'Long-press any ayah for portal, tafsir & sharing';

  @override
  String get reader_versePortal => 'Verse Portal';

  @override
  String get reader_portalSub => 'Tafsir · Words · Context';

  @override
  String get reader_showTafsir => 'Show Tafsir';

  @override
  String get reader_shareAyah => 'Share Ayah';

  @override
  String get reader_copyAyah => 'Copy Ayah';

  @override
  String get reader_ayahCopied => 'Ayah copied';

  @override
  String reader_tafsirOf(int n) {
    return 'Tafsir of Ayah $n';
  }

  @override
  String get reader_muyassar => 'Al-Muyassar';

  @override
  String get reader_tafsirError => 'Failed to load tafsir';

  @override
  String get reader_shareTitle => 'Noble Ayah';

  @override
  String reader_shareSubtitle(String surah, int n) {
    return '$surah · Ayah $n';
  }

  @override
  String get portal_muyassar => 'Al-Muyassar';

  @override
  String get portal_words => 'Word Analysis';

  @override
  String get portal_hadiths => 'Hadiths';

  @override
  String get portal_stories => 'Stories';

  @override
  String get portal_arabicTafsir => 'Arabic Tafsir';

  @override
  String get portal_foreignTafsir => 'Foreign Tafsir';

  @override
  String get portal_asbab => 'Reason for Revelation';

  @override
  String get portal_searchLang => 'Search language...';

  @override
  String get portal_error => 'Could not open portal';

  @override
  String get portal_back => 'Back';

  @override
  String get portal_noTafsir => 'No tafsir available';

  @override
  String get portal_loadError => 'Failed to load';

  @override
  String get portal_comingSoon => 'Soon';

  @override
  String get portal_noHadiths => 'No hadiths linked to this verse yet';

  @override
  String get portal_addingContent => 'Content being added gradually';

  @override
  String get more_search => 'Unified Search';

  @override
  String get more_settings => 'Settings';

  @override
  String get more_calendar => 'Islamic Calendar';

  @override
  String get more_shareCards => 'Share Cards';

  @override
  String get more_fullMode => 'Full Mode';

  @override
  String get more_radio => 'Quran Radio';

  @override
  String get more_mosques => 'Nearby Mosques';

  @override
  String get athkarcat_error => 'Error';

  @override
  String get athkarcat_empty => 'No athkar';

  @override
  String athkarcat_completed(String name) {
    return '$name completed';
  }

  @override
  String get athkarcat_back => 'Back';

  @override
  String get athkarcat_next => 'Next';

  @override
  String get athkarcat_finish => 'Finish';

  @override
  String get athkarcat_prev => 'Previous';

  @override
  String athkarcat_repeat(int count, String source) {
    return 'Repeat: $count · $source';
  }

  @override
  String athkarcat_narrated(String source) {
    return 'Narrated by $source';
  }

  @override
  String get athkarcat_moving => 'Moving on...';

  @override
  String get athkarcat_tapCount => 'Tap to count';

  @override
  String get athkar_allSections => 'All Sections';

  @override
  String get gateway_entry_title => 'Discover Islam';

  @override
  String get gateway_intro_title => 'A Journey of Spiritual Awareness';

  @override
  String get gateway_journey_title => 'The Journey';

  @override
  String get gateway_principles_title => 'Principles of Islam';

  @override
  String get gateway_library_title => 'Library';

  @override
  String get gateway_begin => 'Begin the Journey';

  @override
  String get gateway_next => 'Next';

  @override
  String get gateway_prev => 'Back';

  @override
  String get app_tagline => 'Your Islamic Guide';

  @override
  String get app_brand_name => 'SIRAJ';
}
