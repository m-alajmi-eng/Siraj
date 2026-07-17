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
  String get time_hr => '时';

  @override
  String get time_min => '分';

  @override
  String get time_sec => '秒';

  @override
  String get home_continueReading => '继续阅读';

  @override
  String home_surah(int id) {
    return '第 $id 章';
  }

  @override
  String home_ayah(int number) {
    return '第 $number 节';
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
  String get radio_title => '希拉吉电台';

  @override
  String get radio_all => '全部';

  @override
  String get radio_quran => '古兰经';

  @override
  String get radio_translations => '翻译';

  @override
  String get radio_tafsir => '经注与教法';

  @override
  String get radio_athkar => '记主词';

  @override
  String get radio_international => '国际';

  @override
  String get cal_title => '伊斯兰历';

  @override
  String get cal_todayEvents => '今日事件';

  @override
  String get cal_nextEvent => '下一个事件';

  @override
  String get cal_allEvents => '伊斯兰节日';

  @override
  String cal_daysUntil(int days) {
    return '$days 天';
  }

  @override
  String get cal_gregorian => '公历';

  @override
  String get cal_hijri => '希吉来历';

  @override
  String get cal_prevMonth => '上个月';

  @override
  String get cal_nextMonth => '下个月';

  @override
  String get cal_legendEid => '开斋节/宰牲节';

  @override
  String get cal_legendFast => '斋戒';

  @override
  String get cal_legendBlessed => '吉庆';

  @override
  String get cal_detailPending => '此纪念日暂无更多详情（经文/圣训/说明）- 待宗教审核。';

  @override
  String get hm_1 => '穆哈兰姆月';

  @override
  String get hm_2 => '色法尔月';

  @override
  String get hm_3 => '赖比尔·敖外鲁月';

  @override
  String get hm_4 => '赖比尔·阿色尼月';

  @override
  String get hm_5 => '主马达·敖外鲁月';

  @override
  String get hm_6 => '主马达·阿色尼月';

  @override
  String get hm_7 => '赖哲卜月';

  @override
  String get hm_8 => '舍尔邦月';

  @override
  String get hm_9 => '莱麦丹月';

  @override
  String get hm_10 => '闪瓦鲁月';

  @override
  String get hm_11 => '都尔喀尔德月';

  @override
  String get hm_12 => '都尔黑哲月';

  @override
  String get ev_new_year => '伊斯兰新年';

  @override
  String get ev_ashura => '阿舒拉日';

  @override
  String get ev_mawlid => '圣纪节ﷺ';

  @override
  String get ev_isra => '夜行登霄';

  @override
  String get ev_ramadan_start => '莱麦丹月始';

  @override
  String get ev_laylat_qadr => '盖德尔夜';

  @override
  String get ev_eid_fitr => '开斋节';

  @override
  String get ev_arafah => '阿拉法特日';

  @override
  String get ev_eid_adha => '宰牲节';

  @override
  String get ev_tashreeq => '晾肉日';

  @override
  String get stories_title => '故事与圣传';

  @override
  String get stories_prophets => '众先知';

  @override
  String get stories_companions => '圣门弟子';

  @override
  String get stories_scholars => '学者';

  @override
  String get stories_comingSoon => '即将推出';

  @override
  String get stories_comingSoonMsg => '即将推出 — 内容准备中';

  @override
  String get children_title => '儿童故事';

  @override
  String get settings_secIdentity => '身份';

  @override
  String get settings_secAdhan => '宣礼';

  @override
  String get settings_secApp => '应用';

  @override
  String get settings_secPrivacy => '隐私';

  @override
  String get settings_secAbout => '关于';

  @override
  String get settings_language => '语言';

  @override
  String get settings_chooseLanguage => '选择语言';

  @override
  String get settings_madhab => '教法学派';

  @override
  String get settings_chooseMadhab => '选择教法学派';

  @override
  String get settings_calcMethod => '礼拜时间计算方法';

  @override
  String get settings_chooseCalc => '计算方法';

  @override
  String get settings_enableAdhan => '启用宣礼';

  @override
  String get settings_muezzinVoice => '宣礼员声音';

  @override
  String get settings_vibration => '震动代替声音';

  @override
  String get settings_iqamaAlert => '成拜前提醒';

  @override
  String settings_minutes(int n) {
    return '$n 分钟';
  }

  @override
  String get settings_appMode => '应用模式';

  @override
  String get settings_fullMode => '完整模式';

  @override
  String get settings_liteMode => '精简模式';

  @override
  String get settings_fullModeDesc => '所有功能可用';

  @override
  String get settings_liteModeDesc => '仅基础 — 离线';

  @override
  String get settings_quranFont => '古兰经字体';

  @override
  String get settings_fontUthmani => '奥斯曼体';

  @override
  String get settings_fontHafs => '哈夫斯体';

  @override
  String get settings_quranFontSize => '古兰经字体大小';

  @override
  String get settings_privacyNote => '您的位置仅保留在您的设备上';

  @override
  String get settings_clearCache => '清除缓存数据';

  @override
  String get settings_clearCacheTitle => '清除缓存';

  @override
  String get settings_clearCacheMsg => '本地保存的数据将被删除。您确定吗？';

  @override
  String get settings_cancel => '取消';

  @override
  String get settings_delete => '删除';

  @override
  String get settings_version => '版本';

  @override
  String get settings_shareApp => '分享应用';

  @override
  String get settings_tagline => '希拉吉 — 光上加光';

  @override
  String get madhab_hanafi => '哈乃斐派';

  @override
  String get madhab_maliki => '马立克派';

  @override
  String get madhab_shafi => '沙斐仪派';

  @override
  String get madhab_hanbali => '罕百里派';

  @override
  String get calc_MWL => '世界穆斯林联盟';

  @override
  String get calc_ISNA => '北美 (ISNA)';

  @override
  String get calc_Egypt => '埃及机构';

  @override
  String get calc_Makkah => '古拉母校 (麦加)';

  @override
  String get calc_Kuwait => '科威特';

  @override
  String get calc_Qatar => '卡塔尔';

  @override
  String get calc_Dubai => '迪拜';

  @override
  String get calc_Karachi => '卡拉奇';

  @override
  String get calc_Singapore => '新加坡';

  @override
  String get calc_Turkey => '土耳其（宗教事务局）';

  @override
  String get calc_MoonSighting => '月亮观测委员会';

  @override
  String get search_hint => '搜索古兰经与经注...';

  @override
  String get search_empty => '搜索《古兰经》、经注及词义';

  @override
  String search_noResults(String query) {
    return '未找到「$query」的结果';
  }

  @override
  String get search_typeAyah => '经文';

  @override
  String get search_typeTafsir => '经注';

  @override
  String get search_typeWord => '词语';

  @override
  String get search_typeHadith => '圣训';

  @override
  String get stats_daysStreak => '连续天数';

  @override
  String get stats_prayersUnit => '次礼拜';

  @override
  String get stats_pagesUnit => '页';

  @override
  String get stats_athkar => '记主词';

  @override
  String get stats_sessionsUnit => '次';

  @override
  String stats_pagesOf(int read, int total) {
    return '$read / $total 页';
  }

  @override
  String get reader_tapToListen => '点击聆听';

  @override
  String reader_ayahNum(int n) {
    return '第 $n 节';
  }

  @override
  String get reader_reciter => '诵读者';

  @override
  String get reader_chooseReciter => '选择诵读者';

  @override
  String get reader_searchReciter => '搜索诵读者...';

  @override
  String get reader_longPressHint => '长按任意经文以打开门户、经注与分享';

  @override
  String get reader_versePortal => '经文门户';

  @override
  String get reader_portalSub => '经注 · 词语 · 背景';

  @override
  String get reader_showTafsir => '显示经注';

  @override
  String get reader_shareAyah => '分享经文';

  @override
  String get reader_copyAyah => '复制经文';

  @override
  String get reader_ayahCopied => '经文已复制';

  @override
  String reader_tafsirOf(int n) {
    return '第 $n 节的经注';
  }

  @override
  String get reader_muyassar => '简明经注';

  @override
  String get reader_tafsirError => '经注加载失败';

  @override
  String get reader_shareTitle => '尊贵的经文';

  @override
  String reader_shareSubtitle(String surah, int n) {
    return '$surah · 第 $n 节';
  }

  @override
  String get portal_muyassar => '简明经注';

  @override
  String get portal_words => '词语分析';

  @override
  String get portal_hadiths => '圣训';

  @override
  String get portal_adwaaHadiths => '光明经注';

  @override
  String get portal_stories => '故事与圣传';

  @override
  String get portal_arabicTafsir => '阿拉伯文经注';

  @override
  String get portal_foreignTafsir => '其他语言经注';

  @override
  String get portal_asbab => '降示背景';

  @override
  String get portal_searchLang => '搜索语言...';

  @override
  String get portal_error => '无法打开门户';

  @override
  String get portal_back => '返回';

  @override
  String get portal_noTafsir => '暂无经注';

  @override
  String get portal_loadError => '加载失败';

  @override
  String get portal_comingSoon => '即将推出';

  @override
  String get portal_noHadiths => '暂无与此节经文相关的圣训';

  @override
  String get portal_addingContent => '内容正在逐步添加';

  @override
  String get more_search => '统一搜索';

  @override
  String get more_settings => '设置';

  @override
  String get more_calendar => '伊斯兰历';

  @override
  String get more_shareCards => '分享卡片';

  @override
  String get more_fullMode => '完整模式';

  @override
  String get more_radio => '古兰经电台';

  @override
  String get more_mosques => '附近的清真寺';

  @override
  String get athkarcat_error => '错误';

  @override
  String get athkarcat_empty => '暂无记主词';

  @override
  String athkarcat_completed(String name) {
    return '$name 已完成';
  }

  @override
  String get athkarcat_back => '返回';

  @override
  String get athkarcat_next => '下一个';

  @override
  String get athkarcat_finish => '完成';

  @override
  String get athkarcat_prev => '上一个';

  @override
  String athkarcat_repeat(int count, String source) {
    return '重复：$count · $source';
  }

  @override
  String athkarcat_narrated(String source) {
    return '$source 传述';
  }

  @override
  String get athkarcat_moving => '正在切换...';

  @override
  String get athkarcat_tapCount => '点击计数';

  @override
  String get athkar_allSections => '所有分类';

  @override
  String get gateway_entry_title => '认识伊斯兰';

  @override
  String get gateway_intro_title => '心灵觉悟之旅';

  @override
  String get gateway_journey_title => '旅程';

  @override
  String get gateway_principles_title => '伊斯兰的原则';

  @override
  String get gateway_library_title => '图书馆';

  @override
  String get gateway_begin => '开始旅程';

  @override
  String get gateway_next => '下一个';

  @override
  String get gateway_prev => '返回';

  @override
  String get app_tagline => '您的伊斯兰指南';

  @override
  String get app_brand_name => '希拉吉';

  @override
  String get gateway_shahada_cta => '现在宣读你的信仰';

  @override
  String get nav_library => '图书馆';

  @override
  String get library_could_not_load => '加载失败';

  @override
  String get library_section_not_found => '未找到该栏目';

  @override
  String get library_content_title => '内容';

  @override
  String get library_search_in_category => '在此分类中搜索...';

  @override
  String get library_no_matching_results => '没有匹配的结果';

  @override
  String get library_no_materials_lang => '该语言暂无相关资料';

  @override
  String get library_connection_failed => '连接失败，请检查网络后重试';

  @override
  String get library_search_content_type => '搜索内容类型...';

  @override
  String get library_choose_content_type => '选择内容类型';

  @override
  String get library_no_content_lang => '该语言暂无内容';

  @override
  String get library_not_found => '未找到';

  @override
  String get library_search_in_section => '在此栏目中搜索...';

  @override
  String get library_no_categories => '暂无可用分类';

  @override
  String get library_type_books => '书籍';

  @override
  String get library_type_audios => '音频';

  @override
  String get library_type_videos => '视频';

  @override
  String get library_type_articles => '文章';

  @override
  String get adhan_makkah => '麦加（禁寺）';

  @override
  String get adhan_madinah => '麦地那（先知清真寺）';

  @override
  String get adhan_mustafa_ismail => '穆斯塔法·伊斯梅尔';

  @override
  String get adhan_iraqi => '伊拉克风格';

  @override
  String get adhan_turkish => '土耳其风格';

  @override
  String get adhan_moroccan => '摩洛哥风格';

  @override
  String get adhan_indonesian => '印度尼西亚风格';

  @override
  String get adhan_classic => '经典风格';

  @override
  String prayer_notification_title(Object prayer) {
    return '$prayer时间到了';
  }

  @override
  String get prayer_notification_body => '真主至大，快来礼拜';

  @override
  String get khatmah_title => '诵读计划';

  @override
  String get khatmah_new => '新诵读计划';

  @override
  String get khatmah_empty => '还没有诵读计划。开始第一个吧！';

  @override
  String get khatmah_name => '计划名称';

  @override
  String get khatmah_duration_days => '天数';

  @override
  String get khatmah_daily_pages => '每日页数';

  @override
  String get khatmah_reminder_time => '提醒时间';

  @override
  String get khatmah_create => '创建计划';

  @override
  String get khatmah_preset_ramadan => '斋月（30天）';

  @override
  String get khatmah_preset_weekly => '每周（7天）';

  @override
  String get khatmah_preset_monthly => '每月（30天）';

  @override
  String get khatmah_status_ontrack => '进度正常';

  @override
  String get khatmah_status_behind => '落后';

  @override
  String get khatmah_status_ahead => '超前';

  @override
  String get khatmah_status_completed => '已完成';

  @override
  String get khatmah_today_portion => '今日诵读';

  @override
  String get khatmah_read_now => '现在阅读';

  @override
  String get khatmah_page => '页';

  @override
  String khatmah_day_of(Object current, Object total) {
    return '第 $current 天，共 $total 天';
  }

  @override
  String get khatmah_delete_confirm => '删除此计划？';

  @override
  String get khatmah_progress => '进度';

  @override
  String khatmah_share_text(Object day, Object name, Object percent) {
    return '我正在进行$name的第$day天，已完成$percent%。愿真主使我们成为古兰经的人 🤲';
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
