// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appName => 'Siraj';

  @override
  String get prayer_title => 'Waktu Shalat';

  @override
  String get prayer_nextPrayer => 'Shalat Berikutnya';

  @override
  String get prayer_fajr => 'Subuh';

  @override
  String get prayer_sunrise => 'Syuruq';

  @override
  String get prayer_dhuhr => 'Dzuhur';

  @override
  String get prayer_asr => 'Ashar';

  @override
  String get prayer_maghrib => 'Maghrib';

  @override
  String get prayer_isha => 'Isya';

  @override
  String prayer_countdown(String time) {
    return 'Dalam $time';
  }

  @override
  String get prayer_locationGPS => 'Lokasi Anda saat ini';

  @override
  String get prayer_locationDefault => 'Riyadh (default)';

  @override
  String get quran_title => 'Al-Qur\'an Al-Karim';

  @override
  String get quran_meccan => 'Makkiyah';

  @override
  String get quran_medinan => 'Madaniyah';

  @override
  String quran_ayahCount(int count) {
    return '$count ayat';
  }

  @override
  String get quran_searchHint => 'Cari di Al-Qur\'an...';

  @override
  String get quran_noResults => 'Tidak ada hasil';

  @override
  String get quran_searchPrompt => 'Ketik kata untuk mencari';

  @override
  String get quran_tapForTafsir => 'Tekan lama ayat untuk tafsir';

  @override
  String quran_tafsirTitle(int number) {
    return 'Tafsir Ayat $number';
  }

  @override
  String get quran_tafsirSource => 'Al-Muyassar';

  @override
  String get quran_tafsirError => 'Gagal memuat tafsir';

  @override
  String get quran_reciter => 'Qari';

  @override
  String get quran_selectReciter => 'Pilih Qari';

  @override
  String get quran_searchReciter => 'Cari qari...';

  @override
  String get quran_playPrompt => 'Ketuk untuk mendengarkan';

  @override
  String quran_ayahNumber(int number) {
    return 'Ayat $number';
  }

  @override
  String get athkar_title => 'Dzikir';

  @override
  String get athkar_morning => 'Dzikir Pagi';

  @override
  String get athkar_evening => 'Dzikir Sore';

  @override
  String get athkar_sleep => 'Dzikir Tidur';

  @override
  String get athkar_wake => 'Dzikir Bangun';

  @override
  String get athkar_prayer => 'Dzikir Setelah Shalat';

  @override
  String get athkar_general => 'Dzikir Umum';

  @override
  String get athkar_tapToCount => 'Ketuk untuk menghitung';

  @override
  String get athkar_transitioning => 'Beralih...';

  @override
  String athkar_completed(String name) {
    return '$name selesai';
  }

  @override
  String get athkar_next => 'Berikutnya';

  @override
  String get athkar_prev => 'Sebelumnya';

  @override
  String get athkar_finish => 'Selesai';

  @override
  String get athkar_back => 'Kembali';

  @override
  String athkar_source(String source) {
    return 'Diriwayatkan oleh $source';
  }

  @override
  String get hadith_title => 'Hadits';

  @override
  String get hadith_searchHint => 'Cari hadits...';

  @override
  String get hadith_noResults => 'Tidak ada hasil';

  @override
  String get hadith_tapForDetail => 'Ketuk untuk membaca lengkap';

  @override
  String get hadith_retryButton => 'Coba Lagi';

  @override
  String get hadith_loadError => 'Gagal memuat';

  @override
  String get qibla_title => 'Arah Kiblat';

  @override
  String get qibla_active => 'Kompas aktif';

  @override
  String get qibla_error => 'Tidak dapat menentukan arah kiblat';

  @override
  String get qibla_errorHint => 'Pastikan kompas dan lokasi diaktifkan';

  @override
  String get qibla_kaaba => 'Ka\'bah';

  @override
  String get qibla_fromNorth => 'Derajat dari Utara ke Kiblat';

  @override
  String get stats_title => 'Statistik Saya';

  @override
  String get stats_prayerStreak => 'Streak Shalat';

  @override
  String get stats_totalPrayers => 'Total Shalat';

  @override
  String get stats_quranPages => 'Halaman Al-Qur\'an';

  @override
  String get stats_athkarSessions => 'Dzikir';

  @override
  String get stats_khatma => 'Khatam Al-Qur\'an';

  @override
  String get stats_days => 'hari berturut-turut';

  @override
  String get stats_prayers => 'shalat';

  @override
  String get stats_pages => 'halaman';

  @override
  String get stats_sessions => 'sesi';

  @override
  String get stats_khatmaUnit => 'khatam';

  @override
  String get stats_currentKhatma => 'Progress Khatam Saat Ini';

  @override
  String get more_title => 'Lainnya';

  @override
  String get more_qibla => 'Arah Kiblat';

  @override
  String get more_stats => 'Statistik Saya';

  @override
  String get common_loading => 'Memuat...';

  @override
  String get common_error => 'Gagal memuat data';

  @override
  String get common_retry => 'Coba Lagi';

  @override
  String get common_back => 'Kembali';

  @override
  String get common_next => 'Berikutnya';

  @override
  String get common_save => 'Simpan';

  @override
  String get common_cancel => 'Batal';

  @override
  String get common_done => 'Selesai';

  @override
  String get common_search => 'Cari';

  @override
  String get common_noData => 'Tidak ada data';

  @override
  String get common_offline => 'Tidak ada koneksi internet';

  @override
  String get nav_home => 'Beranda';

  @override
  String get nav_quran => 'Quran';

  @override
  String get nav_athkar => 'Zikir';

  @override
  String get nav_hadith => 'Hadis';

  @override
  String get nav_more => 'Lainnya';

  @override
  String get home_greetingNight => 'Malam yang berkah,';

  @override
  String get home_greetingFajr => 'Damai di waktu fajar,';

  @override
  String get home_greetingMorning => 'Selamat pagi,';

  @override
  String get home_greetingNoon => 'Selamat siang,';

  @override
  String get home_greetingAsr => 'Sore yang berkah,';

  @override
  String get home_greetingEvening => 'Selamat sore,';

  @override
  String get home_greetingLateNight => 'Malam yang tenang,';

  @override
  String get home_welcome => 'Selamat datang';

  @override
  String get home_nextPrayer => 'Shalat Berikutnya';

  @override
  String get home_qiblaDirection => 'Arah Kiblat';

  @override
  String get home_continueReading => 'LANJUTKAN MEMBACA';

  @override
  String home_surah(int id) {
    return 'سورة #$id';
  }

  @override
  String home_ayah(int number) {
    return 'آية $number';
  }

  @override
  String get home_dailyAyah => 'Ayat Hari Ini';

  @override
  String get home_quickAccess => 'Akses Cepat';

  @override
  String get home_searchHint => 'Apa yang Anda cari...';

  @override
  String get home_radio => 'Radio';

  @override
  String get home_calendar => 'Kalender';

  @override
  String get home_stories => 'Kisah';

  @override
  String get home_children => 'Anak-anak';

  @override
  String get settings_title => 'Pengaturan';

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
}
