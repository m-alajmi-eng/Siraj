// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'Сирадж';

  @override
  String get prayer_title => 'Время намаза';

  @override
  String get prayer_nextPrayer => 'Следующий намаз';

  @override
  String get prayer_fajr => 'Фаджр';

  @override
  String get prayer_sunrise => 'Восход';

  @override
  String get prayer_dhuhr => 'Зухр';

  @override
  String get prayer_asr => 'Аср';

  @override
  String get prayer_maghrib => 'Магриб';

  @override
  String get prayer_isha => 'Иша';

  @override
  String prayer_countdown(String time) {
    return 'Через $time';
  }

  @override
  String get prayer_locationGPS => 'Ваше текущее местоположение';

  @override
  String get prayer_locationDefault => 'Эр-Рияд (по умолчанию)';

  @override
  String get quran_title => 'Священный Коран';

  @override
  String get quran_meccan => 'Мекканская';

  @override
  String get quran_medinan => 'Мединская';

  @override
  String quran_ayahCount(int count) {
    return '$count аятов';
  }

  @override
  String get quran_searchHint => 'Поиск в Коране...';

  @override
  String get quran_noResults => 'Результатов нет';

  @override
  String get quran_searchPrompt => 'Введите слово для поиска';

  @override
  String get quran_tapForTafsir => 'Нажмите и удерживайте аят для тафсира';

  @override
  String quran_tafsirTitle(int number) {
    return 'Тафсир аята $number';
  }

  @override
  String get quran_tafsirSource => 'Аль-Муяссар';

  @override
  String get quran_tafsirError => 'Не удалось загрузить тафсир';

  @override
  String get quran_reciter => 'Чтец';

  @override
  String get quran_selectReciter => 'Выбрать чтеца';

  @override
  String get quran_searchReciter => 'Найти чтеца...';

  @override
  String get quran_playPrompt => 'Нажмите для прослушивания';

  @override
  String quran_ayahNumber(int number) {
    return 'Аят $number';
  }

  @override
  String get athkar_title => 'Азкар';

  @override
  String get athkar_morning => 'Утренние азкар';

  @override
  String get athkar_evening => 'Вечерние азкар';

  @override
  String get athkar_sleep => 'Азкар перед сном';

  @override
  String get athkar_wake => 'Азкар после пробуждения';

  @override
  String get athkar_prayer => 'Азкар после намаза';

  @override
  String get athkar_general => 'Общие азкар';

  @override
  String get athkar_tapToCount => 'Нажмите для счёта';

  @override
  String get athkar_transitioning => 'Переход...';

  @override
  String athkar_completed(String name) {
    return '$name завершён';
  }

  @override
  String get athkar_next => 'Следующий';

  @override
  String get athkar_prev => 'Предыдущий';

  @override
  String get athkar_finish => 'Завершить';

  @override
  String get athkar_back => 'Назад';

  @override
  String athkar_source(String source) {
    return 'Передано от $source';
  }

  @override
  String get hadith_title => 'Хадис';

  @override
  String get hadith_searchHint => 'Поиск хадисов...';

  @override
  String get hadith_noResults => 'Результатов нет';

  @override
  String get hadith_tapForDetail => 'Нажмите для полного чтения';

  @override
  String get hadith_retryButton => 'Повторить';

  @override
  String get hadith_loadError => 'Не удалось загрузить';

  @override
  String get qibla_title => 'Направление Киблы';

  @override
  String get qibla_active => 'Компас активен';

  @override
  String get qibla_error => 'Не удалось определить направление Киблы';

  @override
  String get qibla_errorHint => 'Включите компас и геолокацию';

  @override
  String get qibla_kaaba => 'Кааба';

  @override
  String get qibla_fromNorth => 'Градусов от севера к Кибле';

  @override
  String get stats_title => 'Моя статистика';

  @override
  String get stats_prayerStreak => 'Серия намазов';

  @override
  String get stats_totalPrayers => 'Всего намазов';

  @override
  String get stats_quranPages => 'Страниц Корана';

  @override
  String get stats_athkarSessions => 'Азкар';

  @override
  String get stats_khatma => 'Хатм Корана';

  @override
  String get stats_days => 'дней подряд';

  @override
  String get stats_prayers => 'намазов';

  @override
  String get stats_pages => 'страниц';

  @override
  String get stats_sessions => 'сессий';

  @override
  String get stats_khatmaUnit => 'хатм';

  @override
  String get stats_currentKhatma => 'Прогресс текущего хатма';

  @override
  String get more_title => 'Ещё';

  @override
  String get more_qibla => 'Направление Киблы';

  @override
  String get more_stats => 'Моя статистика';

  @override
  String get common_loading => 'Загрузка...';

  @override
  String get common_error => 'Ошибка загрузки данных';

  @override
  String get common_retry => 'Повторить';

  @override
  String get common_back => 'Назад';

  @override
  String get common_next => 'Далее';

  @override
  String get common_save => 'Сохранить';

  @override
  String get common_cancel => 'Отмена';

  @override
  String get common_done => 'Готово';

  @override
  String get common_search => 'Поиск';

  @override
  String get common_noData => 'Нет данных';

  @override
  String get common_offline => 'Нет подключения к интернету';

  @override
  String get nav_home => 'Главная';

  @override
  String get nav_quran => 'Коран';

  @override
  String get nav_athkar => 'Азкары';

  @override
  String get nav_hadith => 'Хадис';

  @override
  String get nav_more => 'Ещё';

  @override
  String get home_greetingNight => 'Благословенной ночи,';

  @override
  String get home_greetingFajr => 'Мир на рассвете,';

  @override
  String get home_greetingMorning => 'Доброе утро,';

  @override
  String get home_greetingNoon => 'Добрый день,';

  @override
  String get home_greetingAsr => 'Благословенного дня,';

  @override
  String get home_greetingEvening => 'Добрый вечер,';

  @override
  String get home_greetingLateNight => 'Спокойной ночи,';

  @override
  String get home_welcome => 'Добро пожаловать';

  @override
  String get home_nextPrayer => 'Следующая молитва';

  @override
  String get home_qiblaDirection => 'Направление Киблы';

  @override
  String get home_continueReading => 'ПРОДОЛЖИТЬ ЧТЕНИЕ';

  @override
  String home_surah(int id) {
    return 'سورة #$id';
  }

  @override
  String home_ayah(int number) {
    return 'آية $number';
  }

  @override
  String get home_dailyAyah => 'Аят дня';

  @override
  String get home_quickAccess => 'Быстрый доступ';

  @override
  String get home_searchHint => 'Что вы ищете...';

  @override
  String get home_radio => 'Радио';

  @override
  String get home_calendar => 'Календарь';

  @override
  String get home_stories => 'Истории';

  @override
  String get home_children => 'Дети';

  @override
  String get settings_title => 'Настройки';

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
