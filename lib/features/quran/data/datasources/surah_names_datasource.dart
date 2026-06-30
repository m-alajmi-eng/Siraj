import 'dart:convert';
import 'package:flutter/services.dart';

/// أسماء السور المترجمة — تُقرأ مرة وتُخزّن في الذاكرة
class SurahNamesDataSource {
  static Map<String, dynamic>? _data;

  static Future<void> _load() async {
    if (_data != null) return;
    final json = await rootBundle.loadString('assets/data/surah_names.json');
    _data = jsonDecode(json) as Map<String, dynamic>;
  }

  /// الاسم العربي للسورة (ثابت دائماً)
  static Future<String> arabicName(int surahId) async {
    await _load();
    return _data?['$surahId']?['ar'] as String? ?? '';
  }

  /// اسم السورة بلغة المستخدم — مترجم إن توفّر، وإلا النقحرة اللاتينية
  static Future<String> localizedName(int surahId, String lang) async {
    await _load();
    final entry = _data?['$surahId'];
    if (entry == null) return '';
    if (lang == 'ar') return entry['ar'] as String? ?? '';
    final names = entry['names'] as Map<String, dynamic>?;
    final translated = names?[lang] as String?;
    return translated ?? (entry['translit'] as String? ?? '');
  }

  /// نسخة متزامنة بعد التحميل (للاستخدام في build بعد ضمان التحميل)
  static String localizedNameSync(int surahId, String lang) {
    final entry = _data?['$surahId'];
    if (entry == null) return '';
    if (lang == 'ar') return entry['ar'] as String? ?? '';
    final names = entry['names'] as Map<String, dynamic>?;
    final translated = names?[lang] as String?;
    return translated ?? (entry['translit'] as String? ?? '');
  }

  static String arabicNameSync(int surahId) {
    return _data?['$surahId']?['ar'] as String? ?? '';
  }

  static Future<void> ensureLoaded() => _load();
}
