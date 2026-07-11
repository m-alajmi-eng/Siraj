import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'feature_flags.dart';

/// يدير قائمة الأقسام التي فعّلها المستخدم صراحة في الوضع الخفيف
/// (يبني قائمته الخاصة من كل الأقسام، بلا نواة مفروضة). في الوضع
/// الكامل هذا المزوّد غير مستخدَم إطلاقاً (كل شيء مفعَّل تلقائياً).
class EnabledSectionsNotifier extends Notifier<Set<String>> {
  static const String _key = 'enabled_sections_lite';

  @override
  Set<String> build() {
    final saved = Hive.box('settings').get(_key, defaultValue: <String>[]);
    return Set<String>.from(saved as List);
  }

  void toggle(String sectionId) {
    final base = state.isEmpty
        ? Set<String>.from(FeatureFlags.defaultLiteSections)
        : Set<String>.from(state);
    if (base.contains(sectionId)) {
      base.remove(sectionId);
    } else {
      base.add(sectionId);
    }
    state = base;
    Hive.box('settings').put(_key, base.toList());
  }
}

final enabledSectionsProvider =
    NotifierProvider<EnabledSectionsNotifier, Set<String>>(
        EnabledSectionsNotifier.new);
