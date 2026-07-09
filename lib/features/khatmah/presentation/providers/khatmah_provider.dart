import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/storage/cache_service.dart';
import '../../domain/entities/khatmah_plan.dart';
import '../../data/services/khatmah_reminder_service.dart';

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
    await _syncReminder(plan);
  }

  Future<void> updatePlan(KhatmahPlan updated) async {
    state = [
      for (final p in state) p.id == updated.id ? updated : p,
    ];
    await _persist();
    await _syncReminder(updated);
  }

  Future<void> deletePlan(String id) async {
    state = state.where((p) => p.id != id).toList();
    await _persist();
    await KhatmahReminderService.cancelForPlan(id);
  }

  /// يزامن تذكير الإشعار المحلي مع حالة الخطة الحالية (يُلغى تلقائياً
  /// إن كانت غير نشطة/مكتملة/بلا وقت تذكير - منطق ذلك داخل الخدمة).
  /// ملاحظة: النصوص ثابتة بالعربية مؤقتاً (Notifier لا يملك
  /// BuildContext) - تحسين مستقبلي: تمرير اللغة الحالية عند الاستدعاء.
  Future<void> _syncReminder(KhatmahPlan plan) async {
    await KhatmahReminderService.scheduleForPlan(
      plan,
      titlePrefix: 'وِردك اليوم من',
      bodyTemplate: 'حان وقت قراءة {pages} صفحة من ختمتك اليوم',
    );
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
