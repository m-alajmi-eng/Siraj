import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:audioplayers/audioplayers.dart';

// ─── نماذج البيانات ───────────────────────────────────────
class RadioStation {
  final String id;
  final String nameAr;
  final String nameEn;
  final String streamUrl;
  final String category; // quran_ar | quran_trans | tafseer | adhkar | international
  final String country;
  final String flag;

  const RadioStation({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.streamUrl,
    required this.category,
    required this.country,
    required this.flag,
  });
}

// ─── القائمة الشاملة والنهائية لمحطات الراديو (بث مباشر 24/7) ────────
const List<RadioStation> radioStations = [

  // ==========================================
  // 1. إذاعات القرآن الكريم (الدول العربية والقراء)
  // ==========================================
  RadioStation(id: 'egypt_quran', nameAr: 'إذاعة القرآن الكريم - القاهرة', nameEn: 'Cairo Quran Radio', streamUrl: 'http://stream.radiojar.com/8s5u5tpdtwzuv', category: 'quran_ar', country: 'مصر', flag: '🇪🇬'),
  RadioStation(id: 'makkah_quran', nameAr: 'إذاعة القرآن - مكة المكرمة', nameEn: 'Makkah Quran Radio', streamUrl: 'http://live.mp3quran.net:8006/', category: 'quran_ar', country: 'السعودية', flag: '🇸🇦'),
  RadioStation(id: 'madinah_quran', nameAr: 'إذاعة القرآن - المدينة المنورة', nameEn: 'Madinah Quran Radio', streamUrl: 'http://live.mp3quran.net:8002/', category: 'quran_ar', country: 'السعودية', flag: '🇸🇦'),
  RadioStation(id: 'quran_mix', nameAr: 'الإذاعة العامة - تنوع القراء', nameEn: 'Mix Quran Readers', streamUrl: 'http://qurango.net/radio/mix', category: 'quran_ar', country: 'عالمي', flag: '🕋'),
  RadioStation(id: 'abdulbasit', nameAr: 'عبدالباسط عبدالصمد', nameEn: 'Abdulbasit Abdulsamad', streamUrl: 'http://qurango.net/radio/abdulbasit_abdulsamad_mojawwad', category: 'quran_ar', country: 'مصر', flag: '🇪🇬'),
  RadioStation(id: 'minshawi', nameAr: 'محمد صديق المنشاوي', nameEn: 'Al-Minshawi', streamUrl: 'http://qurango.net/radio/mohammed_siddiq_alminshawi_mojawwad', category: 'quran_ar', country: 'مصر', flag: '🇪🇬'),
  RadioStation(id: 'sudais', nameAr: 'عبدالرحمن السديس', nameEn: 'Al-Sudais', streamUrl: 'http://qurango.net/radio/abdulrahman_alsudaes', category: 'quran_ar', country: 'السعودية', flag: '🇸🇦'),
  RadioStation(id: 'mishary', nameAr: 'مشاري العفاسي', nameEn: 'Mishary Alafasy', streamUrl: 'http://qurango.net/radio/mishary_alafasi', category: 'quran_ar', country: 'الكويت', flag: '🇰🇼'),

  // ==========================================
  // 2. التفسير، الفتاوى، والدروس العلمية
  // ==========================================
  RadioStation(id: 'tafseer', nameAr: 'إذاعة تفسير القرآن الكريم', nameEn: 'Quran Tafseer Radio', streamUrl: 'http://qurango.net/radio/tafseer', category: 'tafseer', country: 'عالمي', flag: '📚'),
  RadioStation(id: 'fatwa_uthaymeen', nameAr: 'فتاوى الشيخ ابن عثيمين', nameEn: 'Ibn Uthaymeen Fatwas', streamUrl: 'http://server03.quran.com.kw:7147/;*.mp3', category: 'tafseer', country: 'السعودية', flag: '🇸🇦'),
  RadioStation(id: 'fatwa_shaarawi', nameAr: 'خواطر الشيخ محمد متولي الشعراوي', nameEn: 'Shaarawi Thoughts', streamUrl: 'http://server03.quran.com.kw:7148/;*.mp3', category: 'tafseer', country: 'مصر', flag: '🇪🇬'),
  RadioStation(id: 'saadi_tafseer', nameAr: 'تفسير السعدي', nameEn: 'Al-Saadi Tafseer', streamUrl: 'http://qurango.net/radio/tafseer_alsaadi', category: 'tafseer', country: 'عالمي', flag: '📖'),

  // ==========================================
  // 3. الأذكار والرقية الشرعية
  // ==========================================
  RadioStation(id: 'adhkar_morning', nameAr: 'أذكار الصباح', nameEn: 'Morning Adhkar', streamUrl: 'http://qurango.net/radio/athkar_sabah', category: 'adhkar', country: 'عالمي', flag: '🌅'),
  RadioStation(id: 'adhkar_evening', nameAr: 'أذكار المساء', nameEn: 'Evening Adhkar', streamUrl: 'http://qurango.net/radio/athkar_masa', category: 'adhkar', country: 'عالمي', flag: '🌇'),
  RadioStation(id: 'roqyah', nameAr: 'الرقية الشرعية', nameEn: 'Roqyah Shariah', streamUrl: 'http://qurango.net/radio/roqiah', category: 'adhkar', country: 'عالمي', flag: '🛡️'),

  // ==========================================
  // 4. تراجم لغات العالم (أوروبا والأمريكيتين)
  // ==========================================
  RadioStation(id: 'tr_english', nameAr: 'ترجمة - إنجليزي', nameEn: 'English', streamUrl: 'http://qurango.net/radio/translation_quran_english_basit', category: 'quran_trans', country: 'عالمي', flag: '🇬🇧'),
  RadioStation(id: 'tr_french', nameAr: 'ترجمة - فرنسي', nameEn: 'French', streamUrl: 'http://qurango.net/radio/translation_quran_french', category: 'quran_trans', country: 'فرنسا/أفريقيا', flag: '🇫🇷'),
  RadioStation(id: 'tr_spanish', nameAr: 'ترجمة - إسباني', nameEn: 'Spanish', streamUrl: 'http://qurango.net/radio/translation_quran_spanish', category: 'quran_trans', country: 'أمريكا اللاتينية/إسبانيا', flag: '🇪🇸'),
  RadioStation(id: 'tr_portuguese', nameAr: 'ترجمة - برتغالي', nameEn: 'Portuguese', streamUrl: 'http://qurango.net/radio/translation_quran_portuguese', category: 'quran_trans', country: 'البرازيل/البرتغال', flag: '🇵🇹'),
  RadioStation(id: 'tr_italian', nameAr: 'ترجمة - إيطالي', nameEn: 'Italian', streamUrl: 'http://qurango.net/radio/translation_quran_italian', category: 'quran_trans', country: 'إيطاليا', flag: '🇮🇹'),
  RadioStation(id: 'tr_german', nameAr: 'ترجمة - ألماني', nameEn: 'German', streamUrl: 'http://qurango.net/radio/translation_quran_german', category: 'quran_trans', country: 'ألمانيا', flag: '🇩🇪'),
  RadioStation(id: 'tr_russian', nameAr: 'ترجمة - روسي', nameEn: 'Russian', streamUrl: 'http://qurango.net/radio/translation_quran_russian', category: 'quran_trans', country: 'روسيا', flag: '🇷🇺'),
  RadioStation(id: 'tr_bosnian', nameAr: 'ترجمة - بوسني', nameEn: 'Bosnian', streamUrl: 'http://qurango.net/radio/translation_quran_bosnia', category: 'quran_trans', country: 'البوسنة', flag: '🇧🇦'),
  RadioStation(id: 'tr_albanian', nameAr: 'ترجمة - ألباني', nameEn: 'Albanian', streamUrl: 'http://qurango.net/radio/translation_quran_albanian', category: 'quran_trans', country: 'ألبانيا', flag: '🇦🇱'),
  RadioStation(id: 'tr_greek', nameAr: 'ترجمة - يوناني', nameEn: 'Greek', streamUrl: 'http://qurango.net/radio/translation_quran_greek', category: 'quran_trans', country: 'اليونان', flag: '🇬🇷'),
  RadioStation(id: 'tr_romanian', nameAr: 'ترجمة - روماني', nameEn: 'Romanian', streamUrl: 'http://qurango.net/radio/translation_quran_romanian', category: 'quran_trans', country: 'رومانيا', flag: '🇷🇴'),

  // ==========================================
  // 5. تراجم لغات العالم (آسيا والشرق الأقصى)
  // ==========================================
  RadioStation(id: 'tr_chinese', nameAr: 'ترجمة - صيني', nameEn: 'Chinese', streamUrl: 'http://qurango.net/radio/translation_quran_chinese', category: 'quran_trans', country: 'الصين', flag: '🇨🇳'),
  RadioStation(id: 'tr_japanese', nameAr: 'ترجمة - ياباني', nameEn: 'Japanese', streamUrl: 'http://qurango.net/radio/translation_quran_japanese', category: 'quran_trans', country: 'اليابان', flag: '🇯🇵'),
  RadioStation(id: 'tr_korean', nameAr: 'ترجمة - كوري', nameEn: 'Korean', streamUrl: 'http://qurango.net/radio/translation_quran_korean', category: 'quran_trans', country: 'كوريا', flag: '🇰🇷'),
  RadioStation(id: 'tr_thai', nameAr: 'ترجمة - تايلندي', nameEn: 'Thai', streamUrl: 'http://qurango.net/radio/translation_quran_thai', category: 'quran_trans', country: 'تايلند', flag: '🇹🇭'),
  RadioStation(id: 'tr_tagalog', nameAr: 'ترجمة - فلبيني', nameEn: 'Tagalog', streamUrl: 'http://qurango.net/radio/translation_quran_tagalog', category: 'quran_trans', country: 'الفلبين', flag: '🇵🇭'),
  RadioStation(id: 'tr_vietnamese', nameAr: 'ترجمة - فيتنامي', nameEn: 'Vietnamese', streamUrl: 'http://qurango.net/radio/translation_quran_vietnamese', category: 'quran_trans', country: 'فيتنام', flag: '🇻🇳'),
  RadioStation(id: 'tr_indonesian', nameAr: 'ترجمة - إندونيسي', nameEn: 'Indonesian', streamUrl: 'http://qurango.net/radio/translation_quran_indonesia', category: 'quran_trans', country: 'إندونيسيا', flag: '🇮🇩'),
  RadioStation(id: 'tr_malay', nameAr: 'ترجمة - ملايو', nameEn: 'Malay', streamUrl: 'http://qurango.net/radio/translation_quran_malay', category: 'quran_trans', country: 'ماليزيا', flag: '🇲🇾'),
  RadioStation(id: 'tr_hindi', nameAr: 'ترجمة - هندي', nameEn: 'Hindi', streamUrl: 'http://qurango.net/radio/translation_quran_hindi', category: 'quran_trans', country: 'الهند', flag: '🇮🇳'),
  RadioStation(id: 'tr_urdu', nameAr: 'ترجمة - أوردو', nameEn: 'Urdu', streamUrl: 'http://qurango.net/radio/translation_quran_urdu_minsh', category: 'quran_trans', country: 'باكستان', flag: '🇵🇰'),
  RadioStation(id: 'tr_farsi', nameAr: 'ترجمة - فارسي', nameEn: 'Persian', streamUrl: 'http://qurango.net/radio/translation_quran_farsi', category: 'quran_trans', country: 'إيران', flag: '🇮🇷'),
  RadioStation(id: 'tr_kurdish', nameAr: 'ترجمة - كردي', nameEn: 'Kurdish', streamUrl: 'http://qurango.net/radio/translation_quran_kurdish', category: 'quran_trans', country: 'كردستان', flag: '☀️'),
  RadioStation(id: 'tr_turkish', nameAr: 'ترجمة - تركي', nameEn: 'Turkish', streamUrl: 'http://qurango.net/radio/translation_quran_turkish', category: 'quran_trans', country: 'تركيا', flag: '🇹🇷'),
  RadioStation(id: 'tr_bengali', nameAr: 'ترجمة - بنغالي', nameEn: 'Bengali', streamUrl: 'http://qurango.net/radio/translation_quran_bengali', category: 'quran_trans', country: 'بنغلاديش', flag: '🇧🇩'),

  // ==========================================
  // 6. تراجم لغات العالم (أفريقيا)
  // ==========================================
  RadioStation(id: 'tr_swahili', nameAr: 'ترجمة - سواحيلي', nameEn: 'Swahili', streamUrl: 'http://qurango.net/radio/translation_quran_swahili', category: 'quran_trans', country: 'شرق أفريقيا', flag: '🇰🇪'),
  RadioStation(id: 'tr_somali', nameAr: 'ترجمة - صومالي', nameEn: 'Somali', streamUrl: 'http://qurango.net/radio/translation_quran_somali', category: 'quran_trans', country: 'الصومال', flag: '🇸🇴'),
  RadioStation(id: 'tr_amharic', nameAr: 'ترجمة - أمهري', nameEn: 'Amharic', streamUrl: 'http://qurango.net/radio/translation_quran_amharic', category: 'quran_trans', country: 'إثيوبيا', flag: '🇪🇹'),
  RadioStation(id: 'tr_oromo', nameAr: 'ترجمة - أورومو', nameEn: 'Oromo', streamUrl: 'http://qurango.net/radio/translation_quran_oromo', category: 'quran_trans', country: 'إثيوبيا', flag: '🇪🇹'),

  // ==========================================
  // 7. إذاعات البرامج الإسلامية العامة 
  // ==========================================
  RadioStation(id: 'rodja_indo', nameAr: 'راديو رودجا (إندونيسيا - دروس)', nameEn: 'Radio Rodja', streamUrl: 'http://live.radiorodja.com:8000/;', category: 'international', country: 'إندونيسيا', flag: '🇮🇩'),
  RadioStation(id: 'islam_za', nameAr: 'راديو إسلام (جنوب أفريقيا)', nameEn: 'Radio Islam ZA', streamUrl: 'http://live.radioislam.org.za/islam', category: 'international', country: 'جنوب أفريقيا', flag: '🇿🇦'),
];

