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
    return 'Сура #$id';
  }

  @override
  String home_ayah(int number) {
    return 'Аят $number';
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
  String get radio_title => 'Радио Сирадж';

  @override
  String get radio_all => 'Все';

  @override
  String get radio_quran => 'Коран';

  @override
  String get radio_translations => 'Переводы';

  @override
  String get radio_tafsir => 'Тафсир и фетвы';

  @override
  String get radio_athkar => 'Азкары';

  @override
  String get radio_international => 'Международные';

  @override
  String get cal_title => 'Исламский календарь';

  @override
  String get cal_todayEvents => 'Сегодняшние события';

  @override
  String get cal_nextEvent => 'Следующее событие';

  @override
  String get cal_allEvents => 'Исламские даты';

  @override
  String cal_daysUntil(int days) {
    return '$days дн.';
  }

  @override
  String get cal_gregorian => 'Григорианский';

  @override
  String get cal_hijri => 'Хиджра';

  @override
  String get hm_1 => 'Мухаррам';

  @override
  String get hm_2 => 'Сафар';

  @override
  String get hm_3 => 'Раби аль-авваль';

  @override
  String get hm_4 => 'Раби ас-сани';

  @override
  String get hm_5 => 'Джумада аль-уля';

  @override
  String get hm_6 => 'Джумада аль-ахира';

  @override
  String get hm_7 => 'Раджаб';

  @override
  String get hm_8 => 'Шаабан';

  @override
  String get hm_9 => 'Рамадан';

  @override
  String get hm_10 => 'Шавваль';

  @override
  String get hm_11 => 'Зуль-када';

  @override
  String get hm_12 => 'Зуль-хиджа';

  @override
  String get ev_new_year => 'Исламский Новый год';

  @override
  String get ev_ashura => 'День Ашура';

  @override
  String get ev_mawlid => 'Мавлид ан-Набиﷺ';

  @override
  String get ev_isra => 'Исра и Мирадж';

  @override
  String get ev_ramadan_start => 'Начало Рамадана';

  @override
  String get ev_laylat_qadr => 'Ляйлят аль-Кадр';

  @override
  String get ev_eid_fitr => 'Ид аль-Фитр';

  @override
  String get ev_arafah => 'День Арафа';

  @override
  String get ev_eid_adha => 'Ид аль-Адха';

  @override
  String get ev_tashreeq => 'Дни Ташрика';

  @override
  String get stories_title => 'Истории и Сира';

  @override
  String get stories_prophets => 'Пророки';

  @override
  String get stories_companions => 'Сподвижники';

  @override
  String get stories_scholars => 'Учёные';

  @override
  String get stories_comingSoon => 'Скоро';

  @override
  String get stories_comingSoonMsg => 'Скоро — контент готовится';

  @override
  String get children_title => 'Детские истории';

  @override
  String get settings_secIdentity => 'Идентификация';

  @override
  String get settings_secAdhan => 'Азан';

  @override
  String get settings_secApp => 'Приложение';

  @override
  String get settings_secPrivacy => 'Конфиденциальность';

  @override
  String get settings_secAbout => 'О приложении';

  @override
  String get settings_language => 'Язык';

  @override
  String get settings_chooseLanguage => 'Выберите язык';

  @override
  String get settings_madhab => 'Мазхаб';

  @override
  String get settings_chooseMadhab => 'Выберите мазхаб';

  @override
  String get settings_calcMethod => 'Метод расчёта молитв';

  @override
  String get settings_chooseCalc => 'Метод расчёта';

  @override
  String get settings_enableAdhan => 'Включить азан';

  @override
  String get settings_muezzinVoice => 'Голос муэдзина';

  @override
  String get settings_vibration => 'Вибрация вместо звука';

  @override
  String get settings_iqamaAlert => 'Уведомление перед икамой';

  @override
  String settings_minutes(int n) {
    return '$n мин.';
  }

  @override
  String get settings_appMode => 'Режим приложения';

  @override
  String get settings_fullMode => 'Полный режим';

  @override
  String get settings_liteMode => 'Облегчённый режим';

  @override
  String get settings_fullModeDesc => 'Все функции доступны';

  @override
  String get settings_liteModeDesc => 'Только основное — офлайн';

  @override
  String get settings_quranFont => 'Шрифт Корана';

  @override
  String get settings_fontUthmani => 'Усмани';

  @override
  String get settings_fontHafs => 'Хафс';

  @override
  String get settings_quranFontSize => 'Размер шрифта Корана';

  @override
  String get settings_privacyNote =>
      'Ваше местоположение остаётся только на вашем устройстве';

  @override
  String get settings_clearCache => 'Очистить кэш';

  @override
  String get settings_clearCacheTitle => 'Очистить кэш';

  @override
  String get settings_clearCacheMsg =>
      'Локально сохранённые данные будут удалены. Вы уверены?';

  @override
  String get settings_cancel => 'Отмена';

  @override
  String get settings_delete => 'Удалить';

  @override
  String get settings_version => 'Версия';

  @override
  String get settings_shareApp => 'Поделиться приложением';

  @override
  String get settings_tagline => 'Сирадж — Свет над светом';

  @override
  String get madhab_hanafi => 'Ханафитский';

  @override
  String get madhab_maliki => 'Маликитский';

  @override
  String get madhab_shafi => 'Шафиитский';

  @override
  String get madhab_hanbali => 'Ханбалитский';

  @override
  String get calc_MWL => 'Всемирная исламская лига';

  @override
  String get calc_ISNA => 'Северная Америка (ISNA)';

  @override
  String get calc_Egypt => 'Египетское управление';

  @override
  String get calc_Makkah => 'Умм аль-Кура (Мекка)';

  @override
  String get calc_Kuwait => 'Кувейт';

  @override
  String get calc_Qatar => 'Катар';

  @override
  String get calc_Dubai => 'Дубай';

  @override
  String get search_hint => 'Поиск в Коране и тафсире...';

  @override
  String get search_empty =>
      'Ищите в Священном Коране, тафсире и значениях слов';

  @override
  String search_noResults(String query) {
    return 'Нет результатов по «$query»';
  }

  @override
  String get search_typeAyah => 'Аят';

  @override
  String get search_typeTafsir => 'Тафсир';

  @override
  String get search_typeWord => 'Слово';

  @override
  String get search_typeHadith => 'Хадис';

  @override
  String get stats_daysStreak => 'дней подряд';

  @override
  String get stats_prayersUnit => 'молитв';

  @override
  String get stats_pagesUnit => 'страниц';

  @override
  String get stats_athkar => 'Азкары';

  @override
  String get stats_sessionsUnit => 'сессий';

  @override
  String stats_pagesOf(int read, int total) {
    return '$read / $total страниц';
  }

  @override
  String get reader_tapToListen => 'Нажмите, чтобы слушать';

  @override
  String reader_ayahNum(int n) {
    return 'Аят $n';
  }

  @override
  String get reader_reciter => 'Чтец';

  @override
  String get reader_chooseReciter => 'Выберите чтеца';

  @override
  String get reader_searchReciter => 'Поиск чтеца...';

  @override
  String get reader_longPressHint =>
      'Удерживайте любой аят для портала, тафсира и обмена';

  @override
  String get reader_versePortal => 'Портал аята';

  @override
  String get reader_portalSub => 'Тафсир · Слова · Контекст';

  @override
  String get reader_showTafsir => 'Показать тафсир';

  @override
  String get reader_shareAyah => 'Поделиться аятом';

  @override
  String get reader_copyAyah => 'Копировать аят';

  @override
  String get reader_ayahCopied => 'Аят скопирован';

  @override
  String reader_tafsirOf(int n) {
    return 'Тафсир аята $n';
  }

  @override
  String get reader_muyassar => 'Аль-Муяссар';

  @override
  String get reader_tafsirError => 'Не удалось загрузить тафсир';

  @override
  String get reader_shareTitle => 'Благородный аят';

  @override
  String reader_shareSubtitle(String surah, int n) {
    return '$surah · Аят $n';
  }

  @override
  String get portal_muyassar => 'Аль-Муяссар';

  @override
  String get portal_words => 'Анализ слов';

  @override
  String get portal_hadiths => 'Хадисы';

  @override
  String get portal_stories => 'Истории и Сира';

  @override
  String get portal_arabicTafsir => 'Арабские тафсиры';

  @override
  String get portal_foreignTafsir => 'Тафсиры на других языках';

  @override
  String get portal_asbab => 'Причина ниспослания';

  @override
  String get portal_searchLang => 'Поиск языка...';

  @override
  String get portal_error => 'Не удалось открыть портал';

  @override
  String get portal_back => 'Назад';

  @override
  String get portal_noTafsir => 'Тафсир недоступен';

  @override
  String get portal_loadError => 'Не удалось загрузить';

  @override
  String get portal_comingSoon => 'Скоро';

  @override
  String get portal_noHadiths => 'С этим аятом пока не связаны хадисы';

  @override
  String get portal_addingContent => 'Контент добавляется постепенно';

  @override
  String get more_search => 'Единый поиск';

  @override
  String get more_settings => 'Настройки';

  @override
  String get more_calendar => 'Исламский календарь';

  @override
  String get more_shareCards => 'Карточки обмена';

  @override
  String get more_fullMode => 'Полный режим';

  @override
  String get more_radio => 'Радио Корана';

  @override
  String get more_mosques => 'Мечети поблизости';

  @override
  String get athkarcat_error => 'Ошибка';

  @override
  String get athkarcat_empty => 'Нет азкаров';

  @override
  String athkarcat_completed(String name) {
    return '$name завершено';
  }

  @override
  String get athkarcat_back => 'Назад';

  @override
  String get athkarcat_next => 'Далее';

  @override
  String get athkarcat_finish => 'Завершить';

  @override
  String get athkarcat_prev => 'Назад';

  @override
  String athkarcat_repeat(int count, String source) {
    return 'Повтор: $count · $source';
  }

  @override
  String athkarcat_narrated(String source) {
    return 'Передал $source';
  }

  @override
  String get athkarcat_moving => 'Переход...';

  @override
  String get athkarcat_tapCount => 'Нажмите для счёта';

  @override
  String get athkar_allSections => 'Все разделы';
}
