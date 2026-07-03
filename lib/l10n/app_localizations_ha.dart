// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hausa (`ha`).
class AppLocalizationsHa extends AppLocalizations {
  AppLocalizationsHa([String locale = 'ha']) : super(locale);

  @override
  String get appName => 'Siraj';

  @override
  String get prayer_title => 'Lokutan Sallah';

  @override
  String get prayer_nextPrayer => 'Sallah ta Gaba';

  @override
  String get prayer_fajr => 'Asuba';

  @override
  String get prayer_sunrise => 'Fitowar Rana';

  @override
  String get prayer_dhuhr => 'Azahar';

  @override
  String get prayer_asr => 'La\'asar';

  @override
  String get prayer_maghrib => 'Magariba';

  @override
  String get prayer_isha => 'Isha\'i';

  @override
  String prayer_countdown(String time) {
    return 'A cikin $time';
  }

  @override
  String get prayer_locationGPS => 'Wurinka na yanzu';

  @override
  String get prayer_locationDefault => 'Riyadh (tsoho)';

  @override
  String get quran_title => 'Al-Qur\'ani Mai Tsarki';

  @override
  String get quran_meccan => 'Makkiyya';

  @override
  String get quran_medinan => 'Madaniyya';

  @override
  String quran_ayahCount(int count) {
    return 'Ayoyi $count';
  }

  @override
  String get quran_searchHint => 'Nema a cikin Al-Qur\'ani...';

  @override
  String get quran_noResults => 'Babu sakamakon bincike';

  @override
  String get quran_searchPrompt => 'Rubuta kalma don bincike';

  @override
  String get quran_tapForTafsir => 'Riƙe aya don tafsiri';

  @override
  String quran_tafsirTitle(int number) {
    return 'Tafsirin Aya ta $number';
  }

  @override
  String get quran_tafsirSource => 'Al-Muyassar';

  @override
  String get quran_tafsirError => 'Ba a iya loda tafsiri';

  @override
  String get quran_reciter => 'Mai Karatu';

  @override
  String get quran_selectReciter => 'Zaɓi Mai Karatu';

  @override
  String get quran_searchReciter => 'Nema mai karatu...';

  @override
  String get quran_playPrompt => 'Taɓa don sauraro';

  @override
  String quran_ayahNumber(int number) {
    return 'Aya ta $number';
  }

  @override
  String get athkar_title => 'Azkar';

  @override
  String get athkar_morning => 'Azkar na Safiya';

  @override
  String get athkar_evening => 'Azkar na Yamma';

  @override
  String get athkar_sleep => 'Azkar na Barci';

  @override
  String get athkar_wake => 'Azkar na Farkawa';

  @override
  String get athkar_prayer => 'Azkar bayan Sallah';

  @override
  String get athkar_general => 'Azkar na Gaba ɗaya';

  @override
  String get athkar_tapToCount => 'Taɓa don ƙidaya';

  @override
  String get athkar_transitioning => 'Ana tafiya...';

  @override
  String athkar_completed(String name) {
    return '$name ya kammala';
  }

  @override
  String get athkar_next => 'Na Gaba';

  @override
  String get athkar_prev => 'Na Baya';

  @override
  String get athkar_finish => 'Kammala';

  @override
  String get athkar_back => 'Koma';

  @override
  String athkar_source(String source) {
    return 'Rawaito daga $source';
  }

  @override
  String get hadith_title => 'Hadisi';

  @override
  String get hadith_searchHint => 'Nema hadisi...';

  @override
  String get hadith_noResults => 'Babu sakamakon bincike';

  @override
  String get hadith_tapForDetail => 'Taɓa don karanta cikakke';

  @override
  String get hadith_retryButton => 'Sake Gwadawa';

  @override
  String get hadith_loadError => 'Ba a iya loda';

  @override
  String get qibla_title => 'Alkibla';

  @override
  String get qibla_active => 'Compass yana aiki';

  @override
  String get qibla_error => 'Ba a iya tantance alkibla';

  @override
  String get qibla_errorHint => 'Kunna compass da wuri';

  @override
  String get qibla_kaaba => 'Ka\'aba';

