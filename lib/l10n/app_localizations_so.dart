// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Somali (`so`).
class AppLocalizationsSo extends AppLocalizations {
  AppLocalizationsSo([String locale = 'so']) : super(locale);

  @override
  String get appName => 'Siraj';

  @override
  String get prayer_title => 'Wakhtiyada Salaada';

  @override
  String get prayer_nextPrayer => 'Salaada Xigta';

  @override
  String get prayer_fajr => 'Fajr';

  @override
  String get prayer_sunrise => 'Baxaxa Qorraxda';

  @override
  String get prayer_dhuhr => 'Duhr';

  @override
  String get prayer_asr => 'Casr';

  @override
  String get prayer_maghrib => 'Maghrib';

  @override
  String get prayer_isha => 'Cisha';

  @override
  String prayer_countdown(String time) {
    return 'Gudaha $time';
  }

  @override
  String get prayer_locationGPS => 'Goobta aad hadda joogtid';

  @override
  String get prayer_locationDefault => 'Riyaad (caadiga ah)';

  @override
  String get quran_title => 'Qur\'aanka Kariimka';

  @override
  String get quran_meccan => 'Makkiyah';

  @override
  String get quran_medinan => 'Madaniyah';

  @override
  String quran_ayahCount(int count) {
    return '$count aayad';
  }

  @override
  String get quran_searchHint => 'Ka raadi Qur\'aanka...';

  @override
  String get quran_noResults => 'Wax natiijo ah ma jiraan';

  @override
  String get quran_searchPrompt => 'Fur eray si aad u raadiso';

  @override
  String get quran_tapForTafsir => 'Tafsir heli ku hayso aayada';

  @override
  String quran_tafsirTitle(int number) {
    return 'Tafsirka Aayada $number';
  }

  @override
  String get quran_tafsirSource => 'Al-Muyassar';

  @override
  String get quran_tafsirError => 'Tafsirka lama soo dejin karin';

  @override
  String get quran_reciter => 'Qaari';

  @override
  String get quran_selectReciter => 'Dooro Qaari';

  @override
  String get quran_searchReciter => 'Raadi qaari...';

  @override
  String get quran_playPrompt => 'Taabo si aad u dhageysato';

  @override
  String quran_ayahNumber(int number) {
    return 'Aayada $number';
  }

  @override
  String get athkar_title => 'Adhkaar';

  @override
  String get athkar_morning => 'Adhkaar Subaxnimo';

  @override
  String get athkar_evening => 'Adhkaar Galab';

  @override
  String get athkar_sleep => 'Adhkaar Hurdada';

  @override
  String get athkar_wake => 'Adhkaar Toosashada';

  @override
  String get athkar_prayer => 'Adhkaar ka Dib Salaada';

  @override
  String get athkar_general => 'Adhkaar Guud';

  @override
  String get athkar_tapToCount => 'Taabo si aad u tiriso';

  @override
  String get athkar_transitioning => 'Socda...';

  @override
  String athkar_completed(String name) {
    return '$name dhammaatay';
  }

  @override
  String get athkar_next => 'Xigta';

  @override
  String get athkar_prev => 'Hore';

  @override
  String get athkar_finish => 'Dhamee';

  @override
  String get athkar_back => 'Ku Noqo';

  @override
  String athkar_source(String source) {
    return 'Waxaa sheegay $source';
  }

  @override
  String get hadith_title => 'Xadiis';

  @override
  String get hadith_searchHint => 'Raadi xadiis...';

  @override
  String get hadith_noResults => 'Wax natiijo ah ma jiraan';

  @override
  String get hadith_tapForDetail => 'Taabo si aad u akhridid oo dhan';

  @override
  String get hadith_retryButton => 'Isku Day Mar Kale';

  @override
  String get hadith_loadError => 'Soo dejinta ku guuldareystay';

  @override
  String get qibla_title => 'Jihada Qiblada';

  @override
  String get qibla_active => 'Kombiyuutarku wuu shaqeynayaa';

  @override
  String get qibla_error => 'Jihada Qiblada lama go\'aamin karin';

  @override
  String get qibla_errorHint => 'Compass iyo goobta fur';

  @override
  String get qibla_kaaba => 'Kacbada';

  @override
  String get qibla_fromNorth => 'Darajo Waqooyi ilaa Qiblada';

  @override
  String get stats_title => 'Xogahaygii';

  @override
  String get stats_prayerStreak => 'Silsiladda Salaada';

  @override
  String get stats_totalPrayers => 'Wadarta Salaadaha';

  @override
  String get stats_quranPages => 'Bogagga Qur\'aanka';

  @override
  String get stats_athkarSessions => 'Adhkaar';

  @override
  String get stats_khatma => 'Dhammaadka Qur\'aanka';

  @override
  String get stats_days => 'maalmood xiga';

  @override
  String get stats_prayers => 'salaad';

  @override
  String get stats_pages => 'bog';

  @override
  String get stats_sessions => 'fasal';

  @override
  String get stats_khatmaUnit => 'dhammaad';

  @override
  String get stats_currentKhatma => 'Horumarinta Dhammaadka Hadda';

  @override
  String get more_title => 'Wax Dheeraad ah';

  @override
  String get more_qibla => 'Jihada Qiblada';

  @override
  String get more_stats => 'Xogahaygii';

  @override
  String get common_loading => 'Waa la soo dejinayaa...';

  @override
  String get common_error => 'Khalad soo dejinta xogta';

  @override
  String get common_retry => 'Isku Day Mar Kale';

  @override
  String get common_back => 'Ku Noqo';

  @override
  String get common_next => 'Xigta';

  @override
  String get common_save => 'Keydi';

  @override
  String get common_cancel => 'Jooji';

  @override
  String get common_done => 'Dhammaatay';

  @override
  String get common_search => 'Raadi';

  @override
  String get common_noData => 'Xog ma jirto';

  @override
  String get common_offline => 'Xiriirka internetka ma jiro';

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
