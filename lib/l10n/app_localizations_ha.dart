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
    return 'سورة #$id';
  }

  @override
  String home_ayah(int number) {
    return 'آية $number';
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
