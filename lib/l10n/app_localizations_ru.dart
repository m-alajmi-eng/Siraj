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
}
