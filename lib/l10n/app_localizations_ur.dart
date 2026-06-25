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
  String get prayer_locationDefault => 'ریاض (پہلے سے طے شدہ)';

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
  String get qibla_title => 'قبلہ کی سمت';

  @override
  String get qibla_active => 'کمپاس فعال ہے';

  @override
  String get qibla_error => 'قبلہ کی سمت معلوم نہیں ہو سکی';

  @override
  String get qibla_errorHint => 'کمپاس اور مقام کو فعال کریں';

  @override
  String get qibla_kaaba => 'کعبہ';

  @override
  String get qibla_fromNorth => 'شمال سے قبلہ کی طرف ڈگری';

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
}