  @override
  String get qibla_fromNorth => 'Digiri daga Arewa zuwa Alkibla';

  @override
  String get stats_title => 'Ƙididdiga Na';

  @override
  String get stats_prayerStreak => 'Jerin Sallah';

  @override
  String get stats_totalPrayers => 'Wadarta Sallah';

  @override
  String get stats_quranPages => 'Shafukan Al-Qur\'ani';

  @override
  String get stats_athkarSessions => 'Azkar';

  @override
  String get stats_khatma => 'Kammala Al-Qur\'ani';

  @override
  String get stats_days => 'kwanaki a jere';

  @override
  String get stats_prayers => 'sallah';

  @override
  String get stats_pages => 'shafuka';

  @override
  String get stats_sessions => 'zaman';

  @override
  String get stats_khatmaUnit => 'kammala';

  @override
  String get stats_currentKhatma => 'Ci gaban Kammala na Yanzu';

  @override
  String get more_title => 'Ƙari';

  @override
  String get more_qibla => 'Alkibla';

  @override
  String get more_stats => 'Ƙididdiga Na';

  @override
  String get common_loading => 'Ana loda...';

  @override
  String get common_error => 'Kuskure wajen loda bayanan';

  @override
  String get common_retry => 'Sake Gwadawa';

  @override
  String get common_back => 'Koma';

  @override
  String get common_next => 'Na Gaba';

  @override
  String get common_save => 'Ajiye';

  @override
  String get common_cancel => 'Soke';

  @override
  String get common_done => 'An Gama';

  @override
  String get common_search => 'Bincike';

  @override
  String get common_noData => 'Babu bayanan';

  @override
  String get common_offline => 'Babu haɗin intanet';

  @override
  String get nav_home => 'Gida';

  @override
  String get nav_quran => 'Alkur\'ani';

  @override
  String get nav_athkar => 'Azkar';

  @override
  String get nav_hadith => 'Hadisi';

  @override
  String get nav_more => 'Ƙari';

  @override
  String get home_greetingNight => 'Dare mai albarka,';

  @override
  String get home_greetingFajr => 'Salama da asuba,';

  @override
  String get home_greetingMorning => 'Barka da safiya,';

  @override
  String get home_greetingNoon => 'Barka da rana,';

  @override
  String get home_greetingAsr => 'Yamma mai albarka,';

  @override
  String get home_greetingEvening => 'Barka da yamma,';

  @override
  String get home_greetingLateNight => 'Dare mai kwanciyar hankali,';

  @override
  String get home_welcome => 'Barka da zuwa';

  @override
  String get home_nextPrayer => 'Sallah Mai Zuwa';

  @override
  String get home_qiblaDirection => 'Hanyar Alƙibla';

  @override
  String get home_continueReading => 'CI GABA DA KARANTAWA';

  @override
  String home_surah(int id) {
    return 'Sura #$id';
  }

  @override
  String home_ayah(int number) {
    return 'Aya ta $number';
  }

  @override
  String get home_dailyAyah => 'Ayar Yini';

  @override
  String get home_quickAccess => 'Saurin Shiga';

  @override
  String get home_searchHint => 'Me kake nema...';

  @override
  String get home_radio => 'Rediyo';

  @override
  String get home_calendar => 'Kalanda';

  @override
  String get home_stories => 'Labarai';

  @override
  String get home_children => 'Yara';

  @override
  String get settings_title => 'Saituna';

  @override
  String get radio_title => 'Rediyon Siraj';

  @override
  String get radio_all => 'Duka';

  @override
  String get radio_quran => 'Alkur\'ani';

  @override
  String get radio_translations => 'Fassara';

  @override
  String get radio_tafsir => 'Tafsiri da Fatawa';

  @override
  String get radio_athkar => 'Azkari';

  @override
  String get radio_international => 'Na Duniya';

  @override
  String get cal_title => 'Kalandar Musulunci';

  @override
  String get cal_todayEvents => 'Abubuwan Yau';

  @override
  String get cal_nextEvent => 'Abu Na Gaba';

  @override
  String get cal_allEvents => 'Ranakun Musulunci';

