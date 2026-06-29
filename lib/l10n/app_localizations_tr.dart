// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'Siraj';

  @override
  String get prayer_title => 'Namaz Vakitleri';

  @override
  String get prayer_nextPrayer => 'Sonraki Namaz';

  @override
  String get prayer_fajr => 'Sabah';

  @override
  String get prayer_sunrise => 'Güneş';

  @override
  String get prayer_dhuhr => 'Öğle';

  @override
  String get prayer_asr => 'İkindi';

  @override
  String get prayer_maghrib => 'Akşam';

  @override
  String get prayer_isha => 'Yatsı';

  @override
  String prayer_countdown(String time) {
    return '$time içinde';
  }

  @override
  String get prayer_locationGPS => 'Mevcut konumunuz';

  @override
  String get prayer_locationDefault => 'Riyad (varsayılan)';

  @override
  String get quran_title => 'Kur\'an-ı Kerim';

  @override
  String get quran_meccan => 'Mekki';

  @override
  String get quran_medinan => 'Medeni';

  @override
  String quran_ayahCount(int count) {
    return '$count ayet';
  }

  @override
  String get quran_searchHint => 'Kur\'an\'da ara...';

  @override
  String get quran_noResults => 'Sonuç bulunamadı';

  @override
  String get quran_searchPrompt => 'Aramak için kelime yazın';

  @override
  String get quran_tapForTafsir => 'Tefsir için ayete uzun basın';

  @override
  String quran_tafsirTitle(int number) {
    return '$number. Ayetin Tefsiri';
  }

  @override
  String get quran_tafsirSource => 'El-Müyesser';

  @override
  String get quran_tafsirError => 'Tefsir yüklenemedi';

  @override
  String get quran_reciter => 'Okuyucu';

  @override
  String get quran_selectReciter => 'Okuyucu Seç';

  @override
  String get quran_searchReciter => 'Okuyucu ara...';

  @override
  String get quran_playPrompt => 'Dinlemek için dokun';

  @override
  String quran_ayahNumber(int number) {
    return '$number. Ayet';
  }

  @override
  String get athkar_title => 'Zikirler';

  @override
  String get athkar_morning => 'Sabah Zikirleri';

  @override
  String get athkar_evening => 'Akşam Zikirleri';

  @override
  String get athkar_sleep => 'Uyku Zikirleri';

  @override
  String get athkar_wake => 'Uyanış Zikirleri';

  @override
  String get athkar_prayer => 'Namaz Sonrası Zikirler';

  @override
  String get athkar_general => 'Genel Zikirler';

  @override
  String get athkar_tapToCount => 'Saymak için dokun';

  @override
  String get athkar_transitioning => 'Geçiliyor...';

  @override
  String athkar_completed(String name) {
    return '$name tamamlandı';
  }

  @override
  String get athkar_next => 'Sonraki';

  @override
  String get athkar_prev => 'Önceki';

  @override
  String get athkar_finish => 'Bitir';

  @override
  String get athkar_back => 'Geri';

  @override
  String athkar_source(String source) {
    return '$source rivayet etti';
  }

  @override
  String get hadith_title => 'Hadis-i Şerif';

  @override
  String get hadith_searchHint => 'Hadislerde ara...';

  @override
  String get hadith_noResults => 'Sonuç bulunamadı';

  @override
  String get hadith_tapForDetail => 'Tamamını okumak için dokun';

  @override
  String get hadith_retryButton => 'Tekrar Dene';

  @override
  String get hadith_loadError => 'Yüklenemedi';

  @override
  String get qibla_title => 'Kıble Yönü';

  @override
  String get qibla_active => 'Pusula aktif';

  @override
  String get qibla_error => 'Kıble yönü belirlenemedi';

  @override
  String get qibla_errorHint => 'Pusulayı ve konumu etkinleştirin';

  @override
  String get qibla_kaaba => 'Kabe';

  @override
  String get qibla_fromNorth => 'Kuzeyden Kıbleye derece';

  @override
  String get stats_title => 'İstatistiklerim';

  @override
  String get stats_prayerStreak => 'Namaz Serisi';

  @override
  String get stats_totalPrayers => 'Toplam Namaz';

  @override
  String get stats_quranPages => 'Kur\'an Sayfaları';

  @override
  String get stats_athkarSessions => 'Zikirler';

  @override
  String get stats_khatma => 'Kur\'an Hatmi';

  @override
  String get stats_days => 'ardışık gün';

  @override
  String get stats_prayers => 'namaz';

  @override
  String get stats_pages => 'sayfa';

  @override
  String get stats_sessions => 'oturum';

  @override
  String get stats_khatmaUnit => 'hatim';

  @override
  String get stats_currentKhatma => 'Mevcut Hatim İlerlemesi';

  @override
  String get more_title => 'Daha Fazla';

  @override
  String get more_qibla => 'Kıble Yönü';

  @override
  String get more_stats => 'İstatistiklerim';

  @override
  String get common_loading => 'Yükleniyor...';

  @override
  String get common_error => 'Veri yüklenemedi';

  @override
  String get common_retry => 'Tekrar Dene';

  @override
  String get common_back => 'Geri';

  @override
  String get common_next => 'Sonraki';

  @override
  String get common_save => 'Kaydet';

  @override
  String get common_cancel => 'İptal';

  @override
  String get common_done => 'Tamam';

  @override
  String get common_search => 'Ara';

  @override
  String get common_noData => 'Veri yok';

  @override
  String get common_offline => 'İnternet bağlantısı yok';

  @override
  String get nav_home => 'Ana Sayfa';

  @override
  String get nav_quran => 'Kuran';

  @override
  String get nav_athkar => 'Zikirler';

  @override
  String get nav_hadith => 'Hadis';

  @override
  String get nav_more => 'Daha Fazla';

  @override
  String get home_greetingNight => 'Mübarek gece,';

  @override
  String get home_greetingFajr => 'Şafağa selam,';

  @override
  String get home_greetingMorning => 'Günaydın,';

  @override
  String get home_greetingNoon => 'İyi öğlenler,';

  @override
  String get home_greetingAsr => 'Mübarek ikindi,';

  @override
  String get home_greetingEvening => 'İyi akşamlar,';

  @override
  String get home_greetingLateNight => 'Huzurlu gece,';

  @override
  String get home_welcome => 'Hoş geldiniz';

  @override
  String get home_nextPrayer => 'Sonraki Namaz';

  @override
  String get home_qiblaDirection => 'Kıble Yönü';

  @override
  String get home_continueReading => 'OKUMAYA DEVAM ET';

  @override
  String home_surah(int id) {
    return 'سورة #$id';
  }

  @override
  String home_ayah(int number) {
    return 'آية $number';
  }

  @override
  String get home_dailyAyah => 'Günün Ayeti';

  @override
  String get home_quickAccess => 'Hızlı Erişim';

  @override
  String get home_searchHint => 'Ne arıyorsunuz...';

  @override
  String get home_radio => 'Radyo';

  @override
  String get home_calendar => 'Takvim';

  @override
  String get home_stories => 'Hikayeler';

  @override
  String get home_children => 'Çocuklar';

  @override
  String get settings_title => 'Ayarlar';

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
