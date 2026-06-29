// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appName => 'Siraj';

  @override
  String get prayer_title => 'Horários de Oração';

  @override
  String get prayer_nextPrayer => 'Próxima Oração';

  @override
  String get prayer_fajr => 'Fajr';

  @override
  String get prayer_sunrise => 'Nascer do Sol';

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
    return 'Em $time';
  }

  @override
  String get prayer_locationGPS => 'Sua localização atual';

  @override
  String get prayer_locationDefault => 'Riade (padrão)';

  @override
  String get quran_title => 'O Sagrado Alcorão';

  @override
  String get quran_meccan => 'Mequense';

  @override
  String get quran_medinan => 'Medinense';

  @override
  String quran_ayahCount(int count) {
    return '$count versículos';
  }

  @override
  String get quran_searchHint => 'Pesquisar no Alcorão...';

  @override
  String get quran_noResults => 'Sem resultados';

  @override
  String get quran_searchPrompt => 'Digite uma palavra para pesquisar';

  @override
  String get quran_tapForTafsir => 'Pressione um versículo para tafsir';

  @override
  String quran_tafsirTitle(int number) {
    return 'Tafsir do Versículo $number';
  }

  @override
  String get quran_tafsirSource => 'Al-Muyassar';

  @override
  String get quran_tafsirError => 'Não foi possível carregar o tafsir';

  @override
  String get quran_reciter => 'Recitador';

  @override
  String get quran_selectReciter => 'Selecionar Recitador';

  @override
  String get quran_searchReciter => 'Procurar recitador...';

  @override
  String get quran_playPrompt => 'Toque para ouvir';

  @override
  String quran_ayahNumber(int number) {
    return 'Versículo $number';
  }

  @override
  String get athkar_title => 'Athkar';

  @override
  String get athkar_morning => 'Athkar da Manhã';

  @override
  String get athkar_evening => 'Athkar da Tarde';

  @override
  String get athkar_sleep => 'Athkar para Dormir';

  @override
  String get athkar_wake => 'Athkar ao Acordar';

  @override
  String get athkar_prayer => 'Athkar após a Oração';

  @override
  String get athkar_general => 'Athkar Geral';

  @override
  String get athkar_tapToCount => 'Toque para contar';

  @override
  String get athkar_transitioning => 'Avançando...';

  @override
  String athkar_completed(String name) {
    return '$name concluído';
  }

  @override
  String get athkar_next => 'Próximo';

  @override
  String get athkar_prev => 'Anterior';

  @override
  String get athkar_finish => 'Finalizar';

  @override
  String get athkar_back => 'Voltar';

  @override
  String athkar_source(String source) {
    return 'Narrado por $source';
  }

  @override
  String get hadith_title => 'Hadith';

  @override
  String get hadith_searchHint => 'Pesquisar hadiths...';

  @override
  String get hadith_noResults => 'Sem resultados';

  @override
  String get hadith_tapForDetail => 'Toque para ler completo';

  @override
  String get hadith_retryButton => 'Tentar Novamente';

  @override
  String get hadith_loadError => 'Falha ao carregar';

  @override
  String get qibla_title => 'Direção da Qibla';

  @override
  String get qibla_active => 'Bússola ativa';

  @override
  String get qibla_error => 'Não foi possível determinar a direção da Qibla';

  @override
  String get qibla_errorHint => 'Ative a bússola e a localização';

  @override
  String get qibla_kaaba => 'Caaba';

  @override
  String get qibla_fromNorth => 'Graus do Norte em direção à Qibla';

  @override
  String get stats_title => 'Minhas Estatísticas';

  @override
  String get stats_prayerStreak => 'Sequência de Orações';

  @override
  String get stats_totalPrayers => 'Total de Orações';

  @override
  String get stats_quranPages => 'Páginas do Alcorão';

  @override
  String get stats_athkarSessions => 'Athkar';

  @override
  String get stats_khatma => 'Completamentos do Alcorão';

  @override
  String get stats_days => 'dias consecutivos';

  @override
  String get stats_prayers => 'orações';

  @override
  String get stats_pages => 'páginas';

  @override
  String get stats_sessions => 'sessões';

  @override
  String get stats_khatmaUnit => 'completamento';

  @override
  String get stats_currentKhatma => 'Progresso do Khatm Atual';

  @override
  String get more_title => 'Mais';

  @override
  String get more_qibla => 'Direção da Qibla';

  @override
  String get more_stats => 'Minhas Estatísticas';

  @override
  String get common_loading => 'Carregando...';

  @override
  String get common_error => 'Erro ao carregar dados';

  @override
  String get common_retry => 'Tentar Novamente';

  @override
  String get common_back => 'Voltar';

  @override
  String get common_next => 'Próximo';

  @override
  String get common_save => 'Salvar';

  @override
  String get common_cancel => 'Cancelar';

  @override
  String get common_done => 'Concluído';

  @override
  String get common_search => 'Pesquisar';

  @override
  String get common_noData => 'Sem dados';

  @override
  String get common_offline => 'Sem conexão à internet';

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
