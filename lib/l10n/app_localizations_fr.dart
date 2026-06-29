// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Siraj';

  @override
  String get prayer_title => 'Horaires de Prière';

  @override
  String get prayer_nextPrayer => 'Prochaine Prière';

  @override
  String get prayer_fajr => 'Fajr';

  @override
  String get prayer_sunrise => 'Lever du Soleil';

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
    return 'Dans $time';
  }

  @override
  String get prayer_locationGPS => 'Votre position actuelle';

  @override
  String get prayer_locationDefault => 'Riyad (par défaut)';

  @override
  String get quran_title => 'Le Saint Coran';

  @override
  String get quran_meccan => 'Mecquoise';

  @override
  String get quran_medinan => 'Médinoise';

  @override
  String quran_ayahCount(int count) {
    return '$count versets';
  }

  @override
  String get quran_searchHint => 'Rechercher dans le Coran...';

  @override
  String get quran_noResults => 'Aucun résultat';

  @override
  String get quran_searchPrompt => 'Tapez un mot pour rechercher';

  @override
  String get quran_tapForTafsir => 'Appui long sur un verset pour le tafsir';

  @override
  String quran_tafsirTitle(int number) {
    return 'Tafsir du Verset $number';
  }

  @override
  String get quran_tafsirSource => 'Al-Muyassar';

  @override
  String get quran_tafsirError => 'Impossible de charger le tafsir';

  @override
  String get quran_reciter => 'Récitant';

  @override
  String get quran_selectReciter => 'Choisir un Récitant';

  @override
  String get quran_searchReciter => 'Rechercher un récitant...';

  @override
  String get quran_playPrompt => 'Appuyer pour écouter';

  @override
  String quran_ayahNumber(int number) {
    return 'Verset $number';
  }

  @override
  String get athkar_title => 'Athkar';

  @override
  String get athkar_morning => 'Athkar du Matin';

  @override
  String get athkar_evening => 'Athkar du Soir';

  @override
  String get athkar_sleep => 'Athkar du Coucher';

  @override
  String get athkar_wake => 'Athkar du Réveil';

  @override
  String get athkar_prayer => 'Athkar Après la Prière';

  @override
  String get athkar_general => 'Athkar Généraux';

  @override
  String get athkar_tapToCount => 'Appuyer pour compter';

  @override
  String get athkar_transitioning => 'Transition...';

  @override
  String athkar_completed(String name) {
    return '$name terminé';
  }

  @override
  String get athkar_next => 'Suivant';

  @override
  String get athkar_prev => 'Précédent';

  @override
  String get athkar_finish => 'Terminer';

  @override
  String get athkar_back => 'Retour';

  @override
  String athkar_source(String source) {
    return 'Rapporté par $source';
  }

  @override
  String get hadith_title => 'Hadith';

  @override
  String get hadith_searchHint => 'Rechercher des hadiths...';

  @override
  String get hadith_noResults => 'Aucun résultat';

  @override
  String get hadith_tapForDetail => 'Appuyer pour lire le hadith complet';

  @override
  String get hadith_retryButton => 'Réessayer';

  @override
  String get hadith_loadError => 'Échec du chargement';

  @override
  String get qibla_title => 'Direction de la Qibla';

  @override
  String get qibla_active => 'Boussole active';

  @override
  String get qibla_error => 'Impossible de déterminer la direction de la Qibla';

  @override
  String get qibla_errorHint => 'Activez la boussole et la localisation';

  @override
  String get qibla_kaaba => 'Kaaba';

  @override
  String get qibla_fromNorth => 'Degrés du Nord vers la Qibla';

  @override
  String get stats_title => 'Mes Statistiques';

  @override
  String get stats_prayerStreak => 'Série de Prières';

  @override
  String get stats_totalPrayers => 'Total des Prières';

  @override
  String get stats_quranPages => 'Pages du Coran';

  @override
  String get stats_athkarSessions => 'Athkar';

  @override
  String get stats_khatma => 'Khatm du Coran';

  @override
  String get stats_days => 'jours consécutifs';

  @override
  String get stats_prayers => 'prières';

  @override
  String get stats_pages => 'pages';

  @override
  String get stats_sessions => 'séances';

  @override
  String get stats_khatmaUnit => 'khatm';

  @override
  String get stats_currentKhatma => 'Progression du Khatm Actuel';

  @override
  String get more_title => 'Plus';

  @override
  String get more_qibla => 'Direction de la Qibla';

  @override
  String get more_stats => 'Mes Statistiques';

  @override
  String get common_loading => 'Chargement...';

  @override
  String get common_error => 'Erreur de chargement';

  @override
  String get common_retry => 'Réessayer';

  @override
  String get common_back => 'Retour';

  @override
  String get common_next => 'Suivant';

  @override
  String get common_save => 'Enregistrer';

  @override
  String get common_cancel => 'Annuler';

  @override
  String get common_done => 'Terminé';

  @override
  String get common_search => 'Rechercher';

  @override
  String get common_noData => 'Aucune donnée';

  @override
  String get common_offline => 'Pas de connexion internet';

  @override
  String get nav_home => 'Accueil';

  @override
  String get nav_quran => 'Coran';

  @override
  String get nav_athkar => 'Athkar';

  @override
  String get nav_hadith => 'Hadith';

  @override
  String get nav_more => 'Plus';

  @override
  String get home_greetingNight => 'Nuit bénie,';

  @override
  String get home_greetingFajr => 'Paix sur l\'aube,';

  @override
  String get home_greetingMorning => 'Bonjour,';

  @override
  String get home_greetingNoon => 'Bon après-midi,';

  @override
  String get home_greetingAsr => 'Après-midi béni,';

  @override
  String get home_greetingEvening => 'Bonsoir,';

  @override
  String get home_greetingLateNight => 'Nuit paisible,';

  @override
  String get home_welcome => 'Bienvenue';

  @override
  String get home_nextPrayer => 'Prochaine Prière';

  @override
  String get home_qiblaDirection => 'Direction de la Qibla';

  @override
  String get home_continueReading => 'CONTINUER LA LECTURE';

  @override
  String home_surah(int id) {
    return 'سورة #$id';
  }

  @override
  String home_ayah(int number) {
    return 'آية $number';
  }

  @override
  String get home_dailyAyah => 'Verset du Jour';

  @override
  String get home_quickAccess => 'Accès Rapide';

  @override
  String get home_searchHint => 'Que cherchez-vous...';

  @override
  String get home_radio => 'Radio';

  @override
  String get home_calendar => 'Calendrier';

  @override
  String get home_stories => 'Histoires';

  @override
  String get home_children => 'Enfants';

  @override
  String get settings_title => 'Paramètres';

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

  @override
  String get search_hint => 'ابحث في القرآن والتفاسير...';

  @override
  String get search_empty => 'ابحث في القرآن الكريم والتفاسير ومعاني الكلمات';

  @override
  String search_noResults(String query) {
    return 'لا نتائج لـ \"$query\"';
  }

  @override
  String get search_typeAyah => 'آية';

  @override
  String get search_typeTafsir => 'تفسير';

  @override
  String get search_typeWord => 'كلمة';

  @override
  String get search_typeHadith => 'حديث';
}
