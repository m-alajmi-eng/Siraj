import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class SirajAudioService {
  static final SirajAudioService _instance = SirajAudioService._internal();
  factory SirajAudioService() => _instance;
  SirajAudioService._internal();

  final AudioPlayer _player = AudioPlayer();
  AudioPlayer get player => _player;

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

  String _url(int surahId, int ayah, String reciter) {
    final s = surahId.toString().padLeft(3, '0');
    final a = ayah.toString().padLeft(3, '0');
    return '$_baseUrl/$reciter/$s$a.mp3';
  }

  // بناء قائمة تشغيل لكامل السورة (تلاوة متصلة بلا فجوات)
  Future<void> playSurah({
    required int surahId,
    required int totalAyahs,
    required String reciter,
    required String surahName,
    int startAyah = 1,
    bool withBasmala = true,
  }) async {
    final children = <AudioSource>[];

    // البسملة كأول مقطع (عدا الفاتحة والتوبة)
    if (withBasmala && surahId != 1 && surahId != 9 && startAyah == 1) {
      children.add(_ayahSource(1, 1, reciter, surahName, 'بسملة', 0));
    }

    for (int a = startAyah; a <= totalAyahs; a++) {
      children.add(_ayahSource(surahId, a, reciter, surahName, 'آية $a', a));
    }

    final playlist = ConcatenatingAudioSource(children: children);
    await _player.setAudioSource(playlist);
    await _player.play();
  }

  AudioSource _ayahSource(
      int surahId, int ayah, String reciter, String surahName, String label, int tagAyah) {
    return AudioSource.uri(
      Uri.parse(_url(surahId, ayah, reciter)),
      tag: MediaItem(
        id: '${surahId}_${ayah}_$reciter',
        title: surahName,
        artist: label,
        // نخزّن رقم الآية في extras لتتبّع الآية الحالية
        extras: {'ayah': tagAyah},
      ),
    );
  }

  Future<void> pause() => _player.pause();
  Future<void> resume() => _player.play();
  Future<void> stop() => _player.stop();
  Future<void> seekToIndex(int index) => _player.seek(Duration.zero, index: index);

  void dispose() => _player.dispose();
}
