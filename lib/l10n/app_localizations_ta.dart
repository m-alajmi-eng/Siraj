// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Tamil (`ta`).
class AppLocalizationsTa extends AppLocalizations {
  AppLocalizationsTa([String locale = 'ta']) : super(locale);

  @override
  String get appName => 'சிராஜ்';

  @override
  String get prayer_title => 'தொழுகை நேரங்கள்';

  @override
  String get prayer_nextPrayer => 'அடுத்த தொழுகை';

  @override
  String get prayer_fajr => 'ஃபஜ்ர்';

  @override
  String get prayer_sunrise => 'சூரிய உதயம்';

  @override
  String get prayer_dhuhr => 'ழுஹர்';

  @override
  String get prayer_asr => 'அஸர்';

  @override
  String get prayer_maghrib => 'மஃக்ரிப்';

  @override
  String get prayer_isha => 'இஷா';

  @override
  String prayer_countdown(String time) {
    return '$time இல்';
  }

  @override
  String get prayer_locationGPS => 'உங்கள் தற்போதைய இருப்பிடம்';

  @override
  String get prayer_locationDefault => 'ரியாத் (இயல்புநிலை)';

  @override
  String get quran_title => 'புனித குர்ஆன்';

  @override
  String get quran_meccan => 'மக்கி';

  @override
  String get quran_medinan => 'மதனி';

  @override
  String quran_ayahCount(int count) {
    return '$count வசனங்கள்';
  }

  @override
  String get quran_searchHint => 'குர்ஆனில் தேடு...';

  @override
  String get quran_noResults => 'முடிவுகள் இல்லை';

  @override
  String get quran_searchPrompt => 'தேட ஒரு வார்த்தை தட்டச்சு செய்யுங்கள்';

  @override
  String get quran_tapForTafsir =>
      'தஃப்சீருக்கு வசனத்தை நீண்ட நேரம் அழுத்துங்கள்';

  @override
  String quran_tafsirTitle(int number) {
    return '$numberவது வசனத்தின் தஃப்சீர்';
  }

  @override
  String get quran_tafsirSource => 'அல்-முயஸ்ஸர்';

  @override
  String get quran_tafsirError => 'தஃப்சீர் ஏற்ற முடியவில்லை';

  @override
  String get quran_reciter => 'ஓதுபவர்';

  @override
  String get quran_selectReciter => 'ஓதுபவரை தேர்வு செய்யுங்கள்';

  @override
  String get quran_searchReciter => 'ஓதுபவரை தேடுங்கள்...';

  @override
  String get quran_playPrompt => 'கேட்க தட்டுங்கள்';

  @override
  String quran_ayahNumber(int number) {
    return '$numberவது வசனம்';
  }

  @override
  String get athkar_title => 'திக்ர்';

  @override
  String get athkar_morning => 'காலை திக்ர்';

  @override
  String get athkar_evening => 'மாலை திக்ர்';

  @override
  String get athkar_sleep => 'தூக்க திக்ர்';

  @override
  String get athkar_wake => 'விழிப்பு திக்ர்';

  @override
  String get athkar_prayer => 'தொழுகைக்கு பின் திக்ர்';

  @override
  String get athkar_general => 'பொது திக்ர்';

  @override
  String get athkar_tapToCount => 'எண்ண தட்டுங்கள்';

  @override
  String get athkar_transitioning => 'தொடர்கிறது...';

  @override
  String athkar_completed(String name) {
    return '$name முடிந்தது';
  }

  @override
  String get athkar_next => 'அடுத்து';

  @override
  String get athkar_prev => 'முந்தையது';

  @override
  String get athkar_finish => 'முடி';

  @override
  String get athkar_back => 'திரும்பு';

  @override
  String athkar_source(String source) {
    return '$source அறிவித்தார்';
  }

  @override
  String get hadith_title => 'ஹதீஸ்';

  @override
  String get hadith_searchHint => 'ஹதீஸ் தேடு...';

  @override
  String get hadith_noResults => 'முடிவுகள் இல்லை';

  @override
  String get hadith_tapForDetail => 'முழுவதும் படிக்க தட்டுங்கள்';

  @override
  String get hadith_retryButton => 'மீண்டும் முயற்சி';

  @override
  String get hadith_loadError => 'ஏற்றுவதில் தோல்வி';

  @override
  String get qibla_title => 'கிப்லா திசை';

  @override
  String get qibla_active => 'திசைகாட்டி செயலில் உள்ளது';

  @override
  String get qibla_error => 'கிப்லா திசையை தீர்மானிக்க முடியவில்லை';

  @override
  String get qibla_errorHint => 'திசைகாட்டி மற்றும் இடத்தை இயக்குங்கள்';

  @override
  String get qibla_kaaba => 'கஃபா';

  @override
  String get qibla_fromNorth => 'வடக்கிலிருந்து கிப்லா வரை டிகிரி';

  @override
  String get stats_title => 'என் புள்ளிவிவரங்கள்';

  @override
  String get stats_prayerStreak => 'தொழுகை தொடர்ச்சி';

  @override
  String get stats_totalPrayers => 'மொத்த தொழுகைகள்';

  @override
  String get stats_quranPages => 'குர்ஆன் பக்கங்கள்';

  @override
  String get stats_athkarSessions => 'திக்ர்';

  @override
  String get stats_khatma => 'குர்ஆன் முழுமை';

  @override
  String get stats_days => 'தொடர்ச்சியான நாட்கள்';

  @override
  String get stats_prayers => 'தொழுகைகள்';

  @override
  String get stats_pages => 'பக்கங்கள்';

  @override
  String get stats_sessions => 'அமர்வுகள்';

  @override
  String get stats_khatmaUnit => 'முழுமை';

  @override
  String get stats_currentKhatma => 'தற்போதைய முழுமை முன்னேற்றம்';

  @override
  String get more_title => 'மேலும்';

  @override
  String get more_qibla => 'கிப்லா திசை';

  @override
  String get more_stats => 'என் புள்ளிவிவரங்கள்';

  @override
  String get common_loading => 'ஏற்றுகிறது...';

  @override
  String get common_error => 'தரவு ஏற்றுவதில் பிழை';

  @override
  String get common_retry => 'மீண்டும் முயற்சி';

  @override
  String get common_back => 'திரும்பு';

  @override
  String get common_next => 'அடுத்து';

  @override
  String get common_save => 'சேமி';

  @override
  String get common_cancel => 'ரத்து செய்';

  @override
  String get common_done => 'முடிந்தது';

  @override
  String get common_search => 'தேடு';

  @override
  String get common_noData => 'தரவு இல்லை';

  @override
  String get common_offline => 'இணைய இணைப்பு இல்லை';
}
