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

  Future<void> playAyah(int surahId, int ayahNumber,
      {String reciter = 'ar.alafasy'}) async {
    final global = _globalAyahNumber(surahId, ayahNumber);
    final url =
        'https://cdn.islamic.network/quran/audio/128/$reciter/$global.mp3';
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

  int _globalAyahNumber(int surahId, int ayahNumber) {
    const ayahCounts = [
      0,7,286,200,176,120,165,206,75,129,109,123,111,43,52,99,128,111,
      110,98,135,112,78,118,64,77,227,93,88,69,60,34,30,73,54,45,83,
      54,53,92,68,60,52,55,78,96,45,26,47,60,52,82,32,54,84,54,31,
      20,45,33,30,35,25,17,26,30,25,25,27,20,25,25,20,20,28,22,40,
      39,29,27,26,25,23,22,24,24,22,26,29,27,26,25,24,22,23,22,23,
      21,21,23,20,22,22,21,22,21,22,22,21,20,20,20,18,26,14,17,19,
      18,15,19
    ];
    int global = 0;
    for (int i = 1; i < surahId; i++) {
      global += ayahCounts[i];
    }
    return global + ayahNumber;
  }
}