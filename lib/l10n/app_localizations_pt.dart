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

  @override
  String get stories_title => 'القصص والسير';

  @override
  String get stories_prophets => 'الأنبياء';

  @override
  String get stories_companions => 'الصحابة';

  @override
  String get stories_scholars => 'العلماء';

  @override
  String get stories_comingSoon => 'قريباً';

  @override
  String get stories_comingSoonMsg => 'قريباً — نعمل على إضافة المحتوى';

  @override
  String get children_title => 'قصص الأطفال';

  @override
  String get settings_secIdentity => 'الهوية';

  @override
  String get settings_secAdhan => 'الأذان';

  @override
  String get settings_secApp => 'التطبيق';

  @override
  String get settings_secPrivacy => 'الخصوصية';

  @override
  String get settings_secAbout => 'عن التطبيق';

  @override
  String get settings_language => 'اللغة';

  @override
  String get settings_chooseLanguage => 'اختر اللغة';

  @override
  String get settings_madhab => 'المذهب';

  @override
  String get settings_chooseMadhab => 'اختر المذهب';

  @override
  String get settings_calcMethod => 'طريقة حساب الصلاة';

  @override
  String get settings_chooseCalc => 'طريقة الحساب';

  @override
  String get settings_enableAdhan => 'تفعيل الأذان';

  @override
  String get settings_muezzinVoice => 'صوت المؤذن';

  @override
  String get settings_vibration => 'اهتزاز بدل صوت';

  @override
  String get settings_iqamaAlert => 'تنبيه قبل الإقامة';

  @override
  String settings_minutes(int n) {
    return '$n د';
  }

  @override
  String get settings_appMode => 'وضع التطبيق';

  @override
  String get settings_fullMode => 'الوضع الكامل';

  @override
  String get settings_liteMode => 'الوضع الخفيف';

  @override
  String get settings_fullModeDesc => 'كل الميزات متاحة';

  @override
  String get settings_liteModeDesc => 'الأساسيات فقط — بدون إنترنت';

  @override
  String get settings_quranFont => 'خط القرآن';

  @override
  String get settings_fontUthmani => 'عثماني';

  @override
  String get settings_fontHafs => 'حفص';

  @override
  String get settings_quranFontSize => 'حجم خط القرآن';

  @override
  String get settings_privacyNote => 'موقعك يبقى على جهازك فقط';

  @override
  String get settings_clearCache => 'حذف بيانات الكاش';

  @override
  String get settings_clearCacheTitle => 'حذف الكاش';

  @override
  String get settings_clearCacheMsg =>
      'سيتم حذف البيانات المحفوظة محلياً. هل أنت متأكد؟';

  @override
  String get settings_cancel => 'إلغاء';

  @override
  String get settings_delete => 'حذف';

  @override
  String get settings_version => 'الإصدار';

  @override
  String get settings_shareApp => 'مشاركة التطبيق';

  @override
  String get settings_tagline => 'سراج — نور على نور';

  @override
  String get madhab_hanafi => 'الحنفي';

  @override
  String get madhab_maliki => 'المالكي';

  @override
  String get madhab_shafi => 'الشافعي';

  @override
  String get madhab_hanbali => 'الحنبلي';

  @override
  String get calc_MWL => 'رابطة العالم الإسلامي';

  @override
  String get calc_ISNA => 'أمريكا الشمالية (ISNA)';

  @override
  String get calc_Egypt => 'الهيئة المصرية';

  @override
  String get calc_Makkah => 'أم القرى (مكة)';

  @override
  String get calc_Kuwait => 'الكويت';

  @override
  String get calc_Qatar => 'قطر';

  @override
  String get calc_Dubai => 'دبي';
}
