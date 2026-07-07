import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/storage/cache_service.dart';
import '../../domain/entities/khatmah_plan.dart';

/// يدير قائمة خطط الختمة (تحميل، إضافة، تحديث، حذف) مع التخزين المحلي.
class KhatmahNotifier extends Notifier<List<KhatmahPlan>> {
  @override
  List<KhatmahPlan> build() => _load();

  List<KhatmahPlan> _load() {
    return CacheService.getKhatmahPlans()
        .map((json) => KhatmahPlan.fromJson(json))
        .toList();
  }

  Future<void> _persist() async {
    await CacheService.saveKhatmahPlans(
      state.map((p) => p.toJson()).toList(),
    );
  }

  Future<void> addPlan(KhatmahPlan plan) async {
    state = [...state, plan];
    await _persist();
  }

  Future<void> updatePlan(KhatmahPlan updated) async {
    state = [
      for (final p in state) p.id == updated.id ? updated : p,
    ];
    await _persist();
  }

  Future<void> deletePlan(String id) async {
    state = state.where((p) => p.id != id).toList();
    await _persist();
  }

  /// يسجّل وصول المستخدم لصفحة معيّنة (يحدّث currentPage + dailyLog).
  Future<void> recordProgress(String planId, int reachedPage) async {
    final plan = state.firstWhere((p) => p.id == planId);
    final newLog = Map<String, int>.from(plan.dailyLog);
    newLog[KhatmahPlan.todayKey()] = reachedPage;
    final updated = plan.copyWith(
      currentPage:
          reachedPage > plan.currentPage ? reachedPage : plan.currentPage,
      dailyLog: newLog,
    );
    await updatePlan(updated);
  }
}

final khatmahProvider =
    NotifierProvider<KhatmahNotifier, List<KhatmahPlan>>(KhatmahNotifier.new);

final activeKhatmahsProvider = Provider<List<KhatmahPlan>>((ref) {
  return ref
      .watch(khatmahProvider)
      .where((p) => p.isActive && !p.isCompleted)
      .toList();
});
