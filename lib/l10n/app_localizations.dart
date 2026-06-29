import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_am.dart';
import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_ff.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_gu.dart';
import 'app_localizations_ha.dart';
import 'app_localizations_id.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_kk.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_mr.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pa.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_so.dart';
import 'app_localizations_sw.dart';
import 'app_localizations_ta.dart';
import 'app_localizations_te.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ur.dart';
import 'app_localizations_uz.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('am'),
    Locale('ar'),
    Locale('bn'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('ff'),
    Locale('fr'),
    Locale('gu'),
    Locale('ha'),
    Locale('id'),
    Locale('it'),
    Locale('ja'),
    Locale('kk'),
    Locale('ko'),
    Locale('mr'),
    Locale('ms'),
    Locale('nl'),
    Locale('pa'),
    Locale('pt'),
    Locale('ru'),
    Locale('so'),
    Locale('sw'),
    Locale('ta'),
    Locale('te'),
    Locale('tr'),
    Locale('ur'),
    Locale('uz'),
    Locale('zh'),
  ];

  /// No description provided for @appName.
  ///
  /// In ar, this message translates to:
  /// **'سراج'**
  String get appName;

  /// No description provided for @prayer_title.
  ///
  /// In ar, this message translates to:
  /// **'أوقات الصلاة'**
  String get prayer_title;

  /// No description provided for @prayer_nextPrayer.
  ///
  /// In ar, this message translates to:
  /// **'الصلاة القادمة'**
  String get prayer_nextPrayer;

  /// No description provided for @prayer_fajr.
  ///
  /// In ar, this message translates to:
  /// **'الفجر'**
  String get prayer_fajr;

  /// No description provided for @prayer_sunrise.
  ///
  /// In ar, this message translates to:
  /// **'الشروق'**
  String get prayer_sunrise;

  /// No description provided for @prayer_dhuhr.
  ///
  /// In ar, this message translates to:
  /// **'الظهر'**
  String get prayer_dhuhr;

  /// No description provided for @prayer_asr.
  ///
  /// In ar, this message translates to:
  /// **'العصر'**
  String get prayer_asr;

  /// No description provided for @prayer_maghrib.
  ///
  /// In ar, this message translates to:
  /// **'المغرب'**
  String get prayer_maghrib;

  /// No description provided for @prayer_isha.
  ///
  /// In ar, this message translates to:
  /// **'العشاء'**
  String get prayer_isha;

  /// No description provided for @prayer_countdown.
  ///
  /// In ar, this message translates to:
  /// **'في {time}'**
  String prayer_countdown(String time);

  /// No description provided for @prayer_locationGPS.
  ///
  /// In ar, this message translates to:
  /// **'موقعك الحالي'**
  String get prayer_locationGPS;

  /// No description provided for @prayer_locationDefault.
  ///
  /// In ar, this message translates to:
  /// **'الرياض (افتراضي)'**
  String get prayer_locationDefault;

  /// No description provided for @quran_title.
  ///
  /// In ar, this message translates to:
  /// **'القرآن الكريم'**
  String get quran_title;

  /// No description provided for @quran_meccan.
  ///
  /// In ar, this message translates to:
  /// **'مكية'**
  String get quran_meccan;

  /// No description provided for @quran_medinan.
  ///
  /// In ar, this message translates to:
  /// **'مدنية'**
  String get quran_medinan;

  /// No description provided for @quran_ayahCount.
  ///
  /// In ar, this message translates to:
  /// **'{count} آية'**
  String quran_ayahCount(int count);

  /// No description provided for @quran_searchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث في القرآن الكريم...'**
  String get quran_searchHint;

  /// No description provided for @quran_noResults.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد نتائج'**
  String get quran_noResults;

  /// No description provided for @quran_searchPrompt.
  ///
  /// In ar, this message translates to:
  /// **'اكتب كلمة للبحث'**
  String get quran_searchPrompt;

  /// No description provided for @quran_tapForTafsir.
  ///
  /// In ar, this message translates to:
  /// **'اضغط مطولاً على أي آية لعرض التفسير'**
  String get quran_tapForTafsir;

  /// No description provided for @quran_tafsirTitle.
  ///
  /// In ar, this message translates to:
  /// **'تفسير الآية {number}'**
  String quran_tafsirTitle(int number);

  /// No description provided for @quran_tafsirSource.
  ///
  /// In ar, this message translates to:
  /// **'الميسر'**
  String get quran_tafsirSource;

  /// No description provided for @quran_tafsirError.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تحميل التفسير'**
  String get quran_tafsirError;

  /// No description provided for @quran_reciter.
  ///
  /// In ar, this message translates to:
  /// **'القارئ'**
  String get quran_reciter;

  /// No description provided for @quran_selectReciter.
  ///
  /// In ar, this message translates to:
  /// **'اختر القارئ'**
  String get quran_selectReciter;

  /// No description provided for @quran_searchReciter.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن قارئ...'**
  String get quran_searchReciter;

  /// No description provided for @quran_playPrompt.
  ///
  /// In ar, this message translates to:
  /// **'اضغط للاستماع'**
  String get quran_playPrompt;

  /// No description provided for @quran_ayahNumber.
  ///
  /// In ar, this message translates to:
  /// **'الآية {number}'**
  String quran_ayahNumber(int number);

  /// No description provided for @athkar_title.
  ///
  /// In ar, this message translates to:
  /// **'الأذكار'**
  String get athkar_title;

  /// No description provided for @athkar_morning.
  ///
  /// In ar, this message translates to:
  /// **'أذكار الصباح'**
  String get athkar_morning;

  /// No description provided for @athkar_evening.
  ///
  /// In ar, this message translates to:
  /// **'أذكار المساء'**
  String get athkar_evening;

  /// No description provided for @athkar_sleep.
  ///
  /// In ar, this message translates to:
  /// **'أذكار النوم'**
  String get athkar_sleep;

  /// No description provided for @athkar_wake.
  ///
  /// In ar, this message translates to:
  /// **'أذكار الاستيقاظ'**
  String get athkar_wake;

  /// No description provided for @athkar_prayer.
  ///
  /// In ar, this message translates to:
  /// **'أذكار بعد الصلاة'**
  String get athkar_prayer;

  /// No description provided for @athkar_general.
  ///
  /// In ar, this message translates to:
  /// **'أذكار متنوعة'**
  String get athkar_general;

  /// No description provided for @athkar_tapToCount.
  ///
  /// In ar, this message translates to:
  /// **'اضغط للعدّ'**
  String get athkar_tapToCount;

  /// No description provided for @athkar_transitioning.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ الانتقال...'**
  String get athkar_transitioning;

  /// No description provided for @athkar_completed.
  ///
  /// In ar, this message translates to:
  /// **'اكتملت {name}'**
  String athkar_completed(String name);

  /// No description provided for @athkar_next.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get athkar_next;

  /// No description provided for @athkar_prev.
  ///
  /// In ar, this message translates to:
  /// **'السابق'**
  String get athkar_prev;

  /// No description provided for @athkar_finish.
  ///
  /// In ar, this message translates to:
  /// **'إنهاء'**
  String get athkar_finish;

  /// No description provided for @athkar_back.
  ///
  /// In ar, this message translates to:
  /// **'رجوع'**
  String get athkar_back;

  /// No description provided for @athkar_source.
  ///
  /// In ar, this message translates to:
  /// **'رواه {source}'**
  String athkar_source(String source);

  /// No description provided for @hadith_title.
  ///
  /// In ar, this message translates to:
  /// **'الحديث الشريف'**
  String get hadith_title;

  /// No description provided for @hadith_searchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث في الأحاديث...'**
  String get hadith_searchHint;

  /// No description provided for @hadith_noResults.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد نتائج للبحث'**
  String get hadith_noResults;

  /// No description provided for @hadith_tapForDetail.
  ///
  /// In ar, this message translates to:
  /// **'اضغط لعرض كامل'**
  String get hadith_tapForDetail;

  /// No description provided for @hadith_retryButton.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get hadith_retryButton;

  /// No description provided for @hadith_loadError.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر التحميل'**
  String get hadith_loadError;

  /// No description provided for @qibla_title.
  ///
  /// In ar, this message translates to:
  /// **'اتجاه القبلة'**
  String get qibla_title;

  /// No description provided for @qibla_active.
  ///
  /// In ar, this message translates to:
  /// **'البوصلة نشطة'**
  String get qibla_active;

  /// No description provided for @qibla_error.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تحديد اتجاه القبلة'**
  String get qibla_error;

  /// No description provided for @qibla_errorHint.
  ///
  /// In ar, this message translates to:
  /// **'تأكد من تفعيل البوصلة والموقع'**
  String get qibla_errorHint;

  /// No description provided for @qibla_kaaba.
  ///
  /// In ar, this message translates to:
  /// **'الكعبة'**
  String get qibla_kaaba;

  /// No description provided for @qibla_fromNorth.
  ///
  /// In ar, this message translates to:
  /// **'من الشمال باتجاه القبلة'**
  String get qibla_fromNorth;

  /// No description provided for @stats_title.
  ///
  /// In ar, this message translates to:
  /// **'إحصائياتي'**
  String get stats_title;

  /// No description provided for @stats_prayerStreak.
  ///
  /// In ar, this message translates to:
  /// **'سلسلة الصلوات'**
  String get stats_prayerStreak;

  /// No description provided for @stats_totalPrayers.
  ///
  /// In ar, this message translates to:
  /// **'إجمالي الصلوات'**
  String get stats_totalPrayers;

  /// No description provided for @stats_quranPages.
  ///
  /// In ar, this message translates to:
  /// **'صفحات القرآن'**
  String get stats_quranPages;

  /// No description provided for @stats_athkarSessions.
  ///
  /// In ar, this message translates to:
  /// **'الأذكار'**
  String get stats_athkarSessions;

  /// No description provided for @stats_khatma.
  ///
  /// In ar, this message translates to:
  /// **'ختمات القرآن'**
  String get stats_khatma;

  /// No description provided for @stats_days.
  ///
  /// In ar, this message translates to:
  /// **'يوم متتالي'**
  String get stats_days;

  /// No description provided for @stats_prayers.
  ///
  /// In ar, this message translates to:
  /// **'صلاة'**
  String get stats_prayers;

  /// No description provided for @stats_pages.
  ///
  /// In ar, this message translates to:
  /// **'صفحة'**
  String get stats_pages;

  /// No description provided for @stats_sessions.
  ///
  /// In ar, this message translates to:
  /// **'جلسة'**
  String get stats_sessions;

  /// No description provided for @stats_khatmaUnit.
  ///
  /// In ar, this message translates to:
  /// **'ختمة'**
  String get stats_khatmaUnit;

  /// No description provided for @stats_currentKhatma.
  ///
  /// In ar, this message translates to:
  /// **'تقدم الختمة الحالية'**
  String get stats_currentKhatma;

  /// No description provided for @more_title.
  ///
  /// In ar, this message translates to:
  /// **'المزيد'**
  String get more_title;

  /// No description provided for @more_qibla.
  ///
  /// In ar, this message translates to:
  /// **'اتجاه القبلة'**
  String get more_qibla;

  /// No description provided for @more_stats.
  ///
  /// In ar, this message translates to:
  /// **'إحصائياتي'**
  String get more_stats;

  /// No description provided for @common_loading.
  ///
  /// In ar, this message translates to:
  /// **'جار التحميل...'**
  String get common_loading;

  /// No description provided for @common_error.
  ///
  /// In ar, this message translates to:
  /// **'خطأ في التحميل'**
  String get common_error;

  /// No description provided for @common_retry.
  ///
  /// In ar, this message translates to:
  /// **'إعادة المحاولة'**
  String get common_retry;

  /// No description provided for @common_back.
  ///
  /// In ar, this message translates to:
  /// **'رجوع'**
  String get common_back;

  /// No description provided for @common_next.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get common_next;

  /// No description provided for @common_save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get common_save;

  /// No description provided for @common_cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get common_cancel;

  /// No description provided for @common_done.
  ///
  /// In ar, this message translates to:
  /// **'تم'**
  String get common_done;

  /// No description provided for @common_search.
  ///
  /// In ar, this message translates to:
  /// **'بحث'**
  String get common_search;

  /// No description provided for @common_noData.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد بيانات'**
  String get common_noData;

  /// No description provided for @common_offline.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد اتصال بالإنترنت'**
  String get common_offline;

  /// No description provided for @nav_home.
  ///
  /// In ar, this message translates to:
  /// **'الرئيسية'**
  String get nav_home;

  /// No description provided for @nav_quran.
  ///
  /// In ar, this message translates to:
  /// **'القرآن'**
  String get nav_quran;

  /// No description provided for @nav_athkar.
  ///
  /// In ar, this message translates to:
  /// **'الأذكار'**
  String get nav_athkar;

  /// No description provided for @nav_hadith.
  ///
  /// In ar, this message translates to:
  /// **'الحديث'**
  String get nav_hadith;

  /// No description provided for @nav_more.
  ///
  /// In ar, this message translates to:
  /// **'المزيد'**
  String get nav_more;

  /// No description provided for @home_greetingNight.
  ///
  /// In ar, this message translates to:
  /// **'ليلة مباركة،'**
  String get home_greetingNight;

  /// No description provided for @home_greetingFajr.
  ///
  /// In ar, this message translates to:
  /// **'السلام على الفجر،'**
  String get home_greetingFajr;

  /// No description provided for @home_greetingMorning.
  ///
  /// In ar, this message translates to:
  /// **'صباح الخير،'**
  String get home_greetingMorning;

  /// No description provided for @home_greetingNoon.
  ///
  /// In ar, this message translates to:
  /// **'مساء النور،'**
  String get home_greetingNoon;

  /// No description provided for @home_greetingAsr.
  ///
  /// In ar, this message translates to:
  /// **'عصر مبارك،'**
  String get home_greetingAsr;

  /// No description provided for @home_greetingEvening.
  ///
  /// In ar, this message translates to:
  /// **'مساء الخير،'**
  String get home_greetingEvening;

  /// No description provided for @home_greetingLateNight.
  ///
  /// In ar, this message translates to:
  /// **'ليلة هادئة،'**
  String get home_greetingLateNight;

  /// No description provided for @home_welcome.
  ///
  /// In ar, this message translates to:
  /// **'أهلاً وسهلاً'**
  String get home_welcome;

  /// No description provided for @home_nextPrayer.
  ///
  /// In ar, this message translates to:
  /// **'الصلاة القادمة'**
  String get home_nextPrayer;

  /// No description provided for @home_qiblaDirection.
  ///
  /// In ar, this message translates to:
  /// **'اتجاه القبلة'**
  String get home_qiblaDirection;

  /// No description provided for @home_continueReading.
  ///
  /// In ar, this message translates to:
  /// **'متابعة القراءة'**
  String get home_continueReading;

  /// No description provided for @home_surah.
  ///
  /// In ar, this message translates to:
  /// **'سورة #{id}'**
  String home_surah(int id);

  /// No description provided for @home_ayah.
  ///
  /// In ar, this message translates to:
  /// **'آية {number}'**
  String home_ayah(int number);

  /// No description provided for @home_dailyAyah.
  ///
  /// In ar, this message translates to:
  /// **'آية اليوم'**
  String get home_dailyAyah;

  /// No description provided for @home_quickAccess.
  ///
  /// In ar, this message translates to:
  /// **'وصول سريع'**
  String get home_quickAccess;

  /// No description provided for @home_searchHint.
  ///
  /// In ar, this message translates to:
  /// **'ما الذي تبحث عنه...'**
  String get home_searchHint;

  /// No description provided for @home_radio.
  ///
  /// In ar, this message translates to:
  /// **'الراديو'**
  String get home_radio;

  /// No description provided for @home_calendar.
  ///
  /// In ar, this message translates to:
  /// **'التقويم'**
  String get home_calendar;

  /// No description provided for @home_stories.
  ///
  /// In ar, this message translates to:
  /// **'القصص'**
  String get home_stories;

  /// No description provided for @home_children.
  ///
  /// In ar, this message translates to:
  /// **'الأطفال'**
  String get home_children;

  /// No description provided for @settings_title.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get settings_title;

  /// No description provided for @radio_title.
  ///
  /// In ar, this message translates to:
  /// **'إذاعات سراج'**
  String get radio_title;

  /// No description provided for @radio_all.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get radio_all;

  /// No description provided for @radio_quran.
  ///
  /// In ar, this message translates to:
  /// **'قرآن'**
  String get radio_quran;

  /// No description provided for @radio_translations.
  ///
  /// In ar, this message translates to:
  /// **'تراجم'**
  String get radio_translations;

  /// No description provided for @radio_tafsir.
  ///
  /// In ar, this message translates to:
  /// **'تفسير وفتاوى'**
  String get radio_tafsir;

  /// No description provided for @radio_athkar.
  ///
  /// In ar, this message translates to:
  /// **'أذكار'**
  String get radio_athkar;

  /// No description provided for @radio_international.
  ///
  /// In ar, this message translates to:
  /// **'إذاعات دولية'**
  String get radio_international;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'am',
    'ar',
    'bn',
    'de',
    'en',
    'es',
    'fa',
    'ff',
    'fr',
    'gu',
    'ha',
    'id',
    'it',
    'ja',
    'kk',
    'ko',
    'mr',
    'ms',
    'nl',
    'pa',
    'pt',
    'ru',
    'so',
    'sw',
    'ta',
    'te',
    'tr',
    'ur',
    'uz',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'am':
      return AppLocalizationsAm();
    case 'ar':
      return AppLocalizationsAr();
    case 'bn':
      return AppLocalizationsBn();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fa':
      return AppLocalizationsFa();
    case 'ff':
      return AppLocalizationsFf();
    case 'fr':
      return AppLocalizationsFr();
    case 'gu':
      return AppLocalizationsGu();
    case 'ha':
      return AppLocalizationsHa();
    case 'id':
      return AppLocalizationsId();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
    case 'kk':
      return AppLocalizationsKk();
    case 'ko':
      return AppLocalizationsKo();
    case 'mr':
      return AppLocalizationsMr();
    case 'ms':
      return AppLocalizationsMs();
    case 'nl':
      return AppLocalizationsNl();
    case 'pa':
      return AppLocalizationsPa();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'so':
      return AppLocalizationsSo();
    case 'sw':
      return AppLocalizationsSw();
    case 'ta':
      return AppLocalizationsTa();
    case 'te':
      return AppLocalizationsTe();
    case 'tr':
      return AppLocalizationsTr();
    case 'ur':
      return AppLocalizationsUr();
    case 'uz':
      return AppLocalizationsUz();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
