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
  String get prayer_locationDefault => 'Мекка (по умолчанию)';

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
  String get quran_toggleDisplayMode =>
      'Переключить режим отображения (Мусхаф/перевод)';

  @override
  String get quran_toggleTajweed => 'Переключить цветовую разметку таджвида';

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
  String hadith_readProgress(int read, int total) {
    return 'Прочитано $read из $total';
  }

  @override
  String get qibla_title => 'Направление Киблы';

  @override
  String get qibla_active => 'Компас активен';

  @override
  String get qibla_error => 'Не удалось определить направление Киблы';

  @override
  String get qibla_errorHint => 'Включите компас и геолокацию';

  @override
  String get qibla_staticMode => 'Статичный режим (нет датчика компаса)';

  @override
  String get qibla_calibrationHint =>
      'Двигайте устройством по траектории восьмёрки для калибровки компаса';

  @override
  String get qibla_kaaba => 'Кааба';

  @override
  String get qibla_fromNorth => 'Градусов от севера к Кибле';

  @override
  String qibla_distanceKm(int km, String kaaba) {
    return '$km км до $kaaba';
  }

  @override
  String get qibla_infoLocation => 'Местоположение';

  @override
  String get qibla_infoDirection => 'Направление';

  @override
  String get qibla_infoDistance => 'Расстояние';

  @override
  String get qibla_infoAccuracy => 'Точность GPS';

  @override
  String qibla_distanceValueKm(int km) {
    return '$km км';
  }

  @override
  String qibla_accuracyValueM(int m) {
    return '±$m м';
  }

  @override
  String get qibla_accuracyUnknown => 'Недоступно';

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
  String get library_title => 'Полная библиотека';

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
  String get common_close => 'Закрыть';

  @override
  String get common_share => 'Поделиться';

  @override
  String get common_refresh => 'Обновить';

  @override
  String get common_prevPage => 'Предыдущая страница';

  @override
  String get common_nextPage => 'Следующая страница';

  @override
  String get common_clearSearch => 'Очистить поиск';

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
  String get time_hr => 'ч';

  @override
  String get time_min => 'мин';

  @override
  String get time_sec => 'сек';

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
  String get radio_play => 'Воспроизвести';

  @override
  String get radio_pause => 'Пауза';

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
  String get cal_prevMonth => 'Предыдущий месяц';

  @override
  String get cal_nextMonth => 'Следующий месяц';

  @override
  String get cal_legendEid => 'Ид';

  @override
  String get cal_legendFast => 'Пост';

  @override
  String get cal_legendBlessed => 'Благословенный';

  @override
  String get cal_hijriOffset => 'Коррекция хиджры';

  @override
  String get cal_wd_sun => 'Вс';

  @override
  String get cal_wd_mon => 'Пн';

  @override
  String get cal_wd_tue => 'Вт';

  @override
  String get cal_wd_wed => 'Ср';

  @override
  String get cal_wd_thu => 'Чт';

  @override
  String get cal_wd_fri => 'Пт';

  @override
  String get cal_wd_sat => 'Сб';

  @override
  String get cal_detailPending =>
      'Дополнительные сведения (аят/хадис/описание) для этого события пока недоступны - ожидает религиозной проверки.';

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
  String get children_category_values => 'Ценности';

  @override
  String get children_category_quran => 'Коранические истории';

  @override
  String get stories_companions => 'Сподвижники';

  @override
  String get stories_tabieen => 'Табиины';

  @override
  String get stories_scholars => 'Учёные';

  @override
  String get stories_comingSoon => 'Скоро';

  @override
  String get stories_comingSoonMsg => 'Скоро — контент готовится';

  @override
  String get stories_all => 'Все';

  @override
  String get stories_otherCompanions => 'Другие сподвижники';

  @override
  String get stories_fourImams => 'Четыре имама';

  @override
  String get stories_otherScholars => 'Другие учёные';

  @override
  String get stories_searchHint => 'Поиск по имени...';

  @override
  String get stories_noResults => 'Нет результатов';

  @override
  String get children_title => 'Детские истории';

  @override
  String get settings_secIdentity => 'Идентификация';

  @override
  String get onboarding_languageTitle => 'Выберите язык';

  @override
  String get onboarding_languageSubtitle =>
      'Вы можете изменить это позже в настройках';

  @override
  String get onboarding_modeTitle => 'Выберите режим приложения';

  @override
  String get onboarding_modeSubtitle =>
      'Вы можете изменить это позже в настройках';

  @override
  String get onboarding_liteSubtitle => 'Основное · Быстро · Полностью офлайн';

  @override
  String get onboarding_fullSubtitle =>
      'Все функции · Полный набор · Углублённо';

  @override
  String get onboarding_andMore => '+ ещё';

  @override
  String get onboarding_madhabTitle => 'Мазхаб (правовая школа)';

  @override
  String get onboarding_madhabSubtitle => 'Для точного расчёта времени намаза';

  @override
  String get onboarding_locationTitle => 'Укажите своё местоположение';

  @override
  String get onboarding_locationSubtitle => 'Для точного времени намаза';

  @override
  String get onboarding_locationBody =>
      'Приложение запросит доступ к местоположению,\nчтобы автоматически определять время намаза';

  @override
  String get onboarding_locationPrivacy =>
      'Ваши данные остаются только на вашем устройстве';

  @override
  String get onboarding_start => 'Начать';

  @override
  String get settings_dirRtl => 'RTL';

  @override
  String get settings_dirLtr => 'LTR';

  @override
  String get settings_secAdhan => 'Азан';

  @override
  String get settings_secApp => 'Приложение';

  @override
  String get settings_secAppearance => 'Оформление';

  @override
  String get settings_secAccessibility => 'Доступность';

  @override
  String get settings_highContrast => 'Высокий контраст';

  @override
  String get settings_reduceMotion => 'Уменьшить движение';

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
  String get settings_previewAdhan => 'Прослушать голос азана';

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
  String get settings_fontQuran => 'Шахерезада';

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
  String get settings_licenses => 'Лицензии';

  @override
  String get settings_openSourcePackages => 'Лицензии открытых пакетов';

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
  String get calc_Karachi => 'Карачи';

  @override
  String get calc_Singapore => 'Сингапур';

  @override
  String get calc_Turkey => 'Турция (Диянет)';

  @override
  String get calc_MoonSighting => 'Комитет по наблюдению за луной';

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
  String get search_typeAthkar => 'Зикр';

  @override
  String get search_partialResults =>
      'Некоторые источники недоступны — результаты могут быть неполными';

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
  String get portal_adwaaHadiths => 'Адва аль-Баян';

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
  String get portal_reportTranslation => 'Сообщить об ошибке перевода';

  @override
  String get portal_reportDialogTitle => 'Сообщить об ошибке перевода';

  @override
  String get portal_reportIssueLabel => 'Опишите проблему';

  @override
  String get portal_reportIssueHint =>
      'напр. пропущено слово, неточный смысл...';

  @override
  String get portal_reportNoteLabel =>
      'Дополнительное примечание (необязательно)';

  @override
  String get portal_reportCancel => 'Отмена';

  @override
  String get portal_reportSubmit => 'Отправить';

  @override
  String get portal_reportSuccess =>
      'Спасибо, ваше сообщение получено и будет рассмотрено';

  @override
  String get portal_reportError =>
      'Не удалось отправить сообщение, попробуйте позже';

  @override
  String get portal_reportIssueRequired => 'Пожалуйста, опишите проблему';

  @override
  String get portal_translationPendingReview => 'Ожидает проверки сообществом';

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
  String get more_groupPrayerTools => 'Инструменты молитвы';

  @override
  String get more_groupContent => 'Контент';

  @override
  String get mosques_searching => 'Поиск ближайших мечетей...';

  @override
  String get mosques_unnamed => 'Мечеть без названия';

  @override
  String get mosques_notFound => 'Ближайшие мечети не найдены';

  @override
  String get mosques_permissionDenied => 'Доступ к геолокации запрещён';

  @override
  String get mosques_permissionDeniedHint =>
      'Разрешите доступ к геолокации в настройках устройства, чтобы увидеть ближайшие мечети';

  @override
  String get mosques_serviceDisabled => 'Служба геолокации отключена';

  @override
  String get mosques_serviceDisabledHint =>
      'Включите службы геолокации (GPS) в настройках устройства';

  @override
  String get mosques_networkError => 'Не удалось подключиться к серверу';

  @override
  String get mosques_networkErrorHint =>
      'Проверьте подключение к интернету и попробуйте снова';

  @override
  String get mosques_openSettings => 'Открыть настройки';

  @override
  String get mosques_directions => 'Маршрут';

  @override
  String get mosques_desktopOnly =>
      'Эта функция доступна только на Android и iOS';

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

  @override
  String get gateway_entry_title => 'Познать ислам';

  @override
  String get gateway_intro_title => 'Путь духовного осознания';

  @override
  String get gateway_journey_title => 'Путешествие';

  @override
  String get gateway_principles_title => 'Основы ислама';

  @override
  String get gateway_library_title => 'Библиотека';

  @override
  String get gateway_begin => 'Начать путь';

  @override
  String get gateway_next => 'Далее';

  @override
  String get gateway_prev => 'Назад';

  @override
  String get app_tagline => 'Ваш исламский путеводитель';

  @override
  String get app_brand_name => 'СИРАДЖ';

  @override
  String get gateway_shahada_cta => 'Произнеси Свидетельство Сейчас';

  @override
  String get nav_library => 'Библиотека';

  @override
  String get library_could_not_load => 'Не удалось загрузить';

  @override
  String get library_section_not_found => 'Раздел не найден';

  @override
  String get library_content_title => 'Содержимое';

  @override
  String get library_search_in_category => 'Поиск в этой категории...';

  @override
  String get library_no_matching_results => 'Нет совпадений';

  @override
  String get library_no_materials_lang =>
      'Материалы на этом языке пока недоступны';

  @override
  String get library_connection_failed =>
      'Не удалось подключиться. Проверьте интернет и попробуйте снова';

  @override
  String get library_search_content_type => 'Поиск типа контента...';

  @override
  String get library_choose_content_type => 'Выберите тип контента';

  @override
  String get library_no_content_lang => 'Контент на этом языке пока недоступен';

  @override
  String get library_not_found => 'Не найдено';

  @override
  String get library_search_in_section => 'Поиск в этом разделе...';

  @override
  String get library_no_categories => 'Категории пока недоступны';

  @override
  String library_subcategoryCount(int count) {
    return '$count папок';
  }

  @override
  String get library_authorsSection => 'Авторы';

  @override
  String get library_type_books => 'Книги';

  @override
  String get library_type_audios => 'Аудио';

  @override
  String get library_type_videos => 'Видео';

  @override
  String get library_type_articles => 'Статьи';

  @override
  String get adhan_makkah => 'Мекка (Заповедная мечеть)';

  @override
  String get adhan_madinah => 'Медина (мечеть Пророка)';

  @override
  String get adhan_mustafa_ismail => 'Мустафа Исмаил';

  @override
  String get adhan_iraqi => 'Иракский';

  @override
  String get adhan_turkish => 'Турецкий';

  @override
  String get adhan_moroccan => 'Марокканский';

  @override
  String get adhan_indonesian => 'Индонезийский';

  @override
  String get adhan_classic => 'Классический';

  @override
  String prayer_notification_title(Object prayer) {
    return 'Время молитвы $prayer';
  }

  @override
  String get prayer_notification_body => 'Аллаху Акбар, спешите на молитву';

  @override
  String get iqama_notification_title => 'Уведомление об икаме';

  @override
  String iqama_notification_body(Object minutes, Object prayer) {
    return 'Икама через $minutes мин. — $prayer';
  }

  @override
  String get khatmah_title => 'Хатмы';

  @override
  String get khatmah_new => 'Новая хатма';

  @override
  String get khatmah_empty => 'Пока нет хатм. Начните первую!';

  @override
  String get khatmah_name => 'Название хатмы';

  @override
  String get khatmah_duration_days => 'Длительность (дни)';

  @override
  String get khatmah_daily_pages => 'Дневная норма (страницы)';

  @override
  String get khatmah_reminder_time => 'Время напоминания';

  @override
  String get khatmah_create => 'Создать хатму';

  @override
  String get khatmah_preset_ramadan => 'Рамадан (30 дней)';

  @override
  String get khatmah_preset_weekly => 'Еженедельно (7 дней)';

  @override
  String get khatmah_preset_monthly => 'Ежемесячно (30 дней)';

  @override
  String get khatmah_status_ontrack => 'По плану';

  @override
  String get khatmah_status_behind => 'Отставание';

  @override
  String get khatmah_status_ahead => 'Опережение';

  @override
  String get khatmah_status_completed => 'Завершено';

  @override
  String get khatmah_today_portion => 'Норма на сегодня';

  @override
  String get khatmah_read_now => 'Читать сейчас';

  @override
  String get khatmah_page => 'Страница';

  @override
  String khatmah_day_of(Object current, Object total) {
    return 'День $current из $total';
  }

  @override
  String get khatmah_delete_confirm => 'Удалить эту хатму?';

  @override
  String get khatmah_progress => 'Прогресс';

  @override
  String khatmah_share_text(Object day, Object name, Object percent) {
    return 'Я на $day дне моей Хатмы $name, завершено $percent%. Пусть Аллах сделает нас людьми Корана 🤲';
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
