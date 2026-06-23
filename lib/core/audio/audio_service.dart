import 'package:audioplayers/audioplayers.dart';

class SirajAudioService {
  static final SirajAudioService _instance = SirajAudioService._internal();
  factory SirajAudioService() => _instance;
  SirajAudioService._internal() {
    _player.onPlayerComplete.listen((_) {
      _onComplete?.call();
    });
  }

  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  void Function()? _onComplete;
  void onComplete(void Function() callback) {
    _onComplete = callback;
  }

  static const String _baseUrl = 'https://everyayah.com/data';

  // القراء المتحقق منهم ✅
  static const Map<String, String> reciters = {
    'مشاري راشد العفاسي':        'Alafasy_128kbps',
    'عبد الباسط (مرتّل)':        'Abdul_Basit_Murattal_192kbps',
    'عبد الباسط (مجوّد)':        'Abdul_Basit_Mujawwad_128kbps',
    'محمود خليل الحصري':         'Husary_128kbps',
    'محمد صديق المنشاوي':        'Minshawy_Murattal_128kbps',
    'محمد الطبلاوي':              'Mohammad_al_Tablaway_128kbps',
    'ماهر المعيقلي':              'Maher_AlMuaiqly_64kbps',
    'سعد الغامدي':                'Ghamadi_40kbps',
    'علي الحذيفي':                'Hudhaify_128kbps',
    'هاني الرفاعي':               'Hani_Rifai_192kbps',
    'سعود الشريم':                'Saood_ash-Shuraym_128kbps',
    'محمد جبريل':                 'Muhammad_Jibreel_128kbps',
    'ياسر الدوسري':               'Yasser_Ad-Dussary_128kbps',
    'خالد عبدالله القحطاني':      'Khaalid_Abdullaah_al-Qahtaanee_192kbps',
    'ناصر القطامي':               'Nasser_Alqatami_128kbps',
    'أحمد نعينع':                 'Ahmed_Neana_128kbps',
    'عبدالله بصفر':               'Abdullah_Basfar_192kbps',
    'صلاح البدير':                'Salah_Al_Budair_128kbps',
    'محمد عبدالكريم':             'Muhammad_AbdulKareem_128kbps',
    'علي حجاج السويسي':           'Ali_Hajjaj_AlSuesy_128kbps',
    'أكرم العلاقمي':              'Akram_AlAlaqimy_128kbps',
    'عبد الرحمن السديس':          'Abdurrahmaan_As-Sudais_192kbps',
    'محمد جبريل (64)':            'Muhammad_Jibreel_64kbps',
  };

  Future<void> playAyah(int surahId, int ayahNumber,
      {String reciter = 'Alafasy_128kbps'}) async {
    final surah = surahId.toString().padLeft(3, '0');
    final ayah  = ayahNumber.toString().padLeft(3, '0');
    final url   = '$_baseUrl/$reciter/$surah$ayah.mp3';

    await _player.stop();
    await _player.play(UrlSource(url));
    _isPlaying = true;
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
    _isPlaying = false;
  }

  void dispose() => _player.dispose();
} 