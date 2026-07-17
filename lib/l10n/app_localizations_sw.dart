// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get appName => 'Siraj';

  @override
  String get prayer_title => 'Nyakati za Sala';

  @override
  String get prayer_nextPrayer => 'Sala Inayofuata';

  @override
  String get prayer_fajr => 'Alfajiri';

  @override
  String get prayer_sunrise => 'Machweo ya Jua';

  @override
  String get prayer_dhuhr => 'Adhuhuri';

  @override
  String get prayer_asr => 'Alasiri';

  @override
  String get prayer_maghrib => 'Magharibi';

  @override
  String get prayer_isha => 'Isha';

  @override
  String prayer_countdown(String time) {
    return 'Katika $time';
  }

  @override
  String get prayer_locationGPS => 'Mahali pako sasa hivi';

  @override
  String get prayer_locationDefault => 'Riyadh (chaguo-msingi)';

  @override
  String get quran_title => 'Qurani Tukufu';

  @override
  String get quran_meccan => 'Makkiya';

  @override
  String get quran_medinan => 'Madaniya';

  @override
  String quran_ayahCount(int count) {
    return 'Aya $count';
  }

  @override
  String get quran_searchHint => 'Tafuta katika Qurani...';

  @override
  String get quran_noResults => 'Hakuna matokeo';

  @override
  String get quran_searchPrompt => 'Andika neno kutafuta';

  @override
  String get quran_tapForTafsir => 'Bonyeza kwa muda mrefu aya kwa tafsiri';

  @override
  String quran_tafsirTitle(int number) {
    return 'Tafsiri ya Aya $number';
  }

  @override
  String get quran_tafsirSource => 'Al-Muyassar';

  @override
  String get quran_tafsirError => 'Imeshindwa kupakia tafsiri';

  @override
  String get quran_reciter => 'Msomaji';

  @override
  String get quran_selectReciter => 'Chagua Msomaji';

  @override
  String get quran_searchReciter => 'Tafuta msomaji...';

  @override
  String get quran_playPrompt => 'Gusa kusikiliza';

  @override
  String quran_ayahNumber(int number) {
    return 'Aya $number';
  }

  @override
  String get quran_toggleDisplayMode =>
      'Badilisha hali ya uonyeshaji (Msahafu/tafsiri)';

  @override
  String get quran_toggleTajweed => 'Badilisha rangi za tajwid';

  @override
  String get athkar_title => 'Adhkari';

  @override
  String get athkar_morning => 'Adhkari ya Asubuhi';

  @override
  String get athkar_evening => 'Adhkari ya Jioni';

  @override
  String get athkar_sleep => 'Adhkari ya Kulala';

  @override
  String get athkar_wake => 'Adhkari ya Kuamka';

  @override
  String get athkar_prayer => 'Adhkari Baada ya Sala';

  @override
  String get athkar_general => 'Adhkari ya Jumla';

  @override
  String get athkar_tapToCount => 'Gusa kuhesabu';

  @override
  String get athkar_transitioning => 'Inaendelea...';

  @override
  String athkar_completed(String name) {
    return '$name imekamilika';
  }

  @override
  String get athkar_next => 'Inayofuata';

  @override
  String get athkar_prev => 'Iliyotangulia';

  @override
  String get athkar_finish => 'Maliza';

  @override
  String get athkar_back => 'Rudi';

  @override
  String athkar_source(String source) {
    return 'Iliyosimuliwa na $source';
  }

  @override
  String get hadith_title => 'Hadithi';

  @override
  String get hadith_searchHint => 'Tafuta hadithi...';

  @override
  String get hadith_noResults => 'Hakuna matokeo';

  @override
  String get hadith_tapForDetail => 'Gusa kusoma kamili';

  @override
  String get hadith_retryButton => 'Jaribu Tena';

  @override
  String get hadith_loadError => 'Imeshindwa kupakia';

  @override
  String get qibla_title => 'Mwelekeo wa Qibla';

  @override
  String get qibla_active => 'Dira inafanya kazi';

  @override
  String get qibla_error => 'Imeshindwa kuamua mwelekeo wa Qibla';

  @override
  String get qibla_errorHint => 'Washa dira na eneo';

  @override
  String get qibla_kaaba => 'Kaaba';

  @override
  String get qibla_fromNorth => 'Digrii kutoka Kaskazini kwenda Qibla';

  @override
  String qibla_distanceKm(int km, String kaaba) {
    return '$km km hadi $kaaba';
  }

  @override
  String get stats_title => 'Takwimu Zangu';

  @override
  String get stats_prayerStreak => 'Mfululizo wa Sala';

  @override
  String get stats_totalPrayers => 'Jumla ya Sala';

  @override
  String get stats_quranPages => 'Kurasa za Qurani';

  @override
  String get stats_athkarSessions => 'Adhkari';

  @override
  String get stats_khatma => 'Ukamilishaji wa Qurani';

  @override
  String get stats_days => 'siku mfululizo';

  @override
  String get stats_prayers => 'sala';

  @override
  String get stats_pages => 'kurasa';

  @override
  String get stats_sessions => 'vikao';

  @override
  String get stats_khatmaUnit => 'ukamilishaji';

  @override
  String get stats_currentKhatma => 'Maendeleo ya Ukamilishaji wa Sasa';

  @override
  String get more_title => 'Zaidi';

  @override
  String get more_qibla => 'Mwelekeo wa Qibla';

  @override
  String get more_stats => 'Takwimu Zangu';

  @override
  String get common_loading => 'Inapakia...';

  @override
  String get common_error => 'Hitilafu ya kupakia data';

  @override
  String get common_retry => 'Jaribu Tena';

  @override
  String get common_back => 'Rudi';

  @override
  String get common_next => 'Inayofuata';

  @override
  String get common_save => 'Hifadhi';

  @override
  String get common_cancel => 'Ghairi';

  @override
  String get common_done => 'Imekamilika';

  @override
  String get common_search => 'Tafuta';

  @override
  String get common_noData => 'Hakuna data';

  @override
  String get common_offline => 'Hakuna muunganisho wa intaneti';

  @override
  String get common_close => 'Funga';

  @override
  String get common_share => 'Shiriki';

  @override
  String get common_refresh => 'Onyesha upya';

  @override
  String get common_prevPage => 'Ukurasa uliopita';

  @override
  String get common_nextPage => 'Ukurasa unaofuata';

  @override
  String get common_clearSearch => 'Futa utafutaji';

  @override
  String get nav_home => 'Nyumbani';

  @override
  String get nav_quran => 'Quran';

  @override
  String get nav_athkar => 'Adhkari';

  @override
  String get nav_hadith => 'Hadithi';

  @override
  String get nav_more => 'Zaidi';

  @override
  String get home_greetingNight => 'Usiku mwema,';

  @override
  String get home_greetingFajr => 'Amani ya alfajiri,';

  @override
  String get home_greetingMorning => 'Habari za asubuhi,';

  @override
  String get home_greetingNoon => 'Habari za mchana,';

  @override
  String get home_greetingAsr => 'Alasiri njema,';

  @override
  String get home_greetingEvening => 'Habari za jioni,';

  @override
  String get home_greetingLateNight => 'Usiku wa amani,';

  @override
  String get home_welcome => 'Karibu';

  @override
  String get home_nextPrayer => 'Sala Inayofuata';

  @override
  String get home_qiblaDirection => 'Mwelekeo wa Kibla';

  @override
  String get time_hr => 'saa';

  @override
  String get time_min => 'dak';

  @override
  String get time_sec => 'sek';

  @override
  String get home_continueReading => 'ENDELEA KUSOMA';

  @override
  String home_surah(int id) {
    return 'Sura #$id';
  }

  @override
  String home_ayah(int number) {
    return 'Aya $number';
  }

  @override
  String get home_dailyAyah => 'Aya ya Leo';

  @override
  String get home_quickAccess => 'Ufikiaji wa Haraka';

  @override
  String get home_searchHint => 'Unatafuta nini...';

  @override
  String get home_radio => 'Redio';

  @override
  String get home_calendar => 'Kalenda';

  @override
  String get home_stories => 'Hadithi';

  @override
  String get home_children => 'Watoto';

  @override
  String get settings_title => 'Mipangilio';

  @override
  String get radio_title => 'Redio ya Siraj';

  @override
  String get radio_all => 'Zote';

  @override
  String get radio_quran => 'Qurani';

  @override
  String get radio_translations => 'Tafsiri za Lugha';

  @override
  String get radio_tafsir => 'Tafsiri na Fatwa';

  @override
  String get radio_athkar => 'Adhkari';

  @override
  String get radio_international => 'Kimataifa';

  @override
  String get radio_play => 'Cheza';

  @override
  String get radio_pause => 'Simamisha';

  @override
  String get cal_title => 'Kalenda ya Kiislamu';

  @override
  String get cal_todayEvents => 'Matukio ya Leo';

  @override
  String get cal_nextEvent => 'Tukio Lijalo';

  @override
  String get cal_allEvents => 'Matukio ya Kiislamu';

  @override
  String cal_daysUntil(int days) {
    return 'Siku $days';
  }

  @override
  String get cal_gregorian => 'Miladia';

  @override
  String get cal_hijri => 'Hijiria';

  @override
  String get cal_prevMonth => 'Mwezi uliopita';

  @override
  String get cal_nextMonth => 'Mwezi ujao';

  @override
  String get cal_legendEid => 'Eid';

  @override
  String get cal_legendFast => 'Funga';

  @override
  String get cal_legendBlessed => 'Baraka';

  @override
  String get cal_detailPending =>
      'Hakuna maelezo zaidi (aya/hadithi/maelezo) yaliyopo bado kwa tukio hili - yanasubiri mapitio ya kidini.';

  @override
  String get hm_1 => 'Muharram';

  @override
  String get hm_2 => 'Safar';

  @override
  String get hm_3 => 'Rabiul Awwal';

  @override
  String get hm_4 => 'Rabiul Akhir';

  @override
  String get hm_5 => 'Jumada al-Ula';

  @override
  String get hm_6 => 'Jumada al-Akhira';

  @override
  String get hm_7 => 'Rajab';

  @override
  String get hm_8 => 'Shaabani';

  @override
  String get hm_9 => 'Ramadhani';

  @override
  String get hm_10 => 'Shawwal';

  @override
  String get hm_11 => 'Dhul-Qida';

  @override
  String get hm_12 => 'Dhul-Hijja';

  @override
  String get ev_new_year => 'Mwaka Mpya wa Kiislamu';

  @override
  String get ev_ashura => 'Siku ya Ashura';

  @override
  String get ev_mawlid => 'Maulidi ya Mtumeﷺ';

  @override
  String get ev_isra => 'Isra na Miiraji';

  @override
  String get ev_ramadan_start => 'Mwanzo wa Ramadhani';

  @override
  String get ev_laylat_qadr => 'Lailatul Qadr';

  @override
  String get ev_eid_fitr => 'Idd el-Fitr';

  @override
  String get ev_arafah => 'Siku ya Arafa';

  @override
  String get ev_eid_adha => 'Idd el-Hajj';

  @override
  String get ev_tashreeq => 'Siku za Tashriki';

  @override
  String get stories_title => 'Hadithi na Sira';

  @override
  String get stories_prophets => 'Mitume';

  @override
  String get stories_companions => 'Maswahaba';

  @override
  String get stories_scholars => 'Wanazuoni';

  @override
  String get stories_comingSoon => 'Hivi karibuni';

  @override
  String get stories_comingSoonMsg =>
      'Inakuja hivi karibuni — maudhui yanaandaliwa';

  @override
  String get children_title => 'Hadithi za Watoto';

  @override
  String get settings_secIdentity => 'Utambulisho';

  @override
  String get onboarding_modeTitle => 'Chagua hali ya programu';

  @override
  String get onboarding_modeSubtitle =>
      'Unaweza kubadilisha hii baadaye kwenye mipangilio';

  @override
  String get onboarding_liteSubtitle =>
      'Mambo ya msingi · Haraka · Nje ya mtandao kikamilifu';

  @override
  String get onboarding_fullSubtitle => 'Vipengele vyote · Kamili · Kina';

  @override
  String get onboarding_andMore => '+ zaidi';

  @override
  String get onboarding_madhabTitle => 'Madhehebu ya Kifiqhi';

  @override
  String get onboarding_madhabSubtitle =>
      'Kwa kukokotoa nyakati za sala kwa usahihi';

  @override
  String get onboarding_locationTitle => 'Weka mahali ulipo';

  @override
  String get onboarding_locationSubtitle => 'Kwa nyakati sahihi za sala';

  @override
  String get onboarding_locationBody =>
      'Programu itaomba ruhusa ya mahali\nili kubaini nyakati za sala kiotomatiki';

  @override
  String get onboarding_locationPrivacy =>
      'Data yako inabaki kwenye kifaa chako pekee';

  @override
  String get onboarding_start => 'Anza';

  @override
  String get settings_dirRtl => 'RTL';

  @override
  String get settings_dirLtr => 'LTR';

  @override
  String get settings_secAdhan => 'Adhana';

  @override
  String get settings_secApp => 'Programu';

  @override
  String get settings_secPrivacy => 'Faragha';

  @override
  String get settings_secAbout => 'Kuhusu';

  @override
  String get settings_language => 'Lugha';

  @override
  String get settings_chooseLanguage => 'Chagua Lugha';

  @override
  String get settings_madhab => 'Madhhabu';

  @override
  String get settings_chooseMadhab => 'Chagua Madhhabu';

  @override
  String get settings_calcMethod => 'Njia ya Kukokotoa Swala';

  @override
  String get settings_chooseCalc => 'Njia ya Kukokotoa';

  @override
  String get settings_enableAdhan => 'Washa Adhana';

  @override
  String get settings_muezzinVoice => 'Sauti ya Muadhini';

  @override
  String get settings_previewAdhan => 'Hakiki sauti ya adhana';

  @override
  String get settings_vibration => 'Mtetemo badala ya sauti';

  @override
  String get settings_iqamaAlert => 'Tahadhari kabla ya Ikama';

  @override
  String settings_minutes(int n) {
    return 'Dakika $n';
  }

  @override
  String get settings_appMode => 'Hali ya Programu';

  @override
  String get settings_fullMode => 'Hali Kamili';

  @override
  String get settings_liteMode => 'Hali Nyepesi';

  @override
  String get settings_fullModeDesc => 'Vipengele vyote vinapatikana';

  @override
  String get settings_liteModeDesc => 'Muhimu tu — nje ya mtandao';

  @override
  String get settings_quranFont => 'Fonti ya Qurani';

  @override
  String get settings_fontUthmani => 'Uthmani';

  @override
  String get settings_fontHafs => 'Hafs';

  @override
  String get settings_quranFontSize => 'Ukubwa wa Fonti ya Qurani';

  @override
  String get settings_privacyNote =>
      'Mahali pako hubaki kwenye kifaa chako pekee';

  @override
  String get settings_clearCache => 'Futa Data ya Cache';

  @override
  String get settings_clearCacheTitle => 'Futa Cache';

  @override
  String get settings_clearCacheMsg =>
      'Data iliyohifadhiwa itafutwa. Una uhakika?';

  @override
  String get settings_cancel => 'Ghairi';

  @override
  String get settings_delete => 'Futa';

  @override
  String get settings_version => 'Toleo';

  @override
  String get settings_shareApp => 'Shiriki Programu';

  @override
  String get settings_licenses => 'Leseni';

  @override
  String get settings_openSourcePackages => 'Leseni za Vifurushi Huria';

  @override
  String get settings_tagline => 'Siraj — Nuru juu ya Nuru';

  @override
  String get madhab_hanafi => 'Hanafi';

  @override
  String get madhab_maliki => 'Maliki';

  @override
  String get madhab_shafi => 'Shafii';

  @override
  String get madhab_hanbali => 'Hanbali';

  @override
  String get calc_MWL => 'Jumuiya ya Kiislamu Duniani';

  @override
  String get calc_ISNA => 'Amerika Kaskazini (ISNA)';

  @override
  String get calc_Egypt => 'Mamlaka ya Misri';

  @override
  String get calc_Makkah => 'Umm al-Qura (Makka)';

  @override
  String get calc_Kuwait => 'Kuwait';

  @override
  String get calc_Qatar => 'Qatar';

  @override
  String get calc_Dubai => 'Dubai';

  @override
  String get calc_Karachi => 'Karachi';

  @override
  String get calc_Singapore => 'Singapore';

  @override
  String get calc_Turkey => 'Uturuki (Diyanet)';

  @override
  String get calc_MoonSighting => 'Kamati ya Kuona Mwezi';

  @override
  String get search_hint => 'Tafuta katika Qurani na tafsiri...';

  @override
  String get search_empty =>
      'Tafuta katika Qurani Tukufu, tafsiri na maana za maneno';

  @override
  String search_noResults(String query) {
    return 'Hakuna matokeo kwa \"$query\"';
  }

  @override
  String get search_typeAyah => 'Aya';

  @override
  String get search_typeTafsir => 'Tafsiri';

  @override
  String get search_typeWord => 'Neno';

  @override
  String get search_typeHadith => 'Hadithi';

  @override
  String get stats_daysStreak => 'siku mfululizo';

  @override
  String get stats_prayersUnit => 'swala';

  @override
  String get stats_pagesUnit => 'kurasa';

  @override
  String get stats_athkar => 'Adhkari';

  @override
  String get stats_sessionsUnit => 'vipindi';

  @override
  String stats_pagesOf(int read, int total) {
    return 'Ukurasa $read / $total';
  }

  @override
  String get reader_tapToListen => 'Gusa kusikiliza';

  @override
  String reader_ayahNum(int n) {
    return 'Aya $n';
  }

  @override
  String get reader_reciter => 'Qari';

  @override
  String get reader_chooseReciter => 'Chagua Qari';

  @override
  String get reader_searchReciter => 'Tafuta qari...';

  @override
  String get reader_longPressHint =>
      'Bonyeza kwa muda mrefu aya yoyote kwa portal, tafsiri na kushiriki';

  @override
  String get reader_versePortal => 'Lango la Aya';

  @override
  String get reader_portalSub => 'Tafsiri · Maneno · Muktadha';

  @override
  String get reader_showTafsir => 'Onyesha Tafsiri';

  @override
  String get reader_shareAyah => 'Shiriki Aya';

  @override
  String get reader_copyAyah => 'Nakili Aya';

  @override
  String get reader_ayahCopied => 'Aya imenakiliwa';

  @override
  String reader_tafsirOf(int n) {
    return 'Tafsiri ya Aya $n';
  }

  @override
  String get reader_muyassar => 'Al-Muyassar';

  @override
  String get reader_tafsirError => 'Imeshindwa kupakia tafsiri';

  @override
  String get reader_shareTitle => 'Aya Tukufu';

  @override
  String reader_shareSubtitle(String surah, int n) {
    return '$surah · Aya $n';
  }

  @override
  String get portal_muyassar => 'Al-Muyassar';

  @override
  String get portal_words => 'Uchambuzi wa Maneno';

  @override
  String get portal_hadiths => 'Hadithi';

  @override
  String get portal_adwaaHadiths => 'Adhwa\'ul Bayan';

  @override
  String get portal_stories => 'Hadithi na Sira';

  @override
  String get portal_arabicTafsir => 'Tafsiri za Kiarabu';

  @override
  String get portal_foreignTafsir => 'Tafsiri za Lugha Nyingine';

  @override
  String get portal_asbab => 'Sababu ya Kuteremshwa';

  @override
  String get portal_searchLang => 'Tafuta lugha...';

  @override
  String get portal_error => 'Imeshindwa kufungua lango';

  @override
  String get portal_back => 'Rudi';

  @override
  String get portal_noTafsir => 'Hakuna tafsiri';

  @override
  String get portal_loadError => 'Imeshindwa kupakia';

  @override
  String get portal_translationPendingReview => 'Inasubiri ukaguzi wa jamii';

  @override
  String get portal_comingSoon => 'Hivi karibuni';

  @override
  String get portal_noHadiths => 'Bado hakuna hadithi inayohusiana na aya hii';

  @override
  String get portal_addingContent => 'Maudhui yanaongezwa hatua kwa hatua';

  @override
  String get more_search => 'Utafutaji wa Pamoja';

  @override
  String get more_settings => 'Mipangilio';

  @override
  String get more_calendar => 'Kalenda ya Kiislamu';

  @override
  String get more_shareCards => 'Kadi za Kushiriki';

  @override
  String get more_fullMode => 'Hali Kamili';

  @override
  String get more_radio => 'Redio ya Qurani';

  @override
  String get more_mosques => 'Misikiti ya Karibu';

  @override
  String get athkarcat_error => 'Hitilafu';

  @override
  String get athkarcat_empty => 'Hakuna adhkari';

  @override
  String athkarcat_completed(String name) {
    return '$name imekamilika';
  }

  @override
  String get athkarcat_back => 'Rudi';

  @override
  String get athkarcat_next => 'Inayofuata';

  @override
  String get athkarcat_finish => 'Maliza';

  @override
  String get athkarcat_prev => 'Iliyotangulia';

  @override
  String athkarcat_repeat(int count, String source) {
    return 'Rudia: $count · $source';
  }

  @override
  String athkarcat_narrated(String source) {
    return 'Imepokewa na $source';
  }

  @override
  String get athkarcat_moving => 'Inahamia...';

  @override
  String get athkarcat_tapCount => 'Gusa kuhesabu';

  @override
  String get athkar_allSections => 'Sehemu Zote';

  @override
  String get gateway_entry_title => 'Fahamu Uislamu';

  @override
  String get gateway_intro_title => 'Safari ya Ufahamu wa Kiroho';

  @override
  String get gateway_journey_title => 'Safari';

  @override
  String get gateway_principles_title => 'Misingi ya Uislamu';

  @override
  String get gateway_library_title => 'Maktaba';

  @override
  String get gateway_begin => 'Anza Safari';

  @override
  String get gateway_next => 'Ifuatayo';

  @override
  String get gateway_prev => 'Nyuma';

  @override
  String get app_tagline => 'Mwongozo Wako wa Kiislamu';

  @override
  String get app_brand_name => 'SIRAJ';

  @override
  String get gateway_shahada_cta => 'Tangaza Imani Yako Sasa';

  @override
  String get nav_library => 'Maktaba';

  @override
  String get library_could_not_load => 'Imeshindwa kupakia';

  @override
  String get library_section_not_found => 'Sehemu haikupatikana';

  @override
  String get library_content_title => 'Maudhui';

  @override
  String get library_search_in_category => 'Tafuta katika jamii hii...';

  @override
  String get library_no_matching_results => 'Hakuna matokeo yanayolingana';

  @override
  String get library_no_materials_lang =>
      'Bado hakuna maudhui katika lugha hii';

  @override
  String get library_connection_failed =>
      'Muunganisho umeshindwa. Angalia intaneti yako na ujaribu tena';

  @override
  String get library_search_content_type => 'Tafuta aina ya maudhui...';

  @override
  String get library_choose_content_type => 'Chagua aina ya maudhui';

  @override
  String get library_no_content_lang => 'Bado hakuna maudhui katika lugha hii';

  @override
  String get library_not_found => 'Haikupatikana';

  @override
  String get library_search_in_section => 'Tafuta katika sehemu hii...';

  @override
  String get library_no_categories => 'Bado hakuna jamii';

  @override
  String get library_type_books => 'Vitabu';

  @override
  String get library_type_audios => 'Sauti';

  @override
  String get library_type_videos => 'Video';

  @override
  String get library_type_articles => 'Makala';

  @override
  String get adhan_makkah => 'Makka (Msikiti Mkuu)';

  @override
  String get adhan_madinah => 'Madina (Msikiti wa Mtume)';

  @override
  String get adhan_mustafa_ismail => 'Mustafa Ismail';

  @override
  String get adhan_iraqi => 'Kiiraki';

  @override
  String get adhan_turkish => 'Kituruki';

  @override
  String get adhan_moroccan => 'Kimorocco';

  @override
  String get adhan_indonesian => 'Kiindonesia';

  @override
  String get adhan_classic => 'Kawaida';

  @override
  String prayer_notification_title(Object prayer) {
    return 'Ni wakati wa $prayer';
  }

  @override
  String get prayer_notification_body => 'Allahu Akbar, njooni kusali';

  @override
  String get khatmah_title => 'Khatma';

  @override
  String get khatmah_new => 'Khatma Mpya';

  @override
  String get khatmah_empty => 'Hakuna khatma bado. Anza ya kwanza!';

  @override
  String get khatmah_name => 'Jina la khatma';

  @override
  String get khatmah_duration_days => 'Muda (siku)';

  @override
  String get khatmah_daily_pages => 'Sehemu ya kila siku (kurasa)';

  @override
  String get khatmah_reminder_time => 'Wakati wa kikumbusho';

  @override
  String get khatmah_create => 'Unda khatma';

  @override
  String get khatmah_preset_ramadan => 'Ramadhani (siku 30)';

  @override
  String get khatmah_preset_weekly => 'Kila wiki (siku 7)';

  @override
  String get khatmah_preset_monthly => 'Kila mwezi (siku 30)';

  @override
  String get khatmah_status_ontrack => 'Kwenye njia';

  @override
  String get khatmah_status_behind => 'Nyuma';

  @override
  String get khatmah_status_ahead => 'Mbele';

  @override
  String get khatmah_status_completed => 'Imekamilika';

  @override
  String get khatmah_today_portion => 'Sehemu ya leo';

  @override
  String get khatmah_read_now => 'Soma sasa';

  @override
  String get khatmah_page => 'Ukurasa';

  @override
  String khatmah_day_of(Object current, Object total) {
    return 'Siku $current kati ya $total';
  }

  @override
  String get khatmah_delete_confirm => 'Futa khatma hii?';

  @override
  String get khatmah_progress => 'Maendeleo';

  @override
  String khatmah_share_text(Object day, Object name, Object percent) {
    return 'Niko siku ya $day ya Khatmah yangu $name, $percent% imekamilika. Mwenyezi Mungu atufanye watu wa Qur\'an 🤲';
  }

  @override
  String get auth_welcome_title => 'Welcome to Siraj';

  @override
  String get auth_welcome_subtitle =>
      'Sign in to sync your progress across devices, or continue as guest';

  @override
  String get auth_email_hint => 'Your email address';

  @override
  String get auth_send_magic_link => 'Send sign-in link';

  @override
  String get auth_magic_link_sent =>
      'We sent a sign-in link to your email. Check it to complete sign-in';

  @override
  String get auth_or => 'or';

  @override
  String get auth_continue_google => 'Continue with Google';

  @override
  String get auth_continue_apple => 'Continue with Apple';

  @override
  String get auth_continue_guest => 'Continue as guest';

  @override
  String get auth_guest_note =>
      'You can use all Siraj features instantly without signing in';

  @override
  String get auth_invalid_email => 'Please enter a valid email address';

  @override
  String get auth_error_generic => 'Something went wrong. Please try again';

  @override
  String get auth_sign_out => 'Sign out';

  @override
  String get auth_delete_account => 'Delete account';

  @override
  String get auth_delete_account_confirm =>
      'Your account and all its data will be permanently deleted. This cannot be undone.';

  @override
  String get auth_delete_account_success =>
      'Your account has been deleted successfully';

  @override
  String get auth_account_settings => 'Account';

  @override
  String get auth_signed_in_as => 'Signed in as';

  @override
  String get auth_guest_account => 'Guest account';

  @override
  String get sections_customize_title => 'Customize Sections';

  @override
  String get sections_customize_subtitle =>
      'Choose which sections to show. Local data stays saved when disabled';

  @override
  String get sections_full_mode_required =>
      'Enable Full Mode in settings to customize sections';

  @override
  String get sections_full_mode_notice =>
      'You\'re in Full Mode, all app sections are enabled automatically. Customization is only available in Lite Mode';

  @override
  String get section_quran_reader => 'Quran';

  @override
  String get section_adhan => 'Adhan';

  @override
  String get section_prayer => 'Prayer Times';

  @override
  String get section_qibla => 'Qibla';

  @override
  String get section_athkar => 'Athkar';

  @override
  String get section_hadith => 'Hadith';

  @override
  String get section_radio => 'Radio';

  @override
  String get section_hifz => 'Memorization';

  @override
  String get section_khatmah => 'Khatmah';

  @override
  String get section_library => 'Library';

  @override
  String get section_mosques => 'Nearby Mosques';

  @override
  String get section_ruqyah => 'Ruqyah';

  @override
  String get section_dua_journal => 'Dua Journal';

  @override
  String get section_mihrab => 'Mihrab';

  @override
  String get section_qke => 'Verse Portal';

  @override
  String get section_timeline => 'Timeline';

  @override
  String get section_new_muslim => 'New to Islam';

  @override
  String get section_calendar => 'Hijri Calendar';

  @override
  String get section_share_cards => 'Share Cards';

  @override
  String get section_gateway => 'Introduction to Islam';

  @override
  String get section_stories => 'Stories';

  @override
  String get section_children_stories => 'Children\'s Stories';
}
