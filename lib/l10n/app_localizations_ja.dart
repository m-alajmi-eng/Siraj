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
}
