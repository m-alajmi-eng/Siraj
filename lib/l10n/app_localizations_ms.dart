// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appName => 'Siraj';

  @override
  String get prayer_title => 'Waktu Solat';

  @override
  String get prayer_nextPrayer => 'Solat Seterusnya';

  @override
  String get prayer_fajr => 'Subuh';

  @override
  String get prayer_sunrise => 'Syuruk';

  @override
  String get prayer_dhuhr => 'Zohor';

  @override
  String get prayer_asr => 'Asar';

  @override
  String get prayer_maghrib => 'Maghrib';

  @override
  String get prayer_isha => 'Isyak';

  @override
  String prayer_countdown(String time) {
    return 'Dalam $time';
  }

  @override
  String get prayer_locationGPS => 'Lokasi semasa anda';

  @override
  String get prayer_locationDefault => 'Riyadh (lalai)';

  @override
  String get quran_title => 'Al-Quran Al-Karim';

  @override
  String get quran_meccan => 'Makkiyah';

  @override
  String get quran_medinan => 'Madaniyah';

  @override
  String quran_ayahCount(int count) {
    return '$count ayat';
  }

  @override
  String get quran_searchHint => 'Cari dalam Al-Quran...';

  @override
  String get quran_noResults => 'Tiada keputusan';

  @override
  String get quran_searchPrompt => 'Taip perkataan untuk mencari';

  @override
  String get quran_tapForTafsir => 'Tekan lama ayat untuk tafsir';

  @override
  String quran_tafsirTitle(int number) {
    return 'Tafsir Ayat $number';
  }

  @override
  String get quran_tafsirSource => 'Al-Muyassar';

  @override
  String get quran_tafsirError => 'Gagal memuatkan tafsir';

  @override
  String get quran_reciter => 'Qari';

  @override
  String get quran_selectReciter => 'Pilih Qari';

  @override
  String get quran_searchReciter => 'Cari qari...';

  @override
  String get quran_playPrompt => 'Ketuk untuk mendengar';

  @override
  String quran_ayahNumber(int number) {
    return 'Ayat $number';
  }

  @override
  String get athkar_title => 'Zikir';

  @override
  String get athkar_morning => 'Zikir Pagi';

  @override
  String get athkar_evening => 'Zikir Petang';

  @override
  String get athkar_sleep => 'Zikir Tidur';

  @override
  String get athkar_wake => 'Zikir Bangun';

  @override
  String get athkar_prayer => 'Zikir Selepas Solat';

  @override
  String get athkar_general => 'Zikir Umum';

  @override
  String get athkar_tapToCount => 'Ketuk untuk kira';

  @override
  String get athkar_transitioning => 'Beralih...';

  @override
  String athkar_completed(String name) {
    return '$name selesai';
  }

  @override
  String get athkar_next => 'Seterusnya';

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
  String get hadith_title => 'Hadith';

  @override
  String get hadith_searchHint => 'Cari hadith...';

  @override
  String get hadith_noResults => 'Tiada keputusan';

  @override
  String get hadith_tapForDetail => 'Ketuk untuk baca penuh';

  @override
  String get hadith_retryButton => 'Cuba Lagi';

  @override
  String get hadith_loadError => 'Gagal memuatkan';

  @override
  String get qibla_title => 'Arah Kiblat';

  @override
  String get qibla_active => 'Kompas aktif';

  @override
  String get qibla_error => 'Tidak dapat menentukan arah kiblat';

  @override
  String get qibla_errorHint => 'Pastikan kompas dan lokasi diaktifkan';

  @override
  String get qibla_kaaba => 'Kaabah';

  @override
  String get qibla_fromNorth => 'Darjah dari Utara ke Kiblat';

  @override
  String get stats_title => 'Statistik Saya';

  @override
  String get stats_prayerStreak => 'Streak Solat';

  @override
  String get stats_totalPrayers => 'Jumlah Solat';

  @override
  String get stats_quranPages => 'Halaman Al-Quran';

  @override
  String get stats_athkarSessions => 'Zikir';

  @override
  String get stats_khatma => 'Khatam Al-Quran';

  @override
  String get stats_days => 'hari berturut-turut';

  @override
  String get stats_prayers => 'solat';

  @override
  String get stats_pages => 'halaman';

  @override
  String get stats_sessions => 'sesi';

  @override
  String get stats_khatmaUnit => 'khatam';

  @override
  String get stats_currentKhatma => 'Kemajuan Khatam Semasa';

  @override
  String get more_title => 'Lagi';

  @override
  String get more_qibla => 'Arah Kiblat';

  @override
  String get more_stats => 'Statistik Saya';

  @override
  String get common_loading => 'Memuatkan...';

  @override
  String get common_error => 'Ralat memuatkan data';

  @override
  String get common_retry => 'Cuba Lagi';

  @override
  String get common_back => 'Kembali';

  @override
  String get common_next => 'Seterusnya';

  @override
  String get common_save => 'Simpan';

  @override
  String get common_cancel => 'Batal';

  @override
  String get common_done => 'Selesai';

  @override
  String get common_search => 'Cari';

  @override
  String get common_noData => 'Tiada data';

  @override
  String get common_offline => 'Tiada sambungan internet';

  @override
  String get nav_home => 'Utama';

  @override
  String get nav_quran => 'Quran';

  @override
  String get nav_athkar => 'Zikir';

  @override
  String get nav_hadith => 'Hadis';

  @override
  String get nav_more => 'Lagi';

  @override
  String get home_greetingNight => 'Malam yang berkat,';

  @override
  String get home_greetingFajr => 'Damai di waktu subuh,';

  @override
  String get home_greetingMorning => 'Selamat pagi,';

  @override
  String get home_greetingNoon => 'Selamat tengah hari,';

  @override
  String get home_greetingAsr => 'Petang yang berkat,';

  @override
  String get home_greetingEvening => 'Selamat petang,';

  @override
  String get home_greetingLateNight => 'Malam yang tenang,';

  @override
  String get home_welcome => 'Selamat datang';

  @override
  String get home_nextPrayer => 'Solat Seterusnya';

  @override
  String get home_qiblaDirection => 'Arah Kiblat';

  @override
  String get home_continueReading => 'TERUSKAN MEMBACA';

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
  String get home_quickAccess => 'Akses Pantas';

  @override
  String get home_searchHint => 'Apa yang anda cari...';

  @override
  String get home_radio => 'Radio';

  @override
  String get home_calendar => 'Kalendar';

  @override
  String get home_stories => 'Kisah';

  @override
  String get home_children => 'Kanak-kanak';

  @override
  String get settings_title => 'Tetapan';

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
