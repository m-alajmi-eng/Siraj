// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Kazakh (`kk`).
class AppLocalizationsKk extends AppLocalizations {
  AppLocalizationsKk([String locale = 'kk']) : super(locale);

  @override
  String get appName => 'Сираж';

  @override
  String get prayer_title => 'Намаз Уақыттары';

  @override
  String get prayer_nextPrayer => 'Келесі Намаз';

  @override
  String get prayer_fajr => 'Таң';

  @override
  String get prayer_sunrise => 'Күн Шығу';

  @override
  String get prayer_dhuhr => 'Бесін';

  @override
  String get prayer_asr => 'Екінті';

  @override
  String get prayer_maghrib => 'Ақшам';

  @override
  String get prayer_isha => 'Құптан';

  @override
  String prayer_countdown(String time) {
    return '$time кейін';
  }

  @override
  String get prayer_locationGPS => 'Сіздің қазіргі орналасуыңыз';

  @override
  String get prayer_locationDefault => 'Эр-Рияд (әдепкі)';

  @override
  String get quran_title => 'Қасиетті Құран';

  @override
  String get quran_meccan => 'Меккелік';

  @override
  String get quran_medinan => 'Мединелік';

  @override
  String quran_ayahCount(int count) {
    return '$count аят';
  }

  @override
  String get quran_searchHint => 'Құраннан іздеу...';

  @override
  String get quran_noResults => 'Нәтиже табылмады';

  @override
  String get quran_searchPrompt => 'Іздеу үшін сөз енгізіңіз';

  @override
  String get quran_tapForTafsir => 'Тапсир үшін аятты ұстап тұрыңыз';

  @override
  String quran_tafsirTitle(int number) {
    return '$number аяттың тапсиры';
  }

  @override
  String get quran_tafsirSource => 'Әл-Муяссар';

  @override
  String get quran_tafsirError => 'Тапсирды жүктеу мүмкін болмады';

  @override
  String get quran_reciter => 'Қари';

  @override
  String get quran_selectReciter => 'Қариді таңдаңыз';

  @override
  String get quran_searchReciter => 'Қариді іздеу...';

  @override
  String get quran_playPrompt => 'Тыңдау үшін түртіңіз';

  @override
  String quran_ayahNumber(int number) {
    return '$number аят';
  }

  @override
  String get athkar_title => 'Зікірлер';

  @override
  String get athkar_morning => 'Таңғы Зікірлер';

  @override
  String get athkar_evening => 'Кешкі Зікірлер';

  @override
  String get athkar_sleep => 'Ұйқы Зікірлері';

  @override
  String get athkar_wake => 'Ояну Зікірлері';

  @override
  String get athkar_prayer => 'Намаздан Кейінгі Зікірлер';

  @override
  String get athkar_general => 'Жалпы Зікірлер';

  @override
  String get athkar_tapToCount => 'Санау үшін түртіңіз';

  @override
  String get athkar_transitioning => 'Өтуде...';

  @override
  String athkar_completed(String name) {
    return '$name аяқталды';
  }

  @override
  String get athkar_next => 'Келесі';

  @override
  String get athkar_prev => 'Алдыңғы';

  @override
  String get athkar_finish => 'Аяқтау';

  @override
  String get athkar_back => 'Артқа';

  @override
  String athkar_source(String source) {
    return '$source риуаят еткен';
  }

  @override
  String get hadith_title => 'Хадис';

  @override
  String get hadith_searchHint => 'Хадис іздеу...';

  @override
  String get hadith_noResults => 'Нәтиже табылмады';

  @override
  String get hadith_tapForDetail => 'Толық оқу үшін түртіңіз';

  @override
  String get hadith_retryButton => 'Қайталап көру';

  @override
  String get hadith_loadError => 'Жүктеу мүмкін болмады';

  @override
  String get qibla_title => 'Қибла Бағыты';

  @override
  String get qibla_active => 'Компас белсенді';

  @override
  String get qibla_error => 'Қибла бағытын анықтау мүмкін болмады';

  @override
  String get qibla_errorHint => 'Компас пен орналасуды қосыңыз';

  @override
  String get qibla_kaaba => 'Кааба';

  @override
  String get qibla_fromNorth => 'Солтүстіктен Қиблаға дейінгі градус';

  @override
  String get stats_title => 'Менің Статистикам';

  @override
  String get stats_prayerStreak => 'Намаз Сериясы';

  @override
  String get stats_totalPrayers => 'Жалпы Намаздар';

  @override
  String get stats_quranPages => 'Құран Беттері';

  @override
  String get stats_athkarSessions => 'Зікірлер';

  @override
  String get stats_khatma => 'Құран Хатымы';

  @override
  String get stats_days => 'қатарлы күн';

  @override
  String get stats_prayers => 'намаз';

  @override
  String get stats_pages => 'бет';

  @override
  String get stats_sessions => 'сеанс';

  @override
  String get stats_khatmaUnit => 'хатым';

  @override
  String get stats_currentKhatma => 'Ағымдағы Хатым Прогресі';

  @override
  String get more_title => 'Көбірек';

  @override
  String get more_qibla => 'Қибла Бағыты';

  @override
  String get more_stats => 'Менің Статистикам';

  @override
  String get common_loading => 'Жүктелуде...';

  @override
  String get common_error => 'Деректерді жүктеу қатесі';

  @override
  String get common_retry => 'Қайталап көру';

  @override
  String get common_back => 'Артқа';

  @override
  String get common_next => 'Келесі';

  @override
  String get common_save => 'Сақтау';

  @override
  String get common_cancel => 'Болдырмау';

  @override
  String get common_done => 'Дайын';

  @override
  String get common_search => 'Іздеу';

  @override
  String get common_noData => 'Деректер жоқ';

  @override
  String get common_offline => 'Интернет байланысы жоқ';

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
}
