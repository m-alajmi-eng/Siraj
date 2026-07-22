import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'impl/just_audio_controller.dart';
import 'siraj_audio_controller.dart';

/// المصدر الوحيد في كل المشروع الذي يعرف أن التنفيذ الفعلي هو
/// JustAudioController — كل الميزات تستهلك النوع المجرّد
/// [SirajAudioController] فقط عبر هذا الـprovider (ADR-001).
final audioControllerProvider = Provider<SirajAudioController>((ref) {
  final controller = JustAudioController();
  ref.onDispose(controller.dispose);
  return controller;
});
