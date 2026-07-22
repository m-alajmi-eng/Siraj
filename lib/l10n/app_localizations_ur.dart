// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Urdu (`ur`).
class AppLocalizationsUr extends AppLocalizations {
  AppLocalizationsUr([String locale = 'ur']) : super(locale);

  @override
  String get appName => 'سراج';

  @override
  String get prayer_title => 'نماز کے اوقات';

  @override
  String get prayer_nextPrayer => 'اگلی نماز';

  @override
  String get prayer_fajr => 'فجر';

  @override
  String get prayer_sunrise => 'اشراق';

  @override
  String get prayer_dhuhr => 'ظہر';

  @override
  String get prayer_asr => 'عصر';

  @override
  String get prayer_maghrib => 'مغرب';

  @override
  String get prayer_isha => 'عشاء';

  @override
  String prayer_countdown(String time) {
    return '$time میں';
  }

  @override
  String get prayer_locationGPS => 'آپ کا موجودہ مقام';

  @override
  String get prayer_locationDefault => 'مکہ مکرمہ (پہلے سے طے شدہ)';

  @override
  String get quran_title => 'قرآن کریم';

  @override
  String get quran_meccan => 'مکی';

  @override
  String get quran_medinan => 'مدنی';

  @override
  String quran_ayahCount(int count) {
    return '$count آیات';
  }

  @override
  String get quran_searchHint => 'قرآن میں تلاش کریں...';

  @override
  String get quran_noResults => 'کوئی نتیجہ نہیں';

  @override
  String get quran_searchPrompt => 'تلاش کے لیے لفظ لکھیں';

  @override
  String get quran_tapForTafsir => 'تفسیر کے لیے آیت کو دیر تک دبائیں';

  @override
  String quran_tafsirTitle(int number) {
    return 'آیت $number کی تفسیر';
  }

  @override
  String get quran_tafsirSource => 'المیسر';

  @override
  String get quran_tafsirError => 'تفسیر لوڈ نہیں ہو سکی';

  @override
  String get quran_reciter => 'قاری';

  @override
  String get quran_selectReciter => 'قاری منتخب کریں';

  @override
  String get quran_searchReciter => 'قاری تلاش کریں...';

  @override
  String get quran_playPrompt => 'سننے کے لیے دبائیں';

  @override
  String quran_ayahNumber(int number) {
    return 'آیت $number';
  }

  @override
  String get quran_toggleDisplayMode => 'ڈسپلے موڈ تبدیل کریں (مصحف/ترجمہ)';

  @override
  String get quran_toggleTajweed => 'تجوید کی رنگین علامات تبدیل کریں';

  @override
  String get athkar_title => 'اذکار';

  @override
  String get athkar_morning => 'صبح کے اذکار';

  @override
  String get athkar_evening => 'شام کے اذکار';

  @override
  String get athkar_sleep => 'سونے کے اذکار';

  @override
  String get athkar_wake => 'جاگنے کے اذکار';

  @override
  String get athkar_prayer => 'نماز کے بعد کے اذکار';

  @override
  String get athkar_general => 'عمومی اذکار';

  @override
  String get athkar_tapToCount => 'گنتی کے لیے دبائیں';

  @override
  String get athkar_transitioning => 'منتقل ہو رہا ہے...';

  @override
  String athkar_completed(String name) {
    return '$name مکمل';
  }

  @override
  String get athkar_next => 'اگلا';

  @override
  String get athkar_prev => 'پچھلا';

  @override
  String get athkar_finish => 'ختم کریں';

  @override
  String get athkar_back => 'واپس';

  @override
  String athkar_source(String source) {
    return '$source نے روایت کیا';
  }

  @override
  String get hadith_title => 'حدیث شریف';

  @override
  String get hadith_searchHint => 'احادیث میں تلاش کریں...';

  @override
  String get hadith_noResults => 'کوئی نتیجہ نہیں';

