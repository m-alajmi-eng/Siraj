import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/audio/audio_providers.dart';
import '../../../../core/audio/audio_source_spec.dart';
import '../../../../core/audio/siraj_audio_controller.dart';
import '../../domain/entities/athkar_entity.dart';

class AthkarAudioState {
  final int? playingId;
  final bool isLoading;

  const AthkarAudioState({this.playingId, this.isLoading = false});

  AthkarAudioState copyWith({int? playingId, bool? isLoading}) =>
      AthkarAudioState(
        playingId: playingId ?? this.playingId,
        isLoading: isLoading ?? this.isLoading,
      );
}

/// يستهلك SirajAudioController المجرّد (نفس نمط RadioNotifier في
/// audio_providers.dart) - المشغّل مشترك مع القرآن/الراديو/الأذان
/// (حصرية مجّانية عبر setAudioSource)، فنتحقّق من ملكية أحداث nowPlaying
/// عبر مطابقة currentIndex بمعرّف الذكر (AthkarAudioSpec.id) قبل تحديث
/// الحالة، وإلا نعتبر تشغيل الأذكار متوقّفاً (شيء آخر أخذ المشغّل).
class AthkarAudioNotifier extends Notifier<AthkarAudioState> {
  int? _requestedId;

  @override
  AthkarAudioState build() {
    final controller = ref.read(audioControllerProvider);

    final sub = controller.nowPlaying.listen((np) {
      final isMine = _requestedId != null && np.currentIndex == _requestedId;
      if (!isMine) {
        if (state.playingId != null || state.isLoading) {
          state = state.copyWith(playingId: null, isLoading: false);
        }
        return;
      }
      state = AthkarAudioState(
        playingId: np.state == SirajPlaybackState.playing ? _requestedId : null,
        isLoading: np.state == SirajPlaybackState.loading,
      );
    });

    ref.onDispose(sub.cancel);
    return const AthkarAudioState();
  }

  Future<void> toggle(AthkarEntity athkar) async {
    if (athkar.audio.isEmpty) return;

    if (state.playingId == athkar.id) {
      await ref.read(audioControllerProvider).pause();
      state = state.copyWith(playingId: null);
      return;
    }

    _requestedId = athkar.id;
    state = state.copyWith(playingId: null, isLoading: true);

    try {
      // hisnmuslim.com يدعم HTTPS فعلياً رغم أن الرابط المخزَّن http:// -
      // نستخدم https حتى لا نحتاج استثناء cleartext جديداً في
      // network_security_config.xml (ADR-002: الاستثناءات محصورة عمداً).
      final secureUrl = athkar.audio.replaceFirst('http://', 'https://');
      await ref.read(audioControllerProvider).playAthkar(AthkarAudioSpec(
        id: athkar.id,
        url: secureUrl,
        title: athkar.arabic.length > 40
            ? '${athkar.arabic.substring(0, 40)}…'
            : athkar.arabic,
        subtitle: athkar.source,
      ));
    } catch (_) {
      state = state.copyWith(playingId: null, isLoading: false);
    }
  }
}

final athkarAudioProvider =
    NotifierProvider<AthkarAudioNotifier, AthkarAudioState>(
        () => AthkarAudioNotifier());
