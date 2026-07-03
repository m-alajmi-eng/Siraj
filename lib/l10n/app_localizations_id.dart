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
    return 'Surah #$id';
  }

  @override
  String home_ayah(int number) {
    return 'Ayat $number';
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
  String get radio_title => 'Radio Siraj';

  @override
  String get radio_all => 'Semua';

  @override
  String get radio_quran => 'Quran';

  @override
  String get radio_translations => 'Terjemahan';

  @override
  String get radio_tafsir => 'Tafsir & Fatwa';

  @override
  String get radio_athkar => 'Zikir';

  @override
  String get radio_international => 'Internasional';

  @override
  String get cal_title => 'Kalender Islam';

  @override
  String get cal_todayEvents => 'Peristiwa Hari Ini';

  @override
  String get cal_nextEvent => 'Peristiwa Berikutnya';

  @override
  String get cal_allEvents => 'Peristiwa Islam';

  @override
  String cal_daysUntil(int days) {
    return '$days hari';
  }

  @override
  String get cal_gregorian => 'Masehi';

  @override
  String get cal_hijri => 'Hijriah';

  @override
  String get hm_1 => 'Muharram';

  @override
  String get hm_2 => 'Safar';

  @override
  String get hm_3 => 'Rabiul Awal';

  @override
  String get hm_4 => 'Rabiul Akhir';

  @override
  String get hm_5 => 'Jumadil Awal';

  @override
  String get hm_6 => 'Jumadil Akhir';

  @override
  String get hm_7 => 'Rajab';

  @override
  String get hm_8 => 'Syaban';

  @override
  String get hm_9 => 'Ramadan';

  @override
  String get hm_10 => 'Syawal';

  @override
  String get hm_11 => 'Zulkaidah';

  @override
  String get hm_12 => 'Zulhijah';

  @override
  String get ev_new_year => 'Tahun Baru Islam';

  @override
  String get ev_ashura => 'Hari Asyura';

  @override
  String get ev_mawlid => 'Maulid Nabiﷺ';

  @override
  String get ev_isra => 'Isra Mikraj';

  @override
  String get ev_ramadan_start => 'Awal Ramadan';

  @override
  String get ev_laylat_qadr => 'Lailatulqadar';

  @override
  String get ev_eid_fitr => 'Idulfitri';

  @override
  String get ev_arafah => 'Hari Arafah';

  @override
  String get ev_eid_adha => 'Iduladha';

  @override
  String get ev_tashreeq => 'Hari Tasyrik';

  @override
  String get stories_title => 'Kisah & Sirah';

  @override
  String get stories_prophets => 'Para Nabi';

  @override
  String get stories_companions => 'Para Sahabat';

  @override
  String get stories_scholars => 'Para Ulama';

  @override
  String get stories_comingSoon => 'Segera';

  @override
  String get stories_comingSoonMsg => 'Segera hadir — konten dalam proses';

  @override
  String get children_title => 'Kisah Anak';

  @override
  String get settings_secIdentity => 'Identitas';

  @override
  String get settings_secAdhan => 'Azan';

  @override
  String get settings_secApp => 'Aplikasi';

  @override
  String get settings_secPrivacy => 'Privasi';

  @override
  String get settings_secAbout => 'Tentang';

  @override
  String get settings_language => 'Bahasa';

  @override
  String get settings_chooseLanguage => 'Pilih Bahasa';

  @override
  String get settings_madhab => 'Mazhab';

  @override
  String get settings_chooseMadhab => 'Pilih Mazhab';

  @override
  String get settings_calcMethod => 'Metode Perhitungan Salat';

  @override
  String get settings_chooseCalc => 'Metode Perhitungan';

  @override
  String get settings_enableAdhan => 'Aktifkan Azan';

  @override
  String get settings_muezzinVoice => 'Suara Muazin';

  @override
  String get settings_vibration => 'Getar alih-alih suara';

  @override
  String get settings_iqamaAlert => 'Peringatan sebelum Ikamah';

  @override
  String settings_minutes(int n) {
    return '$n mnt';
  }

  @override
  String get settings_appMode => 'Mode Aplikasi';

  @override
  String get settings_fullMode => 'Mode Penuh';

  @override
  String get settings_liteMode => 'Mode Ringan';

  @override
  String get settings_fullModeDesc => 'Semua fitur tersedia';

  @override
  String get settings_liteModeDesc => 'Hanya esensial — luring';

  @override
  String get settings_quranFont => 'Font Quran';

  @override
  String get settings_fontUthmani => 'Usmani';

  @override
  String get settings_fontHafs => 'Hafs';

  @override
  String get settings_quranFontSize => 'Ukuran Font Quran';

  @override
  String get settings_privacyNote => 'Lokasi Anda tetap di perangkat Anda saja';

  @override
  String get settings_clearCache => 'Hapus Data Cache';

  @override
  String get settings_clearCacheTitle => 'Hapus Cache';

  @override
  String get settings_clearCacheMsg =>
      'Data tersimpan lokal akan dihapus. Anda yakin?';

  @override
  String get settings_cancel => 'Batal';

  @override
  String get settings_delete => 'Hapus';

  @override
  String get settings_version => 'Versi';

  @override
  String get settings_shareApp => 'Bagikan Aplikasi';

  @override
  String get settings_tagline => 'Siraj — Cahaya di atas Cahaya';

  @override
  String get madhab_hanafi => 'Hanafi';

  @override
  String get madhab_maliki => 'Maliki';

  @override
  String get madhab_shafi => 'Syafii';

  @override
  String get madhab_hanbali => 'Hanbali';

  @override
  String get calc_MWL => 'Liga Dunia Muslim';

  @override
  String get calc_ISNA => 'Amerika Utara (ISNA)';

  @override
  String get calc_Egypt => 'Otoritas Mesir';

  @override
  String get calc_Makkah => 'Umm al-Qura (Makkah)';

  @override
  String get calc_Kuwait => 'Kuwait';

  @override
  String get calc_Qatar => 'Qatar';

  @override
  String get calc_Dubai => 'Dubai';

  @override
  String get search_hint => 'Cari Quran & tafsir...';

  @override
  String get search_empty => 'Cari Al-Quran, tafsir, dan makna kata';

  @override
  String search_noResults(String query) {
    return 'Tidak ada hasil untuk \"$query\"';
  }

  @override
  String get search_typeAyah => 'Ayat';

  @override
  String get search_typeTafsir => 'Tafsir';

  @override
  String get search_typeWord => 'Kata';

  @override
  String get search_typeHadith => 'Hadis';

  @override
  String get stats_daysStreak => 'hari berturut-turut';

  @override
  String get stats_prayersUnit => 'salat';

  @override
  String get stats_pagesUnit => 'halaman';

  @override
  String get stats_athkar => 'Zikir';

  @override
  String get stats_sessionsUnit => 'sesi';

  @override
  String stats_pagesOf(int read, int total) {
    return '$read / $total halaman';
  }

  @override
  String get reader_tapToListen => 'Ketuk untuk mendengar';

  @override
  String reader_ayahNum(int n) {
    return 'Ayat $n';
  }

  @override
  String get reader_reciter => 'Qari';

  @override
  String get reader_chooseReciter => 'Pilih Qari';

  @override
  String get reader_searchReciter => 'Cari qari...';

  @override
  String get reader_longPressHint =>
      'Tekan lama ayat mana pun untuk portal, tafsir & berbagi';

  @override
  String get reader_versePortal => 'Portal Ayat';

  @override
  String get reader_portalSub => 'Tafsir · Kata · Konteks';

  @override
  String get reader_showTafsir => 'Tampilkan Tafsir';

  @override
  String get reader_shareAyah => 'Bagikan Ayat';

  @override
  String get reader_copyAyah => 'Salin Ayat';

  @override
  String get reader_ayahCopied => 'Ayat disalin';

  @override
  String reader_tafsirOf(int n) {
    return 'Tafsir Ayat $n';
  }

  @override
  String get reader_muyassar => 'Al-Muyassar';

  @override
  String get reader_tafsirError => 'Gagal memuat tafsir';

  @override
  String get reader_shareTitle => 'Ayat Mulia';

  @override
  String reader_shareSubtitle(String surah, int n) {
    return '$surah · Ayat $n';
  }

  @override
  String get portal_muyassar => 'Al-Muyassar';

  @override
  String get portal_words => 'Analisis Kata';

  @override
  String get portal_hadiths => 'Hadis';

  @override
  String get portal_stories => 'Kisah & Sirah';

  @override
  String get portal_arabicTafsir => 'Tafsir Arab';

  @override
  String get portal_foreignTafsir => 'Tafsir Bahasa Lain';

  @override
  String get portal_asbab => 'Sebab Turun';

  @override
  String get portal_searchLang => 'Cari bahasa...';

  @override
  String get portal_error => 'Tidak dapat membuka portal';

  @override
  String get portal_back => 'Kembali';

  @override
  String get portal_noTafsir => 'Tafsir tidak tersedia';

  @override
  String get portal_loadError => 'Gagal memuat';

  @override
  String get portal_comingSoon => 'Segera';

  @override
  String get portal_noHadiths => 'Belum ada hadis terkait ayat ini';

  @override
  String get portal_addingContent => 'Konten ditambahkan secara bertahap';

  @override
  String get more_search => 'Pencarian Terpadu';

  @override
  String get more_settings => 'Pengaturan';

  @override
  String get more_calendar => 'Kalender Islam';

  @override
  String get more_shareCards => 'Kartu Berbagi';

  @override
  String get more_fullMode => 'Mode Penuh';

  @override
  String get more_radio => 'Radio Quran';

  @override
  String get more_mosques => 'Masjid Terdekat';

  @override
  String get athkarcat_error => 'Kesalahan';

  @override
  String get athkarcat_empty => 'Tidak ada zikir';

  @override
  String athkarcat_completed(String name) {
    return '$name selesai';
  }

  @override
  String get athkarcat_back => 'Kembali';

  @override
  String get athkarcat_next => 'Berikutnya';

  @override
  String get athkarcat_finish => 'Selesai';

  @override
  String get athkarcat_prev => 'Sebelumnya';

  @override
  String athkarcat_repeat(int count, String source) {
    return 'Ulangi: $count · $source';
  }

  @override
  String athkarcat_narrated(String source) {
    return 'Diriwayatkan oleh $source';
  }

  @override
  String get athkarcat_moving => 'Berpindah...';

  @override
  String get athkarcat_tapCount => 'Ketuk untuk menghitung';

  @override
  String get athkar_allSections => 'Semua Bagian';

  @override
  String get gateway_entry_title => 'Mengenal Islam';

  @override
  String get gateway_intro_title => 'Perjalanan Kesadaran Spiritual';

  @override
  String get gateway_journey_title => 'Perjalanan';

  @override
  String get gateway_principles_title => 'Prinsip-Prinsip Islam';

  @override
  String get gateway_library_title => 'Perpustakaan';

  @override
  String get gateway_begin => 'Mulai Perjalanan';

  @override
  String get gateway_next => 'Berikutnya';

  @override
  String get gateway_prev => 'Kembali';

  @override
  String get app_tagline => 'Panduan Islam Anda';

  @override
  String get app_brand_name => 'SIRAJ';

  @override
  String get gateway_shahada_cta => 'Ucapkan Syahadatmu Sekarang';

  @override
  String get nav_library => 'Perpustakaan';

  @override
  String get library_could_not_load => 'Gagal memuat';

  @override
  String get library_section_not_found => 'Bagian tidak ditemukan';

  @override
  String get library_content_title => 'Konten';

  @override
  String get library_search_in_category => 'Cari dalam kategori ini...';

  @override
  String get library_no_matching_results => 'Tidak ada hasil yang cocok';

  @override
  String get library_no_materials_lang =>
      'Belum ada materi tersedia dalam bahasa ini';

  @override
  String get library_connection_failed =>
      'Koneksi gagal. Periksa internet Anda dan coba lagi';

  @override
  String get library_search_content_type => 'Cari jenis konten...';

  @override
  String get library_choose_content_type => 'Pilih jenis konten';

  @override
  String get library_no_content_lang =>
      'Belum ada konten tersedia dalam bahasa ini';

  @override
  String get library_not_found => 'Tidak ditemukan';

  @override
  String get library_search_in_section => 'Cari dalam bagian ini...';

  @override
  String get library_no_categories => 'Belum ada kategori tersedia';

  @override
  String get library_type_books => 'Buku';

  @override
  String get library_type_audios => 'Audio';

  @override
  String get library_type_videos => 'Video';

  @override
  String get library_type_articles => 'Artikel';
}