  @override
  String get hadith_tapForDetail => 'مکمل حدیث پڑھنے کے لیے دبائیں';

  @override
  String get hadith_retryButton => 'دوبارہ کوشش کریں';

  @override
  String get hadith_loadError => 'لوڈ نہیں ہو سکا';

  @override
  String hadith_readProgress(int read, int total) {
    return 'پڑھی گئیں: $read از $total';
  }

  @override
  String get qibla_title => 'قبلہ کی سمت';

  @override
  String get qibla_active => 'کمپاس فعال ہے';

  @override
  String get qibla_error => 'قبلہ کی سمت معلوم نہیں ہو سکی';

  @override
  String get qibla_errorHint => 'کمپاس اور مقام کو فعال کریں';

  @override
  String get qibla_staticMode => 'مستقل وضع (کمپاس سینسر نہیں)';

  @override
  String get qibla_calibrationHint =>
      'کمپاس کیلیبریٹ کرنے کے لیے اپنے آلے کو ٨ کی شکل میں حرکت دیں';

  @override
  String get qibla_kaaba => 'کعبہ';

  @override
  String get qibla_fromNorth => 'شمال سے قبلہ کی طرف ڈگری';

  @override
  String qibla_distanceKm(int km, String kaaba) {
    return '$km کلومیٹر - $kaaba تک';
  }

  @override
  String get stats_title => 'میری اعداد و شمار';

  @override
  String get stats_prayerStreak => 'نماز کا سلسلہ';

  @override
  String get stats_totalPrayers => 'کل نمازیں';

  @override
  String get stats_quranPages => 'قرآن کے صفحات';

  @override
  String get stats_athkarSessions => 'اذکار';

  @override
  String get stats_khatma => 'قرآن ختم';

  @override
  String get stats_days => 'مسلسل دن';

  @override
  String get stats_prayers => 'نمازیں';

  @override
  String get stats_pages => 'صفحات';

  @override
  String get stats_sessions => 'سیشن';

  @override
  String get stats_khatmaUnit => 'ختم';

  @override
  String get stats_currentKhatma => 'موجودہ ختم کی پیشرفت';

  @override
  String get more_title => 'مزید';

  @override
  String get library_title => 'جامع لائبریری';

  @override
  String get more_qibla => 'قبلہ کی سمت';

  @override
  String get more_stats => 'میری اعداد و شمار';

  @override
  String get common_loading => 'لوڈ ہو رہا ہے...';

  @override
  String get common_error => 'ڈیٹا لوڈ کرنے میں خطا';

  @override
  String get common_retry => 'دوبارہ کوشش کریں';

  @override
  String get common_back => 'واپس';

  @override
  String get common_next => 'اگلا';

  @override
  String get common_save => 'محفوظ کریں';

  @override
  String get common_cancel => 'منسوخ کریں';

  @override
  String get common_done => 'ہو گیا';

  @override
  String get common_search => 'تلاش';

  @override
  String get common_noData => 'کوئی ڈیٹا نہیں';

  @override
  String get common_offline => 'انٹرنیٹ کنکشن نہیں';

  @override
  String get common_close => 'بند کریں';

  @override
  String get common_share => 'شیئر کریں';

  @override
  String get common_refresh => 'تازہ کریں';

  @override
  String get common_prevPage => 'پچھلا صفحہ';

  @override
  String get common_nextPage => 'اگلا صفحہ';

  @override
  String get common_clearSearch => 'تلاش صاف کریں';

  @override
  String get nav_home => 'ہوم';

  @override
  String get nav_quran => 'قرآن';

  @override
  String get nav_athkar => 'اذکار';

  @override
  String get nav_hadith => 'حدیث';

  @override
  String get nav_more => 'مزید';

  @override
  String get home_greetingNight => 'مبارک رات،';

  @override
  String get home_greetingFajr => 'فجر کی سلامتی،';

