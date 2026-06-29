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

  @override
  String get stories_title => 'القصص والسير';

  @override
  String get stories_prophets => 'الأنبياء';

  @override
  String get stories_companions => 'الصحابة';

  @override
  String get stories_scholars => 'العلماء';

  @override
  String get stories_comingSoon => 'قريباً';

  @override
  String get stories_comingSoonMsg => 'قريباً — نعمل على إضافة المحتوى';

  @override
  String get children_title => 'قصص الأطفال';

  @override
  String get settings_secIdentity => 'الهوية';

  @override
  String get settings_secAdhan => 'الأذان';

  @override
  String get settings_secApp => 'التطبيق';

  @override
  String get settings_secPrivacy => 'الخصوصية';

  @override
  String get settings_secAbout => 'عن التطبيق';

  @override
  String get settings_language => 'اللغة';

  @override
  String get settings_chooseLanguage => 'اختر اللغة';

  @override
  String get settings_madhab => 'المذهب';

  @override
  String get settings_chooseMadhab => 'اختر المذهب';

  @override
  String get settings_calcMethod => 'طريقة حساب الصلاة';

  @override
  String get settings_chooseCalc => 'طريقة الحساب';

  @override
  String get settings_enableAdhan => 'تفعيل الأذان';

  @override
  String get settings_muezzinVoice => 'صوت المؤذن';

  @override
  String get settings_vibration => 'اهتزاز بدل صوت';

  @override
  String get settings_iqamaAlert => 'تنبيه قبل الإقامة';

  @override
  String settings_minutes(int n) {
    return '$n د';
  }

  @override
  String get settings_appMode => 'وضع التطبيق';

  @override
  String get settings_fullMode => 'الوضع الكامل';

  @override
  String get settings_liteMode => 'الوضع الخفيف';

  @override
  String get settings_fullModeDesc => 'كل الميزات متاحة';

  @override
  String get settings_liteModeDesc => 'الأساسيات فقط — بدون إنترنت';

  @override
  String get settings_quranFont => 'خط القرآن';

  @override
  String get settings_fontUthmani => 'عثماني';

  @override
  String get settings_fontHafs => 'حفص';

  @override
  String get settings_quranFontSize => 'حجم خط القرآن';

  @override
  String get settings_privacyNote => 'موقعك يبقى على جهازك فقط';

  @override
  String get settings_clearCache => 'حذف بيانات الكاش';

  @override
  String get settings_clearCacheTitle => 'حذف الكاش';

  @override
  String get settings_clearCacheMsg =>
      'سيتم حذف البيانات المحفوظة محلياً. هل أنت متأكد؟';

  @override
  String get settings_cancel => 'إلغاء';

  @override
  String get settings_delete => 'حذف';

  @override
  String get settings_version => 'الإصدار';

  @override
  String get settings_shareApp => 'مشاركة التطبيق';

  @override
  String get settings_tagline => 'سراج — نور على نور';

  @override
  String get madhab_hanafi => 'الحنفي';

  @override
  String get madhab_maliki => 'المالكي';

  @override
  String get madhab_shafi => 'الشافعي';

  @override
  String get madhab_hanbali => 'الحنبلي';

  @override
  String get calc_MWL => 'رابطة العالم الإسلامي';

  @override
  String get calc_ISNA => 'أمريكا الشمالية (ISNA)';

  @override
  String get calc_Egypt => 'الهيئة المصرية';

  @override
  String get calc_Makkah => 'أم القرى (مكة)';

  @override
  String get calc_Kuwait => 'الكويت';

  @override
  String get calc_Qatar => 'قطر';

  @override
  String get calc_Dubai => 'دبي';

  @override
  String get search_hint => 'ابحث في القرآن والتفاسير...';

  @override
  String get search_empty => 'ابحث في القرآن الكريم والتفاسير ومعاني الكلمات';

  @override
  String search_noResults(String query) {
    return 'لا نتائج لـ \"$query\"';
  }

  @override
  String get search_typeAyah => 'آية';

  @override
  String get search_typeTafsir => 'تفسير';

  @override
  String get search_typeWord => 'كلمة';

  @override
  String get search_typeHadith => 'حديث';

  @override
  String get stats_daysStreak => 'يوم متتالي';

  @override
  String get stats_prayersUnit => 'صلاة';

  @override
  String get stats_pagesUnit => 'صفحة';

  @override
  String get stats_athkar => 'الأذكار';

  @override
  String get stats_sessionsUnit => 'جلسة';

  @override
  String stats_pagesOf(int read, int total) {
    return '$read / $total صفحة';
  }

  @override
  String get reader_tapToListen => 'اضغط للاستماع';

  @override
  String reader_ayahNum(int n) {
    return 'الآية $n';
  }

  @override
  String get reader_reciter => 'القارئ';

  @override
  String get reader_chooseReciter => 'اختر القارئ';

  @override
  String get reader_searchReciter => 'ابحث عن قارئ...';

  @override
  String get reader_longPressHint =>
      'اضغط مطولاً على أي آية للبوابة والتفسير والمشاركة';

  @override
  String get reader_versePortal => 'بوابة الآية';

  @override
  String get reader_portalSub => 'تفسير · كلمات · سياق';

  @override
  String get reader_showTafsir => 'عرض التفسير';

  @override
  String get reader_shareAyah => 'مشاركة الآية';

  @override
  String get reader_copyAyah => 'نسخ الآية';

  @override
  String get reader_ayahCopied => 'تم نسخ الآية';

  @override
  String reader_tafsirOf(int n) {
    return 'تفسير الآية $n';
  }

  @override
  String get reader_muyassar => 'الميسر';

  @override
  String get reader_tafsirError => 'تعذّر تحميل التفسير';

  @override
  String get reader_shareTitle => 'آية كريمة';

  @override
  String reader_shareSubtitle(String surah, int n) {
    return '$surah · آية $n';
  }
}
