// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appName => '시라즈';

  @override
  String get prayer_title => '예배 시간';

  @override
  String get prayer_nextPrayer => '다음 예배';

  @override
  String get prayer_fajr => '파즈르';

  @override
  String get prayer_sunrise => '일출';

  @override
  String get prayer_dhuhr => '주흐르';

  @override
  String get prayer_asr => '아스르';

  @override
  String get prayer_maghrib => '마그립';

  @override
  String get prayer_isha => '이샤';

  @override
  String prayer_countdown(String time) {
    return '$time 후';
  }

  @override
  String get prayer_locationGPS => '현재 위치';

  @override
  String get prayer_locationDefault => '리야드 (기본값)';

  @override
  String get quran_title => '성 꾸란';

  @override
  String get quran_meccan => '메카 수라';

  @override
  String get quran_medinan => '메디나 수라';

  @override
  String quran_ayahCount(int count) {
    return '$count절';
  }

  @override
  String get quran_searchHint => '꾸란 검색...';

  @override
  String get quran_noResults => '결과 없음';

  @override
  String get quran_searchPrompt => '검색할 단어 입력';

  @override
  String get quran_tapForTafsir => '절을 길게 눌러 타프시르 보기';

  @override
  String quran_tafsirTitle(int number) {
    return '$number절 타프시르';
  }

  @override
  String get quran_tafsirSource => '알-무야싸르';

  @override
  String get quran_tafsirError => '타프시르를 불러올 수 없습니다';

  @override
  String get quran_reciter => '낭송자';

  @override
  String get quran_selectReciter => '낭송자 선택';

  @override
  String get quran_searchReciter => '낭송자 검색...';

  @override
  String get quran_playPrompt => '탭하여 듣기';

  @override
  String quran_ayahNumber(int number) {
    return '$number절';
  }

  @override
  String get athkar_title => '지크르';

  @override
  String get athkar_morning => '아침 지크르';

  @override
  String get athkar_evening => '저녁 지크르';

  @override
  String get athkar_sleep => '취침 지크르';

  @override
  String get athkar_wake => '기상 지크르';

  @override
  String get athkar_prayer => '예배 후 지크르';

  @override
  String get athkar_general => '일반 지크르';

  @override
  String get athkar_tapToCount => '탭하여 세기';

  @override
  String get athkar_transitioning => '진행 중...';

  @override
  String athkar_completed(String name) {
    return '$name 완료';
  }

  @override
  String get athkar_next => '다음';

  @override
  String get athkar_prev => '이전';

  @override
  String get athkar_finish => '완료';

  @override
  String get athkar_back => '뒤로';

  @override
  String athkar_source(String source) {
    return '$source 전승';
  }

  @override
  String get hadith_title => '하디스';

  @override
  String get hadith_searchHint => '하디스 검색...';

  @override
  String get hadith_noResults => '결과 없음';

  @override
  String get hadith_tapForDetail => '탭하여 전체 읽기';

  @override
  String get hadith_retryButton => '다시 시도';

  @override
  String get hadith_loadError => '불러오기 실패';

  @override
  String get qibla_title => '끼블라 방향';

  @override
  String get qibla_active => '나침반 활성';

  @override
  String get qibla_error => '끼블라 방향을 결정할 수 없습니다';

  @override
  String get qibla_errorHint => '나침반과 위치를 활성화하세요';

  @override
  String get qibla_kaaba => '카바';

  @override
  String get qibla_fromNorth => '북쪽에서 끼블라까지 각도';

  @override
  String get stats_title => '내 통계';

  @override
  String get stats_prayerStreak => '예배 연속';

  @override
  String get stats_totalPrayers => '총 예배';

  @override
  String get stats_quranPages => '꾸란 페이지';

  @override
  String get stats_athkarSessions => '지크르';

  @override
  String get stats_khatma => '꾸란 완독';

  @override
  String get stats_days => '연속 일';

  @override
  String get stats_prayers => '회';

  @override
  String get stats_pages => '페이지';

  @override
  String get stats_sessions => '세션';

  @override
  String get stats_khatmaUnit => '회 완독';

  @override
  String get stats_currentKhatma => '현재 완독 진행률';

  @override
  String get more_title => '더보기';

  @override
  String get more_qibla => '끼블라 방향';

  @override
  String get more_stats => '내 통계';

  @override
  String get common_loading => '로딩 중...';

  @override
  String get common_error => '데이터 로딩 오류';

  @override
  String get common_retry => '다시 시도';

  @override
  String get common_back => '뒤로';

  @override
  String get common_next => '다음';

  @override
  String get common_save => '저장';

  @override
  String get common_cancel => '취소';

  @override
  String get common_done => '완료';

  @override
  String get common_search => '검색';

  @override
  String get common_noData => '데이터 없음';

  @override
  String get common_offline => '인터넷 연결 없음';

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
}