  @override
  String get home_greetingMorning => 'صبح بخیر،';

  @override
  String get home_greetingNoon => 'دوپہر بخیر،';

  @override
  String get home_greetingAsr => 'مبارک سہ پہر،';

  @override
  String get home_greetingEvening => 'شام بخیر،';

  @override
  String get home_greetingLateNight => 'پرسکون رات،';

  @override
  String get home_welcome => 'خوش آمدید';

  @override
  String get home_nextPrayer => 'اگلی نماز';

  @override
  String get home_qiblaDirection => 'قبلہ کی سمت';

  @override
  String get time_hr => 'گھنٹہ';

  @override
  String get time_min => 'منٹ';

  @override
  String get time_sec => 'سیکنڈ';

  @override
  String get home_continueReading => 'پڑھنا جاری رکھیں';

  @override
  String home_surah(int id) {
    return 'سورہ #$id';
  }

  @override
  String home_ayah(int number) {
    return 'آیت $number';
  }

  @override
  String get home_dailyAyah => 'آج کی آیت';

  @override
  String get home_quickAccess => 'فوری رسائی';

  @override
  String get home_searchHint => 'آپ کیا تلاش کر رہے ہیں...';

  @override
  String get home_radio => 'ریڈیو';

  @override
  String get home_calendar => 'کیلنڈر';

  @override
  String get home_stories => 'کہانیاں';

  @override
  String get home_children => 'بچے';

  @override
  String get settings_title => 'ترتیبات';

  @override
  String get radio_title => 'سراج ریڈیو';

  @override
  String get radio_all => 'سب';

  @override
  String get radio_quran => 'قرآن';

  @override
  String get radio_translations => 'تراجم';

  @override
  String get radio_tafsir => 'تفسیر و فتاویٰ';

  @override
  String get radio_athkar => 'اذکار';

  @override
  String get radio_international => 'بین الاقوامی';

  @override
  String get radio_play => 'چلائیں';

  @override
  String get radio_pause => 'روکیں';

  @override
  String get cal_title => 'اسلامی کیلنڈر';

  @override
  String get cal_todayEvents => 'آج کے واقعات';

  @override
  String get cal_nextEvent => 'اگلا واقعہ';

  @override
  String get cal_allEvents => 'اسلامی مواقع';

  @override
  String cal_daysUntil(int days) {
    return '$days دن';
  }

  @override
  String get cal_gregorian => 'عیسوی';

  @override
  String get cal_hijri => 'ہجری';

  @override
  String get cal_prevMonth => 'پچھلا مہینہ';

  @override
  String get cal_nextMonth => 'اگلا مہینہ';

  @override
  String get cal_legendEid => 'عید';

  @override
  String get cal_legendFast => 'روزہ';

  @override
  String get cal_legendBlessed => 'مبارک';

  @override
  String get cal_hijriOffset => 'ہجری اصلاح';

  @override
  String get cal_detailPending =>
      'اس موقع کے لیے ابھی کوئی اضافی تفصیل (آیت/حدیث/تفصیل) دستیاب نہیں - دینی جائزے کا انتظار ہے۔';

  @override
  String get hm_1 => 'محرم';

  @override
  String get hm_2 => 'صفر';

  @override
  String get hm_3 => 'ربیع الاول';

  @override
  String get hm_4 => 'ربیع الثانی';

  @override
  String get hm_5 => 'جمادی الاول';

  @override
  String get hm_6 => 'جمادی الثانی';

  @override
  String get hm_7 => 'رجب';

  @override
  String get hm_8 => 'شعبان';

  @override
  String get hm_9 => 'رمضان';

  @override
  String get hm_10 => 'شوال';

  @override
  String get hm_11 => 'ذوالقعدہ';

  @override
  String get hm_12 => 'ذوالحجہ';

  @override
  String get ev_new_year => 'اسلامی نیا سال';

  @override
  String get ev_ashura => 'یومِ عاشورا';

