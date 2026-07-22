import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'audio_providers.dart';
import 'audio_source_spec.dart';
import 'siraj_audio_controller.dart';

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

/// حالة تشغيل القرآن للواجهة — تُترجم من [SirajAudioController] المجرّد
/// (لا تعرف just_audio) إلى شكل [AudioState] الذي تتوقّعه شاشة القارئ.
///
/// المشغّل مشترك بين القرآن/الراديو/معاينة الأذان (PHASE E6 — حصرية
/// مجّانية). لذا `nowPlaying` قد يصل من محتوى ليس قرآناً إطلاقاً (مثلاً
/// المستخدم شغّل الراديو بينما كانت السورة تُقرأ) — نتحقّق من ملكية الحدث
/// عبر مطابقة العنوان (اسم السورة) قبل تحديث isPlaying، وإلا نعتبر القرآن
/// متوقّفاً فعلياً (صحيح دلالياً: شيء آخر أخذ المشغّل الوحيد).
class AudioNotifier extends Notifier<AudioState> {
  String _surahName = '';

  @override
  AudioState build() {
    final controller = ref.read(audioControllerProvider);

    final nowPlayingSub = controller.nowPlaying.listen((np) {
      final isMine = _surahName.isNotEmpty && np.title == _surahName;
      if (!isMine) {
        if (state.isPlaying) state = state.copyWith(isPlaying: false);
        return;
      }

      if (np.currentIndex != null && np.currentIndex! > 0) {
        state = state.copyWith(currentAyahId: np.currentIndex);
      }
      state = state.copyWith(isPlaying: np.state == SirajPlaybackState.playing);
    });

    ref.onDispose(nowPlayingSub.cancel);

    return const AudioState();
  }

  Future<void> playFromStart(int surahId, int totalAyahs, String reciter,
      {String surahName = ''}) async {
    final controller = ref.read(audioControllerProvider);
    _surahName = surahName.isNotEmpty ? surahName : 'سورة';
    state = AudioState(
      isPlaying: true,
      currentSurahId: surahId,
      currentAyahId: 1,
      totalAyahs: totalAyahs,
    );
    await controller.playQuran(QuranAudioSpec(
      surahId: surahId,
      totalAyahs: totalAyahs,
      reciter: reciter,
      surahName: _surahName,
    ));
  }

  // تبديل القارئ مع المتابعة من الآية الحالية
  Future<void> changeReciter(String reciter) async {
    final surahId = state.currentSurahId;
    final total   = state.totalAyahs;
    final current = state.currentAyahId ?? 1;
    if (surahId == null) return;
    final controller = ref.read(audioControllerProvider);
    state = state.copyWith(isPlaying: true, currentAyahId: current);
    await controller.playQuran(QuranAudioSpec(
      surahId: surahId,
      totalAyahs: total,
      reciter: reciter,
      surahName: _surahName.isEmpty ? 'سورة' : _surahName,
      startAyah: current,
      withBasmala: false,
    ));
  }

  Future<void> stopAudio() async {
    final controller = ref.read(audioControllerProvider);
    await controller.stop();
    state = const AudioState();
  }

  Future<void> pause() async {
    await ref.read(audioControllerProvider).pause();
  }

  Future<void> resume() async {
    await ref.read(audioControllerProvider).resume();
  }
}

final audioProvider = NotifierProvider<AudioNotifier, AudioState>(() {
  return AudioNotifier();
});
