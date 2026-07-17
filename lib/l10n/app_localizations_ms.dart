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
  String get time_hr => 'jam';

  @override
  String get time_min => 'min';

  @override
  String get time_sec => 'saat';

  @override
  String get home_continueReading => 'TERUSKAN MEMBACA';

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
  String get radio_international => 'Antarabangsa';

  @override
  String get cal_title => 'Kalendar Islam';

  @override
  String get cal_todayEvents => 'Peristiwa Hari Ini';

  @override
  String get cal_nextEvent => 'Peristiwa Seterusnya';

  @override
  String get cal_allEvents => 'Peristiwa Islam';

  @override
  String cal_daysUntil(int days) {
    return '$days hari';
  }

  @override
  String get cal_gregorian => 'Masihi';

  @override
  String get cal_hijri => 'Hijrah';

  @override
  String get cal_prevMonth => 'Bulan sebelumnya';

  @override
  String get cal_nextMonth => 'Bulan seterusnya';

  @override
  String get cal_legendEid => 'Eid';

  @override
  String get cal_legendFast => 'Puasa';

  @override
  String get cal_legendBlessed => 'Diberkati';

  @override
  String get cal_detailPending =>
      'Belum ada butiran tambahan (ayat/hadis/penerangan) untuk peristiwa ini - menunggu semakan agama.';

  @override
  String get hm_1 => 'Muharram';

  @override
  String get hm_2 => 'Safar';

  @override
  String get hm_3 => 'Rabiulawal';

  @override
  String get hm_4 => 'Rabiulakhir';

  @override
  String get hm_5 => 'Jamadilawal';

  @override
  String get hm_6 => 'Jamadilakhir';

  @override
  String get hm_7 => 'Rejab';

  @override
  String get hm_8 => 'Syaaban';

  @override
  String get hm_9 => 'Ramadan';

  @override
  String get hm_10 => 'Syawal';

  @override
  String get hm_11 => 'Zulkaedah';

  @override
  String get hm_12 => 'Zulhijah';

  @override
  String get ev_new_year => 'Tahun Baru Islam';

  @override
  String get ev_ashura => 'Hari Asyura';

  @override
  String get ev_mawlid => 'Maulidur Rasulﷺ';

  @override
  String get ev_isra => 'Israk dan Mikraj';

  @override
  String get ev_ramadan_start => 'Awal Ramadan';

  @override
  String get ev_laylat_qadr => 'Lailatulqadar';

  @override
  String get ev_eid_fitr => 'Aidilfitri';

  @override
  String get ev_arafah => 'Hari Arafah';

  @override
  String get ev_eid_adha => 'Aidiladha';

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
  String get stories_comingSoon => 'Tidak lama lagi';

  @override
  String get stories_comingSoonMsg =>
      'Akan datang — kandungan sedang disediakan';

  @override
  String get children_title => 'Kisah Kanak-kanak';

  @override
  String get settings_secIdentity => 'Identiti';

  @override
  String get settings_secAdhan => 'Azan';

  @override
  String get settings_secApp => 'Aplikasi';

  @override
  String get settings_secPrivacy => 'Privasi';

  @override
  String get settings_secAbout => 'Perihal';

  @override
  String get settings_language => 'Bahasa';

  @override
  String get settings_chooseLanguage => 'Pilih Bahasa';

  @override
  String get settings_madhab => 'Mazhab';

  @override
  String get settings_chooseMadhab => 'Pilih Mazhab';

  @override
  String get settings_calcMethod => 'Kaedah Pengiraan Solat';

  @override
  String get settings_chooseCalc => 'Kaedah Pengiraan';

  @override
  String get settings_enableAdhan => 'Aktifkan Azan';

  @override
  String get settings_muezzinVoice => 'Suara Muazin';

  @override
  String get settings_vibration => 'Getar dan bukan bunyi';

  @override
  String get settings_iqamaAlert => 'Amaran sebelum Iqamah';

  @override
  String settings_minutes(int n) {
    return '$n min';
  }

  @override
  String get settings_appMode => 'Mod Aplikasi';

  @override
  String get settings_fullMode => 'Mod Penuh';

  @override
  String get settings_liteMode => 'Mod Ringan';

  @override
  String get settings_fullModeDesc => 'Semua ciri tersedia';

  @override
  String get settings_liteModeDesc => 'Asas sahaja — luar talian';

  @override
  String get settings_quranFont => 'Fon Quran';

  @override
  String get settings_fontUthmani => 'Usmani';

  @override
  String get settings_fontHafs => 'Hafs';

  @override
  String get settings_quranFontSize => 'Saiz Fon Quran';

  @override
  String get settings_privacyNote =>
      'Lokasi anda kekal pada peranti anda sahaja';

  @override
  String get settings_clearCache => 'Padam Data Cache';

  @override
  String get settings_clearCacheTitle => 'Padam Cache';

  @override
  String get settings_clearCacheMsg =>
      'Data yang disimpan secara setempat akan dipadam. Anda pasti?';

  @override
  String get settings_cancel => 'Batal';

  @override
  String get settings_delete => 'Padam';

  @override
  String get settings_version => 'Versi';

  @override
  String get settings_shareApp => 'Kongsi Aplikasi';

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
  String get calc_MWL => 'Liga Dunia Islam';

  @override
  String get calc_ISNA => 'Amerika Utara (ISNA)';

  @override
  String get calc_Egypt => 'Pihak Berkuasa Mesir';

  @override
  String get calc_Makkah => 'Umm al-Qura (Makkah)';

  @override
  String get calc_Kuwait => 'Kuwait';

  @override
  String get calc_Qatar => 'Qatar';

  @override
  String get calc_Dubai => 'Dubai';

  @override
  String get calc_Karachi => 'Karachi';

  @override
  String get calc_Singapore => 'Singapura';

  @override
  String get calc_Turkey => 'Turki (Diyanet)';

  @override
  String get calc_MoonSighting => 'Jawatankuasa Rukyah';

  @override
  String get search_hint => 'Cari dalam Quran & tafsir...';

  @override
  String get search_empty => 'Cari dalam al-Quran, tafsir dan makna perkataan';

  @override
  String search_noResults(String query) {
    return 'Tiada hasil untuk \"$query\"';
  }

  @override
  String get search_typeAyah => 'Ayat';

  @override
  String get search_typeTafsir => 'Tafsir';

  @override
  String get search_typeWord => 'Perkataan';

  @override
  String get search_typeHadith => 'Hadis';

  @override
  String get stats_daysStreak => 'hari berturut-turut';

  @override
  String get stats_prayersUnit => 'solat';

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
  String get reader_tapToListen => 'Ketik untuk mendengar';

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
      'Tekan lama mana-mana ayat untuk portal, tafsir & kongsi';

  @override
  String get reader_versePortal => 'Portal Ayat';

  @override
  String get reader_portalSub => 'Tafsir · Perkataan · Konteks';

  @override
  String get reader_showTafsir => 'Papar Tafsir';

  @override
  String get reader_shareAyah => 'Kongsi Ayat';

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
  String get reader_tafsirError => 'Gagal memuatkan tafsir';

  @override
  String get reader_shareTitle => 'Ayat Mulia';

  @override
  String reader_shareSubtitle(String surah, int n) {
    return '$surah · Ayat $n';
  }

  @override
  String get portal_muyassar => 'Al-Muyassar';

  @override
  String get portal_words => 'Analisis Perkataan';

  @override
  String get portal_hadiths => 'Hadis';

  @override
  String get portal_adwaaHadiths => 'Adhwa\'ul Bayan';

  @override
  String get portal_stories => 'Kisah & Sirah';

  @override
  String get portal_arabicTafsir => 'Tafsir Arab';

  @override
  String get portal_foreignTafsir => 'Tafsir Bahasa Lain';

  @override
  String get portal_asbab => 'Sebab Penurunan';

  @override
  String get portal_searchLang => 'Cari bahasa...';

  @override
  String get portal_error => 'Tidak dapat membuka portal';

  @override
  String get portal_back => 'Kembali';

  @override
  String get portal_noTafsir => 'Tiada tafsir tersedia';

  @override
  String get portal_loadError => 'Gagal memuatkan';

  @override
  String get portal_comingSoon => 'Tidak lama lagi';

  @override
  String get portal_noHadiths => 'Belum ada hadis berkaitan ayat ini';

  @override
  String get portal_addingContent => 'Kandungan ditambah secara berperingkat';

  @override
  String get more_search => 'Carian Bersepadu';

  @override
  String get more_settings => 'Tetapan';

  @override
  String get more_calendar => 'Kalendar Islam';

  @override
  String get more_shareCards => 'Kad Perkongsian';

  @override
  String get more_fullMode => 'Mod Penuh';

  @override
  String get more_radio => 'Radio Quran';

  @override
  String get more_mosques => 'Masjid Berdekatan';

  @override
  String get athkarcat_error => 'Ralat';

  @override
  String get athkarcat_empty => 'Tiada zikir';

  @override
  String athkarcat_completed(String name) {
    return '$name selesai';
  }

  @override
  String get athkarcat_back => 'Kembali';

  @override
  String get athkarcat_next => 'Seterusnya';

  @override
  String get athkarcat_finish => 'Selesai';

  @override
  String get athkarcat_prev => 'Sebelumnya';

  @override
  String athkarcat_repeat(int count, String source) {
    return 'Ulang: $count · $source';
  }

  @override
  String athkarcat_narrated(String source) {
    return 'Diriwayatkan oleh $source';
  }

  @override
  String get athkarcat_moving => 'Berpindah...';

  @override
  String get athkarcat_tapCount => 'Ketik untuk mengira';

  @override
  String get athkar_allSections => 'Semua Bahagian';

  @override
  String get gateway_entry_title => 'Mengenali Islam';

  @override
  String get gateway_intro_title => 'Perjalanan Kesedaran Rohani';

  @override
  String get gateway_journey_title => 'Perjalanan';

  @override
  String get gateway_principles_title => 'Prinsip-Prinsip Islam';

  @override
  String get gateway_library_title => 'Perpustakaan';

  @override
  String get gateway_begin => 'Mulakan Perjalanan';

  @override
  String get gateway_next => 'Seterusnya';

  @override
  String get gateway_prev => 'Kembali';

  @override
  String get app_tagline => 'Panduan Islam Anda';

  @override
  String get app_brand_name => 'SIRAJ';

  @override
  String get gateway_shahada_cta => 'Ikrarkan Imanmu Sekarang';

  @override
  String get nav_library => 'Perpustakaan';

  @override
  String get library_could_not_load => 'Gagal memuatkan';

  @override
  String get library_section_not_found => 'Bahagian tidak dijumpai';

  @override
  String get library_content_title => 'Kandungan';

  @override
  String get library_search_in_category => 'Cari dalam kategori ini...';

  @override
  String get library_no_matching_results => 'Tiada hasil yang sepadan';

  @override
  String get library_no_materials_lang =>
      'Belum ada bahan tersedia dalam bahasa ini';

  @override
  String get library_connection_failed =>
      'Sambungan gagal. Semak internet anda dan cuba lagi';

  @override
  String get library_search_content_type => 'Cari jenis kandungan...';

  @override
  String get library_choose_content_type => 'Pilih jenis kandungan';

  @override
  String get library_no_content_lang =>
      'Belum ada kandungan tersedia dalam bahasa ini';

  @override
  String get library_not_found => 'Tidak dijumpai';

  @override
  String get library_search_in_section => 'Cari dalam bahagian ini...';

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

  @override
  String get adhan_makkah => 'Makkah (Masjidil Haram)';

  @override
  String get adhan_madinah => 'Madinah (Masjid Nabawi)';

  @override
  String get adhan_mustafa_ismail => 'Mustafa Ismail';

  @override
  String get adhan_iraqi => 'Iraq';

  @override
  String get adhan_turkish => 'Turki';

  @override
  String get adhan_moroccan => 'Maghribi';

  @override
  String get adhan_indonesian => 'Indonesia';

  @override
  String get adhan_classic => 'Klasik';

  @override
  String prayer_notification_title(Object prayer) {
    return 'Sudah masuk waktu $prayer';
  }

  @override
  String get prayer_notification_body => 'Allahu Akbar, marilah bersolat';

  @override
  String get khatmah_title => 'Khatam';

  @override
  String get khatmah_new => 'Khatam Baru';

  @override
  String get khatmah_empty => 'Tiada khatam lagi. Mulakan yang pertama!';

  @override
  String get khatmah_name => 'Nama khatam';

  @override
  String get khatmah_duration_days => 'Tempoh (hari)';

  @override
  String get khatmah_daily_pages => 'Bahagian harian (halaman)';

  @override
  String get khatmah_reminder_time => 'Masa peringatan';

  @override
  String get khatmah_create => 'Cipta khatam';

  @override
  String get khatmah_preset_ramadan => 'Ramadan (30 hari)';

  @override
  String get khatmah_preset_weekly => 'Mingguan (7 hari)';

  @override
  String get khatmah_preset_monthly => 'Bulanan (30 hari)';

  @override
  String get khatmah_status_ontrack => 'Mengikut jadual';

  @override
  String get khatmah_status_behind => 'Ketinggalan';

  @override
  String get khatmah_status_ahead => 'Mendahului';

  @override
  String get khatmah_status_completed => 'Selesai';

  @override
  String get khatmah_today_portion => 'Bahagian hari ini';

  @override
  String get khatmah_read_now => 'Baca sekarang';

  @override
  String get khatmah_page => 'Halaman';

  @override
  String khatmah_day_of(Object current, Object total) {
    return 'Hari $current daripada $total';
  }

  @override
  String get khatmah_delete_confirm => 'Padam khatam ini?';

  @override
  String get khatmah_progress => 'Kemajuan';

  @override
  String khatmah_share_text(Object day, Object name, Object percent) {
    return 'Saya pada hari ke-$day Khatmah $name, $percent% selesai. Semoga Allah menjadikan kita ahli Al-Quran 🤲';
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