  @override
  String get ev_mawlid => 'میلاد النبیﷺ';

  @override
  String get ev_isra => 'شبِ اسراء و معراج';

  @override
  String get ev_ramadan_start => 'یکم رمضان';

  @override
  String get ev_laylat_qadr => 'شبِ قدر';

  @override
  String get ev_eid_fitr => 'عید الفطر';

  @override
  String get ev_arafah => 'یومِ عرفہ';

  @override
  String get ev_eid_adha => 'عید الاضحیٰ';

  @override
  String get ev_tashreeq => 'ایامِ تشریق';

  @override
  String get stories_title => 'قصص و سیرت';

  @override
  String get stories_prophets => 'انبیاء';

  @override
  String get stories_companions => 'صحابہؓ';

  @override
  String get stories_scholars => 'علماء';

  @override
  String get stories_comingSoon => 'جلد';

  @override
  String get stories_comingSoonMsg => 'جلد آ رہا ہے — مواد تیار ہو رہا ہے';

  @override
  String get children_title => 'بچوں کی کہانیاں';

  @override
  String get settings_secIdentity => 'شناخت';

  @override
  String get onboarding_modeTitle => 'ایپ کا موڈ منتخب کریں';

  @override
  String get onboarding_modeSubtitle =>
      'آپ بعد میں اسے ترتیبات سے تبدیل کر سکتے ہیں';

  @override
  String get onboarding_liteSubtitle => 'بنیادی باتیں · تیز · مکمل آف لائن';

  @override
  String get onboarding_fullSubtitle => 'تمام خصوصیات · جامع · تفصیلی';

  @override
  String get onboarding_andMore => '+ مزید';

  @override
  String get onboarding_madhabTitle => 'فقہی مذہب';

  @override
  String get onboarding_madhabSubtitle => 'نماز کے اوقات کی درست گنتی کے لیے';

  @override
  String get onboarding_locationTitle => 'اپنا محل وقوع متعین کریں';

  @override
  String get onboarding_locationSubtitle => 'درست نماز کے اوقات کے لیے';

  @override
  String get onboarding_locationBody =>
      'ایپ محل وقوع کی اجازت مانگے گی\nتاکہ نماز کے اوقات خودکار طور پر متعین ہوں';

  @override
  String get onboarding_locationPrivacy =>
      'آپ کا ڈیٹا صرف آپ کے آلے پر رہتا ہے';

  @override
  String get onboarding_start => 'شروع کریں';

  @override
  String get settings_dirRtl => 'RTL';

  @override
  String get settings_dirLtr => 'LTR';

  @override
  String get settings_secAdhan => 'اذان';

  @override
  String get settings_secApp => 'ایپ';

  @override
  String get settings_secPrivacy => 'رازداری';

  @override
  String get settings_secAbout => 'تعارف';

  @override
  String get settings_language => 'زبان';

  @override
  String get settings_chooseLanguage => 'زبان منتخب کریں';

  @override
  String get settings_madhab => 'مذہب';

  @override
  String get settings_chooseMadhab => 'مذہب منتخب کریں';

  @override
  String get settings_calcMethod => 'نماز کے اوقات کا طریقہ';

  @override
  String get settings_chooseCalc => 'حساب کا طریقہ';

  @override
  String get settings_enableAdhan => 'اذان فعال کریں';

  @override
  String get settings_muezzinVoice => 'مؤذن کی آواز';

  @override
  String get settings_previewAdhan => 'اذان کی آواز کا پیش نظارہ';

  @override
  String get settings_vibration => 'آواز کے بجائے ارتعاش';

  @override
  String get settings_iqamaAlert => 'اقامت سے پہلے انتباہ';

  @override
  String settings_minutes(int n) {
    return '$n منٹ';
  }

  @override
  String get settings_appMode => 'ایپ موڈ';

  @override
  String get settings_fullMode => 'مکمل موڈ';

