import 'dart:async';
import 'package:audio_session/audio_session.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '../audio_source_spec.dart';
import '../siraj_audio_controller.dart';

/// التنفيذ الوحيد الذي يعرف just_audio في كل المشروع — معزول تماماً خلف
/// [SirajAudioController]. مشغّل واحد مشترك بين القرآن/الراديو/معاينة
/// الأذان يمنح "الحصرية" مجّاناً (ADR PHASE E6): استدعاء أي `play*` جديد
/// يستبدل مصدر التشغيل الحالي عبر `setAudioSource` فيوقف ما قبله تلقائياً،
/// بلا أي منطق "أوقف الآخر" يدوي منفصل.
class JustAudioController implements SirajAudioController {
  final AudioPlayer _player = AudioPlayer();
  final _nowPlayingController =
      StreamController<SirajNowPlaying>.broadcast();
  final _stateController = StreamController<SirajPlaybackState>.broadcast();

  StreamSubscription<PlayerState>? _playerStateSub;
  StreamSubscription<int?>? _indexSub;
  bool _sessionConfigured = false;

  JustAudioController() {
    _configureSession();

    _playerStateSub = _player.playerStateStream.listen((_) {
      _stateController.add(_mapState());
      _emitNowPlaying();
    });
    _indexSub = _player.currentIndexStream.listen((_) {
      _emitNowPlaying();
    });
  }

  /// معالجة المقاطعات (مكالمة واردة، تطبيق آخر يطلب تركيز الصوت، نزع
  /// السماعة) — حزمة audio_session كانت معلَنة في pubspec وغير مستخدمة
  /// في أي ملف (PHASE E5).
  Future<void> _configureSession() async {
    if (_sessionConfigured) return;
    _sessionConfigured = true;
    try {
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.music());

      session.interruptionEventStream.listen((event) {
        if (event.begin) {
          // مكالمة واردة أو تطبيق آخر يطلب الصوت — إيقاف مؤقت آمن دائماً
          // (بدل الخفض/duck الذي لا يناسب تلاوة/أذان يُراد سماعه كاملاً).
          _player.pause();
        }
      });

      session.becomingNoisyEventStream.listen((_) {
        // نزع السماعة/فصل بلوتوث — إيقاف مؤقت بدل الاستمرار عبر السماعة
        // الخارجية للجهاز فجأة (سلوك النظام القياسي لتطبيقات الوسائط).
        _player.pause();
      });
    } catch (_) {
      // منصة سطح مكتب/ويب بلا دعم كامل لـaudio_session — الصوت يعمل
      // بلا معالجة مقاطعات (قيد منصة موثَّق، لا عطل).
    }
  }

  SirajPlaybackState _mapState() {
    final ps = _player.playerState;
    switch (ps.processingState) {
      case ProcessingState.idle:
        return SirajPlaybackState.idle;
      case ProcessingState.loading:
      case ProcessingState.buffering:
        return SirajPlaybackState.loading;
      case ProcessingState.completed:
        return SirajPlaybackState.completed;
      case ProcessingState.ready:
        return ps.playing
            ? SirajPlaybackState.playing
            : SirajPlaybackState.paused;
    }
  }

  void _emitNowPlaying() {
    final tag = _player.sequenceState.currentSource?.tag;
    if (tag is! MediaItem) return;
    final ayah = tag.extras?['ayah'] as int?;
    _nowPlayingController.add(SirajNowPlaying(
      title: tag.title,
      subtitle: tag.artist ?? '',
      currentIndex: ayah ?? _player.currentIndex,
      state: _mapState(),
    ));
  }

  @override
  Stream<SirajNowPlaying> get nowPlaying => _nowPlayingController.stream;

  @override
  Stream<SirajPlaybackState> get state => _stateController.stream;

  static const String _everyAyahBaseUrl = 'https://everyayah.com/data';

  AudioSource _quranAyahSource(
    int surahId,
    int ayah,
    String reciter,
    String surahName,
    String label,
    int tagAyah,
  ) {
    final s = surahId.toString().padLeft(3, '0');
    final a = ayah.toString().padLeft(3, '0');
    final url = '$_everyAyahBaseUrl/$reciter/$s$a.mp3';
    return AudioSource.uri(
      Uri.parse(url),
      tag: MediaItem(
        id: '${surahId}_${ayah}_$reciter',
        title: surahName,
        artist: label,
        extras: {'ayah': tagAyah},
      ),
    );
  }

  @override
  Future<void> playQuran(QuranAudioSpec spec) async {
    final children = <AudioSource>[];

    if (spec.withBasmala &&
        spec.surahId != 1 &&
        spec.surahId != 9 &&
        spec.startAyah == 1) {
      children.add(_quranAyahSource(1, 1, spec.reciter, spec.surahName, 'بسملة', 0));
    }

    for (var a = spec.startAyah; a <= spec.totalAyahs; a++) {
      children.add(_quranAyahSource(
          spec.surahId, a, spec.reciter, spec.surahName, 'آية $a', a));
    }

    // setAudioSources (لا ConcatenatingAudioSource المهجورة) - البديل
    // الموصى به رسمياً بتوثيق just_audio 0.10.6 نفسه ("Use
    // AudioPlayer.setAudioSources instead"). يبني نفس قائمة التشغيل
    // المتصلة داخلياً (`_playlist._init(audioSources, ...)`) فسلوك
    // التلاوة المتصلة بلا فجوات بين الآيات مطابق تماماً - فقط عبر
    // واجهة عامة غير مهجورة.
    await _player.setAudioSources(children);
    await _player.play();
  }

  @override
  Future<void> playRadio(RadioAudioSpec spec) async {
    final source = AudioSource.uri(
      Uri.parse(spec.streamUrl),
      tag: MediaItem(
        id: 'radio_${spec.stationId}',
        title: spec.title,
        artist: spec.subtitle,
      ),
    );
    await _player.setAudioSource(source);
    await _player.play();
  }

  @override
  Future<void> playAthkar(AthkarAudioSpec spec) async {
    final source = AudioSource.uri(
      Uri.parse(spec.url),
      tag: MediaItem(
        id: 'athkar_${spec.id}',
        title: spec.title,
        artist: spec.subtitle,
        extras: {'ayah': spec.id},
      ),
    );
    await _player.setAudioSource(source);
    await _player.play();
  }

  @override
  Future<void> previewAdhan(AssetAudioSpec spec) async {
    final source = AudioSource.asset(
      spec.assetPath,
      tag: MediaItem(id: 'adhan_preview_${spec.assetPath}', title: spec.title),
    );
    await _player.setAudioSource(source);
    await _player.play();
  }

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> resume() => _player.play();

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> seekToIndex(int index) =>
      _player.seek(Duration.zero, index: index);

  @override
  void dispose() {
    _playerStateSub?.cancel();
    _indexSub?.cancel();
    _nowPlayingController.close();
    _stateController.close();
    _player.dispose();
  }
}
