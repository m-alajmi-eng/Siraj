// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get appName => 'Siraj';

  @override
  String get prayer_title => 'Namoz Vaqtlari';

  @override
  String get prayer_nextPrayer => 'Keyingi Namoz';

  @override
  String get prayer_fajr => 'Bomdod';

  @override
  String get prayer_sunrise => 'Quyosh Chiqishi';

  @override
  String get prayer_dhuhr => 'Peshin';

  @override
  String get prayer_asr => 'Asr';

  @override
  String get prayer_maghrib => 'Shom';

  @override
  String get prayer_isha => 'Xufton';

  @override
  String prayer_countdown(String time) {
    return '$time ichida';
  }

  @override
  String get prayer_locationGPS => 'Joriy joylashuvingiz';

  @override
  String get prayer_locationDefault => 'Ar-Riyod (standart)';

  @override
  String get quran_title => 'Muqaddas Qur\'on';

  @override
  String get quran_meccan => 'Makkiy';

  @override
  String get quran_medinan => 'Madaniy';

  @override
  String quran_ayahCount(int count) {
    return '$count oyat';
  }

  @override
  String get quran_searchHint => 'Qur\'onda qidirish...';

  @override
  String get quran_noResults => 'Natija topilmadi';

  @override
  String get quran_searchPrompt => 'Qidirish uchun so\'z kiriting';

  @override
  String get quran_tapForTafsir => 'Tafsir uchun oyatni bosib turing';

  @override
  String quran_tafsirTitle(int number) {
    return '$number-oyat tafsiri';
  }

  @override
  String get quran_tafsirSource => 'Al-Muyassar';

  @override
  String get quran_tafsirError => 'Tafsirni yuklab bo\'lmadi';

  @override
  String get quran_reciter => 'Qori';

  @override
  String get quran_selectReciter => 'Qori tanlang';

  @override
  String get quran_searchReciter => 'Qori qidirish...';

  @override
  String get quran_playPrompt => 'Tinglash uchun bosing';

  @override
  String quran_ayahNumber(int number) {
    return '$number-oyat';
  }

  @override
  String get athkar_title => 'Zikrlar';

  @override
  String get athkar_morning => 'Ertalabki Zikrlar';

  @override
  String get athkar_evening => 'Kechki Zikrlar';

  @override
  String get athkar_sleep => 'Uxlash Zikrlari';

  @override
  String get athkar_wake => 'Uyg\'onish Zikrlari';

  @override
  String get athkar_prayer => 'Namozdan Keyin Zikrlar';

  @override
  String get athkar_general => 'Umumiy Zikrlar';

  @override
  String get athkar_tapToCount => 'Hisoblash uchun bosing';

  @override
  String get athkar_transitioning => 'O\'tilmoqda...';

  @override
  String athkar_completed(String name) {
    return '$name yakunlandi';
  }

  @override
  String get athkar_next => 'Keyingisi';

  @override
  String get athkar_prev => 'Oldingi';

  @override
  String get athkar_finish => 'Yakunlash';

  @override
  String get athkar_back => 'Orqaga';

  @override
  String athkar_source(String source) {
    return '$source rivoyat qilgan';
  }

  @override
  String get hadith_title => 'Hadis';

  @override
  String get hadith_searchHint => 'Hadis qidirish...';

  @override
  String get hadith_noResults => 'Natija topilmadi';

  @override
  String get hadith_tapForDetail => 'To\'liq o\'qish uchun bosing';

  @override
  String get hadith_retryButton => 'Qayta urinish';

  @override
  String get hadith_loadError => 'Yuklab bo\'lmadi';

  @override
  String get qibla_title => 'Qibla Yo\'nalishi';

  @override
  String get qibla_active => 'Kompas faol';

  @override
  String get qibla_error => 'Qibla yo\'nalishini aniqlab bo\'lmadi';

  @override
  String get qibla_errorHint => 'Kompas va joylashuvni yoqing';

  @override
  String get qibla_kaaba => 'Ka\'ba';

  @override
  String get qibla_fromNorth => 'Shimoldan Qiblaga darajalar';

  @override
  String get stats_title => 'Mening Statistikam';

  @override
  String get stats_prayerStreak => 'Namoz Ketma-ketligi';

  @override
  String get stats_totalPrayers => 'Jami Namozlar';

  @override
  String get stats_quranPages => 'Qur\'on Sahifalari';

  @override
  String get stats_athkarSessions => 'Zikrlar';

  @override
  String get stats_khatma => 'Qur\'on Xatmi';

  @override
  String get stats_days => 'ketma-ket kun';

  @override
  String get stats_prayers => 'namoz';

  @override
  String get stats_pages => 'sahifa';

  @override
  String get stats_sessions => 'seans';

  @override
  String get stats_khatmaUnit => 'xatm';

  @override
  String get stats_currentKhatma => 'Joriy Xatm Jarayoni';

  @override
  String get more_title => 'Ko\'proq';

  @override
  String get more_qibla => 'Qibla Yo\'nalishi';

  @override
  String get more_stats => 'Mening Statistikam';

  @override
  String get common_loading => 'Yuklanmoqda...';

  @override
  String get common_error => 'Ma\'lumotlarni yuklashda xato';

  @override
  String get common_retry => 'Qayta urinish';

  @override
  String get common_back => 'Orqaga';

  @override
  String get common_next => 'Keyingisi';

  @override
  String get common_save => 'Saqlash';

  @override
  String get common_cancel => 'Bekor qilish';

  @override
  String get common_done => 'Bajarildi';

  @override
  String get common_search => 'Qidirish';

  @override
  String get common_noData => 'Ma\'lumot yo\'q';

  @override
  String get common_offline => 'Internet ulanishi yo\'q';

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