  @override
  String cal_daysUntil(int days) {
    return 'Kwana $days';
  }

  @override
  String get cal_gregorian => 'Miladiyya';

  @override
  String get cal_hijri => 'Hijira';

  @override
  String get hm_1 => 'Muharram';

  @override
  String get hm_2 => 'Safar';

  @override
  String get hm_3 => 'Rabi\'ul Awwal';

  @override
  String get hm_4 => 'Rabi\'ul Akhir';

  @override
  String get hm_5 => 'Jumada Awwal';

  @override
  String get hm_6 => 'Jumada Akhir';

  @override
  String get hm_7 => 'Rajab';

  @override
  String get hm_8 => 'Sha\'aban';

  @override
  String get hm_9 => 'Ramadan';

  @override
  String get hm_10 => 'Shawwal';

  @override
  String get hm_11 => 'Zulkida';

  @override
  String get hm_12 => 'Zulhajji';

  @override
  String get ev_new_year => 'Sabuwar Shekarar Musulunci';

  @override
  String get ev_ashura => 'Ranar Ashura';

  @override
  String get ev_mawlid => 'Maulidin Annabiﷺ';

  @override
  String get ev_isra => 'Isra\'i da Mi\'iraji';

  @override
  String get ev_ramadan_start => 'Farkon Ramadan';

  @override
  String get ev_laylat_qadr => 'Lailatul Kadri';

  @override
  String get ev_eid_fitr => 'Idin Karamar Sallah';

  @override
  String get ev_arafah => 'Ranar Arafa';

  @override
  String get ev_eid_adha => 'Idin Babbar Sallah';

  @override
  String get ev_tashreeq => 'Kwanakin Tashriki';

  @override
  String get stories_title => 'Labarai da Sira';

  @override
  String get stories_prophets => 'Annabawa';

  @override
  String get stories_companions => 'Sahabbai';

  @override
  String get stories_scholars => 'Malamai';

  @override
  String get stories_comingSoon => 'Nan ba da jimawa ba';

  @override
  String get stories_comingSoonMsg =>
      'Nan ba da jimawa ba — ana shirya abun ciki';

  @override
  String get children_title => 'Labaran Yara';

  @override
  String get settings_secIdentity => 'Shaida';

  @override
  String get settings_secAdhan => 'Kira';

  @override
  String get settings_secApp => 'Manhaja';

  @override
  String get settings_secPrivacy => 'Sirri';

  @override
  String get settings_secAbout => 'Game da';

  @override
  String get settings_language => 'Harshe';

  @override
  String get settings_chooseLanguage => 'Zaɓi Harshe';

  @override
  String get settings_madhab => 'Mazhaba';

  @override
  String get settings_chooseMadhab => 'Zaɓi Mazhaba';

  @override
  String get settings_calcMethod => 'Hanyar Lissafin Sallah';

  @override
  String get settings_chooseCalc => 'Hanyar Lissafi';

  @override
  String get settings_enableAdhan => 'Kunna Kiran Sallah';

  @override
  String get settings_muezzinVoice => 'Muryar Ladani';

  @override
  String get settings_vibration => 'Girgiza maimakon sauti';

  @override
  String get settings_iqamaAlert => 'Sanarwa kafin Iƙama';

  @override
  String settings_minutes(int n) {
    return 'Minti $n';
  }

  @override
  String get settings_appMode => 'Yanayin Manhaja';

  @override
  String get settings_fullMode => 'Cikakken Yanayi';

  @override
  String get settings_liteMode => 'Yanayi Mai Sauƙi';

  @override
  String get settings_fullModeDesc => 'Dukkan abubuwa suna nan';

  @override
  String get settings_liteModeDesc => 'Muhimmai kawai — ba layi';

  @override
  String get settings_quranFont => 'Rubutun Alkur\'ani';

  @override
  String get settings_fontUthmani => 'Usmani';

  @override
  String get settings_fontHafs => 'Hafs';

  @override
  String get settings_quranFontSize => 'Girman Rubutun Alkur\'ani';

  @override
  String get settings_privacyNote => 'Wurinka yana kan na\'urarka kawai';

