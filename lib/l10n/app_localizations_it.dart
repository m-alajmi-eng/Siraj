// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appName => 'Siraj';

  @override
  String get prayer_title => 'Orari di Preghiera';

  @override
  String get prayer_nextPrayer => 'Prossima Preghiera';

  @override
  String get prayer_fajr => 'Fajr';

  @override
  String get prayer_sunrise => 'Alba';

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
    return 'Tra $time';
  }

  @override
  String get prayer_locationGPS => 'La tua posizione attuale';

  @override
  String get prayer_locationDefault => 'Riyadh (predefinito)';

  @override
  String get quran_title => 'Il Santo Corano';

  @override
  String get quran_meccan => 'Meccana';

  @override
  String get quran_medinan => 'Medinese';

  @override
  String quran_ayahCount(int count) {
    return '$count versetti';
  }

  @override
  String get quran_searchHint => 'Cerca nel Corano...';

  @override
  String get quran_noResults => 'Nessun risultato';

  @override
  String get quran_searchPrompt => 'Digita una parola per cercare';

  @override
  String get quran_tapForTafsir => 'Tieni premuto un versetto per il tafsir';

  @override
  String quran_tafsirTitle(int number) {
    return 'Tafsir del Versetto $number';
  }

  @override
  String get quran_tafsirSource => 'Al-Muyassar';

  @override
  String get quran_tafsirError => 'Impossibile caricare il tafsir';

  @override
  String get quran_reciter => 'Recitatore';

  @override
  String get quran_selectReciter => 'Seleziona Recitatore';

  @override
  String get quran_searchReciter => 'Cerca recitatore...';

  @override
  String get quran_playPrompt => 'Tocca per ascoltare';

  @override
  String quran_ayahNumber(int number) {
    return 'Versetto $number';
  }

  @override
  String get athkar_title => 'Athkar';

  @override
  String get athkar_morning => 'Athkar del Mattino';

  @override
  String get athkar_evening => 'Athkar della Sera';

  @override
  String get athkar_sleep => 'Athkar per Dormire';

  @override
  String get athkar_wake => 'Athkar al Risveglio';

  @override
  String get athkar_prayer => 'Athkar dopo la Preghiera';

  @override
  String get athkar_general => 'Athkar Generali';

  @override
  String get athkar_tapToCount => 'Tocca per contare';

  @override
  String get athkar_transitioning => 'Avanzando...';

  @override
  String athkar_completed(String name) {
    return '$name completato';
  }

  @override
  String get athkar_next => 'Successivo';

  @override
  String get athkar_prev => 'Precedente';

  @override
  String get athkar_finish => 'Fine';

  @override
  String get athkar_back => 'Indietro';

  @override
  String athkar_source(String source) {
    return 'Tramandato da $source';
  }

  @override
  String get hadith_title => 'Hadith';

  @override
  String get hadith_searchHint => 'Cerca hadith...';

  @override
  String get hadith_noResults => 'Nessun risultato';

  @override
  String get hadith_tapForDetail => 'Tocca per leggere completo';

  @override
  String get hadith_retryButton => 'Riprova';

  @override
  String get hadith_loadError => 'Caricamento fallito';

  @override
  String get qibla_title => 'Direzione della Qibla';

  @override
  String get qibla_active => 'Bussola attiva';

  @override
  String get qibla_error => 'Impossibile determinare la direzione della Qibla';

  @override
  String get qibla_errorHint => 'Attiva la bussola e la posizione';

  @override
  String get qibla_kaaba => 'Kaaba';

  @override
  String get qibla_fromNorth => 'Gradi dal Nord verso la Qibla';

  @override
  String get stats_title => 'Le Mie Statistiche';

  @override
  String get stats_prayerStreak => 'Serie di Preghiere';

  @override
  String get stats_totalPrayers => 'Preghiere Totali';

  @override
  String get stats_quranPages => 'Pagine del Corano';

  @override
  String get stats_athkarSessions => 'Athkar';

  @override
  String get stats_khatma => 'Completamenti del Corano';

  @override
  String get stats_days => 'giorni consecutivi';

  @override
  String get stats_prayers => 'preghiere';

  @override
  String get stats_pages => 'pagine';

  @override
  String get stats_sessions => 'sessioni';

  @override
  String get stats_khatmaUnit => 'completamento';

  @override
  String get stats_currentKhatma => 'Progresso del Khatm Attuale';

  @override
  String get more_title => 'Altro';

  @override
  String get more_qibla => 'Direzione della Qibla';

  @override
  String get more_stats => 'Le Mie Statistiche';

  @override
  String get common_loading => 'Caricamento...';

  @override
  String get common_error => 'Errore nel caricamento';

  @override
  String get common_retry => 'Riprova';

  @override
  String get common_back => 'Indietro';

  @override
  String get common_next => 'Successivo';

  @override
  String get common_save => 'Salva';

  @override
  String get common_cancel => 'Annulla';

  @override
  String get common_done => 'Fatto';

  @override
  String get common_search => 'Cerca';

  @override
  String get common_noData => 'Nessun dato';

  @override
  String get common_offline => 'Nessuna connessione internet';

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
}
