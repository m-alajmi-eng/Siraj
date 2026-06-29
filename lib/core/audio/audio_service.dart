import 'package:audioplayers/audioplayers.dart';

class SirajAudioService {
  static final SirajAudioService _instance = SirajAudioService._internal();
  factory SirajAudioService() => _instance;
  SirajAudioService._internal() {
    _player.onPlayerComplete.listen((_) => _onComplete?.call());
  }

  // مشغّلان: الحالي + التالي (للتحميل المسبق وإلغاء الفجوة)
  final AudioPlayer _player = AudioPlayer();
  final AudioPlayer _preloader = AudioPlayer();

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  String? _preloadedUrl; // الرابط المحمّل مسبقاً

  void Function()? _onComplete;
  void onComplete(void Function() callback) => _onComplete = callback;

  static const String _baseUrl = 'https://everyayah.com/data';

  static const Map<String, String> reciters = {
    'مشاري راشد العفاسي':        'Alafasy_128kbps',
    'عبد الباسط (مرتّل)':        'Abdul_Basit_Murattal_192kbps',
    'عبد الباسط (مجوّد)':        'Abdul_Basit_Mujawwad_128kbps',
    'محمود خليل الحصري':         'Husary_128kbps',
    'محمد صديق المنشاوي':        'Minshawy_Murattal_128kbps',
    'محمد الطبلاوي':             'Mohammad_al_Tablaway_128kbps',
    'ماهر المعيقلي':             'Maher_AlMuaiqly_64kbps',
    'سعد الغامدي':               'Ghamadi_40kbps',
    'علي الحذيفي':               'Hudhaify_128kbps',
    'هاني الرفاعي':              'Hani_Rifai_192kbps',
    'سعود الشريم':               'Saood_ash-Shuraym_128kbps',
    'محمد جبريل':                'Muhammad_Jibreel_128kbps',
    'ياسر الدوسري':              'Yasser_Ad-Dussary_128kbps',
    'خالد عبدالله القحطاني':     'Khaalid_Abdullaah_al-Qahtaanee_192kbps',
    'ناصر القطامي':              'Nasser_Alqatami_128kbps',
    'أحمد نعينع':                'Ahmed_Neana_128kbps',
    'عبدالله بصفر':              'Abdullah_Basfar_192kbps',
    'صلاح البدير':               'Salah_Al_Budair_128kbps',
    'محمد عبدالكريم':            'Muhammad_AbdulKareem_128kbps',
    'علي حجاج السويسي':          'Ali_Hajjaj_AlSuesy_128kbps',
    'أكرم العلاقمي':             'Akram_AlAlaqimy_128kbps',
    'عبد الرحمن السديس':         'Abdurrahmaan_As-Sudais_192kbps',
    'محمد جبريل (64)':           'Muhammad_Jibreel_64kbps',
  };

  String _urlFor(int surahId, int ayahNumber, String reciter) {
    final surah = surahId.toString().padLeft(3, '0');
    final ayah  = ayahNumber.toString().padLeft(3, '0');
    return '$_baseUrl/$reciter/$surah$ayah.mp3';
  }

  Future<void> playAyah(int surahId, int ayahNumber,
      {String reciter = 'Alafasy_128kbps'}) async {
    final url = _urlFor(surahId, ayahNumber, reciter);
    await _player.stop();
    // تقليل الفجوة: وضع التوقف عند الانتهاء بدون تحرير الموارد
    await _player.setReleaseMode(ReleaseMode.stop);
    await _player.play(UrlSource(url));
    _isPlaying = true;
    _preloadedUrl = null;
  }

  // تحميل الآية التالية مسبقاً (تُستدعى أثناء قراءة الحالية)
  Future<void> preloadAyah(int surahId, int ayahNumber,
      {String reciter = 'Alafasy_128kbps'}) async {
    final url = _urlFor(surahId, ayahNumber, reciter);
    try {
      await _preloader.setSourceUrl(url);
      _preloadedUrl = url;
    } catch (_) {
      _preloadedUrl = null;
    }
  }

  Future<void> pause() async {
    await _player.pause();
    _isPlaying = false;
  }

  Future<void> resume() async {
    await _player.resume();
    _isPlaying = true;
  }

  Future<void> stop() async {
    await _player.stop();
    await _preloader.stop();
    _preloadedUrl = null;
    _isPlaying = false;
  }

  void dispose() {
    _player.dispose();
    _preloader.dispose();
  }
}
