// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'Siraj';

  @override
  String get prayer_title => 'Horarios de Oración';

  @override
  String get prayer_nextPrayer => 'Próxima Oración';

  @override
  String get prayer_fajr => 'Fajr';

  @override
  String get prayer_sunrise => 'Amanecer';

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
    return 'En $time';
  }

  @override
  String get prayer_locationGPS => 'Tu ubicación actual';

  @override
  String get prayer_locationDefault => 'Riad (predeterminado)';

  @override
  String get quran_title => 'El Sagrado Corán';

  @override
  String get quran_meccan => 'Mequense';

  @override
  String get quran_medinan => 'Medinense';

  @override
  String quran_ayahCount(int count) {
    return '$count versículos';
  }

  @override
  String get quran_searchHint => 'Buscar en el Corán...';

  @override
  String get quran_noResults => 'Sin resultados';

  @override
  String get quran_searchPrompt => 'Escribe una palabra para buscar';

  @override
  String get quran_tapForTafsir => 'Mantén presionado un versículo para tafsir';

  @override
  String quran_tafsirTitle(int number) {
    return 'Tafsir del Versículo $number';
  }

  @override
  String get quran_tafsirSource => 'Al-Muyassar';

  @override
  String get quran_tafsirError => 'No se pudo cargar el tafsir';

  @override
  String get quran_reciter => 'Recitador';

  @override
  String get quran_selectReciter => 'Seleccionar Recitador';

  @override
  String get quran_searchReciter => 'Buscar recitador...';

  @override
  String get quran_playPrompt => 'Toca para escuchar';

  @override
  String quran_ayahNumber(int number) {
    return 'Versículo $number';
  }

  @override
  String get athkar_title => 'Athkar';

  @override
  String get athkar_morning => 'Athkar de la Mañana';

  @override
  String get athkar_evening => 'Athkar de la Tarde';

  @override
  String get athkar_sleep => 'Athkar para Dormir';

  @override
  String get athkar_wake => 'Athkar al Despertar';

  @override
  String get athkar_prayer => 'Athkar después de la Oración';

  @override
  String get athkar_general => 'Athkar General';

  @override
  String get athkar_tapToCount => 'Toca para contar';

  @override
  String get athkar_transitioning => 'Avanzando...';

  @override
  String athkar_completed(String name) {
    return '$name completado';
  }

  @override
  String get athkar_next => 'Siguiente';

  @override
  String get athkar_prev => 'Anterior';

  @override
  String get athkar_finish => 'Finalizar';

  @override
  String get athkar_back => 'Atrás';

  @override
  String athkar_source(String source) {
    return 'Narrado por $source';
  }

  @override
  String get hadith_title => 'Hadith';

  @override
  String get hadith_searchHint => 'Buscar hadiths...';

  @override
  String get hadith_noResults => 'Sin resultados';

  @override
  String get hadith_tapForDetail => 'Toca para leer completo';

  @override
  String get hadith_retryButton => 'Reintentar';

  @override
  String get hadith_loadError => 'Error al cargar';

  @override
  String get qibla_title => 'Dirección de la Qibla';

  @override
  String get qibla_active => 'Brújula activa';

  @override
  String get qibla_error => 'No se pudo determinar la dirección de la Qibla';

  @override
  String get qibla_errorHint => 'Activa la brújula y la ubicación';

  @override
  String get qibla_kaaba => 'Kaaba';

  @override
  String get qibla_fromNorth => 'Grados desde el Norte hacia la Qibla';

  @override
  String get stats_title => 'Mis Estadísticas';

  @override
  String get stats_prayerStreak => 'Racha de Oraciones';

  @override
  String get stats_totalPrayers => 'Total de Oraciones';

  @override
  String get stats_quranPages => 'Páginas del Corán';

  @override
  String get stats_athkarSessions => 'Athkar';

  @override
  String get stats_khatma => 'Completaciones del Corán';

  @override
  String get stats_days => 'días consecutivos';

  @override
  String get stats_prayers => 'oraciones';

  @override
  String get stats_pages => 'páginas';

  @override
  String get stats_sessions => 'sesiones';

  @override
  String get stats_khatmaUnit => 'completación';

  @override
  String get stats_currentKhatma => 'Progreso del Khatm Actual';

  @override
  String get more_title => 'Más';

  @override
  String get more_qibla => 'Dirección de la Qibla';

  @override
  String get more_stats => 'Mis Estadísticas';

  @override
  String get common_loading => 'Cargando...';

  @override
  String get common_error => 'Error al cargar datos';

  @override
  String get common_retry => 'Reintentar';

  @override
  String get common_back => 'Atrás';

  @override
  String get common_next => 'Siguiente';

  @override
  String get common_save => 'Guardar';

  @override
  String get common_cancel => 'Cancelar';

  @override
  String get common_done => 'Listo';

  @override
  String get common_search => 'Buscar';

  @override
  String get common_noData => 'Sin datos';

  @override
  String get common_offline => 'Sin conexión a internet';
}
