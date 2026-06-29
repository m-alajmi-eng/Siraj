import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

class LocaleNotifier extends Notifier<Locale> {
  @override
  Locale build() {
    try {
      final box  = Hive.box('settings');
      final code = box.get('locale', defaultValue: 'ar') as String;
      return Locale(code);
    } catch (_) {
      return const Locale('ar');
    }
  }

  void setLocale(String code) {
    try {
      Hive.box('settings').put('locale', code);
    } catch (_) {}
    state = Locale(code);
  }
}

final localeProvider =
    NotifierProvider<LocaleNotifier, Locale>(LocaleNotifier.new);