  @override
  String get settings_clearCache => 'Share Bayanan Cache';

  @override
  String get settings_clearCacheTitle => 'Share Cache';

  @override
  String get settings_clearCacheMsg =>
      'Za a share bayanan da aka adana. Ka tabbata?';

  @override
  String get settings_cancel => 'Soke';

  @override
  String get settings_delete => 'Share';

  @override
  String get settings_version => 'Sigar';

  @override
  String get settings_shareApp => 'Raba Manhaja';

  @override
  String get settings_tagline => 'Siraj — Haske bisa Haske';

  @override
  String get madhab_hanafi => 'Hanafi';

  @override
  String get madhab_maliki => 'Maliki';

  @override
  String get madhab_shafi => 'Shafi\'i';

  @override
  String get madhab_hanbali => 'Hanbali';

  @override
  String get calc_MWL => 'Ƙungiyar Musulmin Duniya';

  @override
  String get calc_ISNA => 'Arewacin Amurka (ISNA)';

  @override
  String get calc_Egypt => 'Hukumar Masar';

  @override
  String get calc_Makkah => 'Umm al-Qura (Makka)';

  @override
  String get calc_Kuwait => 'Kuwait';

  @override
  String get calc_Qatar => 'Qatar';

  @override
  String get calc_Dubai => 'Dubai';

  @override
  String get search_hint => 'Bincika a Alkur\'ani da tafsiri...';

  @override
  String get search_empty =>
      'Bincika a cikin Alkur\'ani, tafsiri da ma\'anar kalmomi';

  @override
  String search_noResults(String query) {
    return 'Babu sakamako don \"$query\"';
  }

  @override
  String get search_typeAyah => 'Aya';

  @override
  String get search_typeTafsir => 'Tafsiri';

  @override
  String get search_typeWord => 'Kalma';

  @override
  String get search_typeHadith => 'Hadisi';

  @override
  String get stats_daysStreak => 'kwanaki a jere';

  @override
  String get stats_prayersUnit => 'sallah';

  @override
  String get stats_pagesUnit => 'shafuka';

  @override
  String get stats_athkar => 'Azkari';

  @override
  String get stats_sessionsUnit => 'zaman';

  @override
  String stats_pagesOf(int read, int total) {
    return 'Shafi $read / $total';
  }

  @override
  String get reader_tapToListen => 'Danna don saurara';

  @override
  String reader_ayahNum(int n) {
    return 'Aya ta $n';
  }

  @override
  String get reader_reciter => 'Mai karatu';

  @override
  String get reader_chooseReciter => 'Zaɓi Mai karatu';

  @override
  String get reader_searchReciter => 'Bincika mai karatu...';

  @override
  String get reader_longPressHint =>
      'Danna kowace aya na dogon lokaci don portal, tafsiri da rabawa';

  @override
  String get reader_versePortal => 'Ƙofar Aya';

  @override
  String get reader_portalSub => 'Tafsiri · Kalmomi · Mahalli';

  @override
  String get reader_showTafsir => 'Nuna Tafsiri';

  @override
  String get reader_shareAyah => 'Raba Aya';

  @override
  String get reader_copyAyah => 'Kwafi Aya';

  @override
  String get reader_ayahCopied => 'An kwafi aya';

  @override
  String reader_tafsirOf(int n) {
    return 'Tafsirin Aya ta $n';
  }

  @override
  String get reader_muyassar => 'Al-Muyassar';

  @override
  String get reader_tafsirError => 'An kasa loda tafsiri';

  @override
  String get reader_shareTitle => 'Aya Mai Daraja';

  @override
  String reader_shareSubtitle(String surah, int n) {
    return '$surah · Aya ta $n';
  }

  @override
  String get portal_muyassar => 'Al-Muyassar';

  @override
  String get portal_words => 'Nazarin Kalmomi';

  @override
  String get portal_hadiths => 'Hadisai';

  @override
  String get portal_stories => 'Labarai da Sira';

  @override
  String get portal_arabicTafsir => 'Tafsiran Larabci';

  @override
  String get portal_foreignTafsir => 'Tafsiran Sauran Harsuna';

  @override
  String get portal_asbab => 'Dalilin Sauka';

