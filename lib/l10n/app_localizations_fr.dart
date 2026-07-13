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
    return 'Sourate #$id';
  }

  @override
  String home_ayah(int number) {
    return 'Verset $number';
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
  String get radio_title => 'Radio Siraj';

  @override
  String get radio_all => 'Tout';

  @override
  String get radio_quran => 'Coran';

  @override
  String get radio_translations => 'Traductions';

  @override
  String get radio_tafsir => 'Tafsir et Fatwa';

  @override
  String get radio_athkar => 'Adhkar';

  @override
  String get radio_international => 'International';

  @override
  String get cal_title => 'Calendrier islamique';

  @override
  String get cal_todayEvents => 'Événements du jour';

  @override
  String get cal_nextEvent => 'Prochain événement';

  @override
  String get cal_allEvents => 'Événements islamiques';

  @override
  String cal_daysUntil(int days) {
    return '$days jours';
  }

  @override
  String get cal_gregorian => 'Grégorien';

  @override
  String get cal_hijri => 'Hégirien';

  @override
  String get hm_1 => 'Mouharram';

  @override
  String get hm_2 => 'Safar';

  @override
  String get hm_3 => 'Rabi al-Awwal';

  @override
  String get hm_4 => 'Rabi al-Thani';

  @override
  String get hm_5 => 'Joumada al-Oula';

  @override
  String get hm_6 => 'Joumada al-Akhira';

  @override
  String get hm_7 => 'Rajab';

  @override
  String get hm_8 => 'Chaabane';

  @override
  String get hm_9 => 'Ramadan';

  @override
  String get hm_10 => 'Chawwal';

  @override
  String get hm_11 => 'Dhou al-Qida';

  @override
  String get hm_12 => 'Dhou al-Hijja';

  @override
  String get ev_new_year => 'Nouvel An islamique';

  @override
  String get ev_ashura => 'Jour de l\'Achoura';

  @override
  String get ev_mawlid => 'Mawlid an-Nabiﷺ';

  @override
  String get ev_isra => 'Isra et Miraj';

  @override
  String get ev_ramadan_start => 'Début du Ramadan';

  @override
  String get ev_laylat_qadr => 'Laylat al-Qadr';

  @override
  String get ev_eid_fitr => 'Aïd al-Fitr';

  @override
  String get ev_arafah => 'Jour d\'Arafat';

  @override
  String get ev_eid_adha => 'Aïd al-Adha';

  @override
  String get ev_tashreeq => 'Jours de Tachriq';

  @override
  String get stories_title => 'Récits et Sîra';

  @override
  String get stories_prophets => 'Prophètes';

  @override
  String get stories_companions => 'Compagnons';

  @override
  String get stories_scholars => 'Savants';

  @override
  String get stories_comingSoon => 'Bientôt';

  @override
  String get stories_comingSoonMsg => 'Bientôt disponible — contenu en cours';

  @override
  String get children_title => 'Histoires pour enfants';

  @override
  String get settings_secIdentity => 'Identité';

  @override
  String get settings_secAdhan => 'Adhan';

  @override
  String get settings_secApp => 'Application';

  @override
  String get settings_secPrivacy => 'Confidentialité';

  @override
  String get settings_secAbout => 'À propos';

  @override
  String get settings_language => 'Langue';

  @override
  String get settings_chooseLanguage => 'Choisir la langue';

  @override
  String get settings_madhab => 'Madhhab';

  @override
  String get settings_chooseMadhab => 'Choisir le madhhab';

  @override
  String get settings_calcMethod => 'Méthode de calcul des prières';

  @override
  String get settings_chooseCalc => 'Méthode de calcul';

  @override
  String get settings_enableAdhan => 'Activer l\'Adhan';

  @override
  String get settings_muezzinVoice => 'Voix du muezzin';

  @override
  String get settings_vibration => 'Vibrer au lieu du son';

  @override
  String get settings_iqamaAlert => 'Alerte avant l\'Iqama';

  @override
  String settings_minutes(int n) {
    return '$n min';
  }

  @override
  String get settings_appMode => 'Mode de l\'application';

  @override
  String get settings_fullMode => 'Mode complet';

  @override
  String get settings_liteMode => 'Mode léger';

  @override
  String get settings_fullModeDesc => 'Toutes les fonctionnalités disponibles';

  @override
  String get settings_liteModeDesc => 'Essentiel uniquement — hors ligne';

  @override
  String get settings_quranFont => 'Police du Coran';

  @override
  String get settings_fontUthmani => 'Uthmani';

  @override
  String get settings_fontHafs => 'Hafs';

  @override
  String get settings_quranFontSize => 'Taille de police du Coran';

  @override
  String get settings_privacyNote =>
      'Votre position reste uniquement sur votre appareil';

  @override
  String get settings_clearCache => 'Effacer les données du cache';

  @override
  String get settings_clearCacheTitle => 'Effacer le cache';

  @override
  String get settings_clearCacheMsg =>
      'Les données enregistrées localement seront supprimées. Êtes-vous sûr ?';

  @override
  String get settings_cancel => 'Annuler';

  @override
  String get settings_delete => 'Supprimer';

  @override
  String get settings_version => 'Version';

  @override
  String get settings_shareApp => 'Partager l\'application';

  @override
  String get settings_tagline => 'Siraj — Lumière sur Lumière';

  @override
  String get madhab_hanafi => 'Hanafite';

  @override
  String get madhab_maliki => 'Malikite';

  @override
  String get madhab_shafi => 'Chaféite';

  @override
  String get madhab_hanbali => 'Hanbalite';

  @override
  String get calc_MWL => 'Ligue islamique mondiale';

  @override
  String get calc_ISNA => 'Amérique du Nord (ISNA)';

  @override
  String get calc_Egypt => 'Autorité égyptienne';

  @override
  String get calc_Makkah => 'Oumm al-Qoura (La Mecque)';

  @override
  String get calc_Kuwait => 'Koweït';

  @override
  String get calc_Qatar => 'Qatar';

  @override
  String get calc_Dubai => 'Dubaï';

  @override
  String get calc_Karachi => 'Karachi';

  @override
  String get calc_Singapore => 'Singapour';

  @override
  String get calc_Turkey => 'Turquie (Diyanet)';

  @override
  String get calc_MoonSighting => 'Comité d\'observation de la lune';

  @override
  String get search_hint => 'Rechercher dans le Coran et le tafsir...';

  @override
  String get search_empty =>
      'Recherchez dans le Saint Coran, le tafsir et le sens des mots';

  @override
  String search_noResults(String query) {
    return 'Aucun résultat pour « $query »';
  }

  @override
  String get search_typeAyah => 'Verset';

  @override
  String get search_typeTafsir => 'Tafsir';

  @override
  String get search_typeWord => 'Mot';

  @override
  String get search_typeHadith => 'Hadith';

  @override
  String get stats_daysStreak => 'jours d\'affilée';

  @override
  String get stats_prayersUnit => 'prières';

  @override
  String get stats_pagesUnit => 'pages';

  @override
  String get stats_athkar => 'Adhkar';

  @override
  String get stats_sessionsUnit => 'séances';

  @override
  String stats_pagesOf(int read, int total) {
    return '$read / $total pages';
  }

  @override
  String get reader_tapToListen => 'Appuyez pour écouter';

  @override
  String reader_ayahNum(int n) {
    return 'Verset $n';
  }

  @override
  String get reader_reciter => 'Récitateur';

  @override
  String get reader_chooseReciter => 'Choisir le récitateur';

  @override
  String get reader_searchReciter => 'Rechercher un récitateur...';

  @override
  String get reader_longPressHint =>
      'Appui long sur un verset pour le portail, le tafsir et le partage';

  @override
  String get reader_versePortal => 'Portail du verset';

  @override
  String get reader_portalSub => 'Tafsir · Mots · Contexte';

  @override
  String get reader_showTafsir => 'Afficher le tafsir';

  @override
  String get reader_shareAyah => 'Partager le verset';

  @override
  String get reader_copyAyah => 'Copier le verset';

  @override
  String get reader_ayahCopied => 'Verset copié';

  @override
  String reader_tafsirOf(int n) {
    return 'Tafsir du verset $n';
  }

  @override
  String get reader_muyassar => 'Al-Muyassar';

  @override
  String get reader_tafsirError => 'Échec du chargement du tafsir';

  @override
  String get reader_shareTitle => 'Noble verset';

  @override
  String reader_shareSubtitle(String surah, int n) {
    return '$surah · Verset $n';
  }

  @override
  String get portal_muyassar => 'Al-Muyassar';

  @override
  String get portal_words => 'Analyse des mots';

  @override
  String get portal_hadiths => 'Hadiths';

  @override
  String get portal_stories => 'Récits et Sîra';

  @override
  String get portal_arabicTafsir => 'Tafsirs arabes';

  @override
  String get portal_foreignTafsir => 'Tafsirs en d\'autres langues';

  @override
  String get portal_asbab => 'Cause de la révélation';

  @override
  String get portal_searchLang => 'Rechercher une langue...';

  @override
  String get portal_error => 'Impossible d\'ouvrir le portail';

  @override
  String get portal_back => 'Retour';

  @override
  String get portal_noTafsir => 'Aucun tafsir disponible';

  @override
  String get portal_loadError => 'Échec du chargement';

  @override
  String get portal_comingSoon => 'Bientôt';

  @override
  String get portal_noHadiths => 'Aucun hadith lié à ce verset pour le moment';

  @override
  String get portal_addingContent => 'Contenu ajouté progressivement';

  @override
  String get more_search => 'Recherche unifiée';

  @override
  String get more_settings => 'Paramètres';

  @override
  String get more_calendar => 'Calendrier islamique';

  @override
  String get more_shareCards => 'Cartes de partage';

  @override
  String get more_fullMode => 'Mode complet';

  @override
  String get more_radio => 'Radio Coran';

  @override
  String get more_mosques => 'Mosquées à proximité';

  @override
  String get athkarcat_error => 'Erreur';

  @override
  String get athkarcat_empty => 'Aucun dhikr';

  @override
  String athkarcat_completed(String name) {
    return '$name terminé';
  }

  @override
  String get athkarcat_back => 'Retour';

  @override
  String get athkarcat_next => 'Suivant';

  @override
  String get athkarcat_finish => 'Terminer';

  @override
  String get athkarcat_prev => 'Précédent';

  @override
  String athkarcat_repeat(int count, String source) {
    return 'Répéter : $count · $source';
  }

  @override
  String athkarcat_narrated(String source) {
    return 'Rapporté par $source';
  }

  @override
  String get athkarcat_moving => 'Passage...';

  @override
  String get athkarcat_tapCount => 'Appuyez pour compter';

  @override
  String get athkar_allSections => 'Toutes les sections';

  @override
  String get gateway_entry_title => 'Découvrir l\'Islam';

  @override
  String get gateway_intro_title => 'Un voyage de conscience spirituelle';

  @override
  String get gateway_journey_title => 'Le voyage';

  @override
  String get gateway_principles_title => 'Principes de l\'Islam';

  @override
  String get gateway_library_title => 'Bibliothèque';

  @override
  String get gateway_begin => 'Commencer le voyage';

  @override
  String get gateway_next => 'Suivant';

  @override
  String get gateway_prev => 'Retour';

  @override
  String get app_tagline => 'Votre Guide Islamique';

  @override
  String get app_brand_name => 'SIRAJ';

  @override
  String get gateway_shahada_cta => 'Déclare Ta Foi Maintenant';

  @override
  String get nav_library => 'Bibliothèque';

  @override
  String get library_could_not_load => 'Impossible de charger';

  @override
  String get library_section_not_found => 'Section introuvable';

  @override
  String get library_content_title => 'Contenu';

  @override
  String get library_search_in_category => 'Rechercher dans cette catégorie...';

  @override
  String get library_no_matching_results => 'Aucun résultat correspondant';

  @override
  String get library_no_materials_lang =>
      'Aucun contenu disponible dans cette langue pour l\'instant';

  @override
  String get library_connection_failed =>
      'Échec de la connexion. Vérifiez votre internet et réessayez';

  @override
  String get library_search_content_type => 'Rechercher un type de contenu...';

  @override
  String get library_choose_content_type => 'Choisissez un type de contenu';

  @override
  String get library_no_content_lang =>
      'Aucun contenu disponible dans cette langue pour l\'instant';

  @override
  String get library_not_found => 'Introuvable';

  @override
  String get library_search_in_section => 'Rechercher dans cette section...';

  @override
  String get library_no_categories =>
      'Aucune catégorie disponible pour l\'instant';

  @override
  String get library_type_books => 'Livres';

  @override
  String get library_type_audios => 'Audio';

  @override
  String get library_type_videos => 'Vidéo';

  @override
  String get library_type_articles => 'Articles';

  @override
  String get adhan_makkah => 'La Mecque (Grande Mosquée)';

  @override
  String get adhan_madinah => 'Médine (Mosquée du Prophète)';

  @override
  String get adhan_mustafa_ismail => 'Mustafa Ismail';

  @override
  String get adhan_iraqi => 'Irakien';

  @override
  String get adhan_turkish => 'Turc';

  @override
  String get adhan_moroccan => 'Marocain';

  @override
  String get adhan_indonesian => 'Indonésien';

  @override
  String get adhan_classic => 'Classique';

  @override
  String prayer_notification_title(Object prayer) {
    return 'C\'est l\'heure de $prayer';
  }

  @override
  String get prayer_notification_body => 'Allahu Akbar, venez à la prière';

  @override
  String get khatmah_title => 'Khatmas';

  @override
  String get khatmah_new => 'Nouvelle Khatma';

  @override
  String get khatmah_empty => 'Aucune khatma. Commencez la première !';

  @override
  String get khatmah_name => 'Nom de la khatma';

  @override
  String get khatmah_duration_days => 'Durée (jours)';

  @override
  String get khatmah_daily_pages => 'Portion quotidienne (pages)';

  @override
  String get khatmah_reminder_time => 'Heure de rappel';

  @override
  String get khatmah_create => 'Créer la khatma';

  @override
  String get khatmah_preset_ramadan => 'Ramadan (30 jours)';

  @override
  String get khatmah_preset_weekly => 'Hebdomadaire (7 jours)';

  @override
  String get khatmah_preset_monthly => 'Mensuelle (30 jours)';

  @override
  String get khatmah_status_ontrack => 'Dans les temps';

  @override
  String get khatmah_status_behind => 'En retard';

  @override
  String get khatmah_status_ahead => 'En avance';

  @override
  String get khatmah_status_completed => 'Terminée';

  @override
  String get khatmah_today_portion => 'Portion du jour';

  @override
  String get khatmah_read_now => 'Lire maintenant';

  @override
  String get khatmah_page => 'Page';

  @override
  String khatmah_day_of(Object current, Object total) {
    return 'Jour $current sur $total';
  }

  @override
  String get khatmah_delete_confirm => 'Supprimer cette khatma ?';

  @override
  String get khatmah_progress => 'Progression';

  @override
  String khatmah_share_text(Object day, Object name, Object percent) {
    return 'Je suis au jour $day de ma Khatmah $name, $percent% terminé. Qu\'Allah fasse de nous les gens du Coran 🤲';
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
