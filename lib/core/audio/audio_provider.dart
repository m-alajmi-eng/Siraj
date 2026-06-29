import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
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
  AudioState build() {
    final service = ref.read(audioServiceProvider);

    // متابعة تشغيل/إيقاف
    final playSub = service.player.playingStream.listen((playing) {
      state = state.copyWith(isPlaying: playing);
    });

    // متابعة الآية الحالية عبر الفهرس + وسم MediaItem
    final idxSub = service.player.currentIndexStream.listen((index) {
      if (index == null) return;
      final seq = service.player.sequence;
      if (seq == null || index >= seq.length) return;
      final tag = seq[index].tag;
      final ayah = (tag is MediaItem) ? (tag.extras?['ayah'] as int?) : null;
      if (ayah != null && ayah > 0) {
        state = state.copyWith(currentAyahId: ayah);
      }
    });

    // عند انتهاء كامل السورة
    final stateSub = service.player.playerStateStream.listen((ps) {
      if (ps.processingState == ProcessingState.completed) {
        state = state.copyWith(isPlaying: false);
      }
    });

    ref.onDispose(() {
      playSub.cancel();
      idxSub.cancel();
      stateSub.cancel();
    });

    return const AudioState();
  }

  String _surahName = '';

  Future<void> playFromStart(int surahId, int totalAyahs, String reciter,
      {String surahName = ''}) async {
    final service = ref.read(audioServiceProvider);
    if (surahName.isNotEmpty) _surahName = surahName;
    state = AudioState(
      isPlaying: true,
      currentSurahId: surahId,
      currentAyahId: 1,
      totalAyahs: totalAyahs,
    );
    await service.playSurah(
      surahId: surahId,
      totalAyahs: totalAyahs,
      reciter: reciter,
      surahName: _surahName.isEmpty ? 'سورة' : _surahName,
    );
  }

  // تبديل القارئ مع المتابعة من الآية الحالية
  Future<void> changeReciter(String reciter) async {
    final surahId = state.currentSurahId;
    final total   = state.totalAyahs;
    final current = state.currentAyahId ?? 1;
    if (surahId == null) return;
    final service = ref.read(audioServiceProvider);
    state = state.copyWith(isPlaying: true, currentAyahId: current);
    await service.playSurah(
      surahId: surahId,
      totalAyahs: total,
      reciter: reciter,
      surahName: _surahName.isEmpty ? 'سورة' : _surahName,
      startAyah: current,
      withBasmala: false,
    );
  }

  Future<void> stopAudio() async {
    final service = ref.read(audioServiceProvider);
    await service.stop();
    state = const AudioState();
  }

  Future<void> pause() async {
    final service = ref.read(audioServiceProvider);
    await service.pause();
  }

  Future<void> resume() async {
    final service = ref.read(audioServiceProvider);
    await service.resume();
  }
}

final audioProvider = NotifierProvider<AudioNotifier, AudioState>(() {
  return AudioNotifier();
});
