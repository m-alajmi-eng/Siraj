// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'سراج';

  @override
  String get prayer_title => 'أوقات الصلاة';

  @override
  String get prayer_nextPrayer => 'الصلاة القادمة';

  @override
  String get prayer_fajr => 'الفجر';

  @override
  String get prayer_sunrise => 'الشروق';

  @override
  String get prayer_dhuhr => 'الظهر';

  @override
  String get prayer_asr => 'العصر';

  @override
  String get prayer_maghrib => 'المغرب';

  @override
  String get prayer_isha => 'العشاء';

  @override
  String prayer_countdown(String time) {
    return 'في $time';
  }

  @override
  String get prayer_locationGPS => 'موقعك الحالي';

  @override
  String get prayer_locationDefault => 'مكة المكرمة (افتراضي)';

  @override
  String get quran_title => 'القرآن الكريم';

  @override
  String get quran_meccan => 'مكية';

  @override
  String get quran_medinan => 'مدنية';

  @override
  String quran_ayahCount(int count) {
    return '$count آية';
  }

  @override
  String get quran_searchHint => 'ابحث في القرآن الكريم...';

  @override
  String get quran_noResults => 'لا توجد نتائج';

  @override
  String get quran_searchPrompt => 'اكتب كلمة للبحث';

  @override
  String get quran_tapForTafsir => 'اضغط مطولاً على أي آية لعرض التفسير';

  @override
  String quran_tafsirTitle(int number) {
    return 'تفسير الآية $number';
  }

  @override
  String get quran_tafsirSource => 'الميسر';

  @override
  String get quran_tafsirError => 'تعذّر تحميل التفسير';

  @override
  String get quran_reciter => 'القارئ';

  @override
  String get quran_selectReciter => 'اختر القارئ';

  @override
  String get quran_searchReciter => 'ابحث عن قارئ...';

  @override
  String get quran_playPrompt => 'اضغط للاستماع';

  @override
  String quran_ayahNumber(int number) {
    return 'الآية $number';
  }

  @override
  String get quran_toggleDisplayMode => 'تبديل نمط العرض (مصحف/ترجمة)';

  @override
  String get quran_toggleTajweed => 'تبديل تلوين أحكام التجويد';

  @override
  String get athkar_title => 'الأذكار';

  @override
  String get athkar_morning => 'أذكار الصباح';

  @override
  String get athkar_evening => 'أذكار المساء';

  @override
  String get athkar_sleep => 'أذكار النوم';

  @override
  String get athkar_wake => 'أذكار الاستيقاظ';

  @override
  String get athkar_prayer => 'أذكار بعد الصلاة';

  @override
  String get athkar_general => 'أذكار متنوعة';

  @override
  String get athkar_tapToCount => 'اضغط للعدّ';

  @override
  String get athkar_transitioning => 'جارٍ الانتقال...';

  @override
  String athkar_completed(String name) {
    return 'اكتملت $name';
  }

  @override
  String get athkar_next => 'التالي';

  @override
  String get athkar_prev => 'السابق';

  @override
  String get athkar_finish => 'إنهاء';

  @override
  String get athkar_back => 'رجوع';

  @override
  String athkar_source(String source) {
    return 'رواه $source';
  }

  @override
  String get hadith_title => 'الحديث الشريف';

  @override
  String get hadith_searchHint => 'ابحث في الأحاديث...';

  @override
  String get hadith_noResults => 'لا توجد نتائج للبحث';

  @override
  String get hadith_tapForDetail => 'اضغط لعرض كامل';

  @override
  String get hadith_retryButton => 'إعادة المحاولة';

  @override
  String get hadith_loadError => 'تعذّر التحميل';

  @override
  String hadith_readProgress(int read, int total) {
    return 'قرأت $read من $total';
  }

  @override
  String get qibla_title => 'اتجاه القبلة';

  @override
  String get qibla_active => 'البوصلة نشطة';

  @override
  String get qibla_error => 'تعذّر تحديد اتجاه القبلة';

  @override
  String get qibla_errorHint => 'تأكد من تفعيل البوصلة والموقع';

  @override
  String get qibla_staticMode => 'وضع ثابت (لا مستشعر بوصلة)';

  @override
  String get qibla_calibrationHint => 'حرّك جهازك على شكل ٨ لمعايرة البوصلة';

  @override
  String get qibla_kaaba => 'الكعبة';

  @override
  String get qibla_fromNorth => 'من الشمال باتجاه القبلة';

  @override
  String qibla_distanceKm(int km, String kaaba) {
    return '$km كم إلى $kaaba';
  }

  @override
  String get stats_title => 'إحصائياتي';

  @override
  String get stats_prayerStreak => 'سلسلة الصلوات';

  @override
  String get stats_totalPrayers => 'إجمالي الصلوات';

  @override
  String get stats_quranPages => 'صفحات القرآن';

  @override
  String get stats_athkarSessions => 'الأذكار';

  @override
  String get stats_khatma => 'ختمات القرآن';

  @override
  String get stats_days => 'يوم متتالي';

  @override
  String get stats_prayers => 'صلاة';

  @override
  String get stats_pages => 'صفحة';

  @override
  String get stats_sessions => 'جلسة';

  @override
  String get stats_khatmaUnit => 'ختمة';

  @override
  String get stats_currentKhatma => 'تقدم الختمة الحالية';

  @override
  String get more_title => 'المزيد';

  @override
  String get library_title => 'المكتبة الشاملة';

  @override
  String get more_qibla => 'اتجاه القبلة';

  @override
  String get more_stats => 'إحصائياتي';

  @override
  String get common_loading => 'جار التحميل...';

  @override
  String get common_error => 'خطأ في التحميل';

  @override
  String get common_retry => 'إعادة المحاولة';

  @override
  String get common_back => 'رجوع';

  @override
  String get common_next => 'التالي';

  @override
  String get common_save => 'حفظ';

  @override
  String get common_cancel => 'إلغاء';

  @override
  String get common_done => 'تم';

  @override
  String get common_search => 'بحث';

  @override
  String get common_noData => 'لا توجد بيانات';

  @override
  String get common_offline => 'لا يوجد اتصال بالإنترنت';

  @override
  String get common_close => 'إغلاق';

  @override
  String get common_share => 'مشاركة';

  @override
  String get common_refresh => 'تحديث';

  @override
  String get common_prevPage => 'الصفحة السابقة';

  @override
  String get common_nextPage => 'الصفحة التالية';

  @override
  String get common_clearSearch => 'مسح البحث';

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
  String get time_hr => 'ساعة';

  @override
  String get time_min => 'دقيقة';

  @override
  String get time_sec => 'ثانية';

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
  String get radio_play => 'تشغيل';

  @override
  String get radio_pause => 'إيقاف مؤقت';

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
  String get cal_prevMonth => 'الشهر السابق';

  @override
  String get cal_nextMonth => 'الشهر التالي';

  @override
  String get cal_legendEid => 'عيد';

  @override
  String get cal_legendFast => 'صيام';

  @override
  String get cal_legendBlessed => 'مبارك';

  @override
  String get cal_hijriOffset => 'تصحيح الهجري';

  @override
  String get cal_wd_sun => 'أحد';

  @override
  String get cal_wd_mon => 'اثنين';

  @override
  String get cal_wd_tue => 'ثلاثاء';

  @override
  String get cal_wd_wed => 'أربعاء';

  @override
  String get cal_wd_thu => 'خميس';

  @override
  String get cal_wd_fri => 'جمعة';

  @override
  String get cal_wd_sat => 'سبت';

  @override
  String get cal_detailPending =>
      'لا تفاصيل إضافية (آية/حديث/وصف) متاحة بعد لهذه المناسبة - قيد المراجعة الدينية.';

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
  String get onboarding_languageTitle => 'اختر اللغة';

  @override
  String get onboarding_languageSubtitle => 'يمكنك تغييره لاحقاً من الإعدادات';

  @override
  String get onboarding_modeTitle => 'اختر وضع التطبيق';

  @override
  String get onboarding_modeSubtitle => 'يمكنك تغييره لاحقاً من الإعدادات';

  @override
  String get onboarding_liteSubtitle => 'الأساسيات · سريع · offline كامل';

  @override
  String get onboarding_fullSubtitle => 'كل الميزات · شامل · عميق';

  @override
  String get onboarding_andMore => '+ المزيد';

  @override
  String get onboarding_madhabTitle => 'المذهب الفقهي';

  @override
  String get onboarding_madhabSubtitle => 'لحساب أوقات الصلاة بدقة';

  @override
  String get onboarding_locationTitle => 'تحديد موقعك';

  @override
  String get onboarding_locationSubtitle => 'لأوقات صلاة دقيقة';

  @override
  String get onboarding_locationBody =>
      'التطبيق سيطلب إذن الموقع\nلتحديد أوقات الصلاة تلقائياً';

  @override
  String get onboarding_locationPrivacy => 'بياناتك تبقى على جهازك فقط';

  @override
  String get onboarding_start => 'ابدأ';

  @override
  String get settings_dirRtl => 'RTL';

  @override
  String get settings_dirLtr => 'LTR';

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
  String get settings_previewAdhan => 'معاينة صوت الأذان';

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
  String get settings_fontQuran => 'شهرزاد';

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
  String get settings_licenses => 'التراخيص';

  @override
  String get settings_openSourcePackages => 'تراخيص الحزم مفتوحة المصدر';

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
  String get calc_Karachi => 'جامعة كراتشي';

  @override
  String get calc_Singapore => 'سنغافورة';

  @override
  String get calc_Turkey => 'تركيا (ديانت)';

  @override
  String get calc_MoonSighting => 'لجنة رؤية الهلال';

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

  @override
  String get search_typeAthkar => 'ذكر';

  @override
  String get search_partialResults =>
      'تعذّر الوصول لبعض المصادر — النتائج قد تكون غير مكتملة';

  @override
  String get stats_daysStreak => 'يوم متتالي';

  @override
  String get stats_prayersUnit => 'صلاة';

  @override
  String get stats_pagesUnit => 'صفحة';

  @override
  String get stats_athkar => 'الأذكار';

  @override
  String get stats_sessionsUnit => 'جلسة';

  @override
  String stats_pagesOf(int read, int total) {
    return '$read / $total صفحة';
  }

  @override
  String get reader_tapToListen => 'اضغط للاستماع';

  @override
  String reader_ayahNum(int n) {
    return 'الآية $n';
  }

  @override
  String get reader_reciter => 'القارئ';

  @override
  String get reader_chooseReciter => 'اختر القارئ';

  @override
  String get reader_searchReciter => 'ابحث عن قارئ...';

  @override
  String get reader_longPressHint =>
      'اضغط مطولاً على أي آية للبوابة والتفسير والمشاركة';

  @override
  String get reader_versePortal => 'بوابة الآية';

  @override
  String get reader_portalSub => 'تفسير · كلمات · سياق';

  @override
  String get reader_showTafsir => 'عرض التفسير';

  @override
  String get reader_shareAyah => 'مشاركة الآية';

  @override
  String get reader_copyAyah => 'نسخ الآية';

  @override
  String get reader_ayahCopied => 'تم نسخ الآية';

  @override
  String reader_tafsirOf(int n) {
    return 'تفسير الآية $n';
  }

  @override
  String get reader_muyassar => 'الميسر';

  @override
  String get reader_tafsirError => 'تعذّر تحميل التفسير';

  @override
  String get reader_shareTitle => 'آية كريمة';

  @override
  String reader_shareSubtitle(String surah, int n) {
    return '$surah · آية $n';
  }

  @override
  String get portal_muyassar => 'التفسير الميسّر';

  @override
  String get portal_words => 'الشرح اللغوي';

  @override
  String get portal_hadiths => 'أحاديث';

  @override
  String get portal_adwaaHadiths => 'أضواء البيان';

  @override
  String get portal_stories => 'قصص وسير';

  @override
  String get portal_arabicTafsir => 'التفاسير بالعربية';

  @override
  String get portal_foreignTafsir => 'التفاسير بلغات أجنبية';

  @override
  String get portal_asbab => 'سبب النزول';

  @override
  String get portal_searchLang => 'ابحث عن لغة...';

  @override
  String get portal_error => 'تعذّر فتح البوابة';

  @override
  String get portal_back => 'رجوع';

  @override
  String get portal_noTafsir => 'لا يوجد تفسير';

  @override
  String get portal_loadError => 'تعذّر التحميل';

  @override
  String get portal_reportTranslation => 'أبلغ عن خطأ ترجمة';

  @override
  String get portal_reportDialogTitle => 'الإبلاغ عن خطأ في الترجمة';

  @override
  String get portal_reportIssueLabel => 'صف المشكلة';

  @override
  String get portal_reportIssueHint => 'مثال: كلمة مفقودة، معنى غير دقيق...';

  @override
  String get portal_reportNoteLabel => 'ملاحظة إضافية (اختياري)';

  @override
  String get portal_reportCancel => 'إلغاء';

  @override
  String get portal_reportSubmit => 'إرسال';

  @override
  String get portal_reportSuccess => 'شكراً، وصل بلاغك وسيُراجَع';

  @override
  String get portal_reportError => 'تعذّر إرسال البلاغ، حاول لاحقاً';

  @override
  String get portal_reportIssueRequired => 'يرجى وصف المشكلة';

  @override
  String get portal_translationPendingReview => 'بانتظار مراجعة المجتمع';

  @override
  String get portal_comingSoon => 'قريباً';

  @override
  String get portal_noHadiths => 'لا توجد أحاديث مرتبطة بهذه الآية حتى الآن';

  @override
  String get portal_addingContent => 'نعمل على إضافة المحتوى تدريجياً';

  @override
  String get more_search => 'البحث الموحد';

  @override
  String get more_settings => 'الإعدادات';

  @override
  String get more_calendar => 'التقويم الإسلامي';

  @override
  String get more_shareCards => 'بطاقات المشاركة';

  @override
  String get more_fullMode => 'الوضع الكامل';

  @override
  String get more_radio => 'راديو القرآن';

  @override
  String get more_mosques => 'المساجد القريبة';

  @override
  String get more_groupPrayerTools => 'أدوات الصلاة';

  @override
  String get more_groupContent => 'محتوى';

  @override
  String get mosques_searching => 'جاري البحث عن المساجد القريبة...';

  @override
  String get mosques_unnamed => 'مسجد غير مسمى';

  @override
  String get mosques_notFound => 'لم يتم العثور على مساجد قريبة';

  @override
  String get mosques_permissionDenied => 'الإذن بالموقع مرفوض';

  @override
  String get mosques_permissionDeniedHint =>
      'امنح إذن الموقع من إعدادات الجهاز لعرض المساجد القريبة';

  @override
  String get mosques_serviceDisabled => 'خدمة الموقع معطّلة';

  @override
  String get mosques_serviceDisabledHint =>
      'فعّل خدمة الموقع (GPS) من إعدادات جهازك';

  @override
  String get mosques_networkError => 'تعذّر الاتصال بالخادم';

  @override
  String get mosques_networkErrorHint =>
      'تحقّق من اتصالك بالإنترنت وحاول مجدداً';

  @override
  String get mosques_openSettings => 'فتح الإعدادات';

  @override
  String get mosques_directions => 'الاتجاهات';

  @override
  String get mosques_desktopOnly => 'هذه الميزة تعمل على Android وiOS فقط';

  @override
  String get athkarcat_error => 'خطأ';

  @override
  String get athkarcat_empty => 'لا توجد أذكار';

  @override
  String athkarcat_completed(String name) {
    return 'اكتملت $name';
  }

  @override
  String get athkarcat_back => 'رجوع';

  @override
  String get athkarcat_next => 'التالي';

  @override
  String get athkarcat_finish => 'إنهاء';

  @override
  String get athkarcat_prev => 'السابق';

  @override
  String athkarcat_repeat(int count, String source) {
    return 'التكرار: $count · $source';
  }

  @override
  String athkarcat_narrated(String source) {
    return 'رواه $source';
  }

  @override
  String get athkarcat_moving => 'جارٍ الانتقال...';

  @override
  String get athkarcat_tapCount => 'اضغط للعدّ';

  @override
  String get athkar_allSections => 'جميع الأقسام';

  @override
  String get gateway_entry_title => 'تعرّف على الإسلام';

  @override
  String get gateway_intro_title => 'رحلة الوعي الروحي';

  @override
  String get gateway_journey_title => 'رحلة الوعي';

  @override
  String get gateway_principles_title => 'مبادئ الإسلام';

  @override
  String get gateway_library_title => 'مكتبة التعمّق';

  @override
  String get gateway_begin => 'ابدأ الرحلة';

  @override
  String get gateway_next => 'التالي';

  @override
  String get gateway_prev => 'السابق';

  @override
  String get app_tagline => 'دليلك الإسلامي';

  @override
  String get app_brand_name => 'SIRAJ';

  @override
  String get gateway_shahada_cta => 'أعلن شهادتك الآن';

  @override
  String get nav_library => 'المكتبة';

  @override
  String get library_could_not_load => 'تعذّر التحميل';

  @override
  String get library_section_not_found => 'القسم غير موجود';

  @override
  String get library_content_title => 'المحتوى';

  @override
  String get library_search_in_category => 'ابحث في هذا التصنيف...';

  @override
  String get library_no_matching_results => 'لا توجد نتائج مطابقة';

  @override
  String get library_no_materials_lang =>
      'لا توجد مواد متاحة حالياً بهذه اللغة';

  @override
  String get library_connection_failed =>
      'تعذّر الاتصال. تحقّق من الإنترنت وحاول مجدداً';

  @override
  String get library_search_content_type => 'ابحث عن نوع المحتوى...';

  @override
  String get library_choose_content_type => 'اختر نوع المحتوى';

  @override
  String get library_no_content_lang => 'لا يوجد محتوى متاح حالياً بهذه اللغة';

  @override
  String get library_not_found => 'غير موجود';

  @override
  String get library_search_in_section => 'ابحث في هذا القسم...';

  @override
  String get library_no_categories => 'لا توجد تصنيفات متاحة حالياً';

  @override
  String library_subcategoryCount(int count) {
    return '$count مجلدات';
  }

  @override
  String get library_authorsSection => 'المؤلفون';

  @override
  String get library_type_books => 'كتب';

  @override
  String get library_type_audios => 'صوتيات';

  @override
  String get library_type_videos => 'مرئيات';

  @override
  String get library_type_articles => 'مقالات';

  @override
  String get adhan_makkah => 'مكي (الحرم المكي)';

  @override
  String get adhan_madinah => 'مديني (الحرم النبوي)';

  @override
  String get adhan_mustafa_ismail => 'مصطفى إسماعيل';

  @override
  String get adhan_iraqi => 'عراقي';

  @override
  String get adhan_turkish => 'تركي';

  @override
  String get adhan_moroccan => 'مغربي';

  @override
  String get adhan_indonesian => 'أندونيسي';

  @override
  String get adhan_classic => 'كلاسيكي';

  @override
  String prayer_notification_title(Object prayer) {
    return 'حان وقت $prayer';
  }

  @override
  String get prayer_notification_body => 'الله أكبر، حي على الصلاة';

  @override
  String get iqama_notification_title => 'تنبيه الإقامة';

  @override
  String iqama_notification_body(Object minutes, Object prayer) {
    return 'الإقامة بعد $minutes دقيقة — $prayer';
  }

  @override
  String get khatmah_title => 'الختمات';

  @override
  String get khatmah_new => 'ختمة جديدة';

  @override
  String get khatmah_empty => 'لا توجد ختمات بعد. ابدأ ختمتك الأولى!';

  @override
  String get khatmah_name => 'اسم الختمة';

  @override
  String get khatmah_duration_days => 'المدة (أيام)';

  @override
  String get khatmah_daily_pages => 'الوِرد اليومي (صفحات)';

  @override
  String get khatmah_reminder_time => 'وقت التذكير';

  @override
  String get khatmah_create => 'إنشاء الختمة';

  @override
  String get khatmah_preset_ramadan => 'رمضان (30 يوما)';

  @override
  String get khatmah_preset_weekly => 'أسبوعية (7 أيام)';

  @override
  String get khatmah_preset_monthly => 'شهرية (30 يوماً)';

  @override
  String get khatmah_status_ontrack => 'على المسار';

  @override
  String get khatmah_status_behind => 'متأخر';

  @override
  String get khatmah_status_ahead => 'متقدّم';

  @override
  String get khatmah_status_completed => 'مكتملة';

  @override
  String get khatmah_today_portion => 'وردك اليوم';

  @override
  String get khatmah_read_now => 'اقرأ الآن';

  @override
  String get khatmah_page => 'صفحة';

  @override
  String khatmah_day_of(Object current, Object total) {
    return 'اليوم $current من $total';
  }

  @override
  String get khatmah_delete_confirm => 'هل تريد حذف هذه الختمة؟';

  @override
  String get khatmah_progress => 'التقدّم';

  @override
  String khatmah_share_text(Object day, Object name, Object percent) {
    return 'أنا في يومي $day من ختمة $name، أكملت $percent% حتى الآن. اللهم اجعلنا من أهل القرآن 🤲';
  }

  @override
  String get auth_welcome_title => 'أهلاً بك في سراج';

  @override
  String get auth_welcome_subtitle =>
      'سجّل الدخول لمزامنة تقدمك عبر أجهزتك، أو تابع كضيف';

  @override
  String get auth_email_hint => 'بريدك الإلكتروني';

  @override
  String get auth_send_magic_link => 'أرسل رابط الدخول';

  @override
  String get auth_magic_link_sent =>
      'أرسلنا رابط الدخول إلى بريدك. تحقق منه لإكمال الدخول';

  @override
  String get auth_or => 'أو';

  @override
  String get auth_continue_google => 'المتابعة عبر Google';

  @override
  String get auth_continue_apple => 'المتابعة عبر Apple';

  @override
  String get auth_continue_guest => 'المتابعة كضيف';

  @override
  String get auth_guest_note => 'يمكنك استخدام كل ميزات سراج فوراً بلا تسجيل';

  @override
  String get auth_invalid_email => 'يرجى إدخال بريد إلكتروني صحيح';

  @override
  String get auth_error_generic => 'حدث خطأ ما. حاول مرة أخرى';

  @override
  String get auth_sign_out => 'تسجيل الخروج';

  @override
  String get auth_delete_account => 'حذف الحساب';

  @override
  String get auth_delete_account_confirm =>
      'سيُحذف حسابك وكل بياناته نهائياً. هذا الإجراء لا يمكن التراجع عنه.';

  @override
  String get auth_delete_account_success => 'تم حذف حسابك بنجاح';

  @override
  String get auth_account_settings => 'الحساب';

  @override
  String get auth_signed_in_as => 'مسجَّل الدخول باسم';

  @override
  String get auth_guest_account => 'حساب ضيف';

  @override
  String get sections_customize_title => 'تخصيص الأقسام';

  @override
  String get sections_customize_subtitle =>
      'اختر الأقسام التي تريد إظهارها. البيانات المحلية تبقى محفوظة عند الإيقاف';

  @override
  String get sections_full_mode_required =>
      'فعّل الوضع الكامل من الإعدادات لتخصيص الأقسام';

  @override
  String get sections_full_mode_notice =>
      'أنت في الوضع الكامل، وكل أقسام التطبيق مفعَّلة تلقائياً. التخصيص متاح فقط في الوضع الخفيف';

  @override
  String get section_quran_reader => 'القرآن الكريم';

  @override
  String get section_adhan => 'الأذان';

  @override
  String get section_prayer => 'أوقات الصلاة';

  @override
  String get section_qibla => 'القبلة';

  @override
  String get section_athkar => 'الأذكار';

  @override
  String get section_hadith => 'الأحاديث';

  @override
  String get section_radio => 'الراديو';

  @override
  String get section_hifz => 'الحفظ';

  @override
  String get section_khatmah => 'الختمة';

  @override
  String get section_library => 'المكتبة';

  @override
  String get section_mosques => 'المساجد القريبة';

  @override
  String get section_ruqyah => 'الرقية';

  @override
  String get section_dua_journal => 'سجل الأدعية';

  @override
  String get section_mihrab => 'المحراب';

  @override
  String get section_qke => 'بوابة الآيات';

  @override
  String get section_timeline => 'الخط الزمني';

  @override
  String get section_new_muslim => 'حديث الإسلام';

  @override
  String get section_calendar => 'التقويم الهجري';

  @override
  String get section_share_cards => 'بطاقات المشاركة';

  @override
  String get section_gateway => 'بوابة التعرف على الإسلام';

  @override
  String get section_stories => 'القصص';

  @override
  String get section_children_stories => 'قصص الأطفال';
}