// ─── حالة الراديو ─────────────────────────────────────────
class RadioState {
  final RadioStation? currentStation;
  final bool          isPlaying;
  final bool          isLoading;
  final String?       error;

  const RadioState({
    this.currentStation,
    this.isPlaying  = false,
    this.isLoading  = false,
    this.error,
  });

  RadioState copyWith({
    RadioStation? currentStation,
    bool?         isPlaying,
    bool?         isLoading,
    String?       error,
  }) => RadioState(
    currentStation: currentStation ?? this.currentStation,
    isPlaying:      isPlaying      ?? this.isPlaying,
    isLoading:      isLoading      ?? this.isLoading,
    error:          error,
  );
}

// ─── Radio Notifier ───────────────────────────────────────
class RadioNotifier extends Notifier<RadioState> {
  late final AudioPlayer _player;

  @override
  RadioState build() {
    _player = AudioPlayer();
    
    // الاستماع لحالة المشغل لمعرفة متى يتوقف البث
    _player.onPlayerStateChanged.listen((playerState) {
      if (playerState == PlayerState.completed || playerState == PlayerState.stopped) {
        state = state.copyWith(isPlaying: false, isLoading: false);
      }
    });

    ref.onDispose(() => _player.dispose());
    return const RadioState();
  }

  Future<void> play(RadioStation station) async {
    if (state.currentStation?.id == station.id && state.isPlaying) {
      await pause();
      return;
    }

    state = state.copyWith(
      currentStation: station,
      isLoading:      true,
      isPlaying:      false,
      error:          null,
    );

    try {
      await _player.stop();
      await _player.play(UrlSource(station.streamUrl));
      state = state.copyWith(isLoading: false, isPlaying: true);
    } catch (e) {
      print('Exception during playback: $e');
      state = state.copyWith(
        isLoading: false,
        isPlaying: false,
        error:     'تعذّر تشغيل المحطة',
      );
    }
  }

  Future<void> pause() async {
    await _player.pause();
    state = state.copyWith(isPlaying: false);
  }
}

final radioProvider =
    NotifierProvider<RadioNotifier, RadioState>(() => RadioNotifier());

// ─── الفلترة ──────────────────────────────────────
final selectedCategoryProvider = NotifierProvider<_CategoryNotifier, String>(
  () => _CategoryNotifier());

class _CategoryNotifier extends Notifier<String> {
  @override
  String build() => 'all';
  void select(String cat) => state = cat;
}

final filteredStationsProvider = Provider<List<RadioStation>>((ref) {
  final cat = ref.watch(selectedCategoryProvider);
  if (cat == 'all') return radioStations;
  return radioStations.where((s) => s.category == cat).toList();
});