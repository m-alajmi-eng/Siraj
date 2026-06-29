// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'Siraj';

  @override
  String get prayer_title => '礼拜时间';

  @override
  String get prayer_nextPrayer => '下次礼拜';

  @override
  String get prayer_fajr => '晨礼';

  @override
  String get prayer_sunrise => '日出';

  @override
  String get prayer_dhuhr => '晌礼';

  @override
  String get prayer_asr => '晡礼';

  @override
  String get prayer_maghrib => '昏礼';

  @override
  String get prayer_isha => '宵礼';

  @override
  String prayer_countdown(String time) {
    return '$time后';
  }

  @override
  String get prayer_locationGPS => '您的当前位置';

  @override
  String get prayer_locationDefault => '利雅得（默认）';

  @override
  String get quran_title => '神圣古兰经';

  @override
  String get quran_meccan => '麦加章';

  @override
  String get quran_medinan => '麦地那章';

  @override
  String quran_ayahCount(int count) {
    return '$count节';
  }

  @override
  String get quran_searchHint => '在古兰经中搜索...';

  @override
  String get quran_noResults => '没有结果';

  @override
  String get quran_searchPrompt => '输入单词进行搜索';

  @override
  String get quran_tapForTafsir => '长按经文查看注释';

  @override
  String quran_tafsirTitle(int number) {
    return '第$number节注释';
  }

  @override
  String get quran_tafsirSource => 'Al-Muyassar';

  @override
  String get quran_tafsirError => '无法加载注释';

  @override
  String get quran_reciter => '诵读者';

  @override
  String get quran_selectReciter => '选择诵读者';

  @override
  String get quran_searchReciter => '搜索诵读者...';

  @override
  String get quran_playPrompt => '点击收听';

  @override
  String quran_ayahNumber(int number) {
    return '第$number节';
  }

  @override
  String get athkar_title => '记念词';

  @override
  String get athkar_morning => '晨间记念词';

  @override
  String get athkar_evening => '傍晚记念词';

  @override
  String get athkar_sleep => '睡前记念词';

  @override
  String get athkar_wake => '晨起记念词';

  @override
  String get athkar_prayer => '礼拜后记念词';

  @override
  String get athkar_general => '常用记念词';

  @override
  String get athkar_tapToCount => '点击计数';

  @override
  String get athkar_transitioning => '进行中...';

  @override
  String athkar_completed(String name) {
    return '$name已完成';
  }

  @override
  String get athkar_next => '下一个';

  @override
  String get athkar_prev => '上一个';

  @override
  String get athkar_finish => '完成';

  @override
  String get athkar_back => '返回';

  @override
  String athkar_source(String source) {
    return '$source传述';
  }

  @override
  String get hadith_title => '圣训';

  @override
  String get hadith_searchHint => '搜索圣训...';

  @override
  String get hadith_noResults => '没有结果';

  @override
  String get hadith_tapForDetail => '点击阅读完整内容';

  @override
  String get hadith_retryButton => '重试';

  @override
  String get hadith_loadError => '加载失败';

  @override
  String get qibla_title => '朝拜方向';

  @override
  String get qibla_active => '指南针已激活';

  @override
  String get qibla_error => '无法确定朝拜方向';

  @override
  String get qibla_errorHint => '请开启指南针和位置服务';

  @override
  String get qibla_kaaba => '天房';

  @override
  String get qibla_fromNorth => '从北方到朝拜方向的度数';

  @override
  String get stats_title => '我的统计';

  @override
  String get stats_prayerStreak => '礼拜连续天数';

  @override
  String get stats_totalPrayers => '礼拜总数';

  @override
  String get stats_quranPages => '古兰经页数';

  @override
  String get stats_athkarSessions => '记念词';

  @override
  String get stats_khatma => '古兰经通读次数';

  @override
  String get stats_days => '连续天';

  @override
  String get stats_prayers => '次礼拜';

  @override
  String get stats_pages => '页';

  @override
  String get stats_sessions => '次';

  @override
  String get stats_khatmaUnit => '次通读';

  @override
  String get stats_currentKhatma => '当前通读进度';

  @override
  String get more_title => '更多';

  @override
  String get more_qibla => '朝拜方向';

  @override
  String get more_stats => '我的统计';

  @override
  String get common_loading => '加载中...';

  @override
  String get common_error => '加载数据出错';

  @override
  String get common_retry => '重试';

  @override
  String get common_back => '返回';

  @override
  String get common_next => '下一步';

  @override
  String get common_save => '保存';

  @override
  String get common_cancel => '取消';

  @override
  String get common_done => '完成';

  @override
  String get common_search => '搜索';

  @override
  String get common_noData => '暂无数据';

  @override
  String get common_offline => '无网络连接';

  @override
  String get nav_home => '主页';

  @override
  String get nav_quran => '古兰经';

  @override
  String get nav_athkar => '记主词';

  @override
  String get nav_hadith => '圣训';

  @override
  String get nav_more => '更多';

  @override
  String get home_greetingNight => '吉祥之夜，';

  @override
  String get home_greetingFajr => '黎明平安，';

  @override
  String get home_greetingMorning => '早上好，';

  @override
  String get home_greetingNoon => '下午好，';

  @override
  String get home_greetingAsr => '吉祥的午后，';

  @override
  String get home_greetingEvening => '晚上好，';

  @override
  String get home_greetingLateNight => '宁静之夜，';

  @override
  String get home_welcome => '欢迎';

  @override
  String get home_nextPrayer => '下一次礼拜';

  @override
  String get home_qiblaDirection => '朝向方位';

  @override
  String get home_continueReading => '继续阅读';

  @override
  String home_surah(int id) {
    return 'سورة #$id';
  }

  @override
  String home_ayah(int number) {
    return 'آية $number';
  }

  @override
  String get home_dailyAyah => '每日经文';

  @override
  String get home_quickAccess => '快速访问';

  @override
  String get home_searchHint => '您在寻找什么...';

  @override
  String get home_radio => '广播';

  @override
  String get home_calendar => '日历';

  @override
  String get home_stories => '故事';

  @override
  String get home_children => '儿童';

  @override
  String get settings_title => '设置';

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
