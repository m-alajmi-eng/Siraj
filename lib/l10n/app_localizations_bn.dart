// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'সিরাজ';

  @override
  String get prayer_title => 'নামাজের সময়';

  @override
  String get prayer_nextPrayer => 'পরবর্তী নামাজ';

  @override
  String get prayer_fajr => 'ফজর';

  @override
  String get prayer_sunrise => 'সূর্যোদয়';

  @override
  String get prayer_dhuhr => 'যোহর';

  @override
  String get prayer_asr => 'আসর';

  @override
  String get prayer_maghrib => 'মাগরিব';

  @override
  String get prayer_isha => 'এশা';

  @override
  String prayer_countdown(String time) {
    return '$time এর মধ্যে';
  }

  @override
  String get prayer_locationGPS => 'আপনার বর্তমান অবস্থান';

  @override
  String get prayer_locationDefault => 'মক্কা (ডিফল্ট)';

  @override
  String get quran_title => 'পবিত্র কুরআন';

  @override
  String get quran_meccan => 'মক';

  @override
  String get quran_medinan => 'মাদানী';

  @override
  String quran_ayahCount(int count) {
    return '$count আয়াত';
  }

  @override
  String get quran_searchHint => 'কুরআনে অনসন্ধান করুন...';

  @override
  String get quran_noResults => 'কোনো ফলাফল নেই';

  @override
  String get quran_searchPrompt => 'অনুসন্ধানের জন্য একটি শব্দ টাইপ করুন';

  @override
  String get quran_tapForTafsir => 'তাফসীরের জন্য আয়াতে দীর্ঘ চপ দিন';

  @override
  String quran_tafsirTitle(int number) {
    return '$number নম্বর আয়াতর তাফসীর';
  }

  @override
  String get quran_tafsirSource => 'আল-মুয়াস্সার';

  @override
  String get quran_tafsirError => 'তাফসীর লড করা যায়নি';

  @override
  String get quran_reciter => 'ক্বরী';

  @override
  String get quran_selectReciter => 'ক্বারী নির্বাচন করুন';

  @override
  String get quran_searchReciter => 'ক্রী অনুসন্ধান করুন...';

  @override
  String get quran_playPrompt => 'শুনতে স্পর্শ করুন';

  @override
  String quran_ayahNumber(int number) {
    return '$number নম্বর আয়াত';
  }

  @override
  String get quran_toggleDisplayMode =>
      'প্রদর্শন মোড পরিবর্তন করুন (মুসহাফ/অনুবাদ)';

  @override
  String get quran_toggleTajweed => 'তাজবিদ রঙ পরিবর্তন করুন';

  @override
  String get athkar_title => 'যিকর';

  @override
  String get athkar_morning => 'সকালের যিকর';

  @override
  String get athkar_evening => 'সন্ধ্যার যিকর';

  @override
  String get athkar_sleep => 'ঘুমের যিকর';

  @override
  String get athkar_wake => 'জাগ্রত হওয়ার যিকর';

  @override
  String get athkar_prayer => 'নামাজ পরবর্তী যিকর';

  @override
  String get athkar_general => 'সাধারণ যিকর';

  @override
  String get athkar_tapToCount => 'গণনার জন্য সর্শ করুন';

  @override
  String get athkar_transitioning => 'পরবর্তীতে যাচ্ছে...';

  @override
  String athkar_completed(String name) {
    return '$name সম্পন্ন';
  }

  @override
  String get athkar_next => 'পরবর্তী';

  @override
  String get athkar_prev => 'পূর্ববর্তী';

  @override
  String get athkar_finish => 'শেষ করুন';

  @override
  String get athkar_back => 'ফিরে যান';

  @override
  String athkar_source(String source) {
    return '$source কর্তৃক বর্ণিত';
  }

  @override
  String get hadith_title => 'হাদীস শরীফ';

  @override
  String get hadith_searchHint => 'হাদীস অনুসন্ধান করুন...';

  @override
  String get hadith_noResults => 'কনো ফলাফল নেই';

  @override
  String get hadith_tapForDetail => 'সম্পূর্ণ হাদীস পড়ত স্পর্শ করুন';

  @override
  String get hadith_retryButton => 'আবার চেষ্টা করুন';

  @override
  String get hadith_loadError => 'লোড করা যায়নি';

  @override
  String get qibla_title => 'কিবলার দিক';

  @override
  String get qibla_active => 'কমস সক্রিয়';

  @override
  String get qibla_error => 'কিবলার দিক নির্ধারণ করা যায়নি';

  @override
  String get qibla_errorHint => 'কম্পাস এবং অবস্থান সক্রিয় করুন';

  @override
  String get qibla_staticMode => 'স্থির মোড (কম্পাস সেন্সর নেই)';

  @override
  String get qibla_calibrationHint =>
      'কম্পাস ক্যালিব্রেট করতে ডিভাইসটি ৮ আকারে নাড়ান';

  @override
  String get qibla_kaaba => 'কাবা';

  @override
  String get qibla_fromNorth => 'উত্তর থেকে কিবলার দিক ডিগ্রি';

  @override
  String qibla_distanceKm(int km, String kaaba) {
    return '$kaaba পর্যন্ত $km কিমি';
  }

  @override
  String get stats_title => 'আমার পরিসখ্যান';

  @override
  String get stats_prayerStreak => 'নামাজের ধারাবাহিকতা';

  @override
  String get stats_totalPrayers => 'মোট নামাজ';

  @override
  String get stats_quranPages => 'কুরআনের পৃষ্ঠা';

  @override
  String get stats_athkarSessions => 'যকর';

  @override
  String get stats_khatma => 'কুরআন খতম';

  @override
  String get stats_days => 'ধারাবাহিক দিন';

  @override
  String get stats_prayers => 'নামাজ';

  @override
  String get stats_pages => 'পৃষ্ঠা';

  @override
  String get stats_sessions => 'সেশন';

  @override
  String get stats_khatmaUnit => 'খতম';

  @override
  String get stats_currentKhatma => 'বর্তমান খতমর অগ্রগতি';

  @override
  String get more_title => 'আরও';

  @override
  String get more_qibla => 'কিবলার দিক';

  @override
  String get more_stats => 'আমর পরিসংখ্যান';

  @override
  String get common_loading => 'লোড হচ্ছে...';

  @override
  String get common_error => 'ডেটা লোড করতে ত্রুটি';

  @override
  String get common_retry => 'আবার চেষ্টা করুন';

  @override
  String get common_back => 'ফিরে যান';

  @override
  String get common_next => 'পরবর্তী';

  @override
  String get common_save => 'সংরক্ষণ করুন';

  @override
  String get common_cancel => 'বাতিল করুন';

  @override
  String get common_done => 'সম্পন্ন';

  @override
  String get common_search => 'অনুসন্ধান';

  @override
  String get common_noData => 'কোনো ডেটা নেই';

  @override
  String get common_offline => 'ইন্টারনেট সংযোগ নেই';

  @override
  String get common_close => 'বন্ধ করুন';

  @override
  String get common_share => 'শেয়ার করুন';

  @override
  String get common_refresh => 'রিফ্রেশ করুন';

  @override
  String get common_prevPage => 'আগের পৃষ্ঠা';

  @override
  String get common_nextPage => 'পরের পৃষ্ঠা';

  @override
  String get common_clearSearch => 'অনুসন্ধান মুছুন';

  @override
  String get nav_home => 'হোম';

  @override
  String get nav_quran => 'কুরআন';

  @override
  String get nav_athkar => 'যকর';

  @override
  String get nav_hadith => 'হাদিস';

  @override
  String get nav_more => 'আরও';

  @override
  String get home_greetingNight => 'বরকতময় রাত,';

  @override
  String get home_greetingFajr => 'ফজরর শান্তি,';

  @override
  String get home_greetingMorning => 'শুভ সকাল,';

  @override
  String get home_greetingNoon => 'শভ দুপুর,';

  @override
  String get home_greetingAsr => 'বরকতময় বিকেল,';

  @override
  String get home_greetingEvening => 'শুভ সন্ধ,';

  @override
  String get home_greetingLateNight => 'শান্তিময় রাত,';

  @override
  String get home_welcome => 'স্বাগতম';

  @override
  String get home_nextPrayer => 'পরবর্তী নামাজ';

  @override
  String get home_qiblaDirection => 'কিবলর দিক';

  @override
  String get time_hr => 'ঘণ্টা';

  @override
  String get time_min => 'মিনিট';

  @override
  String get time_sec => 'সেকেন্ড';

  @override
  String get home_continueReading => 'পড়া চালিয়ে যান';

  @override
  String home_surah(int id) {
    return 'সূরা #$id';
  }

  @override
  String home_ayah(int number) {
    return 'আয়াত $number';
  }

  @override
  String get home_dailyAyah => 'আজকের আয়াত';

  @override
  String get home_quickAccess => 'দ্রুত অ্যাক্সেস';

  @override
  String get home_searchHint => 'আপনি কী খুঁজছেন...';

  @override
  String get home_radio => 'রেডিও';

  @override
  String get home_calendar => 'ক্যালেন্ডার';

  @override
  String get home_stories => 'গল্প';

  @override
  String get home_children => 'শশুরা';

  @override
  String get settings_title => 'সেটিংস';

  @override
  String get radio_title => 'সরাজ রেডিও';

  @override
  String get radio_all => 'সব';

  @override
  String get radio_quran => 'করআন';

  @override
  String get radio_translations => 'অনুবাদ';

  @override
  String get radio_tafsir => 'তফসির ও ফতোয়া';

  @override
  String get radio_athkar => 'যিকর';

  @override
  String get radio_international => 'আন্তর্জাতিক';

  @override
  String get radio_play => 'চালান';

  @override
  String get radio_pause => 'বিরতি';

  @override
  String get cal_title => 'ইসলামি ক্যালেন্ডার';

  @override
  String get cal_todayEvents => 'আজকের ঘটন';

  @override
  String get cal_nextEvent => 'পরবর্তী ঘটনা';

  @override
  String get cal_allEvents => 'ইসলামি দিবস';

  @override
  String cal_daysUntil(int days) {
    return '$days দিন';
  }

  @override
  String get cal_gregorian => 'গ্রেগরিযন';

  @override
  String get cal_hijri => 'হিজরি';

  @override
  String get cal_prevMonth => 'আগের মাস';

  @override
  String get cal_nextMonth => 'পরের মাস';

  @override
  String get cal_legendEid => 'ঈদ';

  @override
  String get cal_legendFast => 'রোজা';

  @override
  String get cal_legendBlessed => 'বরকতময়';

  @override
  String get cal_detailPending =>
      'এই উপলক্ষের জন্য এখনো কোনো অতিরিক্ত বিবরণ (আয়াত/হাদিস/বর্ণনা) উপলব্ধ নেই - ধর্মীয় পর্যালোচনার অপেক্ষায়।';

  @override
  String get hm_1 => 'মুহাররম';

  @override
  String get hm_2 => 'সফর';

  @override
  String get hm_3 => 'রবিউল আউয়াল';

  @override
  String get hm_4 => 'রবিউস সানি';

  @override
  String get hm_5 => 'জুমাদাল উলা';

  @override
  String get hm_6 => 'জুমাদাস সানি';

  @override
  String get hm_7 => 'রজব';

  @override
  String get hm_8 => 'শাবান';

  @override
  String get hm_9 => 'রমজান';

  @override
  String get hm_10 => 'শাওয়াল';

  @override
  String get hm_11 => 'জিলকদ';

  @override
  String get hm_12 => 'জিলহজ';

  @override
  String get ev_new_year => 'ইসলামি নববর্ষ';

  @override
  String get ev_ashura => 'আশুরার দিন';

  @override
  String get ev_mawlid => 'মলাদুন্নবীﷺ';

  @override
  String get ev_isra => 'ইসরা ও মিরাজ';

  @override
  String get ev_ramadan_start => 'রমজানর সূচনা';

  @override
  String get ev_laylat_qadr => 'লাইলাতুল কদর';

  @override
  String get ev_eid_fitr => 'ঈদুল ফিতর';

  @override
  String get ev_arafah => 'আরাফার দিন';

  @override
  String get ev_eid_adha => 'ঈদুল আজহা';

  @override
  String get ev_tashreeq => 'তাশরিকর দিন';

  @override
  String get stories_title => 'কাহিনি ও সিরাত';

  @override
  String get stories_prophets => 'নবিগণ';

  @override
  String get stories_companions => 'সাহাবিগণ';

  @override
  String get stories_scholars => 'আলিমগণ';

  @override
  String get stories_comingSoon => 'শীঘ্রই';

  @override
  String get stories_comingSoonMsg => 'শীঘ্রই আসছে — কনটেন্ট প্রস্তুত হচ্ছে';

  @override
  String get children_title => 'শিশুদের গল্প';

  @override
  String get settings_secIdentity => 'পরিচয়';

  @override
  String get onboarding_modeTitle => 'অ্যাপ মোড নির্বাচন করুন';

  @override
  String get onboarding_modeSubtitle =>
      'আপনি পরে সেটিংস থেকে এটি পরিবর্তন করতে পারেন';

  @override
  String get onboarding_liteSubtitle =>
      'মৌলিক বিষয়াদি · দ্রুত · সম্পূর্ণ অফলাইন';

  @override
  String get onboarding_fullSubtitle => 'সমস্ত বৈশিষ্ট্য · ব্যাপক · গভীর';

  @override
  String get onboarding_andMore => '+ আরও';

  @override
  String get onboarding_madhabTitle => 'ফিকহি মাযহাব';

  @override
  String get onboarding_madhabSubtitle =>
      'নামাজের সময় সঠিকভাবে গণনা করার জন্য';

  @override
  String get onboarding_locationTitle => 'আপনার অবস্থান নির্ধারণ করুন';

  @override
  String get onboarding_locationSubtitle => 'সঠিক নামাজের সময়ের জন্য';

  @override
  String get onboarding_locationBody =>
      'অ্যাপটি অবস্থানের অনুমতি চাইবে\nনামাজের সময় স্বয়ংক্রিয়ভাবে নির্ধারণ করতে';

  @override
  String get onboarding_locationPrivacy =>
      'আপনার তথ্য শুধুমাত্র আপনার ডিভাইসে থাকে';

  @override
  String get onboarding_start => 'শুরু করুন';

  @override
  String get settings_dirRtl => 'RTL';

  @override
  String get settings_dirLtr => 'LTR';

  @override
  String get settings_secAdhan => 'আজান';

  @override
  String get settings_secApp => 'অ্যাপ';

  @override
  String get settings_secPrivacy => 'গোপনীয়তা';

  @override
  String get settings_secAbout => 'সমর্কে';

  @override
  String get settings_language => 'ভাষা';

  @override
  String get settings_chooseLanguage => 'ভাষা নির্বাচন করুন';

  @override
  String get settings_madhab => 'মাজহাব';

  @override
  String get settings_chooseMadhab => 'মাজহাব নিরচন করুন';

  @override
  String get settings_calcMethod => 'নামাজের সময় গণনার পদ্ধতি';

  @override
  String get settings_chooseCalc => 'গণনার পদ্ধতি';

  @override
  String get settings_enableAdhan => 'আজান চালু করুন';

  @override
  String get settings_muezzinVoice => 'মুয়াজ্জিনর কণ্ঠ';

  @override
  String get settings_previewAdhan => 'আজানের আওয়াজ পূর্বরূপ';

  @override
  String get settings_vibration => 'শব্দের পরিবর্তে কম্পন';

  @override
  String get settings_iqamaAlert => 'ইকামতের আগে সতর্তা';

  @override
  String settings_minutes(int n) {
    return '$n মিনিট';
  }

  @override
  String get settings_appMode => 'অ্যাপ মোড';

  @override
  String get settings_fullMode => 'পর্ণ মোড';

  @override
  String get settings_liteMode => 'হালকা মোড';

  @override
  String get settings_fullModeDesc => 'সব ফিচার উপলব্ধ';

  @override
  String get settings_liteModeDesc => 'শুধু প্রয়োজনীয় — অফলাইন';

  @override
  String get settings_quranFont => 'কুরআন ফন্ট';

  @override
  String get settings_fontUthmani => 'উসমনি';

  @override
  String get settings_fontHafs => 'হাফস';

  @override
  String get settings_quranFontSize => 'কুরআন ফন্র আকার';

  @override
  String get settings_privacyNote => 'আপনার অবস্থান শুধু আপনার ডিভাইসে থাকে';

  @override
  String get settings_clearCache => 'ক্যাশ ডেটা মুছুন';

  @override
  String get settings_clearCacheTitle => 'ক্যাশ মুছুন';

  @override
  String get settings_clearCacheMsg =>
      'স্থানীয়ভাবে সংরক্ষিত ডেটা মছে যাবে। আপনি কি নিশ্চিত?';

  @override
  String get settings_cancel => 'বতিল';

  @override
  String get settings_delete => 'মুছুন';

  @override
  String get settings_version => 'সংস্করণ';

  @override
  String get settings_shareApp => 'অ্যাপ শেয়ার করুন';

  @override
  String get settings_licenses => 'লাইসেন্স';

  @override
  String get settings_openSourcePackages => 'ওপেন-সোর্স প্যাকেজ লাইসেন্স';

  @override
  String get settings_tagline => 'সিরাজ — নূরের উপর নূর';

  @override
  String get madhab_hanafi => 'হানাফি';

  @override
  String get madhab_maliki => 'মালিকি';

  @override
  String get madhab_shafi => 'শাফিয়ি';

  @override
  String get madhab_hanbali => 'হাম্বল';

  @override
  String get calc_MWL => 'মুসলিম ওয়ার্ল্ড লিগ';

  @override
  String get calc_ISNA => 'উত্তর আমেরিকা (ISNA)';

  @override
  String get calc_Egypt => 'মিসরীয় কর্তৃপক্ষ';

  @override
  String get calc_Makkah => 'উম্মুল কুরা (মক্কা)';

  @override
  String get calc_Kuwait => 'কুয়েত';

  @override
  String get calc_Qatar => 'কতার';

  @override
  String get calc_Dubai => 'দুবাই';

  @override
  String get calc_Karachi => 'করাচি';

  @override
  String get calc_Singapore => 'সিঙ্গাপুর';

  @override
  String get calc_Turkey => 'তুরস্ (দিয়ানেত)';

  @override
  String get calc_MoonSighting => 'চাঁদ দর্শন কমিটি';

  @override
  String get search_hint => 'কুরআন ও তাফসিরে খুঁজুন...';

  @override
  String get search_empty => 'পবিত্র কুরআন, তাফসির ও শব্দের অর্থ খুঁজুন';

  @override
  String search_noResults(String query) {
    return '\"$query\"-এর জন্য কোনো ফলাফল নেই';
  }

  @override
  String get search_typeAyah => 'আয়াত';

  @override
  String get search_typeTafsir => 'তাফসির';

  @override
  String get search_typeWord => 'শব্দ';

  @override
  String get search_typeHadith => 'হাদিস';

  @override
  String get stats_daysStreak => 'টানা দিন';

  @override
  String get stats_prayersUnit => 'নামাজ';

  @override
  String get stats_pagesUnit => 'পৃষ্ঠা';

  @override
  String get stats_athkar => 'যিকর';

  @override
  String get stats_sessionsUnit => 'সেশন';

  @override
  String stats_pagesOf(int read, int total) {
    return '$read / $total পৃষ্ঠা';
  }

  @override
  String get reader_tapToListen => 'শুনতে চাপুন';

  @override
  String reader_ayahNum(int n) {
    return 'আয়াত $n';
  }

  @override
  String get reader_reciter => 'কারি';

  @override
  String get reader_chooseReciter => 'কারি নির্বাচন করুন';

  @override
  String get reader_searchReciter => 'কারি খুঁজুন...';

  @override
  String get reader_longPressHint =>
      'যেকোনো আয়াতে দীর্ঘ চাপ দিন — পোর্টাল, তাফসির ও শেয়ার';

  @override
  String get reader_versePortal => 'আয়াত পোর্টাল';

  @override
  String get reader_portalSub => 'তাফসির · শব্দ · প্রসঙ্গ';

  @override
  String get reader_showTafsir => 'তাফসির দেখুন';

  @override
  String get reader_shareAyah => 'আয়াত শেয়ার করুন';

  @override
  String get reader_copyAyah => 'আয়াত কপি করুন';

  @override
  String get reader_ayahCopied => 'আয়াত কপি হয়েছে';

  @override
  String reader_tafsirOf(int n) {
    return 'আয়াত $n-এর তাফসির';
  }

  @override
  String get reader_muyassar => 'আল-মুযসসার';

  @override
  String get reader_tafsirError => 'তাফসির লোড করা যায়নি';

  @override
  String get reader_shareTitle => 'মহান আয়াত';

  @override
  String reader_shareSubtitle(String surah, int n) {
    return '$surah · আয়াত $n';
  }

  @override
  String get portal_muyassar => 'আল-মুয়াসসার';

  @override
  String get portal_words => 'শব্দ বিশ্লেষণ';

  @override
  String get portal_hadiths => 'হাদিস';

  @override
  String get portal_adwaaHadiths => 'আদওয়াউল বায়ান';

  @override
  String get portal_stories => 'কাহিনি ও সিরাত';

  @override
  String get portal_arabicTafsir => 'আরবি তাফসির';

  @override
  String get portal_foreignTafsir => 'অন্যান্য ভাষার তাফসির';

  @override
  String get portal_asbab => 'নাজিলের কারণ';

  @override
  String get portal_searchLang => 'ভাষা খুঁজুন...';

  @override
  String get portal_error => 'পোর্টাল খোলা যায়নি';

  @override
  String get portal_back => 'ফিরে যান';

  @override
  String get portal_noTafsir => 'কনো তাফসির নেই';

  @override
  String get portal_loadError => 'লোড করা যায়নি';

  @override
  String get portal_reportTranslation => 'অনুবাদে ত্রুটির অভিযোগ করুন';

  @override
  String get portal_reportDialogTitle => 'অনুবাদে ত্রুটির অভিযোগ করুন';

  @override
  String get portal_reportIssueLabel => 'সমস্যাটি বর্ণনা করুন';

  @override
  String get portal_reportIssueHint => 'যেমন: শব্দ অনুপস্থিত, অর্থ ভুল...';

  @override
  String get portal_reportNoteLabel => 'অতিরিক্ত নোট (ঐচ্ছিক)';

  @override
  String get portal_reportCancel => 'বাতিল';

  @override
  String get portal_reportSubmit => 'জমা দিন';

  @override
  String get portal_reportSuccess =>
      'ধন্যবাদ, আপনার অভিযোগ পৌঁছেছে এবং পর্যালোচনা করা হবে';

  @override
  String get portal_reportError => 'অভিযোগ পাঠানো যায়নি, পরে আবার চেষ্টা করুন';

  @override
  String get portal_reportIssueRequired => 'অনুগ্রহ করে সমস্যাটি বর্ণনা করুন';

  @override
  String get portal_translationPendingReview =>
      'সম্প্রদায়ের পর্যালোচনার অপেক্ষায়';

  @override
  String get portal_comingSoon => 'শীঘ্রই';

  @override
  String get portal_noHadiths => 'এই আয়াতের সাথে এখনো কোনো হাদিস যক্ত নেই';

  @override
  String get portal_addingContent => 'ধীরে ধীরে কনটেন্ট যোগ করা হচ্ছে';

  @override
  String get more_search => 'একীভূত অনুসন্ধান';

  @override
  String get more_settings => 'সেটিংস';

  @override
  String get more_calendar => 'ইসলামি ক্যালেন্র';

  @override
  String get more_shareCards => 'শেয়ার কার্ড';

  @override
  String get more_fullMode => 'পূর্ণ মোড';

  @override
  String get more_radio => 'কুরআন রেডিও';

  @override
  String get more_mosques => 'নিকটবর্তী মসজিদ';

  @override
  String get athkarcat_error => 'ত্রুটি';

  @override
  String get athkarcat_empty => 'কোনো যিকর নই';

  @override
  String athkarcat_completed(String name) {
    return '$name সম্পন্ন';
  }

  @override
  String get athkarcat_back => 'ফিরে যান';

  @override
  String get athkarcat_next => 'পরবর্তী';

  @override
  String get athkarcat_finish => 'শেষ';

  @override
  String get athkarcat_prev => 'পূর্ববর্তী';

  @override
  String athkarcat_repeat(int count, String source) {
    return 'পনরাবৃত্তি: $count · $source';
  }

  @override
  String athkarcat_narrated(String source) {
    return 'বর্ণনায় $source';
  }

  @override
  String get athkarcat_moving => 'সনান্তর হচ্ছে...';

  @override
  String get athkarcat_tapCount => 'গণনা করতে চাপুন';

  @override
  String get athkar_allSections => 'সব বিভাগ';

  @override
  String get gateway_entry_title => 'ইসলামকে জানুন';

  @override
  String get gateway_intro_title => 'আধ্যাত্মিক সচতনতার যাত্রা';

  @override
  String get gateway_journey_title => 'যাত্রা';

  @override
  String get gateway_principles_title => 'ইসলামের মূলনীতি';

  @override
  String get gateway_library_title => 'গ্রন্থাগার';

  @override
  String get gateway_begin => 'যাত্রা শুরু করুন';

  @override
  String get gateway_next => 'পরবর্তী';

  @override
  String get gateway_prev => 'পূর্ববর্তী';

  @override
  String get app_tagline => 'আপনার ইসলামিক গাইড';

  @override
  String get app_brand_name => 'সিরাজ';

  @override
  String get gateway_shahada_cta => 'এখনই আপনার ঈমান ঘোষণা করুন';

  @override
  String get nav_library => 'গ্রন্থাগার';

  @override
  String get library_could_not_load => 'লোড করা যায়নি';

  @override
  String get library_section_not_found => 'বিভাগ পাওয়া যায়নি';

  @override
  String get library_content_title => 'বিষয়বস্তু';

  @override
  String get library_search_in_category => 'এই বিভাগে অনুসন্ধান করুন...';

  @override
  String get library_no_matching_results => 'কোনো মিল ফলাফল নেই';

  @override
  String get library_no_materials_lang => 'এই ভাষায় এখনও কোনো উপকরণ নেই';

  @override
  String get library_connection_failed =>
      'সংযোগ ব্যর্থ হয়েছে। আপনার ইন্টারনেট পরীক্ষা করুন এবং আবার চেষ্টা করুন';

  @override
  String get library_search_content_type => 'বিষয়বস্তুর ধরন খুঁজুন...';

  @override
  String get library_choose_content_type => 'বিষয়বস্তুর ধরন নির্বাচন করুন';

  @override
  String get library_no_content_lang => 'এই ভাষায় এখনও কোনো বিষয়বস্তু নেই';

  @override
  String get library_not_found => 'পাওয়া যায়নি';

  @override
  String get library_search_in_section => 'এই বিভাগে অনুসন্ধান করুন...';

  @override
  String get library_no_categories => 'এখনও কোনো বিভাগ নেই';

  @override
  String get library_type_books => 'বই';

  @override
  String get library_type_audios => 'অডিও';

  @override
  String get library_type_videos => 'ভিডিও';

  @override
  String get library_type_articles => 'নবন্ধ';

  @override
  String get adhan_makkah => 'মক্কী (হারাম শরীফ)';

  @override
  String get adhan_madinah => 'মাদানী (মসজিদে নববী)';

  @override
  String get adhan_mustafa_ismail => 'মুস্তফা ইসমাইল';

  @override
  String get adhan_iraqi => 'ইরাকি';

  @override
  String get adhan_turkish => 'তুর্কি';

  @override
  String get adhan_moroccan => 'মরক্কোর';

  @override
  String get adhan_indonesian => 'ইন্দোনেশিয়ান';

  @override
  String get adhan_classic => 'ক্লাসিক';

  @override
  String prayer_notification_title(Object prayer) {
    return '$prayer-এর সময় হয়েছে';
  }

  @override
  String get prayer_notification_body => 'আল্লাহু আকবার, নামাজর দিকে এসো';

  @override
  String get iqama_notification_title => 'ইকামত সতর্কতা';

  @override
  String iqama_notification_body(Object minutes, Object prayer) {
    return '$minutes মিনিট পর ইকামত — $prayer';
  }

  @override
  String get khatmah_title => 'খতম';

  @override
  String get khatmah_new => 'নতুন খতম';

  @override
  String get khatmah_empty => 'এখনও কোনো খতম নেই। প্রথমটি শুরু করন!';

  @override
  String get khatmah_name => 'খতমের নাম';

  @override
  String get khatmah_duration_days => 'সময়কাল (দিন)';

  @override
  String get khatmah_daily_pages => 'দৈনিক অশ (পৃষ্ঠা)';

  @override
  String get khatmah_reminder_time => 'অনুস্মারকের সময়';

  @override
  String get khatmah_create => 'খতম তৈরি করুন';

  @override
  String get khatmah_preset_ramadan => 'রমজান (৩০ দিন)';

  @override
  String get khatmah_preset_weekly => 'সাপ্তাহিক (৭ দিন)';

  @override
  String get khatmah_preset_monthly => 'মাসিক (৩০ দিন)';

  @override
  String get khatmah_status_ontrack => 'সঠক পথে';

  @override
  String get khatmah_status_behind => 'পিছিয়ে';

  @override
  String get khatmah_status_ahead => 'এগিয়ে';

  @override
  String get khatmah_status_completed => 'সম্পন্ন';

  @override
  String get khatmah_today_portion => 'আজকের অংশ';

  @override
  String get khatmah_read_now => 'এখন পড়ুন';

  @override
  String get khatmah_page => 'পৃষ্ঠা';

  @override
  String khatmah_day_of(Object current, Object total) {
    return '$total দিনের $current তম';
  }

  @override
  String get khatmah_delete_confirm => 'এই খতম মছবেন?';

  @override
  String get khatmah_progress => 'অগ্রগতি';

  @override
  String khatmah_share_text(Object day, Object name, Object percent) {
    return 'আমি আমার $name খতমের $day দিনে আছি, $percent% সম্পন। আল্লাহ আমাদের কুরআনের মানুষ বানান 🤲';
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
