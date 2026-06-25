// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'সিরাজ';

  @override
  String get prayer_title => 'নামাজের সময়';

  @override
  String get prayer_nextPrayer => 'পরবর্তী নামাজ';

  @override
  String get prayer_fajr => 'ফজর';

  @override
  String get prayer_sunrise => 'সূর্যোদয়';

  @override
  String get prayer_dhuhr => 'যোহর';

  @override
  String get prayer_asr => 'আসর';

  @override
  String get prayer_maghrib => 'মাগরিব';

  @override
  String get prayer_isha => 'এশা';

  @override
  String prayer_countdown(String time) {
    return '$time এর মধ্যে';
  }

  @override
  String get prayer_locationGPS => 'আপনার বর্তমান অবস্থান';

  @override
  String get prayer_locationDefault => 'রিয়াদ (ডফল্ট)';

  @override
  String get quran_title => 'পবিত্র কুরআন';

  @override
  String get quran_meccan => 'মক';

  @override
  String get quran_medinan => 'মাদানী';

  @override
  String quran_ayahCount(int count) {
    return '$count আয়াত';
  }

  @override
  String get quran_searchHint => 'কুরআনে অনসন্ধান করুন...';

  @override
  String get quran_noResults => 'কোনো ফলাফল নেই';

  @override
  String get quran_searchPrompt => 'অনুসন্ধানের জন্য একটি শব্দ টাইপ করুন';

  @override
  String get quran_tapForTafsir => 'তাফসীরের জন্য আয়াতে দীর্ঘ চপ দিন';

  @override
  String quran_tafsirTitle(int number) {
    return '$number নম্বর আয়াতর তাফসীর';
  }

  @override
  String get quran_tafsirSource => 'আল-মুয়াস্সার';

  @override
  String get quran_tafsirError => 'তাফসীর লড করা যায়নি';

  @override
  String get quran_reciter => 'ক্বরী';

  @override
  String get quran_selectReciter => 'ক্বারী নির্বাচন করুন';

  @override
  String get quran_searchReciter => 'ক্রী অনুসন্ধান করুন...';

  @override
  String get quran_playPrompt => 'শুনতে স্পর্শ করুন';

  @override
  String quran_ayahNumber(int number) {
    return '$number নম্বর আয়াত';
  }

  @override
  String get athkar_title => 'যিকর';

  @override
  String get athkar_morning => 'সকালের যিকর';

  @override
  String get athkar_evening => 'সন্ধ্যার যিকর';

  @override
  String get athkar_sleep => 'ঘুমের যিকর';

  @override
  String get athkar_wake => 'জাগ্রত হওয়ার যিকর';

  @override
  String get athkar_prayer => 'নামাজ পরবর্তী যিকর';

  @override
  String get athkar_general => 'সাধারণ যিকর';

  @override
  String get athkar_tapToCount => 'গণনার জন্য সর্শ করুন';

  @override
  String get athkar_transitioning => 'পরবর্তীতে যাচ্ছে...';

  @override
  String athkar_completed(String name) {
    return '$name সম্পন্ন';
  }

  @override
  String get athkar_next => 'পরবর্তী';

  @override
  String get athkar_prev => 'পূর্ববর্তী';

  @override
  String get athkar_finish => 'শেষ করুন';

  @override
  String get athkar_back => 'ফিরে যান';

  @override
  String athkar_source(String source) {
    return '$source কর্তৃক বর্ণিত';
  }

  @override
  String get hadith_title => 'হাদীস শরীফ';

  @override
  String get hadith_searchHint => 'হাদীস অনুসন্ধান করুন...';

  @override
  String get hadith_noResults => 'কনো ফলাফল নেই';

  @override
  String get hadith_tapForDetail => 'সম্পূর্ণ হাদীস পড়ত স্পর্শ করুন';

  @override
  String get hadith_retryButton => 'আবার চেষ্টা করুন';

  @override
  String get hadith_loadError => 'লোড করা যায়নি';

  @override
  String get qibla_title => 'কিবলার দিক';

  @override
  String get qibla_active => 'কমস সক্রিয়';

  @override
  String get qibla_error => 'কিবলার দিক নির্ধারণ করা যায়নি';

  @override
  String get qibla_errorHint => 'কম্পাস এবং অবস্থান সক্রিয় করুন';

  @override
  String get qibla_kaaba => 'কাবা';

  @override
  String get qibla_fromNorth => 'উত্তর থেকে কিবলার দিক ডিগ্রি';

  @override
  String get stats_title => 'আমার পরিসখ্যান';

  @override
  String get stats_prayerStreak => 'নামাজের ধারাবাহিকতা';

  @override
  String get stats_totalPrayers => 'মোট নামাজ';

  @override
  String get stats_quranPages => 'কুরআনের পৃষ্ঠা';

  @override
  String get stats_athkarSessions => 'যকর';

  @override
  String get stats_khatma => 'কুরআন খতম';

  @override
  String get stats_days => 'ধারাবাহিক দিন';

  @override
  String get stats_prayers => 'নামাজ';

  @override
  String get stats_pages => 'পৃষ্ঠা';

  @override
  String get stats_sessions => 'সেশন';

  @override
  String get stats_khatmaUnit => 'খতম';

  @override
  String get stats_currentKhatma => 'বর্তমান খতমর অগ্রগতি';

  @override
  String get more_title => 'আরও';

  @override
  String get more_qibla => 'কিবলার দিক';

  @override
  String get more_stats => 'আমর পরিসংখ্যান';

  @override
  String get common_loading => 'লোড হচ্ছে...';

  @override
  String get common_error => 'ডেটা লোড করতে ত্রুটি';

  @override
  String get common_retry => 'আবার চেষ্টা করুন';

  @override
  String get common_back => 'ফিরে যান';

  @override
  String get common_next => 'পরবর্তী';

  @override
  String get common_save => 'সংরক্ষণ করুন';

  @override
  String get common_cancel => 'বাতিল করুন';

  @override
  String get common_done => 'সম্পন্ন';

  @override
  String get common_search => 'অনুসন্ধান';

  @override
  String get common_noData => 'কোনো ডেটা নেই';

  @override
  String get common_offline => 'ইন্টারনেট সংযোগ নেই';
}
