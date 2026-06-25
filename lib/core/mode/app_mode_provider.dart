import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'app_mode.dart';

class AppModeNotifier extends Notifier<AppMode> {
  static const String _key = 'app_mode';

  @override
  AppMode build() {
    final saved = Hive.box('settings').get(_key, defaultValue: 'lite');
    return saved == 'full' ? AppMode.full : AppMode.lite;
  }

  void setMode(AppMode mode) {
    Hive.box('settings').put(_key, mode.name);
    state = mode;
  }

  void toggle() {
    setMode(state == AppMode.lite ? AppMode.full : AppMode.lite);
  }
}

final appModeProvider = NotifierProvider<AppModeNotifier, AppMode>(() {
  return AppModeNotifier();
});