  @override
  String get portal_searchLang => 'Bincika harshe...';

  @override
  String get portal_error => 'An kasa buɗe portal';

  @override
  String get portal_back => 'Koma baya';

  @override
  String get portal_noTafsir => 'Babu tafsiri';

  @override
  String get portal_loadError => 'An kasa loda';

  @override
  String get portal_comingSoon => 'Nan ba da jimawa ba';

  @override
  String get portal_noHadiths => 'Babu hadisi da ya shafi wannan aya tukuna';

  @override
  String get portal_addingContent => 'Ana ƙara abun ciki a hankali';

  @override
  String get more_search => 'Bincike Haɗaɗɗe';

  @override
  String get more_settings => 'Saituna';

  @override
  String get more_calendar => 'Kalandar Musulunci';

  @override
  String get more_shareCards => 'Katunan Rabawa';

  @override
  String get more_fullMode => 'Cikakken Yanayi';

  @override
  String get more_radio => 'Rediyon Alkur\'ani';

  @override
  String get more_mosques => 'Masallatai Kusa';

  @override
  String get athkarcat_error => 'Kuskure';

  @override
  String get athkarcat_empty => 'Babu azkari';

  @override
  String athkarcat_completed(String name) {
    return 'An kammala $name';
  }

  @override
  String get athkarcat_back => 'Koma baya';

  @override
  String get athkarcat_next => 'Na gaba';

  @override
  String get athkarcat_finish => 'Gama';

  @override
  String get athkarcat_prev => 'Da ya gabata';

  @override
  String athkarcat_repeat(int count, String source) {
    return 'Maimaitawa: $count · $source';
  }

  @override
  String athkarcat_narrated(String source) {
    return '$source ya rawaito';
  }

  @override
  String get athkarcat_moving => 'Ana matsawa...';

  @override
  String get athkarcat_tapCount => 'Danna don ƙidaya';

  @override
  String get athkar_allSections => 'Duk Sassa';

  @override
  String get gateway_entry_title => 'Gano Musulunci';

  @override
  String get gateway_intro_title => 'Tafiyar Wayar da Kai ta Ruhi';

  @override
  String get gateway_journey_title => 'Tafiya';

  @override
  String get gateway_principles_title => 'Ka\'idojin Musulunci';

  @override
  String get gateway_library_title => 'Laburare';

  @override
  String get gateway_begin => 'Fara Tafiya';

  @override
  String get gateway_next => 'Na Gaba';

  @override
  String get gateway_prev => 'Baya';

  @override
  String get app_tagline => 'Jagorar Musulunci Naka';

  @override
  String get app_brand_name => 'SIRAJ';

  @override
  String get gateway_shahada_cta => 'Ka Bayyana Imaninka Yanzu';

  @override
  String get nav_library => 'Laburare';

  @override
  String get library_could_not_load => 'An kasa loda';

  @override
  String get library_section_not_found => 'Ba a sami sashin ba';

  @override
  String get library_content_title => 'Abun ciki';

  @override
  String get library_search_in_category => 'Nema a wannan rukunin...';

  @override
  String get library_no_matching_results => 'Babu sakamako da ya dace';

  @override
  String get library_no_materials_lang =>
      'Babu kayan da ake da su a wannan yaren tukuna';

  @override
  String get library_connection_failed =>
      'Haɗi ya kasa. Duba intanet ɗinka sannan ka sake gwadawa';

  @override
  String get library_search_content_type => 'Nema irin abun ciki...';

  @override
  String get library_choose_content_type => 'Zaɓi irin abun ciki';

  @override
  String get library_no_content_lang => 'Babu abun ciki a wannan yaren tukuna';

  @override
  String get library_not_found => 'Ba a samu ba';

  @override
  String get library_search_in_section => 'Nema a wannan sashin...';

  @override
  String get library_no_categories => 'Babu rukuni tukuna';

  @override
  String get library_type_books => 'Littattafai';

  @override
  String get library_type_audios => 'Sauti';

  @override
  String get library_type_videos => 'Bidiyo';

  @override
  String get library_type_articles => 'Kasidu';
}
