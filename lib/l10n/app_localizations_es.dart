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
  String get prayer_maghrib => 'Magrib';

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

  @override
  String get nav_home => 'Inicio';

  @override
  String get nav_quran => 'Corán';

  @override
  String get nav_athkar => 'Adhkar';

  @override
  String get nav_hadith => 'Hadiz';

  @override
  String get nav_more => 'Más';

  @override
  String get home_greetingNight => 'Buenas noches';

  @override
  String get home_greetingFajr => 'Hora del Fayr';

  @override
  String get home_greetingMorning => 'Buenos días';

  @override
  String get home_greetingNoon => 'Buenas tardes';

  @override
  String get home_greetingAsr => 'Tarde';

  @override
  String get home_greetingEvening => 'Buenas noches';

  @override
  String get home_greetingLateNight => 'Noche profunda';

  @override
  String get home_welcome => 'Bienvenido';

  @override
  String get home_nextPrayer => 'Próxima oración';

  @override
  String get home_qiblaDirection => 'Dirección de la Quibla';

  @override
  String get home_continueReading => 'Continuar leyendo';

  @override
  String home_surah(int id) {
    return 'Sura #$id';
  }

  @override
  String home_ayah(int number) {
    return 'Versículo $number';
  }

  @override
  String get home_dailyAyah => 'Versículo del día';

  @override
  String get home_quickAccess => 'Acceso rápido';

  @override
  String get home_searchHint => 'Buscar...';

  @override
  String get home_radio => 'Radio';

  @override
  String get home_calendar => 'Calendario';

  @override
  String get home_stories => 'Historias';

  @override
  String get home_children => 'Niños';

  @override
  String get settings_title => 'Ajustes';

  @override
  String get radio_title => 'Radio Siraj';

  @override
  String get radio_all => 'Todo';

  @override
  String get radio_quran => 'Corán';

  @override
  String get radio_translations => 'Traducciones';

  @override
  String get radio_tafsir => 'Tafsir y Fatua';

  @override
  String get radio_athkar => 'Adhkar';

  @override
  String get radio_international => 'Internacional';

  @override
  String get cal_title => 'Calendario islámico';

  @override
  String get cal_todayEvents => 'Eventos de hoy';

  @override
  String get cal_nextEvent => 'Próximo evento';

  @override
  String get cal_allEvents => 'Eventos islámicos';

  @override
  String cal_daysUntil(int days) {
    return '$days días';
  }

  @override
  String get cal_gregorian => 'Gregoriano';

  @override
  String get cal_hijri => 'Hégira';

  @override
  String get hm_1 => 'Muharram';

  @override
  String get hm_2 => 'Safar';

  @override
  String get hm_3 => 'Rabi al-Awwal';

  @override
  String get hm_4 => 'Rabi al-Thani';

  @override
  String get hm_5 => 'Yumada al-Ula';

  @override
  String get hm_6 => 'Yumada al-Ajira';

  @override
  String get hm_7 => 'Rayab';

  @override
  String get hm_8 => 'Shaban';

  @override
  String get hm_9 => 'Ramadán';

  @override
  String get hm_10 => 'Shawwal';

  @override
  String get hm_11 => 'Dhu al-Qida';

  @override
  String get hm_12 => 'Dhu al-Hiyya';

  @override
  String get ev_new_year => 'Año Nuevo islámico';

  @override
  String get ev_ashura => 'Día de Ashura';

  @override
  String get ev_mawlid => 'Mawlid an-Nabiﷺ';

  @override
  String get ev_isra => 'Isra y Miraj';

  @override
  String get ev_ramadan_start => 'Inicio del Ramadán';

  @override
  String get ev_laylat_qadr => 'Laylat al-Qadr';

  @override
  String get ev_eid_fitr => 'Eid al-Fitr';

  @override
  String get ev_arafah => 'Día de Arafat';

  @override
  String get ev_eid_adha => 'Eid al-Adha';

  @override
  String get ev_tashreeq => 'Días de Tashriq';

  @override
  String get stories_title => 'Historias y Sira';

  @override
  String get stories_prophets => 'Profetas';

  @override
  String get stories_companions => 'Compañeros';

  @override
  String get stories_scholars => 'Sabios';

  @override
  String get stories_comingSoon => 'Pronto';

  @override
  String get stories_comingSoonMsg => 'Próximamente — contenido en preparación';

  @override
  String get children_title => 'Historias para niños';

  @override
  String get settings_secIdentity => 'Identidad';

  @override
  String get settings_secAdhan => 'Adhan';

  @override
  String get settings_secApp => 'Aplicación';

  @override
  String get settings_secPrivacy => 'Privacidad';

  @override
  String get settings_secAbout => 'Acerca de';

  @override
  String get settings_language => 'Idioma';

  @override
  String get settings_chooseLanguage => 'Elegir idioma';

  @override
  String get settings_madhab => 'Madhab';

  @override
  String get settings_chooseMadhab => 'Elegir madhab';

  @override
  String get settings_calcMethod => 'Método de cálculo de oraciones';

  @override
  String get settings_chooseCalc => 'Método de cálculo';

  @override
  String get settings_enableAdhan => 'Activar Adhan';

  @override
  String get settings_muezzinVoice => 'Voz del almuédano';

  @override
  String get settings_vibration => 'Vibrar en lugar de sonido';

  @override
  String get settings_iqamaAlert => 'Aviso antes del Iqama';

  @override
  String settings_minutes(int n) {
    return '$n min';
  }

  @override
  String get settings_appMode => 'Modo de la aplicación';

  @override
  String get settings_fullMode => 'Modo completo';

  @override
  String get settings_liteMode => 'Modo ligero';

  @override
  String get settings_fullModeDesc => 'Todas las funciones disponibles';

  @override
  String get settings_liteModeDesc => 'Solo lo esencial — sin conexión';

  @override
  String get settings_quranFont => 'Fuente del Corán';

  @override
  String get settings_fontUthmani => 'Uthmani';

  @override
  String get settings_fontHafs => 'Hafs';

  @override
  String get settings_quranFontSize => 'Tamaño de fuente del Corán';

  @override
  String get settings_privacyNote =>
      'Tu ubicación permanece solo en tu dispositivo';

  @override
  String get settings_clearCache => 'Borrar datos de caché';

  @override
  String get settings_clearCacheTitle => 'Borrar caché';

  @override
  String get settings_clearCacheMsg =>
      'Los datos guardados localmente se eliminarán. ¿Estás seguro?';

  @override
  String get settings_cancel => 'Cancelar';

  @override
  String get settings_delete => 'Eliminar';

  @override
  String get settings_version => 'Versión';

  @override
  String get settings_shareApp => 'Compartir aplicación';

  @override
  String get settings_tagline => 'Siraj — Luz sobre Luz';

  @override
  String get madhab_hanafi => 'Hanafí';

  @override
  String get madhab_maliki => 'Malikí';

  @override
  String get madhab_shafi => 'Shafií';

  @override
  String get madhab_hanbali => 'Hanbalí';

  @override
  String get calc_MWL => 'Liga Mundial Musulmana';

  @override
  String get calc_ISNA => 'Norteamérica (ISNA)';

  @override
  String get calc_Egypt => 'Autoridad Egipcia';

  @override
  String get calc_Makkah => 'Umm al-Qura (La Meca)';

  @override
  String get calc_Kuwait => 'Kuwait';

  @override
  String get calc_Qatar => 'Catar';

  @override
  String get calc_Dubai => 'Dubái';

  @override
  String get calc_Karachi => 'Karachi';

  @override
  String get calc_Singapore => 'Singapur';

  @override
  String get calc_Turkey => 'Turquía (Diyanet)';

  @override
  String get calc_MoonSighting => 'Comité de Avistamiento Lunar';

  @override
  String get search_hint => 'Buscar en el Corán y tafsir...';

  @override
  String get search_empty =>
      'Busca en el Sagrado Corán, tafsir y significados de palabras';

  @override
  String search_noResults(String query) {
    return 'Sin resultados para \"$query\"';
  }

  @override
  String get search_typeAyah => 'Versículo';

  @override
  String get search_typeTafsir => 'Tafsir';

  @override
  String get search_typeWord => 'Palabra';

  @override
  String get search_typeHadith => 'Hadiz';

  @override
  String get stats_daysStreak => 'días seguidos';

  @override
  String get stats_prayersUnit => 'oraciones';

  @override
  String get stats_pagesUnit => 'páginas';

  @override
  String get stats_athkar => 'Adhkar';

  @override
  String get stats_sessionsUnit => 'sesiones';

  @override
  String stats_pagesOf(int read, int total) {
    return '$read / $total páginas';
  }

  @override
  String get reader_tapToListen => 'Toca para escuchar';

  @override
  String reader_ayahNum(int n) {
    return 'Versículo $n';
  }

  @override
  String get reader_reciter => 'Recitador';

  @override
  String get reader_chooseReciter => 'Elegir recitador';

  @override
  String get reader_searchReciter => 'Buscar recitador...';

  @override
  String get reader_longPressHint =>
      'Mantén pulsado cualquier versículo para el portal, tafsir y compartir';

  @override
  String get reader_versePortal => 'Portal del versículo';

  @override
  String get reader_portalSub => 'Tafsir · Palabras · Contexto';

  @override
  String get reader_showTafsir => 'Mostrar tafsir';

  @override
  String get reader_shareAyah => 'Compartir versículo';

  @override
  String get reader_copyAyah => 'Copiar versículo';

  @override
  String get reader_ayahCopied => 'Versículo copiado';

  @override
  String reader_tafsirOf(int n) {
    return 'Tafsir del versículo $n';
  }

  @override
  String get reader_muyassar => 'Al-Muyassar';

  @override
  String get reader_tafsirError => 'Error al cargar el tafsir';

  @override
  String get reader_shareTitle => 'Noble versículo';

  @override
  String reader_shareSubtitle(String surah, int n) {
    return '$surah · Versículo $n';
  }

  @override
  String get portal_muyassar => 'Al-Muyassar';

  @override
  String get portal_words => 'Análisis de palabras';

  @override
  String get portal_hadiths => 'Hadices';

  @override
  String get portal_stories => 'Historias y Sira';

  @override
  String get portal_arabicTafsir => 'Tafsir árabe';

  @override
  String get portal_foreignTafsir => 'Tafsir en otros idiomas';

  @override
  String get portal_asbab => 'Causa de la revelación';

  @override
  String get portal_searchLang => 'Buscar idioma...';

  @override
  String get portal_error => 'No se pudo abrir el portal';

  @override
  String get portal_back => 'Volver';

  @override
  String get portal_noTafsir => 'No hay tafsir disponible';

  @override
  String get portal_loadError => 'Error al cargar';

  @override
  String get portal_comingSoon => 'Pronto';

  @override
  String get portal_noHadiths =>
      'Aún no hay hadices vinculados a este versículo';

  @override
  String get portal_addingContent => 'El contenido se añade gradualmente';

  @override
  String get more_search => 'Búsqueda unificada';

  @override
  String get more_settings => 'Ajustes';

  @override
  String get more_calendar => 'Calendario islámico';

  @override
  String get more_shareCards => 'Tarjetas para compartir';

  @override
  String get more_fullMode => 'Modo completo';

  @override
  String get more_radio => 'Radio del Corán';

  @override
  String get more_mosques => 'Mezquitas cercanas';

  @override
  String get athkarcat_error => 'Error';

  @override
  String get athkarcat_empty => 'No hay adhkar';

  @override
  String athkarcat_completed(String name) {
    return '$name completado';
  }

  @override
  String get athkarcat_back => 'Volver';

  @override
  String get athkarcat_next => 'Siguiente';

  @override
  String get athkarcat_finish => 'Finalizar';

  @override
  String get athkarcat_prev => 'Anterior';

  @override
  String athkarcat_repeat(int count, String source) {
    return 'Repetir: $count · $source';
  }

  @override
  String athkarcat_narrated(String source) {
    return 'Narrado por $source';
  }

  @override
  String get athkarcat_moving => 'Avanzando...';

  @override
  String get athkarcat_tapCount => 'Toca para contar';

  @override
  String get athkar_allSections => 'Todas las secciones';

  @override
  String get gateway_entry_title => 'Descubre el Islam';

  @override
  String get gateway_intro_title => 'Un viaje de conciencia espiritual';

  @override
  String get gateway_journey_title => 'El viaje';

  @override
  String get gateway_principles_title => 'Principios del Islam';

  @override
  String get gateway_library_title => 'Biblioteca';

  @override
  String get gateway_begin => 'Comenzar el viaje';

  @override
  String get gateway_next => 'Siguiente';

  @override
  String get gateway_prev => 'Atrás';

  @override
  String get app_tagline => 'Tu Guía Islámica';

  @override
  String get app_brand_name => 'SIRAJ';

  @override
  String get gateway_shahada_cta => 'Declara Tu Fe Ahora';

  @override
  String get nav_library => 'Biblioteca';

  @override
  String get library_could_not_load => 'No se pudo cargar';

  @override
  String get library_section_not_found => 'Sección no encontrada';

  @override
  String get library_content_title => 'Contenido';

  @override
  String get library_search_in_category => 'Buscar en esta categoría...';

  @override
  String get library_no_matching_results => 'No hay resultados coincidentes';

  @override
  String get library_no_materials_lang =>
      'Aún no hay materiales disponibles en este idioma';

  @override
  String get library_connection_failed =>
      'Falló la conexión. Verifica tu internet e inténtalo de nuevo';

  @override
  String get library_search_content_type => 'Buscar tipo de contenido...';

  @override
  String get library_choose_content_type => 'Elige el tipo de contenido';

  @override
  String get library_no_content_lang =>
      'Aún no hay contenido disponible en este idioma';

  @override
  String get library_not_found => 'No encontrado';

  @override
  String get library_search_in_section => 'Buscar en esta sección...';

  @override
  String get library_no_categories => 'Aún no hay categorías disponibles';

  @override
  String get library_type_books => 'Libros';

  @override
  String get library_type_audios => 'Audio';

  @override
  String get library_type_videos => 'Vídeo';

  @override
  String get library_type_articles => 'Artículos';

  @override
  String get adhan_makkah => 'La Meca (Gran Mezquita)';

  @override
  String get adhan_madinah => 'Medina (Mezquita del Profeta)';

  @override
  String get adhan_mustafa_ismail => 'Mustafa Ismail';

  @override
  String get adhan_iraqi => 'Iraquí';

  @override
  String get adhan_turkish => 'Turco';

  @override
  String get adhan_moroccan => 'Marroquí';

  @override
  String get adhan_indonesian => 'Indonesio';

  @override
  String get adhan_classic => 'Clásico';

  @override
  String prayer_notification_title(Object prayer) {
    return 'Es hora de $prayer';
  }

  @override
  String get prayer_notification_body => 'Allahu Akbar, venid a la oración';

  @override
  String get khatmah_title => 'Jatmas';

  @override
  String get khatmah_new => 'Nueva Jatma';

  @override
  String get khatmah_empty => 'Aún no hay jatmas. ¡Empieza la primera!';

  @override
  String get khatmah_name => 'Nombre de la jatma';

  @override
  String get khatmah_duration_days => 'Duración (días)';

  @override
  String get khatmah_daily_pages => 'Porción diaria (páginas)';

  @override
  String get khatmah_reminder_time => 'Hora de recordatorio';

  @override
  String get khatmah_create => 'Crear jatma';

  @override
  String get khatmah_preset_ramadan => 'Ramadán (30 días)';

  @override
  String get khatmah_preset_weekly => 'Semanal (7 días)';

  @override
  String get khatmah_preset_monthly => 'Mensual (30 días)';

  @override
  String get khatmah_status_ontrack => 'En camino';

  @override
  String get khatmah_status_behind => 'Atrasado';

  @override
  String get khatmah_status_ahead => 'Adelantado';

  @override
  String get khatmah_status_completed => 'Completada';

  @override
  String get khatmah_today_portion => 'Porción de hoy';

  @override
  String get khatmah_read_now => 'Leer ahora';

  @override
  String get khatmah_page => 'Página';

  @override
  String khatmah_day_of(Object current, Object total) {
    return 'Día $current de $total';
  }

  @override
  String get khatmah_delete_confirm => '¿Eliminar esta jatma?';

  @override
  String get khatmah_progress => 'Progreso';

  @override
  String khatmah_share_text(Object day, Object name, Object percent) {
    return 'Estoy en el día $day de mi Khatmah $name, $percent% completado. Que Alá nos haga de la gente del Corán 🤲';
  }

  @override
  String get auth_welcome_title => 'Welcome to Siraj';

  @override
  String get auth_welcome_subtitle =>
      'Sign in to sync your progress across devices, or continue as guest';

  @override
  String get auth_email_hint => 'Your email address';

  @override
  String get auth_send_magic_link => 'Send sign-in link';

  @override
  String get auth_magic_link_sent =>
      'We sent a sign-in link to your email. Check it to complete sign-in';

  @override
  String get auth_or => 'or';

  @override
  String get auth_continue_google => 'Continue with Google';

  @override
  String get auth_continue_apple => 'Continue with Apple';

  @override
  String get auth_continue_guest => 'Continue as guest';

  @override
  String get auth_guest_note =>
      'You can use all Siraj features instantly without signing in';

  @override
  String get auth_invalid_email => 'Please enter a valid email address';

  @override
  String get auth_error_generic => 'Something went wrong. Please try again';

  @override
  String get auth_sign_out => 'Sign out';

  @override
  String get auth_delete_account => 'Delete account';

  @override
  String get auth_delete_account_confirm =>
      'Your account and all its data will be permanently deleted. This cannot be undone.';

  @override
  String get auth_delete_account_success =>
      'Your account has been deleted successfully';

  @override
  String get auth_account_settings => 'Account';

  @override
  String get auth_signed_in_as => 'Signed in as';

  @override
  String get auth_guest_account => 'Guest account';

  @override
  String get sections_customize_title => 'Customize Sections';

  @override
  String get sections_customize_subtitle =>
      'Choose which sections to show. Local data stays saved when disabled';

  @override
  String get sections_full_mode_required =>
      'Enable Full Mode in settings to customize sections';

  @override
  String get sections_full_mode_notice =>
      'You\'re in Full Mode, all app sections are enabled automatically. Customization is only available in Lite Mode';

  @override
  String get section_quran_reader => 'Quran';

  @override
  String get section_adhan => 'Adhan';

  @override
  String get section_prayer => 'Prayer Times';

  @override
  String get section_qibla => 'Qibla';

  @override
  String get section_athkar => 'Athkar';

  @override
  String get section_hadith => 'Hadith';

  @override
  String get section_radio => 'Radio';

  @override
  String get section_hifz => 'Memorization';

  @override
  String get section_khatmah => 'Khatmah';

  @override
  String get section_library => 'Library';

  @override
  String get section_mosques => 'Nearby Mosques';

  @override
  String get section_ruqyah => 'Ruqyah';

  @override
  String get section_dua_journal => 'Dua Journal';

  @override
  String get section_mihrab => 'Mihrab';

  @override
  String get section_qke => 'Verse Portal';

  @override
  String get section_timeline => 'Timeline';

  @override
  String get section_new_muslim => 'New to Islam';

  @override
  String get section_calendar => 'Hijri Calendar';

  @override
  String get section_share_cards => 'Share Cards';

  @override
  String get section_gateway => 'Introduction to Islam';

  @override
  String get section_stories => 'Stories';

  @override
  String get section_children_stories => 'Children\'s Stories';
}
