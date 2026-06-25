import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'audio_service.dart';

final audioServiceProvider = Provider<SirajAudioService>((ref) {
  final service = SirajAudioService();
  ref.onDispose(() => service.dispose());
  return service;
});

class SelectedReciterNotifier extends Notifier<String> {
  @override
  String build() => 'Alafasy_128kbps';
  void select(String reciter) => state = reciter;
}

final selectedReciterProvider =
    NotifierProvider<SelectedReciterNotifier, String>(() {
  return SelectedReciterNotifier();
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

  Future<void> playAyah(int surahId, int ayahId, {
    int totalAyahs = 0,
    String reciter = 'Alafasy_128kbps',
  }) async {
    final service = ref.read(audioServiceProvider);

    state = state.copyWith(
      isPlaying:      true,
      currentSurahId: surahId,
      currentAyahId:  ayahId,
      totalAyahs:     totalAyahs,
    );

    service.onComplete(() {
      final next = (state.currentAyahId ?? 0) + 1;
      if (next <= state.totalAyahs && state.isPlaying) {
        playAyah(
          surahId, next,
          totalAyahs: state.totalAyahs,
          reciter:    reciter,
        );
      } else {
        state = state.copyWith(isPlaying: false);
      }
    });

    await service.playAyah(surahId, ayahId, reciter: reciter);
  }

  Future<void> playFromStart(
      int surahId, int totalAyahs, String reciter) async {
    final service = ref.read(audioServiceProvider);
    await service.stop();
    state = const AudioState();

    // البسملة أولاً (عدا الفاتحة والتوبة)
    if (surahId != 1 && surahId != 9) {
      final completer = Completer<void>();
      service.onComplete(() => completer.complete());
      await service.playAyah(1, 1, reciter: reciter);
      await completer.future;
    }

    await playAyah(surahId, 1, totalAyahs: totalAyahs, reciter: reciter);
  }

  Future<void> stopAudio() async {
    final service = ref.read(audioServiceProvider);
    await service.stop();
    state = const AudioState();
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