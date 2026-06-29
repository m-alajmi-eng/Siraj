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
}
