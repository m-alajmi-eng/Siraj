import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_bn.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fa.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ha.dart';
import 'app_localizations_id.dart';
import 'app_localizations_ms.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sw.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_ur.dart';
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
    Locale('ar'),
    Locale('bn'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fa'),
    Locale('fr'),
    Locale('ha'),
    Locale('id'),
    Locale('ms'),
    Locale('ru'),
    Locale('sw'),
    Locale('tr'),
    Locale('ur'),
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

  /// No description provided for @cal_title.
  ///
  /// In ar, this message translates to:
  /// **'التقويم الإسلامي'**
  String get cal_title;

  /// No description provided for @cal_todayEvents.
  ///
  /// In ar, this message translates to:
  /// **'مناسبات اليوم'**
  String get cal_todayEvents;

  /// No description provided for @cal_nextEvent.
  ///
  /// In ar, this message translates to:
  /// **'المناسبة القادمة'**
  String get cal_nextEvent;

  /// No description provided for @cal_allEvents.
  ///
  /// In ar, this message translates to:
  /// **'المناسبات الإسلامية'**
  String get cal_allEvents;

  /// No description provided for @cal_daysUntil.
  ///
  /// In ar, this message translates to:
  /// **'{days} يوم'**
  String cal_daysUntil(int days);

  /// No description provided for @cal_gregorian.
  ///
  /// In ar, this message translates to:
  /// **'ميلادي'**
  String get cal_gregorian;

  /// No description provided for @cal_hijri.
  ///
  /// In ar, this message translates to:
  /// **'هجري'**
  String get cal_hijri;

  /// No description provided for @hm_1.
  ///
  /// In ar, this message translates to:
  /// **'محرم'**
  String get hm_1;

  /// No description provided for @hm_2.
  ///
  /// In ar, this message translates to:
  /// **'صفر'**
  String get hm_2;

  /// No description provided for @hm_3.
  ///
  /// In ar, this message translates to:
  /// **'ربيع الأول'**
  String get hm_3;

  /// No description provided for @hm_4.
  ///
  /// In ar, this message translates to:
  /// **'ربيع الآخر'**
  String get hm_4;

  /// No description provided for @hm_5.
  ///
  /// In ar, this message translates to:
  /// **'جمادى الأولى'**
  String get hm_5;

  /// No description provided for @hm_6.
  ///
  /// In ar, this message translates to:
  /// **'جمادى الآخرة'**
  String get hm_6;

  /// No description provided for @hm_7.
  ///
  /// In ar, this message translates to:
  /// **'رجب'**
  String get hm_7;

  /// No description provided for @hm_8.
  ///
  /// In ar, this message translates to:
  /// **'شعبان'**
  String get hm_8;

  /// No description provided for @hm_9.
  ///
  /// In ar, this message translates to:
  /// **'رمضان'**
  String get hm_9;

  /// No description provided for @hm_10.
  ///
  /// In ar, this message translates to:
  /// **'شوال'**
  String get hm_10;

  /// No description provided for @hm_11.
  ///
  /// In ar, this message translates to:
  /// **'ذو القعدة'**
  String get hm_11;

  /// No description provided for @hm_12.
  ///
  /// In ar, this message translates to:
  /// **'ذو الحجة'**
  String get hm_12;

  /// No description provided for @ev_new_year.
  ///
  /// In ar, this message translates to:
  /// **'رأس السنة الهجرية'**
  String get ev_new_year;

  /// No description provided for @ev_ashura.
  ///
  /// In ar, this message translates to:
  /// **'يوم عاشوراء'**
  String get ev_ashura;

  /// No description provided for @ev_mawlid.
  ///
  /// In ar, this message translates to:
  /// **'المولد النبوي'**
  String get ev_mawlid;

  /// No description provided for @ev_isra.
  ///
  /// In ar, this message translates to:
  /// **'ليلة الإسراء والمعراج'**
  String get ev_isra;

  /// No description provided for @ev_ramadan_start.
  ///
  /// In ar, this message translates to:
  /// **'أول رمضان'**
  String get ev_ramadan_start;

  /// No description provided for @ev_laylat_qadr.
  ///
  /// In ar, this message translates to:
  /// **'ليلة القدر'**
  String get ev_laylat_qadr;

  /// No description provided for @ev_eid_fitr.
  ///
  /// In ar, this message translates to:
  /// **'عيد الفطر'**
  String get ev_eid_fitr;

  /// No description provided for @ev_arafah.
  ///
  /// In ar, this message translates to:
  /// **'يوم عرفة'**
  String get ev_arafah;

  /// No description provided for @ev_eid_adha.
  ///
  /// In ar, this message translates to:
  /// **'عيد الأضحى'**
  String get ev_eid_adha;

  /// No description provided for @ev_tashreeq.
  ///
  /// In ar, this message translates to:
  /// **'أيام التشريق'**
  String get ev_tashreeq;

  /// No description provided for @stories_title.
  ///
  /// In ar, this message translates to:
  /// **'القصص والسير'**
  String get stories_title;

  /// No description provided for @stories_prophets.
  ///
  /// In ar, this message translates to:
  /// **'الأنبياء'**
  String get stories_prophets;

  /// No description provided for @stories_companions.
  ///
  /// In ar, this message translates to:
  /// **'الصحابة'**
  String get stories_companions;

  /// No description provided for @stories_scholars.
  ///
  /// In ar, this message translates to:
  /// **'العلماء'**
  String get stories_scholars;

  /// No description provided for @stories_comingSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً'**
  String get stories_comingSoon;

  /// No description provided for @stories_comingSoonMsg.
  ///
  /// In ar, this message translates to:
  /// **'قريباً — نعمل على إضافة المحتوى'**
  String get stories_comingSoonMsg;

  /// No description provided for @children_title.
  ///
  /// In ar, this message translates to:
  /// **'قصص الأطفال'**
  String get children_title;

  /// No description provided for @settings_secIdentity.
  ///
  /// In ar, this message translates to:
  /// **'الهوية'**
  String get settings_secIdentity;

  /// No description provided for @settings_secAdhan.
  ///
  /// In ar, this message translates to:
  /// **'الأذان'**
  String get settings_secAdhan;

  /// No description provided for @settings_secApp.
  ///
  /// In ar, this message translates to:
  /// **'التطبيق'**
  String get settings_secApp;

  /// No description provided for @settings_secPrivacy.
  ///
  /// In ar, this message translates to:
  /// **'الخصوصية'**
  String get settings_secPrivacy;

  /// No description provided for @settings_secAbout.
  ///
  /// In ar, this message translates to:
  /// **'عن التطبيق'**
  String get settings_secAbout;

  /// No description provided for @settings_language.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get settings_language;

  /// No description provided for @settings_chooseLanguage.
  ///
  /// In ar, this message translates to:
  /// **'اختر اللغة'**
  String get settings_chooseLanguage;

  /// No description provided for @settings_madhab.
  ///
  /// In ar, this message translates to:
  /// **'المذهب'**
  String get settings_madhab;

  /// No description provided for @settings_chooseMadhab.
  ///
  /// In ar, this message translates to:
  /// **'اختر المذهب'**
  String get settings_chooseMadhab;

  /// No description provided for @settings_calcMethod.
  ///
  /// In ar, this message translates to:
  /// **'طريقة حساب الصلاة'**
  String get settings_calcMethod;

  /// No description provided for @settings_chooseCalc.
  ///
  /// In ar, this message translates to:
  /// **'طريقة الحساب'**
  String get settings_chooseCalc;

  /// No description provided for @settings_enableAdhan.
  ///
  /// In ar, this message translates to:
  /// **'تفعيل الأذان'**
  String get settings_enableAdhan;

  /// No description provided for @settings_muezzinVoice.
  ///
  /// In ar, this message translates to:
  /// **'صوت المؤذن'**
  String get settings_muezzinVoice;

  /// No description provided for @settings_vibration.
  ///
  /// In ar, this message translates to:
  /// **'اهتزاز بدل صوت'**
  String get settings_vibration;

  /// No description provided for @settings_iqamaAlert.
  ///
  /// In ar, this message translates to:
  /// **'تنبيه قبل الإقامة'**
  String get settings_iqamaAlert;

  /// No description provided for @settings_minutes.
  ///
  /// In ar, this message translates to:
  /// **'{n} د'**
  String settings_minutes(int n);

  /// No description provided for @settings_appMode.
  ///
  /// In ar, this message translates to:
  /// **'وضع التطبيق'**
  String get settings_appMode;

  /// No description provided for @settings_fullMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الكامل'**
  String get settings_fullMode;

  /// No description provided for @settings_liteMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الخفيف'**
  String get settings_liteMode;

  /// No description provided for @settings_fullModeDesc.
  ///
  /// In ar, this message translates to:
  /// **'كل الميزات متاحة'**
  String get settings_fullModeDesc;

  /// No description provided for @settings_liteModeDesc.
  ///
  /// In ar, this message translates to:
  /// **'الأساسيات فقط — بدون إنترنت'**
  String get settings_liteModeDesc;

  /// No description provided for @settings_quranFont.
  ///
  /// In ar, this message translates to:
  /// **'خط القرآن'**
  String get settings_quranFont;

  /// No description provided for @settings_fontUthmani.
  ///
  /// In ar, this message translates to:
  /// **'عثماني'**
  String get settings_fontUthmani;

  /// No description provided for @settings_fontHafs.
  ///
  /// In ar, this message translates to:
  /// **'حفص'**
  String get settings_fontHafs;

  /// No description provided for @settings_quranFontSize.
  ///
  /// In ar, this message translates to:
  /// **'حجم خط القرآن'**
  String get settings_quranFontSize;

  /// No description provided for @settings_privacyNote.
  ///
  /// In ar, this message translates to:
  /// **'موقعك يبقى على جهازك فقط'**
  String get settings_privacyNote;

  /// No description provided for @settings_clearCache.
  ///
  /// In ar, this message translates to:
  /// **'حذف بيانات الكاش'**
  String get settings_clearCache;

  /// No description provided for @settings_clearCacheTitle.
  ///
  /// In ar, this message translates to:
  /// **'حذف الكاش'**
  String get settings_clearCacheTitle;

  /// No description provided for @settings_clearCacheMsg.
  ///
  /// In ar, this message translates to:
  /// **'سيتم حذف البيانات المحفوظة محلياً. هل أنت متأكد؟'**
  String get settings_clearCacheMsg;

  /// No description provided for @settings_cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get settings_cancel;

  /// No description provided for @settings_delete.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get settings_delete;

  /// No description provided for @settings_version.
  ///
  /// In ar, this message translates to:
  /// **'الإصدار'**
  String get settings_version;

  /// No description provided for @settings_shareApp.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة التطبيق'**
  String get settings_shareApp;

  /// No description provided for @settings_tagline.
  ///
  /// In ar, this message translates to:
  /// **'سراج — نور على نور'**
  String get settings_tagline;

  /// No description provided for @madhab_hanafi.
  ///
  /// In ar, this message translates to:
  /// **'الحنفي'**
  String get madhab_hanafi;

  /// No description provided for @madhab_maliki.
  ///
  /// In ar, this message translates to:
  /// **'المالكي'**
  String get madhab_maliki;

  /// No description provided for @madhab_shafi.
  ///
  /// In ar, this message translates to:
  /// **'الشافعي'**
  String get madhab_shafi;

  /// No description provided for @madhab_hanbali.
  ///
  /// In ar, this message translates to:
  /// **'الحنبلي'**
  String get madhab_hanbali;

  /// No description provided for @calc_MWL.
  ///
  /// In ar, this message translates to:
  /// **'رابطة العالم الإسلامي'**
  String get calc_MWL;

  /// No description provided for @calc_ISNA.
  ///
  /// In ar, this message translates to:
  /// **'أمريكا الشمالية (ISNA)'**
  String get calc_ISNA;

  /// No description provided for @calc_Egypt.
  ///
  /// In ar, this message translates to:
  /// **'الهيئة المصرية'**
  String get calc_Egypt;

  /// No description provided for @calc_Makkah.
  ///
  /// In ar, this message translates to:
  /// **'أم القرى (مكة)'**
  String get calc_Makkah;

  /// No description provided for @calc_Kuwait.
  ///
  /// In ar, this message translates to:
  /// **'الكويت'**
  String get calc_Kuwait;

  /// No description provided for @calc_Qatar.
  ///
  /// In ar, this message translates to:
  /// **'قطر'**
  String get calc_Qatar;

  /// No description provided for @calc_Dubai.
  ///
  /// In ar, this message translates to:
  /// **'دبي'**
  String get calc_Dubai;

  /// No description provided for @search_hint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث في القرآن والتفاسير...'**
  String get search_hint;

  /// No description provided for @search_empty.
  ///
  /// In ar, this message translates to:
  /// **'ابحث في القرآن الكريم والتفاسير ومعاني الكلمات'**
  String get search_empty;

  /// No description provided for @search_noResults.
  ///
  /// In ar, this message translates to:
  /// **'لا نتائج لـ \"{query}\"'**
  String search_noResults(String query);

  /// No description provided for @search_typeAyah.
  ///
  /// In ar, this message translates to:
  /// **'آية'**
  String get search_typeAyah;

  /// No description provided for @search_typeTafsir.
  ///
  /// In ar, this message translates to:
  /// **'تفسير'**
  String get search_typeTafsir;

  /// No description provided for @search_typeWord.
  ///
  /// In ar, this message translates to:
  /// **'كلمة'**
  String get search_typeWord;

  /// No description provided for @search_typeHadith.
  ///
  /// In ar, this message translates to:
  /// **'حديث'**
  String get search_typeHadith;

  /// No description provided for @stats_daysStreak.
  ///
  /// In ar, this message translates to:
  /// **'يوم متتالي'**
  String get stats_daysStreak;

  /// No description provided for @stats_prayersUnit.
  ///
  /// In ar, this message translates to:
  /// **'صلاة'**
  String get stats_prayersUnit;

  /// No description provided for @stats_pagesUnit.
  ///
  /// In ar, this message translates to:
  /// **'صفحة'**
  String get stats_pagesUnit;

  /// No description provided for @stats_athkar.
  ///
  /// In ar, this message translates to:
  /// **'الأذكار'**
  String get stats_athkar;

  /// No description provided for @stats_sessionsUnit.
  ///
  /// In ar, this message translates to:
  /// **'جلسة'**
  String get stats_sessionsUnit;

  /// No description provided for @stats_pagesOf.
  ///
  /// In ar, this message translates to:
  /// **'{read} / {total} صفحة'**
  String stats_pagesOf(int read, int total);

  /// No description provided for @reader_tapToListen.
  ///
  /// In ar, this message translates to:
  /// **'اضغط للاستماع'**
  String get reader_tapToListen;

  /// No description provided for @reader_ayahNum.
  ///
  /// In ar, this message translates to:
  /// **'الآية {n}'**
  String reader_ayahNum(int n);

  /// No description provided for @reader_reciter.
  ///
  /// In ar, this message translates to:
  /// **'القارئ'**
  String get reader_reciter;

  /// No description provided for @reader_chooseReciter.
  ///
  /// In ar, this message translates to:
  /// **'اختر القارئ'**
  String get reader_chooseReciter;

  /// No description provided for @reader_searchReciter.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن قارئ...'**
  String get reader_searchReciter;

  /// No description provided for @reader_longPressHint.
  ///
  /// In ar, this message translates to:
  /// **'اضغط مطولاً على أي آية للبوابة والتفسير والمشاركة'**
  String get reader_longPressHint;

  /// No description provided for @reader_versePortal.
  ///
  /// In ar, this message translates to:
  /// **'بوابة الآية'**
  String get reader_versePortal;

  /// No description provided for @reader_portalSub.
  ///
  /// In ar, this message translates to:
  /// **'تفسير · كلمات · سياق'**
  String get reader_portalSub;

  /// No description provided for @reader_showTafsir.
  ///
  /// In ar, this message translates to:
  /// **'عرض التفسير'**
  String get reader_showTafsir;

  /// No description provided for @reader_shareAyah.
  ///
  /// In ar, this message translates to:
  /// **'مشاركة الآية'**
  String get reader_shareAyah;

  /// No description provided for @reader_copyAyah.
  ///
  /// In ar, this message translates to:
  /// **'نسخ الآية'**
  String get reader_copyAyah;

  /// No description provided for @reader_ayahCopied.
  ///
  /// In ar, this message translates to:
  /// **'تم نسخ الآية'**
  String get reader_ayahCopied;

  /// No description provided for @reader_tafsirOf.
  ///
  /// In ar, this message translates to:
  /// **'تفسير الآية {n}'**
  String reader_tafsirOf(int n);

  /// No description provided for @reader_muyassar.
  ///
  /// In ar, this message translates to:
  /// **'الميسر'**
  String get reader_muyassar;

  /// No description provided for @reader_tafsirError.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر تحميل التفسير'**
  String get reader_tafsirError;

  /// No description provided for @reader_shareTitle.
  ///
  /// In ar, this message translates to:
  /// **'آية كريمة'**
  String get reader_shareTitle;

  /// No description provided for @reader_shareSubtitle.
  ///
  /// In ar, this message translates to:
  /// **'{surah} · آية {n}'**
  String reader_shareSubtitle(String surah, int n);

  /// No description provided for @portal_muyassar.
  ///
  /// In ar, this message translates to:
  /// **'التفسير الميسّر'**
  String get portal_muyassar;

  /// No description provided for @portal_words.
  ///
  /// In ar, this message translates to:
  /// **'الشرح اللغوي'**
  String get portal_words;

  /// No description provided for @portal_hadiths.
  ///
  /// In ar, this message translates to:
  /// **'أحاديث'**
  String get portal_hadiths;

  /// No description provided for @portal_stories.
  ///
  /// In ar, this message translates to:
  /// **'قصص وسير'**
  String get portal_stories;

  /// No description provided for @portal_arabicTafsir.
  ///
  /// In ar, this message translates to:
  /// **'التفاسير بالعربية'**
  String get portal_arabicTafsir;

  /// No description provided for @portal_foreignTafsir.
  ///
  /// In ar, this message translates to:
  /// **'التفاسير بلغات أجنبية'**
  String get portal_foreignTafsir;

  /// No description provided for @portal_asbab.
  ///
  /// In ar, this message translates to:
  /// **'سبب النزول'**
  String get portal_asbab;

  /// No description provided for @portal_searchLang.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن لغة...'**
  String get portal_searchLang;

  /// No description provided for @portal_error.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر فتح البوابة'**
  String get portal_error;

  /// No description provided for @portal_back.
  ///
  /// In ar, this message translates to:
  /// **'رجوع'**
  String get portal_back;

  /// No description provided for @portal_noTafsir.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد تفسير'**
  String get portal_noTafsir;

  /// No description provided for @portal_loadError.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر التحميل'**
  String get portal_loadError;

  /// No description provided for @portal_comingSoon.
  ///
  /// In ar, this message translates to:
  /// **'قريباً'**
  String get portal_comingSoon;

  /// No description provided for @portal_noHadiths.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد أحاديث مرتبطة بهذه الآية حتى الآن'**
  String get portal_noHadiths;

  /// No description provided for @portal_addingContent.
  ///
  /// In ar, this message translates to:
  /// **'نعمل على إضافة المحتوى تدريجياً'**
  String get portal_addingContent;

  /// No description provided for @more_search.
  ///
  /// In ar, this message translates to:
  /// **'البحث الموحد'**
  String get more_search;

  /// No description provided for @more_settings.
  ///
  /// In ar, this message translates to:
  /// **'الإعدادات'**
  String get more_settings;

  /// No description provided for @more_calendar.
  ///
  /// In ar, this message translates to:
  /// **'التقويم الإسلامي'**
  String get more_calendar;

  /// No description provided for @more_shareCards.
  ///
  /// In ar, this message translates to:
  /// **'بطاقات المشاركة'**
  String get more_shareCards;

  /// No description provided for @more_fullMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الكامل'**
  String get more_fullMode;

  /// No description provided for @more_radio.
  ///
  /// In ar, this message translates to:
  /// **'راديو القرآن'**
  String get more_radio;

  /// No description provided for @more_mosques.
  ///
  /// In ar, this message translates to:
  /// **'المساجد القريبة'**
  String get more_mosques;

  /// No description provided for @athkarcat_error.
  ///
  /// In ar, this message translates to:
  /// **'خطأ'**
  String get athkarcat_error;

  /// No description provided for @athkarcat_empty.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد أذكار'**
  String get athkarcat_empty;

  /// No description provided for @athkarcat_completed.
  ///
  /// In ar, this message translates to:
  /// **'اكتملت {name}'**
  String athkarcat_completed(String name);

  /// No description provided for @athkarcat_back.
  ///
  /// In ar, this message translates to:
  /// **'رجوع'**
  String get athkarcat_back;

  /// No description provided for @athkarcat_next.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get athkarcat_next;

  /// No description provided for @athkarcat_finish.
  ///
  /// In ar, this message translates to:
  /// **'إنهاء'**
  String get athkarcat_finish;

  /// No description provided for @athkarcat_prev.
  ///
  /// In ar, this message translates to:
  /// **'السابق'**
  String get athkarcat_prev;

  /// No description provided for @athkarcat_repeat.
  ///
  /// In ar, this message translates to:
  /// **'التكرار: {count} · {source}'**
  String athkarcat_repeat(int count, String source);

  /// No description provided for @athkarcat_narrated.
  ///
  /// In ar, this message translates to:
  /// **'رواه {source}'**
  String athkarcat_narrated(String source);

  /// No description provided for @athkarcat_moving.
  ///
  /// In ar, this message translates to:
  /// **'جارٍ الانتقال...'**
  String get athkarcat_moving;

  /// No description provided for @athkarcat_tapCount.
  ///
  /// In ar, this message translates to:
  /// **'اضغط للعدّ'**
  String get athkarcat_tapCount;

  /// No description provided for @athkar_allSections.
  ///
  /// In ar, this message translates to:
  /// **'جميع الأقسام'**
  String get athkar_allSections;

  /// No description provided for @gateway_entry_title.
  ///
  /// In ar, this message translates to:
  /// **'تعرّف على الإسلام'**
  String get gateway_entry_title;

  /// No description provided for @gateway_intro_title.
  ///
  /// In ar, this message translates to:
  /// **'رحلة الوعي الروحي'**
  String get gateway_intro_title;

  /// No description provided for @gateway_journey_title.
  ///
  /// In ar, this message translates to:
  /// **'رحلة الوعي'**
  String get gateway_journey_title;

  /// No description provided for @gateway_principles_title.
  ///
  /// In ar, this message translates to:
  /// **'مبادئ الإسلام'**
  String get gateway_principles_title;

  /// No description provided for @gateway_library_title.
  ///
  /// In ar, this message translates to:
  /// **'مكتبة التعمّق'**
  String get gateway_library_title;

  /// No description provided for @gateway_begin.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ الرحلة'**
  String get gateway_begin;

  /// No description provided for @gateway_next.
  ///
  /// In ar, this message translates to:
  /// **'التالي'**
  String get gateway_next;

  /// No description provided for @gateway_prev.
  ///
  /// In ar, this message translates to:
  /// **'السابق'**
  String get gateway_prev;

  /// No description provided for @app_tagline.
  ///
  /// In ar, this message translates to:
  /// **'دليلك الإسلامي'**
  String get app_tagline;

  /// No description provided for @app_brand_name.
  ///
  /// In ar, this message translates to:
  /// **'SIRAJ'**
  String get app_brand_name;

  /// No description provided for @gateway_shahada_cta.
  ///
  /// In ar, this message translates to:
  /// **'أعلن شهادتك الآن'**
  String get gateway_shahada_cta;

  /// No description provided for @nav_library.
  ///
  /// In ar, this message translates to:
  /// **'المكتبة'**
  String get nav_library;

  /// No description provided for @library_could_not_load.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر التحميل'**
  String get library_could_not_load;

  /// No description provided for @library_section_not_found.
  ///
  /// In ar, this message translates to:
  /// **'القسم غير موجود'**
  String get library_section_not_found;

  /// No description provided for @library_content_title.
  ///
  /// In ar, this message translates to:
  /// **'المحتوى'**
  String get library_content_title;

  /// No description provided for @library_search_in_category.
  ///
  /// In ar, this message translates to:
  /// **'ابحث في هذا التصنيف...'**
  String get library_search_in_category;

  /// No description provided for @library_no_matching_results.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد نتائج مطابقة'**
  String get library_no_matching_results;

  /// No description provided for @library_no_materials_lang.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد مواد متاحة حالياً بهذه اللغة'**
  String get library_no_materials_lang;

  /// No description provided for @library_connection_failed.
  ///
  /// In ar, this message translates to:
  /// **'تعذّر الاتصال. تحقّق من الإنترنت وحاول مجدداً'**
  String get library_connection_failed;

  /// No description provided for @library_search_content_type.
  ///
  /// In ar, this message translates to:
  /// **'ابحث عن نوع المحتوى...'**
  String get library_search_content_type;

  /// No description provided for @library_choose_content_type.
  ///
  /// In ar, this message translates to:
  /// **'اختر نوع المحتوى'**
  String get library_choose_content_type;

  /// No description provided for @library_no_content_lang.
  ///
  /// In ar, this message translates to:
  /// **'لا يوجد محتوى متاح حالياً بهذه اللغة'**
  String get library_no_content_lang;

  /// No description provided for @library_not_found.
  ///
  /// In ar, this message translates to:
  /// **'غير موجود'**
  String get library_not_found;

  /// No description provided for @library_search_in_section.
  ///
  /// In ar, this message translates to:
  /// **'ابحث في هذا القسم...'**
  String get library_search_in_section;

  /// No description provided for @library_no_categories.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد تصنيفات متاحة حالياً'**
  String get library_no_categories;

  /// No description provided for @library_type_books.
  ///
  /// In ar, this message translates to:
  /// **'كتب'**
  String get library_type_books;

  /// No description provided for @library_type_audios.
  ///
  /// In ar, this message translates to:
  /// **'صوتيات'**
  String get library_type_audios;

  /// No description provided for @library_type_videos.
  ///
  /// In ar, this message translates to:
  /// **'مرئيات'**
  String get library_type_videos;

  /// No description provided for @library_type_articles.
  ///
  /// In ar, this message translates to:
  /// **'مقالات'**
  String get library_type_articles;

  /// No description provided for @adhan_makkah.
  ///
  /// In ar, this message translates to:
  /// **'مكي (الحرم المكي)'**
  String get adhan_makkah;

  /// No description provided for @adhan_madinah.
  ///
  /// In ar, this message translates to:
  /// **'مديني (الحرم النبوي)'**
  String get adhan_madinah;

  /// No description provided for @adhan_mustafa_ismail.
  ///
  /// In ar, this message translates to:
  /// **'مصطفى إسماعيل'**
  String get adhan_mustafa_ismail;

  /// No description provided for @adhan_iraqi.
  ///
  /// In ar, this message translates to:
  /// **'عراقي'**
  String get adhan_iraqi;

  /// No description provided for @adhan_turkish.
  ///
  /// In ar, this message translates to:
  /// **'تركي'**
  String get adhan_turkish;

  /// No description provided for @adhan_moroccan.
  ///
  /// In ar, this message translates to:
  /// **'مغربي'**
  String get adhan_moroccan;

  /// No description provided for @adhan_indonesian.
  ///
  /// In ar, this message translates to:
  /// **'أندونيسي'**
  String get adhan_indonesian;

  /// No description provided for @adhan_classic.
  ///
  /// In ar, this message translates to:
  /// **'كلاسيكي'**
  String get adhan_classic;

  /// No description provided for @prayer_notification_title.
  ///
  /// In ar, this message translates to:
  /// **'حان وقت {prayer}'**
  String prayer_notification_title(Object prayer);

  /// No description provided for @prayer_notification_body.
  ///
  /// In ar, this message translates to:
  /// **'الله أكبر، حي على الصلاة'**
  String get prayer_notification_body;

  /// No description provided for @khatmah_title.
  ///
  /// In ar, this message translates to:
  /// **'الختمات'**
  String get khatmah_title;

  /// No description provided for @khatmah_new.
  ///
  /// In ar, this message translates to:
  /// **'ختمة جديدة'**
  String get khatmah_new;

  /// No description provided for @khatmah_empty.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد ختمات بعد. ابدأ ختمتك الأولى!'**
  String get khatmah_empty;

  /// No description provided for @khatmah_name.
  ///
  /// In ar, this message translates to:
  /// **'اسم الختمة'**
  String get khatmah_name;

  /// No description provided for @khatmah_duration_days.
  ///
  /// In ar, this message translates to:
  /// **'المدة (أيام)'**
  String get khatmah_duration_days;

  /// No description provided for @khatmah_daily_pages.
  ///
  /// In ar, this message translates to:
  /// **'الوِرد اليومي (صفحات)'**
  String get khatmah_daily_pages;

  /// No description provided for @khatmah_reminder_time.
  ///
  /// In ar, this message translates to:
  /// **'وقت التذكير'**
  String get khatmah_reminder_time;

  /// No description provided for @khatmah_create.
  ///
  /// In ar, this message translates to:
  /// **'إنشاء الختمة'**
  String get khatmah_create;

  /// No description provided for @khatmah_preset_ramadan.
  ///
  /// In ar, this message translates to:
  /// **'رمضان (30 يوما)'**
  String get khatmah_preset_ramadan;

  /// No description provided for @khatmah_preset_weekly.
  ///
  /// In ar, this message translates to:
  /// **'أسبوعية (7 أيام)'**
  String get khatmah_preset_weekly;

  /// No description provided for @khatmah_preset_monthly.
  ///
  /// In ar, this message translates to:
  /// **'شهرية (30 يوماً)'**
  String get khatmah_preset_monthly;

  /// No description provided for @khatmah_status_ontrack.
  ///
  /// In ar, this message translates to:
  /// **'على المسار'**
  String get khatmah_status_ontrack;

  /// No description provided for @khatmah_status_behind.
  ///
  /// In ar, this message translates to:
  /// **'متأخر'**
  String get khatmah_status_behind;

  /// No description provided for @khatmah_status_ahead.
  ///
  /// In ar, this message translates to:
  /// **'متقدّم'**
  String get khatmah_status_ahead;

  /// No description provided for @khatmah_status_completed.
  ///
  /// In ar, this message translates to:
  /// **'مكتملة'**
  String get khatmah_status_completed;

  /// No description provided for @khatmah_today_portion.
  ///
  /// In ar, this message translates to:
  /// **'وردك اليوم'**
  String get khatmah_today_portion;

  /// No description provided for @khatmah_read_now.
  ///
  /// In ar, this message translates to:
  /// **'اقرأ الآن'**
  String get khatmah_read_now;

  /// No description provided for @khatmah_page.
  ///
  /// In ar, this message translates to:
  /// **'صفحة'**
  String get khatmah_page;

  /// No description provided for @khatmah_day_of.
  ///
  /// In ar, this message translates to:
  /// **'اليوم {current} من {total}'**
  String khatmah_day_of(Object current, Object total);

  /// No description provided for @khatmah_delete_confirm.
  ///
  /// In ar, this message translates to:
  /// **'هل تريد حذف هذه الختمة؟'**
  String get khatmah_delete_confirm;

  /// No description provided for @khatmah_progress.
  ///
  /// In ar, this message translates to:
  /// **'التقدّم'**
  String get khatmah_progress;

  /// No description provided for @khatmah_share_text.
  ///
  /// In ar, this message translates to:
  /// **'أنا في يومي {day} من ختمة {name}، أكملت {percent}% حتى الآن. اللهم اجعلنا من أهل القرآن 🤲'**
  String khatmah_share_text(Object day, Object name, Object percent);
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
    'ar',
    'bn',
    'de',
    'en',
    'es',
    'fa',
    'fr',
    'ha',
    'id',
    'ms',
    'ru',
    'sw',
    'tr',
    'ur',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
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
    case 'fr':
      return AppLocalizationsFr();
    case 'ha':
      return AppLocalizationsHa();
    case 'id':
      return AppLocalizationsId();
    case 'ms':
      return AppLocalizationsMs();
    case 'ru':
      return AppLocalizationsRu();
    case 'sw':
      return AppLocalizationsSw();
    case 'tr':
      return AppLocalizationsTr();
    case 'ur':
      return AppLocalizationsUr();
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
