import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// يدير قائمة الأقسام (من الوضع الكامل) التي عطّلها المستخدم يدوياً
/// عبر شاشة الإعدادات. منفصل عن AppMode: الوضع يحدد "ماذا يظهر
/// افتراضياً"، وهذا يحدد "ماذا عطّله المستخدم صراحة فوق ذلك".
///
/// معرّفات الأقسام تطابق أسماء دوال FeatureFlags بلا بادئة 'show'
/// وبأحرف صغيرة (مثال: showRadio -> 'radio').
class DisabledSectionsNotifier extends Notifier<Set<String>> {
  static const String _key = 'disabled_sections';

  @override
  Set<String> build() {
    final saved = Hive.box('settings').get(_key, defaultValue: <String>[]);
    return Set<String>.from(saved as List);
  }

  bool isDisabled(String sectionId) => state.contains(sectionId);

  void toggle(String sectionId) {
    final updated = Set<String>.from(state);
    if (updated.contains(sectionId)) {
      updated.remove(sectionId);
    } else {
      updated.add(sectionId);
    }
    state = updated;
    Hive.box('settings').put(_key, updated.toList());
  }
}

final disabledSectionsProvider =
    NotifierProvider<DisabledSectionsNotifier, Set<String>>(
        DisabledSectionsNotifier.new);