  @override
  String get settings_liteMode => 'ہلکا موڈ';

  @override
  String get settings_fullModeDesc => 'تمام خصوصیات دستیاب';

  @override
  String get settings_liteModeDesc => 'صرف بنیادی — آف لائن';

  @override
  String get settings_quranFont => 'قرآن فونٹ';

  @override
  String get settings_fontUthmani => 'عثمانی';

  @override
  String get settings_fontHafs => 'حفص';

  @override
  String get settings_quranFontSize => 'قرآن فونٹ سائز';

  @override
  String get settings_privacyNote => 'آپ کا مقام صرف آپ کے آلے پر رہتا ہے';

  @override
  String get settings_clearCache => 'کیش ڈیٹا صاف کریں';

  @override
  String get settings_clearCacheTitle => 'کیش صاف کریں';

  @override
  String get settings_clearCacheMsg =>
      'مقامی طور پر محفوظ ڈیٹا حذف ہو جائے گا۔ کیا آپ یقینی ہیں؟';

  @override
  String get settings_cancel => 'منسوخ';

  @override
  String get settings_delete => 'حذف';

  @override
  String get settings_version => 'ورژن';

  @override
  String get settings_shareApp => 'ایپ شیئر کریں';

  @override
  String get settings_licenses => 'لائسنس';

  @override
  String get settings_openSourcePackages => 'اوپن سورس پیکجز کے لائسنس';

  @override
  String get settings_tagline => 'سراج — نور علیٰ نور';

  @override
  String get madhab_hanafi => 'حنفی';

  @override
  String get madhab_maliki => 'مالکی';

  @override
  String get madhab_shafi => 'شافعی';

  @override
  String get madhab_hanbali => 'حنبلی';

  @override
  String get calc_MWL => 'رابطہ عالم اسلامی';

  @override
  String get calc_ISNA => 'شمالی امریکہ (ISNA)';

  @override
  String get calc_Egypt => 'مصری ادارہ';

  @override
  String get calc_Makkah => 'ام القریٰ (مکہ)';

  @override
  String get calc_Kuwait => 'کویت';

  @override
  String get calc_Qatar => 'قطر';

  @override
  String get calc_Dubai => 'دبئی';

  @override
  String get calc_Karachi => 'کراچی';

  @override
  String get calc_Singapore => 'سنگاپور';

  @override
  String get calc_Turkey => 'ترکی (دیانت)';

  @override
  String get calc_MoonSighting => 'ہلال کمیٹی';

  @override
  String get search_hint => 'قرآن و تفسیر میں تلاش کریں...';

  @override
  String get search_empty => 'قرآن کریم، تفسیر اور کلمات کے معانی تلاش کریں';

  @override
  String search_noResults(String query) {
    return '\"$query\" کے لیے کوئی نتیجہ نہیں';
  }

  @override
  String get search_typeAyah => 'آیت';

  @override
  String get search_typeTafsir => 'تفسیر';

  @override
  String get search_typeWord => 'لفظ';

  @override
  String get search_typeHadith => 'حدیث';

  @override
  String get search_typeAthkar => 'ذکر';

  @override
  String get search_partialResults =>
      'کچھ ذرائع دستیاب نہیں تھے — نتائج نامکمل ہو سکتے ہیں';

  @override
  String get stats_daysStreak => 'مسلسل دن';

  @override
  String get stats_prayersUnit => 'نمازیں';

  @override
  String get stats_pagesUnit => 'صفحات';

  @override
  String get stats_athkar => 'اذکار';

  @override
  String get stats_sessionsUnit => 'نشستیں';

  @override
  String stats_pagesOf(int read, int total) {
    return '$read / $total صفحات';
  }

  @override
  String get reader_tapToListen => 'سننے کے لیے دبائیں';

  @override
  String reader_ayahNum(int n) {
    return 'آیت $n';
  }

  @override
  String get reader_reciter => 'قاری';

