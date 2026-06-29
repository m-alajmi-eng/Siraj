// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get appName => 'સિરાજ';

  @override
  String get prayer_title => 'નમાઝના સમય';

  @override
  String get prayer_nextPrayer => 'આગળની નમાઝ';

  @override
  String get prayer_fajr => 'ફજ્ર';

  @override
  String get prayer_sunrise => 'સૂર્યોદય';

  @override
  String get prayer_dhuhr => 'ઝુહ્ર';

  @override
  String get prayer_asr => 'અસ્ર';

  @override
  String get prayer_maghrib => 'મગ્રિબ';

  @override
  String get prayer_isha => 'ઇશા';

  @override
  String prayer_countdown(String time) {
    return '$time માં';
  }

  @override
  String get prayer_locationGPS => 'તમારું વર્તમાન સ્થાન';

  @override
  String get prayer_locationDefault => 'રિયાધ (ડિફૉલ્ટ)';

  @override
  String get quran_title => 'પવિત્ર કુરાન';

  @override
  String get quran_meccan => 'મક્કી';

  @override
  String get quran_medinan => 'મદની';

  @override
  String quran_ayahCount(int count) {
    return '$count આయતો';
  }

  @override
  String get quran_searchHint => 'કુરાનમાં શોધો...';

  @override
  String get quran_noResults => 'કોઈ પરિણામ નથી';

  @override
  String get quran_searchPrompt => 'શોધ માટે શબ્દ ટાઇપ કરો';

  @override
  String get quran_tapForTafsir => 'તફ્સીર માટે આયત પર લાંબો દબાવો';

  @override
  String quran_tafsirTitle(int number) {
    return '$numberમી આયતની તફ્સીર';
  }

  @override
  String get quran_tafsirSource => 'અલ-મુયસ્સર';

  @override
  String get quran_tafsirError => 'તફ્સીર લોડ કરી શકાયું નહીં';

  @override
  String get quran_reciter => 'કારી';

  @override
  String get quran_selectReciter => 'કારી પસંદ કરો';

  @override
  String get quran_searchReciter => 'કારી શોધો...';

  @override
  String get quran_playPrompt => 'સાંભળવા ટૅપ કરો';

  @override
  String quran_ayahNumber(int number) {
    return '$numberમી આયત';
  }

  @override
  String get athkar_title => 'ઝિક્ર';

  @override
  String get athkar_morning => 'સવારના ઝિક્ર';

  @override
  String get athkar_evening => 'સાંજના ઝિક્ર';

  @override
  String get athkar_sleep => 'ઊંઘના ઝિક્ર';

  @override
  String get athkar_wake => 'જાગવાના ઝિક્ર';

  @override
  String get athkar_prayer => 'નમાઝ પછી ઝિક્ર';

  @override
  String get athkar_general => 'સામાન્ય ઝિક્ર';

  @override
  String get athkar_tapToCount => 'ગણવા ટૅપ કરો';

  @override
  String get athkar_transitioning => 'ચાલુ છે...';

  @override
  String athkar_completed(String name) {
    return '$name પૂર્ણ';
  }

  @override
  String get athkar_next => 'આગળ';

  @override
  String get athkar_prev => 'પહેલા';

  @override
  String get athkar_finish => 'સમાપ્ત';

  @override
  String get athkar_back => 'પાછળ';

  @override
  String athkar_source(String source) {
    return '$source દ્વારા વર્ણવ્યું';
  }

  @override
  String get hadith_title => 'હદીસ';

  @override
  String get hadith_searchHint => 'હદીસ શોધો...';

  @override
  String get hadith_noResults => 'કોઈ પરિણામ નથી';

  @override
  String get hadith_tapForDetail => 'સંપૂર્ણ વાંચવા ટૅપ કરો';

  @override
  String get hadith_retryButton => 'ફરી પ્રયાસ';

  @override
  String get hadith_loadError => 'લોડ નિષ્ફળ';

  @override
  String get qibla_title => 'કિબ્લા દિશા';

  @override
  String get qibla_active => 'કંપાસ સક્રિય';

  @override
  String get qibla_error => 'કિબ્લા દિશા નક્કી કરી શકાઈ નહીં';

  @override
  String get qibla_errorHint => 'કંપાસ અને સ્થાન ચાલુ કરો';

  @override
  String get qibla_kaaba => 'કાબા';

  @override
  String get qibla_fromNorth => 'ઉત્તરથી કિબ્લા સુધી ડિગ્રી';

  @override
  String get stats_title => 'મારી આંકડાઓ';

  @override
  String get stats_prayerStreak => 'નમાઝ ક્રમ';

  @override
  String get stats_totalPrayers => 'કુલ નમાઝ';

  @override
  String get stats_quranPages => 'કુરાન પૃષ્ઠો';

  @override
  String get stats_athkarSessions => 'ઝિક્ર';

  @override
  String get stats_khatma => 'કુરાન ખતમ';

  @override
  String get stats_days => 'સળંગ દિવસ';

  @override
  String get stats_prayers => 'નમાઝ';

  @override
  String get stats_pages => 'પૃષ્ઠો';

  @override
  String get stats_sessions => 'સત્ર';

  @override
  String get stats_khatmaUnit => 'ખતમ';

  @override
  String get stats_currentKhatma => 'વર્તમાન ખતમ પ્રગતિ';

  @override
  String get more_title => 'વધુ';

  @override
  String get more_qibla => 'કિબ્લા દિશા';

  @override
  String get more_stats => 'મારી આંકડાઓ';

  @override
  String get common_loading => 'લોડ થઈ રહ્યું છે...';

  @override
  String get common_error => 'ડેટા લોડ કરવામાં ભૂલ';

  @override
  String get common_retry => 'ફરી પ્રયાસ';

  @override
  String get common_back => 'પાછળ';

  @override
  String get common_next => 'આગળ';

  @override
  String get common_save => 'સાચવો';

  @override
  String get common_cancel => 'રદ કરો';

  @override
  String get common_done => 'સંપૂર્ણ';

  @override
  String get common_search => 'શોધો';

  @override
  String get common_noData => 'કોઈ ડેટા નથી';

  @override
  String get common_offline => 'ઇન્ટરનેટ કનેક્શન નથી';

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
}
