// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get appName => 'Сираж';

  @override
  String get prayer_title => 'Намаз Уақыттары';

  @override
  String get prayer_nextPrayer => 'Келесі Намаз';

  @override
  String get prayer_fajr => 'Таң';

  @override
  String get prayer_sunrise => 'Күн Шығу';

  @override
  String get prayer_dhuhr => 'Бесін';

  @override
  String get prayer_asr => 'Екінті';

  @override
  String get prayer_maghrib => 'Ақшам';

  @override
  String get prayer_isha => 'Құптан';

  @override
  String prayer_countdown(String time) {
    return '$time кейін';
  }

  @override
  String get prayer_locationGPS => 'Сіздің қазіргі орналасуыңыз';

  @override
  String get prayer_locationDefault => 'Эр-Рияд (әдепкі)';

  @override
  String get quran_title => 'Қасиетті Құран';

  @override
  String get quran_meccan => 'Меккелік';

  @override
  String get quran_medinan => 'Мединелік';

  @override
  String quran_ayahCount(int count) {
    return '$count аят';
  }

  @override
  String get quran_searchHint => 'Құраннан іздеу...';

  @override
  String get quran_noResults => 'Нәтиже табылмады';

  @override
  String get quran_searchPrompt => 'Іздеу үшін сөз енгізіңіз';

  @override
  String get quran_tapForTafsir => 'Тапсир үшін аятты ұстап тұрыңыз';

  @override
  String quran_tafsirTitle(int number) {
    return '$number аяттың тапсиры';
  }

  @override
  String get quran_tafsirSource => 'Әл-Муяссар';

  @override
  String get quran_tafsirError => 'Тапсирды жүктеу мүмкін болмады';

  @override
  String get quran_reciter => 'Қари';

  @override
  String get quran_selectReciter => 'Қариді таңдаңыз';

  @override
  String get quran_searchReciter => 'Қариді іздеу...';

  @override
  String get quran_playPrompt => 'Тыңдау үшін түртіңіз';

  @override
  String quran_ayahNumber(int number) {
    return '$number аят';
  }

  @override
  String get athkar_title => 'Зікірлер';

  @override
  String get athkar_morning => 'Таңғы Зікірлер';

  @override
  String get athkar_evening => 'Кешкі Зікірлер';

  @override
  String get athkar_sleep => 'Ұйқы Зікірлері';

  @override
  String get athkar_wake => 'Ояну Зікірлері';

  @override
  String get athkar_prayer => 'Намаздан Кейінгі Зікірлер';

  @override
  String get athkar_general => 'Жалпы Зікірлер';

  @override
  String get athkar_tapToCount => 'Санау үшін түртіңіз';

  @override
  String get athkar_transitioning => 'Өтуде...';

  @override
  String athkar_completed(String name) {
    return '$name аяқталды';
  }

  @override
  String get athkar_next => 'Келесі';

  @override
  String get athkar_prev => 'Алдыңғы';

  @override
  String get athkar_finish => 'Аяқтау';

  @override
  String get athkar_back => 'Артқа';

  @override
  String athkar_source(String source) {
    return '$source риуаят еткен';
  }

  @override
  String get hadith_title => 'Хадис';

  @override
  String get hadith_searchHint => 'Хадис іздеу...';

  @override
  String get hadith_noResults => 'Нәтиже табылмады';

  @override
  String get hadith_tapForDetail => 'Толық оқу үшін түртіңіз';

  @override
  String get hadith_retryButton => 'Қайталап көру';

  @override
  String get hadith_loadError => 'Жүктеу мүмкін болмады';

  @override
  String get qibla_title => 'Қибла Бағыты';

  @override
  String get qibla_active => 'Компас белсенді';

  @override
  String get qibla_error => 'Қибла бағытын анықтау мүмкін болмады';

  @override
  String get qibla_errorHint => 'Компас пен орналасуды қосыңыз';

  @override
  String get qibla_kaaba => 'Кааба';

  @override
  String get qibla_fromNorth => 'Солтүстіктен Қиблаға дейінгі градус';

  @override
  String get stats_title => 'Менің Статистикам';

  @override
  String get stats_prayerStreak => 'Намаз Сериясы';

  @override
  String get stats_totalPrayers => 'Жалпы Намаздар';

  @override
  String get stats_quranPages => 'Құран Беттері';

  @override
  String get stats_athkarSessions => 'Зікірлер';

  @override
  String get stats_khatma => 'Құран Хатымы';

  @override
  String get stats_days => 'қатарлы күн';

  @override
  String get stats_prayers => 'намаз';

  @override
  String get stats_pages => 'бет';

  @override
  String get stats_sessions => 'сеанс';

  @override
  String get stats_khatmaUnit => 'хатым';

  @override
  String get stats_currentKhatma => 'Ағымдағы Хатым Прогресі';

  @override
  String get more_title => 'Көбірек';

  @override
  String get more_qibla => 'Қибла Бағыты';

  @override
  String get more_stats => 'Менің Статистикам';

  @override
  String get common_loading => 'Жүктелуде...';

  @override
  String get common_error => 'Деректерді жүктеу қатесі';

  @override
  String get common_retry => 'Қайталап көру';

  @override
  String get common_back => 'Артқа';

  @override
  String get common_next => 'Келесі';

  @override
  String get common_save => 'Сақтау';

  @override
  String get common_cancel => 'Болдырмау';

  @override
  String get common_done => 'Дайын';

  @override
  String get common_search => 'Іздеу';

  @override
  String get common_noData => 'Деректер жоқ';

  @override
  String get common_offline => 'Интернет байланысы жоқ';
}