  @override
  String get reader_chooseReciter => 'قاری منتخب کریں';

  @override
  String get reader_searchReciter => 'قاری تلاش کریں...';

  @override
  String get reader_longPressHint =>
      'کسی بھی آیت پر دیر تک دبائیں — بوابہ، تفسیر اور شیئرنگ';

  @override
  String get reader_versePortal => 'آیت بوابہ';

  @override
  String get reader_portalSub => 'تفسیر · کلمات · سیاق';

  @override
  String get reader_showTafsir => 'تفسیر دکھائیں';

  @override
  String get reader_shareAyah => 'آیت شیئر کریں';

  @override
  String get reader_copyAyah => 'آیت نقل کریں';

  @override
  String get reader_ayahCopied => 'آیت نقل ہو گئی';

  @override
  String reader_tafsirOf(int n) {
    return 'آیت $n کی تفسیر';
  }

  @override
  String get reader_muyassar => 'المیسر';

  @override
  String get reader_tafsirError => 'تفسیر لوڈ نہیں ہو سکی';

  @override
  String get reader_shareTitle => 'آیتِ کریمہ';

  @override
  String reader_shareSubtitle(String surah, int n) {
    return '$surah · آیت $n';
  }

  @override
  String get portal_muyassar => 'تفسیر المیسر';

  @override
  String get portal_words => 'لغوی تجزیہ';

  @override
  String get portal_hadiths => 'احادیث';

  @override
  String get portal_adwaaHadiths => 'اضواء البیان';

  @override
  String get portal_stories => 'قصص و سیرت';

  @override
  String get portal_arabicTafsir => 'عربی تفاسیر';

  @override
  String get portal_foreignTafsir => 'دیگر زبانوں میں تفاسیر';

  @override
  String get portal_asbab => 'شانِ نزول';

  @override
  String get portal_searchLang => 'زبان تلاش کریں...';

  @override
  String get portal_error => 'بوابہ نہیں کھل سکا';

  @override
  String get portal_back => 'واپس';

  @override
  String get portal_noTafsir => 'کوئی تفسیر دستیاب نہیں';

  @override
  String get portal_loadError => 'لوڈ نہیں ہو سکا';

  @override
  String get portal_reportTranslation => 'ترجمے کی غلطی کی اطلاع دیں';

  @override
  String get portal_reportDialogTitle => 'ترجمے کی غلطی کی اطلاع دیں';

  @override
  String get portal_reportIssueLabel => 'مسئلہ بیان کریں';

  @override
  String get portal_reportIssueHint => 'مثال: لفظ غائب، غلط معنی...';

  @override
  String get portal_reportNoteLabel => 'اضافی نوٹ (اختیاری)';

  @override
  String get portal_reportCancel => 'منسوخ کریں';

  @override
  String get portal_reportSubmit => 'جمع کروائیں';

  @override
  String get portal_reportSuccess =>
      'شکریہ، آپ کی رپورٹ موصول ہوگئی ہے اور اس کا جائزہ لیا جائے گا';

  @override
  String get portal_reportError =>
      'رپورٹ بھیجی نہیں جا سکی، بعد میں دوبارہ کوشش کریں';

  @override
  String get portal_reportIssueRequired => 'براہ کرم مسئلہ بیان کریں';

  @override
  String get portal_translationPendingReview => 'کمیونٹی جائزے کا انتظار ہے';

  @override
  String get portal_comingSoon => 'جلد';

  @override
  String get portal_noHadiths => 'اس آیت سے منسلک ابھی کوئی حدیث نہیں';

  @override
  String get portal_addingContent => 'مواد بتدریج شامل کیا جا رہا ہے';

  @override
  String get more_search => 'متحدہ تلاش';

  @override
  String get more_settings => 'ترتیبات';

  @override
  String get more_calendar => 'اسلامی کیلنڈر';

  @override
  String get more_shareCards => 'شیئرنگ کارڈز';

