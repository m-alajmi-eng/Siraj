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
}
