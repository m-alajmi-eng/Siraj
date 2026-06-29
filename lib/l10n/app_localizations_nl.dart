// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get appName => 'Siraj';

  @override
  String get prayer_title => 'Gebedstijden';

  @override
  String get prayer_nextPrayer => 'Volgend Gebed';

  @override
  String get prayer_fajr => 'Fajr';

  @override
  String get prayer_sunrise => 'Zonsopgang';

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
    return 'Over $time';
  }

  @override
  String get prayer_locationGPS => 'Uw huidige locatie';

  @override
  String get prayer_locationDefault => 'Riyad (standaard)';

  @override
  String get quran_title => 'De Heilige Koran';

  @override
  String get quran_meccan => 'Mekkaans';

  @override
  String get quran_medinan => 'Medinensisch';

  @override
  String quran_ayahCount(int count) {
    return '$count verzen';
  }

  @override
  String get quran_searchHint => 'Zoeken in de Koran...';

  @override
  String get quran_noResults => 'Geen resultaten';

  @override
  String get quran_searchPrompt => 'Typ een woord om te zoeken';

  @override
  String get quran_tapForTafsir => 'Houd een vers ingedrukt voor tafsir';

  @override
  String quran_tafsirTitle(int number) {
    return 'Tafsir van Vers $number';
  }

  @override
  String get quran_tafsirSource => 'Al-Muyassar';

  @override
  String get quran_tafsirError => 'Tafsir kon niet worden geladen';

  @override
  String get quran_reciter => 'Recitator';

  @override
  String get quran_selectReciter => 'Selecteer Recitator';

  @override
  String get quran_searchReciter => 'Zoek recitator...';

  @override
  String get quran_playPrompt => 'Tik om te luisteren';

  @override
  String quran_ayahNumber(int number) {
    return 'Vers $number';
  }

  @override
  String get athkar_title => 'Athkar';

  @override
  String get athkar_morning => 'Ochtend Athkar';

  @override
  String get athkar_evening => 'Avond Athkar';

  @override
  String get athkar_sleep => 'Slaap Athkar';

  @override
  String get athkar_wake => 'Ontwaken Athkar';

  @override
  String get athkar_prayer => 'Athkar na Gebed';

  @override
  String get athkar_general => 'Algemene Athkar';

  @override
  String get athkar_tapToCount => 'Tik om te tellen';

  @override
  String get athkar_transitioning => 'Verder gaan...';

  @override
  String athkar_completed(String name) {
    return '$name voltooid';
  }

  @override
  String get athkar_next => 'Volgende';

  @override
  String get athkar_prev => 'Vorige';

  @override
  String get athkar_finish => 'Voltooien';

  @override
  String get athkar_back => 'Terug';

  @override
  String athkar_source(String source) {
    return 'Overgeleverd door $source';
  }

  @override
  String get hadith_title => 'Hadith';

  @override
  String get hadith_searchHint => 'Hadith zoeken...';

  @override
  String get hadith_noResults => 'Geen resultaten';

  @override
  String get hadith_tapForDetail => 'Tik om volledig te lezen';

  @override
  String get hadith_retryButton => 'Opnieuw proberen';

  @override
  String get hadith_loadError => 'Laden mislukt';

  @override
  String get qibla_title => 'Qibla Richting';

  @override
  String get qibla_active => 'Kompas actief';

  @override
  String get qibla_error => 'Qibla richting kon niet worden bepaald';

  @override
  String get qibla_errorHint => 'Schakel kompas en locatie in';

  @override
  String get qibla_kaaba => 'Kaaba';

  @override
  String get qibla_fromNorth => 'Graden van Noord naar Qibla';

  @override
  String get stats_title => 'Mijn Statistieken';

  @override
  String get stats_prayerStreak => 'Gebed Reeks';

  @override
  String get stats_totalPrayers => 'Totaal Gebeden';

  @override
  String get stats_quranPages => 'Koran Pagina\'s';

  @override
  String get stats_athkarSessions => 'Athkar';

  @override
  String get stats_khatma => 'Koran Voltooiingen';

  @override
  String get stats_days => 'opeenvolgende dagen';

  @override
  String get stats_prayers => 'gebeden';

  @override
  String get stats_pages => 'pagina\'s';

  @override
  String get stats_sessions => 'sessies';

  @override
  String get stats_khatmaUnit => 'voltooiing';

  @override
  String get stats_currentKhatma => 'Huidige Khatm Voortgang';

  @override
  String get more_title => 'Meer';

  @override
  String get more_qibla => 'Qibla Richting';

  @override
  String get more_stats => 'Mijn Statistieken';

  @override
  String get common_loading => 'Laden...';

  @override
  String get common_error => 'Fout bij laden';

  @override
  String get common_retry => 'Opnieuw proberen';

  @override
  String get common_back => 'Terug';

  @override
  String get common_next => 'Volgende';

  @override
  String get common_save => 'Opslaan';

  @override
  String get common_cancel => 'Annuleren';

  @override
  String get common_done => 'Klaar';

  @override
  String get common_search => 'Zoeken';

  @override
  String get common_noData => 'Geen gegevens';

  @override
  String get common_offline => 'Geen internetverbinding';

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

  @override
  String get cal_title => 'التقويم الإسلامي';

  @override
  String get cal_todayEvents => 'مناسبات اليوم';

  @override
  String get cal_nextEvent => 'المناسبة القادمة';

  @override
  String get cal_allEvents => 'المناسبات الإسلامية';

  @override
  String cal_daysUntil(int days) {
    return '$days يوم';
  }

  @override
  String get cal_gregorian => 'ميلادي';

  @override
  String get cal_hijri => 'هجري';

  @override
  String get hm_1 => 'محرم';

  @override
  String get hm_2 => 'صفر';

  @override
  String get hm_3 => 'ربيع الأول';

  @override
  String get hm_4 => 'ربيع الآخر';

  @override
  String get hm_5 => 'جمادى الأولى';

  @override
  String get hm_6 => 'جمادى الآخرة';

  @override
  String get hm_7 => 'رجب';

  @override
  String get hm_8 => 'شعبان';

  @override
  String get hm_9 => 'رمضان';

  @override
  String get hm_10 => 'شوال';

  @override
  String get hm_11 => 'ذو القعدة';

  @override
  String get hm_12 => 'ذو الحجة';

  @override
  String get ev_new_year => 'رأس السنة الهجرية';

  @override
  String get ev_ashura => 'يوم عاشوراء';

  @override
  String get ev_mawlid => 'المولد النبوي';

  @override
  String get ev_isra => 'ليلة الإسراء والمعراج';

  @override
  String get ev_ramadan_start => 'أول رمضان';

  @override
  String get ev_laylat_qadr => 'ليلة القدر';

  @override
  String get ev_eid_fitr => 'عيد الفطر';

  @override
  String get ev_arafah => 'يوم عرفة';

  @override
  String get ev_eid_adha => 'عيد الأضحى';

  @override
  String get ev_tashreeq => 'أيام التشريق';
}