  @override
  String get more_fullMode => 'مکمل موڈ';

  @override
  String get more_radio => 'قرآن ریڈیو';

  @override
  String get more_mosques => 'قریبی مساجد';

  @override
  String get more_groupPrayerTools => 'نماز کے آلات';

  @override
  String get more_groupContent => 'مواد';

  @override
  String get mosques_searching => 'قریبی مساجد تلاش کی جا رہی ہیں...';

  @override
  String get mosques_unnamed => 'بے نام مسجد';

  @override
  String get mosques_notFound => 'قریب کوئی مسجد نہیں ملی';

  @override
  String get mosques_permissionDenied => 'مقام کی اجازت مسترد';

  @override
  String get mosques_permissionDeniedHint =>
      'قریبی مساجد دیکھنے کے لیے آلے کی ترتیبات سے مقام کی اجازت دیں';

  @override
  String get mosques_serviceDisabled => 'مقام کی سروس بند ہے';

  @override
  String get mosques_serviceDisabledHint =>
      'اپنے آلے کی ترتیبات سے مقام کی سروس (GPS) آن کریں';

  @override
  String get mosques_networkError => 'سرور سے رابطہ نہیں ہو سکا';

  @override
  String get mosques_networkErrorHint =>
      'اپنا انٹرنیٹ کنکشن چیک کریں اور دوبارہ کوشش کریں';

  @override
  String get mosques_openSettings => 'ترتیبات کھولیں';

  @override
  String get mosques_directions => 'راستہ';

  @override
  String get mosques_desktopOnly =>
      'یہ خصوصیت صرف Android اور iOS پر کام کرتی ہے';

  @override
  String get athkarcat_error => 'خرابی';

  @override
  String get athkarcat_empty => 'کوئی اذکار نہیں';

  @override
  String athkarcat_completed(String name) {
    return '$name مکمل';
  }

  @override
  String get athkarcat_back => 'واپس';

  @override
  String get athkarcat_next => 'اگلا';

  @override
  String get athkarcat_finish => 'ختم';

  @override
  String get athkarcat_prev => 'پچھلا';

  @override
  String athkarcat_repeat(int count, String source) {
    return 'تکرار: $count · $source';
  }

  @override
  String athkarcat_narrated(String source) {
    return 'راوی: $source';
  }

  @override
  String get athkarcat_moving => 'منتقل ہو رہا ہے...';

  @override
  String get athkarcat_tapCount => 'گننے کے لیے دبائیں';

  @override
  String get athkar_allSections => 'تمام اقسام';

  @override
  String get gateway_entry_title => 'اسلام کو جانیں';

  @override
  String get gateway_intro_title => 'روحانی بیداری کا سفر';

  @override
  String get gateway_journey_title => 'سفر';

  @override
  String get gateway_principles_title => 'اسلام کے بنیادی اصول';

  @override
  String get gateway_library_title => 'کتب خانہ';

  @override
  String get gateway_begin => 'سفر شروع کریں';

  @override
  String get gateway_next => 'اگلا';

  @override
  String get gateway_prev => 'پچھلا';

  @override
  String get app_tagline => 'آپ کا اسلامی رہنما';

  @override
  String get app_brand_name => 'SIRAJ';

  @override
  String get gateway_shahada_cta => 'ابھی اپنا ایمان کا اعلان کریں';

  @override
  String get nav_library => 'لائبریری';

  @override
  String get library_could_not_load => 'لوڈ نہیں ہو سکا';

  @override
  String get library_section_not_found => 'سیکشن نہیں ملا';

  @override
  String get library_content_title => 'مواد';

  @override
  String get library_search_in_category => 'اس زمرے میں تلاش کریں...';

  @override
  String get library_no_matching_results => 'کوئی مماثل نتیجہ نہیں';

  @override
  String get library_no_materials_lang =>
      'اس زبان میں فی الحال کوئی مواد دستیاب نہیں';

