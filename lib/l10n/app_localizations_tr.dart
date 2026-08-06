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
  String get prayer_locationDefault => 'Mekke (varsayılan)';

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
  String get quran_toggleDisplayMode =>
      'Görüntüleme modunu değiştir (Mushaf/çeviri)';

  @override
  String get quran_toggleTajweed => 'Tecvid renklendirmesini değiştir';

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
  String hadith_readProgress(int read, int total) {
    return '$read/$total okundu';
  }

  @override
  String get qibla_title => 'Kıble Yönü';

  @override
  String get qibla_active => 'Pusula aktif';

  @override
  String get qibla_error => 'Kıble yönü belirlenemedi';

  @override
  String get qibla_errorHint => 'Pusulayı ve konumu etkinleştirin';

  @override
  String get qibla_staticMode => 'Sabit mod (pusula sensörü yok)';

  @override
  String get qibla_calibrationHint =>
      'Pusulayı kalibre etmek için cihazınızı sekiz çizecek şekilde hareket ettirin';

  @override
  String get qibla_kaaba => 'Kabe';

  @override
  String get qibla_fromNorth => 'Kuzeyden Kıbleye derece';

  @override
  String qibla_distanceKm(int km, String kaaba) {
    return '$kaaba\'ye $km km';
  }

  @override
  String get qibla_infoLocation => 'Konum';

  @override
  String get qibla_infoDirection => 'Yön';

  @override
  String get qibla_infoDistance => 'Mesafe';

  @override
  String get qibla_infoAccuracy => 'GPS Doğruluğu';

  @override
  String qibla_distanceValueKm(int km) {
    return '$km km';
  }

  @override
  String qibla_accuracyValueM(int m) {
    return '±$m m';
  }

  @override
  String get qibla_accuracyUnknown => 'Kullanılamıyor';

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
  String get library_title => 'Kapsamlı Kütüphane';

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
  String get common_close => 'Kapat';

  @override
  String get common_share => 'Paylaş';

  @override
  String get common_refresh => 'Yenile';

  @override
  String get common_prevPage => 'Önceki sayfa';

  @override
  String get common_nextPage => 'Sonraki sayfa';

  @override
  String get common_clearSearch => 'Aramayı temizle';

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
  String get time_hr => 'sa';

  @override
  String get time_min => 'dk';

  @override
  String get time_sec => 'sn';

  @override
  String get home_continueReading => 'OKUMAYA DEVAM ET';

  @override
  String home_surah(int id) {
    return 'Sure #$id';
  }

  @override
  String home_ayah(int number) {
    return 'Ayet $number';
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
  String get radio_title => 'Siraj Radyo';

  @override
  String get radio_all => 'Tümü';

  @override
  String get radio_quran => 'Kuran';

  @override
  String get radio_translations => 'Çeviriler';

  @override
  String get radio_tafsir => 'Tefsir ve Fetva';

  @override
  String get radio_athkar => 'Zikirler';

  @override
  String get radio_international => 'Uluslararası';

  @override
  String get radio_play => 'Oynat';

  @override
  String get radio_pause => 'Duraklat';

  @override
  String get cal_title => 'İslami Takvim';

  @override
  String get cal_todayEvents => 'Bugünün Olayları';

  @override
  String get cal_nextEvent => 'Sonraki Olay';

  @override
  String get cal_allEvents => 'İslami Günler';

  @override
  String cal_daysUntil(int days) {
    return '$days gün';
  }

  @override
  String get cal_gregorian => 'Miladi';

  @override
  String get cal_hijri => 'Hicri';

  @override
  String get cal_prevMonth => 'Önceki ay';

  @override
  String get cal_nextMonth => 'Sonraki ay';

  @override
  String get cal_legendEid => 'Bayram';

  @override
  String get cal_legendFast => 'Oruç';

  @override
  String get cal_legendBlessed => 'Mübarek';

  @override
  String get cal_hijriOffset => 'Hicri Düzeltme';

  @override
  String get cal_wd_sun => 'Paz';

  @override
  String get cal_wd_mon => 'Pzt';

  @override
  String get cal_wd_tue => 'Sal';

  @override
  String get cal_wd_wed => 'Çar';

  @override
  String get cal_wd_thu => 'Per';

  @override
  String get cal_wd_fri => 'Cum';

  @override
  String get cal_wd_sat => 'Cmt';

  @override
  String get cal_detailPending =>
      'Bu vesile için henüz ek ayrıntı (ayet/hadis/açıklama) mevcut değil - dini incelemeyi bekliyor.';

  @override
  String get hm_1 => 'Muharrem';

  @override
  String get hm_2 => 'Safer';

  @override
  String get hm_3 => 'Rebiülevvel';

  @override
  String get hm_4 => 'Rebiülahir';

  @override
  String get hm_5 => 'Cemaziyelevvel';

  @override
  String get hm_6 => 'Cemaziyelahir';

  @override
  String get hm_7 => 'Recep';

  @override
  String get hm_8 => 'Şaban';

  @override
  String get hm_9 => 'Ramazan';

  @override
  String get hm_10 => 'Şevval';

  @override
  String get hm_11 => 'Zilkade';

  @override
  String get hm_12 => 'Zilhicce';

  @override
  String get ev_new_year => 'Hicri Yılbaşı';

  @override
  String get ev_ashura => 'Aşure Günü';

  @override
  String get ev_mawlid => 'Mevlid Kandili';

  @override
  String get ev_isra => 'İsra ve Miraç';

  @override
  String get ev_ramadan_start => 'Ramazan Başlangıcı';

  @override
  String get ev_laylat_qadr => 'Kadir Gecesi';

  @override
  String get ev_eid_fitr => 'Ramazan Bayramı';

  @override
  String get ev_arafah => 'Arefe Günü';

  @override
  String get ev_eid_adha => 'Kurban Bayramı';

  @override
  String get ev_tashreeq => 'Teşrik Günleri';

  @override
  String get stories_title => 'Kıssalar ve Siyer';

  @override
  String get stories_prophets => 'Peygamberler';

  @override
  String get children_category_values => 'Değerler';

  @override
  String get children_category_quran => 'Kur\'an Kıssaları';

  @override
  String get stories_companions => 'Sahabeler';

  @override
  String get stories_tabieen => 'Tabiîn';

  @override
  String get stories_scholars => 'Âlimler';

  @override
  String get stories_comingSoon => 'Yakında';

  @override
  String get stories_comingSoonMsg => 'Yakında — içerik hazırlanıyor';

  @override
  String get stories_all => 'Tümü';

  @override
  String get stories_otherCompanions => 'Diğer Sahabeler';

  @override
  String get stories_fourImams => 'Dört İmam';

  @override
  String get stories_otherScholars => 'Diğer Âlimler';

  @override
  String get stories_sevenFuqaha => 'Yedi Fakih';

  @override
  String get stories_ahlBayt => 'Peygamber\'in Ehl-i Beytinden';

  @override
  String get stories_otherTabieen => 'Diğer Tabiîn';

  @override
  String get stories_zuhhad => 'Zahidler ve Abidler';

  @override
  String get stories_hanafiCompanions => 'İmam Ebu Hanife\'nin Ashabı';

  @override
  String get stories_sourceLabel => 'Kaynak';

  @override
  String get stories_sourceLinkLabel => 'Orijinal Metni Görüntüle';

  @override
  String get stories_searchHint => 'İsme göre ara...';

  @override
  String get stories_noResults => 'Sonuç bulunamadı';

  @override
  String get children_title => 'Çocuk Hikâyeleri';

  @override
  String get settings_secIdentity => 'Kimlik';

  @override
  String get onboarding_languageTitle => 'Dil Seçin';

  @override
  String get onboarding_languageSubtitle =>
      'Bunu daha sonra ayarlardan değiştirebilirsiniz';

  @override
  String get onboarding_modeTitle => 'Uygulama modunu seçin';

  @override
  String get onboarding_modeSubtitle =>
      'Bunu daha sonra ayarlardan değiştirebilirsiniz';

  @override
  String get onboarding_liteSubtitle =>
      'Temel özellikler · Hızlı · Tamamen çevrimdışı';

  @override
  String get onboarding_fullSubtitle =>
      'Tüm özellikler · Kapsamlı · Derinlemesine';

  @override
  String get onboarding_andMore => '+ daha fazla';

  @override
  String get onboarding_madhabTitle => 'Fıkıh Mezhebi';

  @override
  String get onboarding_madhabSubtitle =>
      'Namaz vakitlerini doğru hesaplamak için';

  @override
  String get onboarding_locationTitle => 'Konumunuzu belirleyin';

  @override
  String get onboarding_locationSubtitle => 'Doğru namaz vakitleri için';

  @override
  String get onboarding_locationBody =>
      'Uygulama, namaz vakitlerini otomatik\nbelirlemek için konum izni isteyecek';

  @override
  String get onboarding_locationPrivacy =>
      'Verileriniz yalnızca cihazınızda kalır';

  @override
  String get onboarding_start => 'Başla';

  @override
  String get settings_dirRtl => 'RTL';

  @override
  String get settings_dirLtr => 'LTR';

  @override
  String get settings_secAdhan => 'Ezan';

  @override
  String get settings_secApp => 'Uygulama';

  @override
  String get settings_secAppearance => 'Görünüm';

  @override
  String get settings_secAccessibility => 'Erişilebilirlik';

  @override
  String get settings_highContrast => 'Yüksek Kontrast';

  @override
  String get settings_reduceMotion => 'Hareketi Azalt';

  @override
  String get settings_secPrivacy => 'Gizlilik';

  @override
  String get settings_secAbout => 'Hakkında';

  @override
  String get settings_language => 'Dil';

  @override
  String get settings_chooseLanguage => 'Dil Seçin';

  @override
  String get settings_madhab => 'Mezhep';

  @override
  String get settings_chooseMadhab => 'Mezhep Seçin';

  @override
  String get settings_calcMethod => 'Namaz Vakti Hesaplama Yöntemi';

  @override
  String get settings_chooseCalc => 'Hesaplama Yöntemi';

  @override
  String get settings_enableAdhan => 'Ezanı Etkinleştir';

  @override
  String get settings_muezzinVoice => 'Müezzin Sesi';

  @override
  String get settings_previewAdhan => 'Ezan sesini önizle';

  @override
  String get settings_vibration => 'Ses yerine titreşim';

  @override
  String get settings_iqamaAlert => 'Kamet öncesi uyarı';

  @override
  String settings_minutes(int n) {
    return '$n dk';
  }

  @override
  String get settings_appMode => 'Uygulama Modu';

  @override
  String get settings_fullMode => 'Tam Mod';

  @override
  String get settings_liteMode => 'Hafif Mod';

  @override
  String get settings_fullModeDesc => 'Tüm özellikler mevcut';

  @override
  String get settings_liteModeDesc => 'Yalnızca temel — çevrimdışı';

  @override
  String get settings_quranFont => 'Kuran Yazı Tipi';

  @override
  String get settings_fontUthmani => 'Osmani';

  @override
  String get settings_fontHafs => 'Hafs';

  @override
  String get settings_fontQuran => 'Şehrazad';

  @override
  String get settings_quranFontSize => 'Kuran Yazı Boyutu';

  @override
  String get settings_privacyNote => 'Konumunuz yalnızca cihazınızda kalır';

  @override
  String get settings_clearCache => 'Önbellek Verilerini Temizle';

  @override
  String get settings_clearCacheTitle => 'Önbelleği Temizle';

  @override
  String get settings_clearCacheMsg =>
      'Yerel olarak kaydedilen veriler silinecek. Emin misiniz?';

  @override
  String get settings_cancel => 'İptal';

  @override
  String get settings_delete => 'Sil';

  @override
  String get settings_version => 'Sürüm';

  @override
  String get settings_shareApp => 'Uygulamayı Paylaş';

  @override
  String get settings_licenses => 'Lisanslar';

  @override
  String get settings_openSourcePackages => 'Açık Kaynak Paket Lisansları';

  @override
  String get settings_tagline => 'Siraj — Nur üstüne Nur';

  @override
  String get madhab_hanafi => 'Hanefi';

  @override
  String get madhab_maliki => 'Maliki';

  @override
  String get madhab_shafi => 'Şafii';

  @override
  String get madhab_hanbali => 'Hanbeli';

  @override
  String get calc_MWL => 'İslam Dünyası Birliği';

  @override
  String get calc_ISNA => 'Kuzey Amerika (ISNA)';

  @override
  String get calc_Egypt => 'Mısır Kurumu';

  @override
  String get calc_Makkah => 'Ümmülkura (Mekke)';

  @override
  String get calc_Kuwait => 'Kuveyt';

  @override
  String get calc_Qatar => 'Katar';

  @override
  String get calc_Dubai => 'Dubai';

  @override
  String get calc_Karachi => 'Karaçi';

  @override
  String get calc_Singapore => 'Singapur';

  @override
  String get calc_Turkey => 'Türkiye (Diyanet)';

  @override
  String get calc_MoonSighting => 'Ay Gözlem Komitesi';

  @override
  String get search_hint => 'Kuran ve tefsirde ara...';

  @override
  String get search_empty => 'Kuran-ı Kerim, tefsir ve kelime anlamlarında ara';

  @override
  String search_noResults(String query) {
    return '\"$query\" için sonuç yok';
  }

  @override
  String get search_typeAyah => 'Ayet';

  @override
  String get search_typeTafsir => 'Tefsir';

  @override
  String get search_typeWord => 'Kelime';

  @override
  String get search_typeHadith => 'Hadis';

  @override
  String get search_typeAthkar => 'Zikir';

  @override
  String get search_partialResults =>
      'Bazı kaynaklara ulaşılamadı — sonuçlar eksik olabilir';

  @override
  String get stats_daysStreak => 'art arda gün';

  @override
  String get stats_prayersUnit => 'namaz';

  @override
  String get stats_pagesUnit => 'sayfa';

  @override
  String get stats_athkar => 'Zikirler';

  @override
  String get stats_sessionsUnit => 'oturum';

  @override
  String stats_pagesOf(int read, int total) {
    return '$read / $total sayfa';
  }

  @override
  String get reader_tapToListen => 'Dinlemek için dokunun';

  @override
  String reader_ayahNum(int n) {
    return 'Ayet $n';
  }

  @override
  String get reader_reciter => 'Kari';

  @override
  String get reader_chooseReciter => 'Kari Seçin';

  @override
  String get reader_searchReciter => 'Kari ara...';

  @override
  String get reader_longPressHint =>
      'Herhangi bir ayete uzun basın — portal, tefsir ve paylaşım';

  @override
  String get reader_versePortal => 'Ayet Portalı';

  @override
  String get reader_portalSub => 'Tefsir · Kelimeler · Bağlam';

  @override
  String get reader_showTafsir => 'Tefsiri Göster';

  @override
  String get reader_shareAyah => 'Ayeti Paylaş';

  @override
  String get reader_copyAyah => 'Ayeti Kopyala';

  @override
  String get reader_ayahCopied => 'Ayet kopyalandı';

  @override
  String reader_tafsirOf(int n) {
    return '$n. Ayetin Tefsiri';
  }

  @override
  String get reader_muyassar => 'El-Müyesser';

  @override
  String get reader_tafsirError => 'Tefsir yüklenemedi';

  @override
  String get reader_shareTitle => 'Mübarek Ayet';

  @override
  String reader_shareSubtitle(String surah, int n) {
    return '$surah · Ayet $n';
  }

  @override
  String get portal_muyassar => 'El-Müyesser';

  @override
  String get portal_words => 'Kelime Analizi';

  @override
  String get portal_hadiths => 'Hadisler';

  @override
  String get portal_adwaaHadiths => 'Advaü\'l-Beyan';

  @override
  String get portal_stories => 'Kıssalar ve Siyer';

  @override
  String get portal_arabicTafsir => 'Arapça Tefsirler';

  @override
  String get portal_foreignTafsir => 'Diğer Dillerde Tefsirler';

  @override
  String get portal_asbab => 'Nüzul Sebebi';

  @override
  String get portal_searchLang => 'Dil ara...';

  @override
  String get portal_error => 'Portal açılamadı';

  @override
  String get portal_back => 'Geri';

  @override
  String get portal_noTafsir => 'Tefsir mevcut değil';

  @override
  String get portal_loadError => 'Yüklenemedi';

  @override
  String get portal_reportTranslation => 'Çeviri hatası bildir';

  @override
  String get portal_reportDialogTitle => 'Çeviri hatası bildir';

  @override
  String get portal_reportIssueLabel => 'Sorunu açıklayın';

  @override
  String get portal_reportIssueHint => 'örn. eksik kelime, hatalı anlam...';

  @override
  String get portal_reportNoteLabel => 'Ek not (isteğe bağlı)';

  @override
  String get portal_reportCancel => 'İptal';

  @override
  String get portal_reportSubmit => 'Gönder';

  @override
  String get portal_reportSuccess =>
      'Teşekkürler, bildiriminiz alındı ve incelenecek';

  @override
  String get portal_reportError =>
      'Bildirim gönderilemedi, daha sonra tekrar deneyin';

  @override
  String get portal_reportIssueRequired => 'Lütfen sorunu açıklayın';

  @override
  String get portal_translationPendingReview =>
      'Topluluk incelemesi bekleniyor';

  @override
  String get portal_comingSoon => 'Yakında';

  @override
  String get portal_noHadiths => 'Bu ayetle ilişkili henüz hadis yok';

  @override
  String get portal_addingContent => 'İçerik kademeli olarak ekleniyor';

  @override
  String get more_search => 'Birleşik Arama';

  @override
  String get more_settings => 'Ayarlar';

  @override
  String get more_calendar => 'İslami Takvim';

  @override
  String get more_shareCards => 'Paylaşım Kartları';

  @override
  String get more_fullMode => 'Tam Mod';

  @override
  String get more_radio => 'Kuran Radyo';

  @override
  String get more_mosques => 'Yakındaki Camiler';

  @override
  String get more_groupPrayerTools => 'Namaz Araçları';

  @override
  String get more_groupContent => 'İçerik';

  @override
  String get mosques_searching => 'Yakındaki camiler aranıyor...';

  @override
  String get mosques_unnamed => 'İsimsiz cami';

  @override
  String get mosques_notFound => 'Yakında cami bulunamadı';

  @override
  String get mosques_permissionDenied => 'Konum izni reddedildi';

  @override
  String get mosques_permissionDeniedHint =>
      'Yakındaki camileri görmek için cihaz ayarlarından konum izni verin';

  @override
  String get mosques_serviceDisabled => 'Konum hizmeti kapalı';

  @override
  String get mosques_serviceDisabledHint =>
      'Cihaz ayarlarından konum hizmetlerini (GPS) açın';

  @override
  String get mosques_networkError => 'Sunucuya bağlanılamadı';

  @override
  String get mosques_networkErrorHint =>
      'İnternet bağlantınızı kontrol edip tekrar deneyin';

  @override
  String get mosques_openSettings => 'Ayarları Aç';

  @override
  String get mosques_directions => 'Yol Tarifi';

  @override
  String get mosques_desktopOnly =>
      'Bu özellik yalnızca Android ve iOS\'ta çalışır';

  @override
  String get athkarcat_error => 'Hata';

  @override
  String get athkarcat_empty => 'Zikir yok';

  @override
  String athkarcat_completed(String name) {
    return '$name tamamlandı';
  }

  @override
  String get athkarcat_back => 'Geri';

  @override
  String get athkarcat_next => 'İleri';

  @override
  String get athkarcat_finish => 'Bitir';

  @override
  String get athkarcat_prev => 'Önceki';

  @override
  String athkarcat_repeat(int count, String source) {
    return 'Tekrar: $count · $source';
  }

  @override
  String athkarcat_narrated(String source) {
    return '$source rivayet etti';
  }

  @override
  String get athkarcat_moving => 'Geçiliyor...';

  @override
  String get athkarcat_tapCount => 'Saymak için dokunun';

  @override
  String get athkar_allSections => 'Tüm Bölümler';

  @override
  String get gateway_entry_title => 'İslam\'ı Keşfet';

  @override
  String get gateway_intro_title => 'Manevi Farkındalık Yolculuğu';

  @override
  String get gateway_journey_title => 'Yolculuk';

  @override
  String get gateway_principles_title => 'İslam\'ın İlkeleri';

  @override
  String get gateway_library_title => 'Kütüphane';

  @override
  String get gateway_begin => 'Yolculuğa Başla';

  @override
  String get gateway_next => 'İleri';

  @override
  String get gateway_prev => 'Geri';

  @override
  String get app_tagline => 'İslami Rehberin';

  @override
  String get app_brand_name => 'SIRAJ';

  @override
  String get gateway_shahada_cta => 'Şimdi İmanını İlan Et';

  @override
  String get nav_library => 'Kütüphane';

  @override
  String get library_could_not_load => 'Yüklenemedi';

  @override
  String get library_section_not_found => 'Bölüm bulunamadı';

  @override
  String get library_content_title => 'İçerik';

  @override
  String get library_search_in_category => 'Bu kategoride ara...';

  @override
  String get library_no_matching_results => 'Eşleşen sonuç yok';

  @override
  String get library_no_materials_lang => 'Bu dilde henüz içerik yok';

  @override
  String get library_connection_failed =>
      'Bağlantı başarısız. İnternetinizi kontrol edip tekrar deneyin';

  @override
  String get library_search_content_type => 'İçerik türü ara...';

  @override
  String get library_choose_content_type => 'İçerik türünü seçin';

  @override
  String get library_no_content_lang => 'Bu dilde henüz içerik yok';

  @override
  String get library_not_found => 'Bulunamadı';

  @override
  String get library_search_in_section => 'Bu bölümde ara...';

  @override
  String get library_no_categories => 'Henüz kategori yok';

  @override
  String library_subcategoryCount(int count) {
    return '$count klasör';
  }

  @override
  String get library_authorsSection => 'Yazarlar';

  @override
  String get library_type_books => 'Kitaplar';

  @override
  String get library_type_audios => 'Sesli İçerik';

  @override
  String get library_type_videos => 'Video';

  @override
  String get library_type_articles => 'Makaleler';

  @override
  String get adhan_makkah => 'Mekke (Mescid-i Haram)';

  @override
  String get adhan_madinah => 'Medine (Mescid-i Nebevi)';

  @override
  String get adhan_mustafa_ismail => 'Mustafa İsmail';

  @override
  String get adhan_iraqi => 'Irak';

  @override
  String get adhan_turkish => 'Türk';

  @override
  String get adhan_moroccan => 'Fas';

  @override
  String get adhan_indonesian => 'Endonezya';

  @override
  String get adhan_classic => 'Klasik';

  @override
  String prayer_notification_title(Object prayer) {
    return '$prayer vakti geldi';
  }

  @override
  String get prayer_notification_body => 'Allahu Ekber, haydi namaza';

  @override
  String get iqama_notification_title => 'Kamet Uyarısı';

  @override
  String iqama_notification_body(Object minutes, Object prayer) {
    return 'Kamete $minutes dakika — $prayer';
  }

  @override
  String get khatmah_title => 'Hatimler';

  @override
  String get khatmah_new => 'Yeni Hatim';

  @override
  String get khatmah_empty => 'Henüz hatim yok. İlkini başlatın!';

  @override
  String get khatmah_name => 'Hatim adı';

  @override
  String get khatmah_duration_days => 'Süre (gün)';

  @override
  String get khatmah_daily_pages => 'Günlük vird (sayfa)';

  @override
  String get khatmah_reminder_time => 'Hatırlatma zamanı';

  @override
  String get khatmah_create => 'Hatim oluştur';

  @override
  String get khatmah_preset_ramadan => 'Ramazan (30 gün)';

  @override
  String get khatmah_preset_weekly => 'Haftalık (7 gün)';

  @override
  String get khatmah_preset_monthly => 'Aylık (30 gün)';

  @override
  String get khatmah_status_ontrack => 'Yolunda';

  @override
  String get khatmah_status_behind => 'Geride';

  @override
  String get khatmah_status_ahead => 'İleride';

  @override
  String get khatmah_status_completed => 'Tamamlandı';

  @override
  String get khatmah_today_portion => 'Bugünkü vird';

  @override
  String get khatmah_read_now => 'Şimdi oku';

  @override
  String get khatmah_page => 'Sayfa';

  @override
  String khatmah_day_of(Object current, Object total) {
    return '$total günden $current. gün';
  }

  @override
  String get khatmah_delete_confirm => 'Bu hatim silinsin mi?';

  @override
  String get khatmah_progress => 'İlerleme';

  @override
  String khatmah_share_text(Object day, Object name, Object percent) {
    return '$name Hatmimin $day. gündeyim, %$percent tamamlandı. Allah bizi Kuran ehlinden eylesin 🤲';
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
