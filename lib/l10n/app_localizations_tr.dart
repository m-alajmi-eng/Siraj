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
  String get stories_companions => 'Sahabeler';

  @override
  String get stories_scholars => 'Âlimler';

  @override
  String get stories_comingSoon => 'Yakında';

  @override
  String get stories_comingSoonMsg => 'Yakında — içerik hazırlanıyor';

  @override
  String get children_title => 'Çocuk Hikâyeleri';

  @override
  String get settings_secIdentity => 'Kimlik';

  @override
  String get settings_secAdhan => 'Ezan';

  @override
  String get settings_secApp => 'Uygulama';

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
}
