// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appName => 'シラージュ';

  @override
  String get prayer_title => '礼拝時間';

  @override
  String get prayer_nextPrayer => '次の礼拝';

  @override
  String get prayer_fajr => 'ファジュル';

  @override
  String get prayer_sunrise => '日の出';

  @override
  String get prayer_dhuhr => 'ズフル';

  @override
  String get prayer_asr => 'アスル';

  @override
  String get prayer_maghrib => 'マグリブ';

  @override
  String get prayer_isha => 'イシャー';

  @override
  String prayer_countdown(String time) {
    return '$time後';
  }

  @override
  String get prayer_locationGPS => '現在地';

  @override
  String get prayer_locationDefault => 'リヤド（デフォルト）';

  @override
  String get quran_title => '神聖なるクルアーン';

  @override
  String get quran_meccan => 'マッカ章';

  @override
  String get quran_medinan => 'マディーナ章';

  @override
  String quran_ayahCount(int count) {
    return '$count節';
  }

  @override
  String get quran_searchHint => 'クルアーンを検索...';

  @override
  String get quran_noResults => '結果なし';

  @override
  String get quran_searchPrompt => '検索する単語を入力';

  @override
  String get quran_tapForTafsir => '節を長押しでタフスィール';

  @override
  String quran_tafsirTitle(int number) {
    return '第$number節のタフスィール';
  }

  @override
  String get quran_tafsirSource => 'アル・ムヤッサル';

  @override
  String get quran_tafsirError => 'タフスィールを読み込めません';

  @override
  String get quran_reciter => '朗誦者';

  @override
  String get quran_selectReciter => '朗誦者を選択';

  @override
  String get quran_searchReciter => '朗誦者を検索...';

  @override
  String get quran_playPrompt => 'タップして聴く';

  @override
  String quran_ayahNumber(int number) {
    return '第$number節';
  }

  @override
  String get athkar_title => 'ズィクル';

  @override
  String get athkar_morning => '朝のズィクル';

  @override
  String get athkar_evening => '夕方のズィクル';

  @override
  String get athkar_sleep => '就寝のズィクル';

  @override
  String get athkar_wake => '起床のズィクル';

  @override
  String get athkar_prayer => '礼拝後のズィクル';

  @override
  String get athkar_general => '一般的なズィクル';

  @override
  String get athkar_tapToCount => 'タップして数える';

  @override
  String get athkar_transitioning => '移行中...';

  @override
  String athkar_completed(String name) {
    return '$name完了';
  }

  @override
  String get athkar_next => '次へ';

  @override
  String get athkar_prev => '前へ';

  @override
  String get athkar_finish => '終了';

  @override
  String get athkar_back => '戻る';

  @override
  String athkar_source(String source) {
    return '$source伝承';
  }

  @override
  String get hadith_title => 'ハディース';

  @override
  String get hadith_searchHint => 'ハディースを検索...';

  @override
  String get hadith_noResults => '結果なし';

  @override
  String get hadith_tapForDetail => 'タップして全文を読む';

  @override
  String get hadith_retryButton => '再試行';

  @override
  String get hadith_loadError => '読み込み失敗';

  @override
  String get qibla_title => 'キブラの方向';

  @override
  String get qibla_active => 'コンパス有効';

  @override
  String get qibla_error => 'キブラの方向を特定できません';

  @override
  String get qibla_errorHint => 'コンパスと位置情報を有効にしてください';

  @override
  String get qibla_kaaba => 'カアバ';

  @override
  String get qibla_fromNorth => '北からキブラへの度数';

  @override
  String get stats_title => 'マイ統計';

  @override
  String get stats_prayerStreak => '礼拝連続記録';

  @override
  String get stats_totalPrayers => '礼拝合計';

  @override
  String get stats_quranPages => 'クルアーンページ数';

  @override
  String get stats_athkarSessions => 'ズィクル';

  @override
  String get stats_khatma => 'クルアーン完読回数';

  @override
  String get stats_days => '連続日';

  @override
  String get stats_prayers => '回';

  @override
  String get stats_pages => 'ページ';

  @override
  String get stats_sessions => 'セッション';

  @override
  String get stats_khatmaUnit => '回完読';

  @override
  String get stats_currentKhatma => '現在の完読進捗';

  @override
  String get more_title => 'その他';

  @override
  String get more_qibla => 'キブラの方向';

  @override
  String get more_stats => 'マイ統計';

  @override
  String get common_loading => '読み込み中...';

  @override
  String get common_error => 'データ読み込みエラー';

  @override
  String get common_retry => '再試行';

  @override
  String get common_back => '戻る';

  @override
  String get common_next => '次へ';

  @override
  String get common_save => '保存';

  @override
  String get common_cancel => 'キャンセル';

  @override
  String get common_done => '完了';

  @override
  String get common_search => '検索';

  @override
  String get common_noData => 'データなし';

  @override
  String get common_offline => 'インターネット接続なし';

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
}
