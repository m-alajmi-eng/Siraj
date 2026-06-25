// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Fulah (`ff`).
class AppLocalizationsFf extends AppLocalizations {
  AppLocalizationsFf([String locale = 'ff']) : super(locale);

  @override
  String get appName => 'Siraj';

  @override
  String get prayer_title => 'Waktu Juulde';

  @override
  String get prayer_nextPrayer => 'Juulde Jokki';

  @override
  String get prayer_fajr => 'Subahi';

  @override
  String get prayer_sunrise => 'Wontude Naange';

  @override
  String get prayer_dhuhr => 'Tislaay';

  @override
  String get prayer_asr => 'Timis';

  @override
  String get prayer_maghrib => 'Haske';

  @override
  String get prayer_isha => 'Gee';

  @override
  String prayer_countdown(String time) {
    return 'Yeeso $time';
  }

  @override
  String get prayer_locationGPS => 'Nokku maa hannde';

  @override
  String get prayer_locationDefault => 'Riyaad (jawtuɗo)';

  @override
  String get quran_title => 'Ɓurŋaango Qur\'aana';

  @override
  String get quran_meccan => 'Makkiyya';

  @override
  String get quran_medinan => 'Madaniyya';

  @override
  String quran_ayahCount(int count) {
    return 'Ayeeji $count';
  }

  @override
  String get quran_searchHint => 'Yiylo e Qur\'aana...';

  @override
  String get quran_noResults => 'Walaa jaɓɓuɗi';

  @override
  String get quran_searchPrompt => 'Windii konngol ngol yiylotoo';

  @override
  String get quran_tapForTafsir => 'Hol ayeejo ngoo ka tafsiri';

  @override
  String quran_tafsirTitle(int number) {
    return 'Tafsiri Ayeejo $number';
  }

  @override
  String get quran_tafsirSource => 'Al-Muyassar';

  @override
  String get quran_tafsirError => 'Tafsiri waawataa artirde';

  @override
  String get quran_reciter => 'Kaari';

  @override
  String get quran_selectReciter => 'Suɓo Kaari';

  @override
  String get quran_searchReciter => 'Yiylo kaari...';

  @override
  String get quran_playPrompt => 'Tappe ka heɓde';

  @override
  String quran_ayahNumber(int number) {
    return 'Ayeejo $number';
  }

  @override
  String get athkar_title => 'Zikirji';

  @override
  String get athkar_morning => 'Zikirji Subaka';

  @override
  String get athkar_evening => 'Zikirji Kikiiɗe';

  @override
  String get athkar_sleep => 'Zikirji Ɲaawoore';

  @override
  String get athkar_wake => 'Zikirji Fellude';

  @override
  String get athkar_prayer => 'Zikirji Caggal Juulde';

  @override
  String get athkar_general => 'Zikirji Jaajungal';

  @override
  String get athkar_tapToCount => 'Tappe ka limoore';

  @override
  String get athkar_transitioning => 'Ɓennii...';

  @override
  String athkar_completed(String name) {
    return '$name haaɗii';
  }

  @override
  String get athkar_next => 'Jokki';

  @override
  String get athkar_prev => 'Ɓennungal';

  @override
  String get athkar_finish => 'Haaɗtu';

  @override
  String get athkar_back => 'Artir';

  @override
  String athkar_source(String source) {
    return 'Ɗum haali $source';
  }

  @override
  String get hadith_title => 'Hadiisa';

  @override
  String get hadith_searchHint => 'Yiylo hadiisa...';

  @override
  String get hadith_noResults => 'Walaa jaɓɓuɗi';

  @override
  String get hadith_tapForDetail => 'Tappe ka jannugol hakkunde';

  @override
  String get hadith_retryButton => 'Eɗen Artira';

  @override
  String get hadith_loadError => 'Artirde waawataa';

  @override
  String get qibla_title => 'Hande Qiibla';

  @override
  String get qibla_active => 'Kompas gollorɗo';

  @override
  String get qibla_error => 'Hande Qiibla waawataa humpito';

  @override
  String get qibla_errorHint => 'Hurmo kompas e nokku';

  @override
  String get qibla_kaaba => 'Kaabaa';

  @override
  String get qibla_fromNorth => 'Degree Rewo haa Qiibla';

  @override
  String get stats_title => 'Limooji Am';

  @override
  String get stats_prayerStreak => 'Juɓɓol Juulde';

  @override
  String get stats_totalPrayers => 'Juulɗe Fof';

  @override
  String get stats_quranPages => 'Hello Qur\'aana';

  @override
  String get stats_athkarSessions => 'Zikirji';

  @override
  String get stats_khatma => 'Haaɗtude Qur\'aana';

  @override
  String get stats_days => 'hannde ɓennuɗe';

  @override
  String get stats_prayers => 'juulde';

  @override
  String get stats_pages => 'hello';

  @override
  String get stats_sessions => 'waktu';

  @override
  String get stats_khatmaUnit => 'haaɗtude';

  @override
  String get stats_currentKhatma => 'Haaɗtude Jonte Hannde';

  @override
  String get more_title => 'Caggal';

  @override
  String get more_qibla => 'Hande Qiibla';

  @override
  String get more_stats => 'Limooji Am';

  @override
  String get common_loading => 'Artirde...';

  @override
  String get common_error => 'Juumre artirde xarfiiji';

  @override
  String get common_retry => 'Eɗen Artira';

  @override
  String get common_back => 'Artir';

  @override
  String get common_next => 'Jokki';

  @override
  String get common_save => 'Dartoo';

  @override
  String get common_cancel => 'Haaytu';

  @override
  String get common_done => 'Haaɗii';

  @override
  String get common_search => 'Yiylo';

  @override
  String get common_noData => 'Walaa xarfiiji';

  @override
  String get common_offline => 'Walaa internetuure';
}
