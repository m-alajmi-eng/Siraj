import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'audio_service.dart';

final audioServiceProvider = Provider<SirajAudioService>((ref) {
  final service = SirajAudioService();
  ref.onDispose(() => service.dispose());
  return service;
});

class AudioState {
  final bool isPlaying;
  final int? currentSurahId;
  final int? currentAyahId;
  final int totalAyahs;

  const AudioState({
    this.isPlaying = false,
    this.currentSurahId,
    this.currentAyahId,
    this.totalAyahs = 0,
  });

  AudioState copyWith({
    bool? isPlaying,
    int? currentSurahId,
    int? currentAyahId,
    int? totalAyahs,
  }) {
    return AudioState(
      isPlaying:      isPlaying      ?? this.isPlaying,
      currentSurahId: currentSurahId ?? this.currentSurahId,
      currentAyahId:  currentAyahId  ?? this.currentAyahId,
      totalAyahs:     totalAyahs     ?? this.totalAyahs,
    );
  }
}

class AudioNotifier extends Notifier<AudioState> {
  @override
  AudioState build() => const AudioState();

  Future<void> playAyah(int surahId, int ayahId, {int totalAyahs = 0}) async {
    final service = ref.read(audioServiceProvider);
    
    state = state.copyWith(
      isPlaying:      true,
      currentSurahId: surahId,
      currentAyahId:  ayahId,
      totalAyahs:     totalAyahs,
    );

    await service.playAyah(surahId, ayahId);

    // انتظر انتهاء الآية ثم انتقل للتالية
    service.onComplete(() async {
      final next = (state.currentAyahId ?? 0) + 1;
      if (next <= state.totalAyahs && state.isPlaying) {
        await playAyah(surahId, next, totalAyahs: state.totalAyahs);
      } else {
        state = state.copyWith(isPlaying: false);
      }
    });
  }

  Future<void> pause() async {
    final service = ref.read(audioServiceProvider);
    await service.pause();
    state = state.copyWith(isPlaying: false);
  }

  Future<void> resume() async {
    final service = ref.read(audioServiceProvider);
    await service.resume();
    state = state.copyWith(isPlaying: true);
  }
}

final audioProvider = NotifierProvider<AudioNotifier, AudioState>(() {
  return AudioNotifier();
});