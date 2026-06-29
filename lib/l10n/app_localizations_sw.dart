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
  String get home_continueReading => 'ENDELEA KUSOMA';

  @override
  String home_surah(int id) {
    return 'سورة #$id';
  }

  @override
  String home_ayah(int number) {
    return 'آية $number';
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
}