  @override
  String get library_connection_failed =>
      'رابطہ ناکام ہوگیا۔ اپنا انٹرنیٹ چیک کریں اور دوبارہ کوشش کریں';

  @override
  String get library_search_content_type => 'مواد کی قسم تلاش کریں...';

  @override
  String get library_choose_content_type => 'مواد کی قسم منتخب کریں';

  @override
  String get library_no_content_lang =>
      'اس زبان میں فی الحال کوئی مواد دستیاب نہیں';

  @override
  String get library_not_found => 'نہیں ملا';

  @override
  String get library_search_in_section => 'اس سیکشن میں تلاش کریں...';

  @override
  String get library_no_categories => 'فی الحال کوئی زمرہ دستیاب نہیں';

  @override
  String get library_type_books => 'کتابیں';

  @override
  String get library_type_audios => 'آڈیو';

  @override
  String get library_type_videos => 'ویڈیو';

  @override
  String get library_type_articles => 'مضامین';

  @override
  String get adhan_makkah => 'مکی (حرم مکی)';

  @override
  String get adhan_madinah => 'مدنی (مسجد نبوی)';

  @override
  String get adhan_mustafa_ismail => 'مصطفی اسماعیل';

  @override
  String get adhan_iraqi => 'عراقی';

  @override
  String get adhan_turkish => 'ترکی';

  @override
  String get adhan_moroccan => 'مراکشی';

  @override
  String get adhan_indonesian => 'انڈونیشیائی';

  @override
  String get adhan_classic => 'کلاسیکی';

  @override
  String prayer_notification_title(Object prayer) {
    return '$prayer کا وقت ہو گیا ہے';
  }

  @override
  String get prayer_notification_body => 'اللہ اکبر، نماز کی طرف آؤ';

  @override
  String get iqama_notification_title => 'اقامت کا انتباہ';

  @override
  String iqama_notification_body(Object minutes, Object prayer) {
    return 'اقامت $minutes منٹ میں — $prayer';
  }

  @override
  String get khatmah_title => 'ختمات';

  @override
  String get khatmah_new => 'نئی ختم';

  @override
  String get khatmah_empty => 'ابھی کوئی ختم نہیں۔ اپنی پہلی ختم شروع کریں!';

  @override
  String get khatmah_name => 'ختم کا نام';

  @override
  String get khatmah_duration_days => 'مدت (دن)';

  @override
  String get khatmah_daily_pages => 'روزانہ ورد (صفحات)';

  @override
  String get khatmah_reminder_time => 'یاد دہانی کا وقت';

  @override
  String get khatmah_create => 'ختم بنائیں';

  @override
  String get khatmah_preset_ramadan => 'رمضان (30 دن)';

  @override
  String get khatmah_preset_weekly => 'ہفتہ وار (7 دن)';

  @override
  String get khatmah_preset_monthly => 'ماہانہ (30 دن)';

  @override
  String get khatmah_status_ontrack => 'درست راہ پر';

  @override
  String get khatmah_status_behind => 'پیچھے';

  @override
  String get khatmah_status_ahead => 'آگے';

  @override
  String get khatmah_status_completed => 'مکمل';

  @override
  String get khatmah_today_portion => 'آج کا ورد';

  @override
  String get khatmah_read_now => 'ابھی پڑھیں';

  @override
  String get khatmah_page => 'صفحہ';

  @override
  String khatmah_day_of(Object current, Object total) {
    return 'دن $current از $total';
  }

  @override
  String get khatmah_delete_confirm => 'کیا یہ ختم حذف کریں؟';

  @override
  String get khatmah_progress => 'پیش رفت';

  @override
  String khatmah_share_text(Object day, Object name, Object percent) {
    return 'میں اپنی $name ختمہ کے دن $day پر ہوں، $percent% مکمل۔ اللہ ہمیں اہل قرآن میں سے بنائے 🤲';
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
