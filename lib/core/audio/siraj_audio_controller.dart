import 'audio_source_spec.dart';

/// الواجهة المجرّدة (العقد) — لا استيراد لـ just_audio هنا إطلاقاً.
/// كل ميزة صوتية (قرآن، راديو، أذان) تعتمد على هذا العقد فقط عبر
/// [audioControllerProvider في audio_providers.dart]، فاستبدال المحرّك
/// مستقبلاً = تغيير `impl/just_audio_controller.dart` وحده (ADR-001).
enum SirajPlaybackState { idle, loading, playing, paused, completed, error }

class SirajNowPlaying {
  final String title;
  final String subtitle;
  final int? currentIndex; // للآيات
  final SirajPlaybackState state;

  const SirajNowPlaying({
    required this.title,
    required this.subtitle,
    this.currentIndex,
    required this.state,
  });
}

abstract interface class SirajAudioController {
  Stream<SirajNowPlaying> get nowPlaying;
  Stream<SirajPlaybackState> get state;

  Future<void> playQuran(QuranAudioSpec spec);
  Future<void> playRadio(RadioAudioSpec spec);
  Future<void> previewAdhan(AssetAudioSpec spec);
  Future<void> pause();
  Future<void> resume();
  Future<void> stop();
  Future<void> seekToIndex(int index);
  void dispose();
}
