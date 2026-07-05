import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/tajweed_entity.dart';

/// مصدر بيانات التجويد المحلي — يقرأ assets/data/quran_tajweed.json
/// (114 سورة، مُولَّد مسبقاً ومُتحقَّق منه، لا استدعاء شبكي وقت التشغيل).
class TajweedLocalDataSource {
  static Map<String, dynamic>? _cache;
  static Map<String, Color>? _ruleColors;

  Future<void> _load() async {
    if (_cache != null) return;
    final raw = await rootBundle.loadString('assets/data/quran_tajweed.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;
    _cache = data['surahs'] as Map<String, dynamic>;

    final colorsRaw = (data['_meta']?['rule_colors'] as Map?) ?? {};
    _ruleColors = colorsRaw.map(
      (key, value) => MapEntry(key.toString(), _parseHexColor(value.toString())),
    );
  }

  Color _parseHexColor(String hex) {
    final cleaned = hex.replaceFirst('#', '');
    return Color(int.parse('FF$cleaned', radix: 16));
  }

  /// يرجع كل آيات سورة معيّنة بصيغة التجويد. يرجع قائمة فارغة إن لم تتوفر.
  Future<List<TajweedAyah>> getSurahTajweed(int surahId) async {
    await _load();
    final surahData = _cache![surahId.toString()] as List?;
    if (surahData == null) return [];
    return surahData
        .whereType<Map>()
        .map((e) => TajweedAyah.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  /// لون قاعدة تجويد معيّنة برمزها. يرجع أسود افتراضياً إن لم توجد.
  Future<Color> colorFor(String rule) async {
    await _load();
    return _ruleColors?[rule] ?? Colors.black;
  }

  /// كل الألوان دفعة واحدة (مفيد لبناء TextSpan بكفاءة بلا await متكرر).
  Future<Map<String, Color>> getAllColors() async {
    await _load();
    return _ruleColors ?? {};
  }
}
