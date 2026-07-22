// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Siraj';

  @override
  String get prayer_title => 'Gebetszeiten';

  @override
  String get prayer_nextPrayer => 'Nächstes Gebet';

  @override
  String get prayer_fajr => 'Fadschr';

  @override
  String get prayer_sunrise => 'Sonnenaufgang';

  @override
  String get prayer_dhuhr => 'Dhuhr';

  @override
  String get prayer_asr => 'Asr';

  @override
  String get prayer_maghrib => 'Maghrib';

  @override
  String get prayer_isha => 'Ischa';

  @override
  String prayer_countdown(String time) {
    return 'In $time';
  }

  @override
  String get prayer_locationGPS => 'Ihr aktueller Standort';

  @override
  String get prayer_locationDefault => 'Riad (Standard)';

  @override
  String get quran_title => 'Der Heilige Koran';

  @override
  String get quran_meccan => 'Mekkanisch';

  @override
  String get quran_medinan => 'Medinensisch';

  @override
  String quran_ayahCount(int count) {
    return '$count Verse';
  }

  @override
  String get quran_searchHint => 'Im Koran suchen...';

  @override
  String get quran_noResults => 'Keine Ergebnisse';

  @override
  String get quran_searchPrompt => 'Wort eingeben zum Suchen';

  @override
  String get quran_tapForTafsir => 'Vers gedrückt halten für Tafsir';

  @override
  String quran_tafsirTitle(int number) {
    return 'Tafsir von Vers $number';
  }

  @override
  String get quran_tafsirSource => 'Al-Muyassar';

  @override
  String get quran_tafsirError => 'Tafsir konnte nicht geladen werden';

  @override
  String get quran_reciter => 'Rezitator';

  @override
  String get quran_selectReciter => 'Rezitator auswählen';

  @override
  String get quran_searchReciter => 'Rezitator suchen...';

  @override
  String get quran_playPrompt => 'Tippen zum Anhören';

  @override
  String quran_ayahNumber(int number) {
    return 'Vers $number';
  }

  @override
  String get quran_toggleDisplayMode =>
      'Anzeigemodus wechseln (Mushaf/Übersetzung)';

  @override
  String get quran_toggleTajweed => 'Tajwid-Farbmarkierung umschalten';

  @override
  String get athkar_title => 'Athkar';

  @override
  String get athkar_morning => 'Morgen-Athkar';

  @override
  String get athkar_evening => 'Abend-Athkar';

  @override
  String get athkar_sleep => 'Schlaf-Athkar';

  @override
  String get athkar_wake => 'Aufwach-Athkar';

  @override
  String get athkar_prayer => 'Athkar nach dem Gebet';

  @override
  String get athkar_general => 'Allgemeine Athkar';

  @override
  String get athkar_tapToCount => 'Tippen zum Zählen';

  @override
  String get athkar_transitioning => 'Weiter...';

  @override
  String athkar_completed(String name) {
    return '$name abgeschlossen';
  }

  @override
  String get athkar_next => 'Weiter';

  @override
  String get athkar_prev => 'Zurück';

  @override
  String get athkar_finish => 'Beenden';

  @override
  String get athkar_back => 'Zurück';

  @override
  String athkar_source(String source) {
    return 'Überliefert von $source';
  }

  @override
  String get hadith_title => 'Hadith';

  @override
  String get hadith_searchHint => 'Hadithe suchen...';

  @override
  String get hadith_noResults => 'Keine Ergebnisse';

  @override
  String get hadith_tapForDetail => 'Tippen für vollständigen Hadith';

  @override
  String get hadith_retryButton => 'Erneut versuchen';

  @override
  String get hadith_loadError => 'Laden fehlgeschlagen';

  @override
  String get qibla_title => 'Qibla-Richtung';

  @override
  String get qibla_active => 'Kompass aktiv';

  @override
  String get qibla_error => 'Qibla-Richtung konnte nicht bestimmt werden';

  @override
  String get qibla_errorHint => 'Kompass und Standort aktivieren';

  @override
  String get qibla_kaaba => 'Kaaba';

  @override
  String get qibla_fromNorth => 'Grad vom Norden zur Qibla';

  @override
  String qibla_distanceKm(int km, String kaaba) {
    return '$km km bis $kaaba';
  }

  @override
  String get stats_title => 'Meine Statistiken';

  @override
  String get stats_prayerStreak => 'Gebets-Streak';

  @override
  String get stats_totalPrayers => 'Gebete gesamt';

  @override
  String get stats_quranPages => 'Koran-Seiten';

  @override
  String get stats_athkarSessions => 'Athkar';

  @override
  String get stats_khatma => 'Koran-Vollendungen';

  @override
  String get stats_days => 'aufeinanderfolgende Tage';

  @override
  String get stats_prayers => 'Gebete';

  @override
  String get stats_pages => 'Seiten';

  @override
  String get stats_sessions => 'Sitzungen';

  @override
  String get stats_khatmaUnit => 'Vollendung';

  @override
  String get stats_currentKhatma => 'Aktueller Khatm-Fortschritt';

  @override
  String get more_title => 'Mehr';

  @override
  String get more_qibla => 'Qibla-Richtung';

  @override
  String get more_stats => 'Meine Statistiken';

  @override
  String get common_loading => 'Wird geladen...';

  @override
  String get common_error => 'Fehler beim Laden';

  @override
  String get common_retry => 'Erneut versuchen';

  @override
  String get common_back => 'Zurück';

  @override
  String get common_next => 'Weiter';

  @override
  String get common_save => 'Speichern';

  @override
  String get common_cancel => 'Abbrechen';

  @override
  String get common_done => 'Fertig';

  @override
  String get common_search => 'Suchen';

  @override
  String get common_noData => 'Keine Daten';

  @override
  String get common_offline => 'Keine Internetverbindung';

  @override
  String get common_close => 'Schließen';

  @override
  String get common_share => 'Teilen';

  @override
  String get common_refresh => 'Aktualisieren';

  @override
  String get common_prevPage => 'Vorherige Seite';

  @override
  String get common_nextPage => 'Nächste Seite';

  @override
  String get common_clearSearch => 'Suche löschen';

  @override
  String get nav_home => 'Start';

  @override
  String get nav_quran => 'Koran';

  @override
  String get nav_athkar => 'Athkar';

  @override
  String get nav_hadith => 'Hadith';

  @override
  String get nav_more => 'Mehr';

  @override
  String get home_greetingNight => 'Gesegnete Nacht,';

  @override
  String get home_greetingFajr => 'Friede über der Morgendämmerung,';

  @override
  String get home_greetingMorning => 'Guten Morgen,';

  @override
  String get home_greetingNoon => 'Guten Tag,';

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
  String get time_hr => 'Std';

  @override
  String get time_min => 'Min';

  @override
  String get time_sec => 'Sek';

  @override
  String get home_continueReading => 'متابعة القراءة';

  @override
  String home_surah(int id) {
    return 'Sure #$id';
  }

  @override
  String home_ayah(int number) {
    return 'Vers $number';
  }

  @override
  String get home_dailyAyah => 'Vers des Tages';

  @override
  String get home_quickAccess => 'Schnellzugriff';

  @override
  String get home_searchHint => 'Wonach suchst du...';

  @override
  String get home_radio => 'Radio';

  @override
  String get home_calendar => 'Kalender';

  @override
  String get home_stories => 'Geschichten';

  @override
  String get home_children => 'Kinder';

  @override
  String get settings_title => 'Einstellungen';

  @override
  String get radio_title => 'Siraj Radio';

  @override
  String get radio_all => 'Alle';

  @override
  String get radio_quran => 'Koran';

  @override
  String get radio_translations => 'Übersetzungen';

  @override
  String get radio_tafsir => 'Tafsir & Fatwa';

  @override
  String get radio_athkar => 'Adhkar';

  @override
  String get radio_international => 'International';

  @override
  String get radio_play => 'Abspielen';

  @override
  String get radio_pause => 'Pause';

  @override
  String get cal_title => 'Islamischer Kalender';

  @override
  String get cal_todayEvents => 'Heutige Ereignisse';

  @override
  String get cal_nextEvent => 'Nächstes Ereignis';

  @override
  String get cal_allEvents => 'Islamische Ereignisse';

  @override
  String cal_daysUntil(int days) {
    return '$days Tage';
  }

  @override
  String get cal_gregorian => 'Gregorianisch';

  @override
  String get cal_hijri => 'Hidschri';

  @override
  String get cal_prevMonth => 'Vorheriger Monat';

  @override
  String get cal_nextMonth => 'Nächster Monat';

  @override
  String get cal_legendEid => 'Eid';

  @override
  String get cal_legendFast => 'Fasten';

  @override
  String get cal_legendBlessed => 'Gesegnet';

  @override
  String get cal_detailPending =>
      'Für diesen Anlass sind noch keine weiteren Details (Vers/Hadith/Beschreibung) verfügbar - religiöse Prüfung steht aus.';

  @override
  String get hm_1 => 'Muharram';

  @override
  String get hm_2 => 'Safar';

  @override
  String get hm_3 => 'Rabi al-Awwal';

  @override
  String get hm_4 => 'Rabi al-Thani';

  @override
  String get hm_5 => 'Dschumada al-Ula';

  @override
  String get hm_6 => 'Dschumada al-Achira';

  @override
  String get hm_7 => 'Radschab';

  @override
  String get hm_8 => 'Schaban';

  @override
  String get hm_9 => 'Ramadan';

  @override
  String get hm_10 => 'Schawwal';

  @override
  String get hm_11 => 'Dhul-Qida';

  @override
  String get hm_12 => 'Dhul-Hidscha';

  @override
  String get ev_new_year => 'Islamisches Neujahr';

  @override
  String get ev_ashura => 'Aschura-Tag';

  @override
  String get ev_mawlid => 'Mawlid an-Nabiﷺ';

  @override
  String get ev_isra => 'Isra und Miradsch';

  @override
  String get ev_ramadan_start => 'Beginn des Ramadan';

  @override
  String get ev_laylat_qadr => 'Lailat al-Qadr';

  @override
  String get ev_eid_fitr => 'Eid al-Fitr';

  @override
  String get ev_arafah => 'Tag von Arafat';

  @override
  String get ev_eid_adha => 'Eid al-Adha';

  @override
  String get ev_tashreeq => 'Taschrik-Tage';

  @override
  String get stories_title => 'Geschichten & Sira';

  @override
  String get stories_prophets => 'Propheten';

  @override
  String get stories_companions => 'Gefährten';

  @override
  String get stories_scholars => 'Gelehrte';

  @override
  String get stories_comingSoon => 'Bald';

  @override
  String get stories_comingSoonMsg => 'Demnächst — Inhalt wird vorbereitet';

  @override
  String get children_title => 'Kindergeschichten';

  @override
  String get settings_secIdentity => 'Identität';

  @override
  String get onboarding_modeTitle => 'App-Modus wählen';

  @override
  String get onboarding_modeSubtitle =>
      'Du kannst dies später in den Einstellungen ändern';

  @override
  String get onboarding_liteSubtitle =>
      'Das Wesentliche · Schnell · Vollständig offline';

  @override
  String get onboarding_fullSubtitle =>
      'Alle Funktionen · Umfassend · Ausführlich';

  @override
  String get onboarding_andMore => '+ mehr';

  @override
  String get onboarding_madhabTitle => 'Rechtsschule (Madhhab)';

  @override
  String get onboarding_madhabSubtitle =>
      'Für eine genaue Berechnung der Gebetszeiten';

  @override
  String get onboarding_locationTitle => 'Standort festlegen';

  @override
  String get onboarding_locationSubtitle => 'Für genaue Gebetszeiten';

  @override
  String get onboarding_locationBody =>
      'Die App fragt nach dem Standortzugriff,\num die Gebetszeiten automatisch zu bestimmen';

  @override
  String get onboarding_locationPrivacy =>
      'Deine Daten verbleiben nur auf deinem Gerät';

  @override
  String get onboarding_start => 'Starten';

  @override
  String get settings_dirRtl => 'RTL';

  @override
  String get settings_dirLtr => 'LTR';

  @override
  String get settings_secAdhan => 'Adhan';

  @override
  String get settings_secApp => 'App';

  @override
  String get settings_secPrivacy => 'Datenschutz';

  @override
  String get settings_secAbout => 'Über';

  @override
  String get settings_language => 'Sprache';

  @override
  String get settings_chooseLanguage => 'Sprache wählen';

  @override
  String get settings_madhab => 'Madhhab';

  @override
  String get settings_chooseMadhab => 'Madhhab wählen';

  @override
  String get settings_calcMethod => 'Berechnungsmethode der Gebete';

  @override
  String get settings_chooseCalc => 'Berechnungsmethode';

  @override
  String get settings_enableAdhan => 'Adhan aktivieren';

  @override
  String get settings_muezzinVoice => 'Stimme des Muezzins';

  @override
  String get settings_previewAdhan => 'Adhan-Stimme anhören';

  @override
  String get settings_vibration => 'Vibration statt Ton';

  @override
  String get settings_iqamaAlert => 'Hinweis vor dem Iqama';

  @override
  String settings_minutes(int n) {
    return '$n Min.';
  }

  @override
  String get settings_appMode => 'App-Modus';

  @override
  String get settings_fullMode => 'Vollmodus';

  @override
  String get settings_liteMode => 'Lite-Modus';

  @override
  String get settings_fullModeDesc => 'Alle Funktionen verfügbar';

  @override
  String get settings_liteModeDesc => 'Nur das Wesentliche — offline';

  @override
  String get settings_quranFont => 'Koran-Schriftart';

  @override
  String get settings_fontUthmani => 'Uthmani';

  @override
  String get settings_fontHafs => 'Hafs';

  @override
  String get settings_quranFontSize => 'Koran-Schriftgröße';

  @override
  String get settings_privacyNote => 'Ihr Standort bleibt nur auf Ihrem Gerät';

  @override
  String get settings_clearCache => 'Cache-Daten löschen';

  @override
  String get settings_clearCacheTitle => 'Cache löschen';

  @override
  String get settings_clearCacheMsg =>
      'Lokal gespeicherte Daten werden gelöscht. Sind Sie sicher?';

  @override
  String get settings_cancel => 'Abbrechen';

  @override
  String get settings_delete => 'Löschen';

  @override
  String get settings_version => 'Version';

  @override
  String get settings_shareApp => 'App teilen';

  @override
  String get settings_licenses => 'Lizenzen';

  @override
  String get settings_openSourcePackages => 'Lizenzen der Open-Source-Pakete';

  @override
  String get settings_tagline => 'Siraj — Licht über Licht';

  @override
  String get madhab_hanafi => 'Hanafi';

  @override
  String get madhab_maliki => 'Maliki';

  @override
  String get madhab_shafi => 'Schafii';

  @override
  String get madhab_hanbali => 'Hanbali';

  @override
  String get calc_MWL => 'Islamische Weltliga';

  @override
  String get calc_ISNA => 'Nordamerika (ISNA)';

  @override
  String get calc_Egypt => 'Ägyptische Behörde';

  @override
  String get calc_Makkah => 'Umm al-Qura (Mekka)';

  @override
  String get calc_Kuwait => 'Kuwait';

  @override
  String get calc_Qatar => 'Katar';

  @override
  String get calc_Dubai => 'Dubai';

  @override
  String get calc_Karachi => 'Karachi';

  @override
  String get calc_Singapore => 'Singapur';

  @override
  String get calc_Turkey => 'Türkei (Diyanet)';

  @override
  String get calc_MoonSighting => 'Mondsichtungskomitee';

  @override
  String get search_hint => 'Im Koran & Tafsir suchen...';

  @override
  String get search_empty =>
      'Durchsuchen Sie den Heiligen Koran, Tafsir und Wortbedeutungen';

  @override
  String search_noResults(String query) {
    return 'Keine Ergebnisse für \"$query\"';
  }

  @override
  String get search_typeAyah => 'Vers';

  @override
  String get search_typeTafsir => 'Tafsir';

  @override
  String get search_typeWord => 'Wort';

  @override
  String get search_typeHadith => 'Hadith';

  @override
  String get stats_daysStreak => 'Tage in Folge';

  @override
  String get stats_prayersUnit => 'Gebete';

  @override
  String get stats_pagesUnit => 'Seiten';

  @override
  String get stats_athkar => 'Adhkar';

  @override
  String get stats_sessionsUnit => 'Sitzungen';

  @override
  String stats_pagesOf(int read, int total) {
    return '$read / $total Seiten';
  }

  @override
  String get reader_tapToListen => 'Zum Anhören tippen';

  @override
  String reader_ayahNum(int n) {
    return 'Vers $n';
  }

  @override
  String get reader_reciter => 'Rezitator';

  @override
  String get reader_chooseReciter => 'Rezitator wählen';

  @override
  String get reader_searchReciter => 'Rezitator suchen...';

  @override
  String get reader_longPressHint =>
      'Langes Drücken auf einen Vers für Portal, Tafsir & Teilen';

  @override
  String get reader_versePortal => 'Vers-Portal';

  @override
  String get reader_portalSub => 'Tafsir · Wörter · Kontext';

  @override
  String get reader_showTafsir => 'Tafsir anzeigen';

  @override
  String get reader_shareAyah => 'Vers teilen';

  @override
  String get reader_copyAyah => 'Vers kopieren';

  @override
  String get reader_ayahCopied => 'Vers kopiert';

  @override
  String reader_tafsirOf(int n) {
    return 'Tafsir von Vers $n';
  }

  @override
  String get reader_muyassar => 'Al-Muyassar';

  @override
  String get reader_tafsirError => 'Tafsir konnte nicht geladen werden';

  @override
  String get reader_shareTitle => 'Edler Vers';

  @override
  String reader_shareSubtitle(String surah, int n) {
    return '$surah · Vers $n';
  }

  @override
  String get portal_muyassar => 'Al-Muyassar';

  @override
  String get portal_words => 'Wortanalyse';

  @override
  String get portal_hadiths => 'Hadithe';

  @override
  String get portal_adwaaHadiths => 'Adwaa al-Bayan';

  @override
  String get portal_stories => 'Geschichten & Sira';

  @override
  String get portal_arabicTafsir => 'Arabische Tafsire';

  @override
  String get portal_foreignTafsir => 'Tafsire in anderen Sprachen';

  @override
  String get portal_asbab => 'Offenbarungsanlass';

  @override
  String get portal_searchLang => 'Sprache suchen...';

  @override
  String get portal_error => 'Portal konnte nicht geöffnet werden';

  @override
  String get portal_back => 'Zurück';

  @override
  String get portal_noTafsir => 'Kein Tafsir verfügbar';

  @override
  String get portal_loadError => 'Laden fehlgeschlagen';

  @override
  String get portal_reportTranslation => 'Übersetzungsfehler melden';

  @override
  String get portal_reportDialogTitle => 'Übersetzungsfehler melden';

  @override
  String get portal_reportIssueLabel => 'Problem beschreiben';

  @override
  String get portal_reportIssueHint =>
      'z. B. fehlendes Wort, ungenaue Bedeutung...';

  @override
  String get portal_reportNoteLabel => 'Zusätzliche Anmerkung (optional)';

  @override
  String get portal_reportCancel => 'Abbrechen';

  @override
  String get portal_reportSubmit => 'Senden';

  @override
  String get portal_reportSuccess =>
      'Danke, Ihre Meldung ist eingegangen und wird geprüft';

  @override
  String get portal_reportError =>
      'Meldung konnte nicht gesendet werden, bitte später erneut versuchen';

  @override
  String get portal_reportIssueRequired => 'Bitte beschreiben Sie das Problem';

  @override
  String get portal_translationPendingReview =>
      'Wartet auf Überprüfung durch die Community';

  @override
  String get portal_comingSoon => 'Bald';

  @override
  String get portal_noHadiths => 'Noch keine Hadithe mit diesem Vers verknüpft';

  @override
  String get portal_addingContent => 'Inhalt wird schrittweise hinzugefügt';

  @override
  String get more_search => 'Einheitliche Suche';

  @override
  String get more_settings => 'Einstellungen';

  @override
  String get more_calendar => 'Islamischer Kalender';

  @override
  String get more_shareCards => 'Teilen-Karten';

  @override
  String get more_fullMode => 'Vollmodus';

  @override
  String get more_radio => 'Koran-Radio';

  @override
  String get more_mosques => 'Moscheen in der Nähe';

  @override
  String get athkarcat_error => 'Fehler';

  @override
  String get athkarcat_empty => 'Keine Adhkar';

  @override
  String athkarcat_completed(String name) {
    return '$name abgeschlossen';
  }

  @override
  String get athkarcat_back => 'Zurück';

  @override
  String get athkarcat_next => 'Weiter';

  @override
  String get athkarcat_finish => 'Beenden';

  @override
  String get athkarcat_prev => 'Zurück';

  @override
  String athkarcat_repeat(int count, String source) {
    return 'Wiederholung: $count · $source';
  }

  @override
  String athkarcat_narrated(String source) {
    return 'Überliefert von $source';
  }

  @override
  String get athkarcat_moving => 'Weiter...';

  @override
  String get athkarcat_tapCount => 'Zum Zählen tippen';

  @override
  String get athkar_allSections => 'Alle Abschnitte';

  @override
  String get gateway_entry_title => 'Den Islam entdecken';

  @override
  String get gateway_intro_title => 'Eine Reise des spirituellen Bewusstseins';

  @override
  String get gateway_journey_title => 'Die Reise';

  @override
  String get gateway_principles_title => 'Grundsätze des Islam';

  @override
  String get gateway_library_title => 'Bibliothek';

  @override
  String get gateway_begin => 'Die Reise beginnen';

  @override
  String get gateway_next => 'Weiter';

  @override
  String get gateway_prev => 'Zurück';

  @override
  String get app_tagline => 'Dein Islamischer Führer';

  @override
  String get app_brand_name => 'SIRAJ';

  @override
  String get gateway_shahada_cta => 'Erkläre Jetzt Deinen Glauben';

  @override
  String get nav_library => 'Bibliothek';

  @override
  String get library_could_not_load => 'Laden fehlgeschlagen';

  @override
  String get library_section_not_found => 'Abschnitt nicht gefunden';

  @override
  String get library_content_title => 'Inhalt';

  @override
  String get library_search_in_category => 'In dieser Kategorie suchen...';

  @override
  String get library_no_matching_results => 'Keine passenden Ergebnisse';

  @override
  String get library_no_materials_lang =>
      'In dieser Sprache noch keine Materialien verfügbar';

  @override
  String get library_connection_failed =>
      'Verbindung fehlgeschlagen. Überprüfe deine Internetverbindung und versuche es erneut';

  @override
  String get library_search_content_type => 'Inhaltstyp suchen...';

  @override
  String get library_choose_content_type => 'Inhaltstyp auswählen';

  @override
  String get library_no_content_lang =>
      'In dieser Sprache noch kein Inhalt verfügbar';

  @override
  String get library_not_found => 'Nicht gefunden';

  @override
  String get library_search_in_section => 'In diesem Abschnitt suchen...';

  @override
  String get library_no_categories => 'Noch keine Kategorien verfügbar';

  @override
  String get library_type_books => 'Bücher';

  @override
  String get library_type_audios => 'Audio';

  @override
  String get library_type_videos => 'Video';

  @override
  String get library_type_articles => 'Artikel';

  @override
  String get adhan_makkah => 'Mekka (Große Moschee)';

  @override
  String get adhan_madinah => 'Medina (Prophetenmoschee)';

  @override
  String get adhan_mustafa_ismail => 'Mustafa Ismail';

  @override
  String get adhan_iraqi => 'Irakisch';

  @override
  String get adhan_turkish => 'Türkisch';

  @override
  String get adhan_moroccan => 'Marokkanisch';

  @override
  String get adhan_indonesian => 'Indonesisch';

  @override
  String get adhan_classic => 'Klassisch';

  @override
  String prayer_notification_title(Object prayer) {
    return 'Es ist Zeit für $prayer';
  }

  @override
  String get prayer_notification_body => 'Allahu Akbar, kommt zum Gebet';

  @override
  String get iqama_notification_title => 'Iqama-Hinweis';

  @override
  String iqama_notification_body(Object minutes, Object prayer) {
    return 'Iqama in $minutes Minuten — $prayer';
  }

  @override
  String get khatmah_title => 'Khatmas';

  @override
  String get khatmah_new => 'Neue Khatma';

  @override
  String get khatmah_empty => 'Noch keine Khatmas. Beginne deine erste!';

  @override
  String get khatmah_name => 'Name der Khatma';

  @override
  String get khatmah_duration_days => 'Dauer (Tage)';

  @override
  String get khatmah_daily_pages => 'Tagespensum (Seiten)';

  @override
  String get khatmah_reminder_time => 'Erinnerungszeit';

  @override
  String get khatmah_create => 'Khatma erstellen';

  @override
  String get khatmah_preset_ramadan => 'Ramadan (30 Tage)';

  @override
  String get khatmah_preset_weekly => 'Wöchentlich (7 Tage)';

  @override
  String get khatmah_preset_monthly => 'Monatlich (30 Tage)';

  @override
  String get khatmah_status_ontrack => 'Im Plan';

  @override
  String get khatmah_status_behind => 'Im Rückstand';

  @override
  String get khatmah_status_ahead => 'Voraus';

  @override
  String get khatmah_status_completed => 'Abgeschlossen';

  @override
  String get khatmah_today_portion => 'Heutiges Pensum';

  @override
  String get khatmah_read_now => 'Jetzt lesen';

  @override
  String get khatmah_page => 'Seite';

  @override
  String khatmah_day_of(Object current, Object total) {
    return 'Tag $current von $total';
  }

  @override
  String get khatmah_delete_confirm => 'Diese Khatma löschen?';

  @override
  String get khatmah_progress => 'Fortschritt';

  @override
  String khatmah_share_text(Object day, Object name, Object percent) {
    return 'Ich bin an Tag $day meiner $name Khatmah, $percent% abgeschlossen. Möge Allah uns zu den Leuten des Korans machen 🤲';
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
