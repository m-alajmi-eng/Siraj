import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/gateway_entity.dart';

/// مصدر بيانات البوابة: يحمّل ملفَّي الرحلة (الطبقة 1) والمبادئ (الطبقة 2)
/// مع تخزين ثابت (static cache) لتجنّب إعادة القراءة — نفس نمط الأذكار.
class GatewayLocalDataSource {
  static List<GatewayStation>? _stations;
  static List<PrincipleTopic>? _topics;

  Future<void> _loadJourney() async {
    if (_stations != null) return;
    final raw = await rootBundle.loadString('assets/data/gateway_journey.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;
    final list = (data['stations'] as List)
        .map((s) => GatewayStation.fromJson(Map<String, dynamic>.from(s)))
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));
    _stations = list;
  }

  Future<void> _loadPrinciples() async {
    if (_topics != null) return;
    final raw = await rootBundle.loadString('assets/data/gateway_principles.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;
    final list = (data['topics'] as List)
        .map((t) => PrincipleTopic.fromJson(Map<String, dynamic>.from(t)))
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));
    _topics = list;
  }

  /// الطبقة 1: محطات رحلة الوعي مرتّبة.
  Future<List<GatewayStation>> getStations() async {
    await _loadJourney();
    return _stations!;
  }

  /// الطبقة 2: مواضيع مبادئ الإسلام مرتّبة.
  Future<List<PrincipleTopic>> getPrinciples() async {
    await _loadPrinciples();
    return _topics!;
  }

  /// موضوع واحد بالمعرّف (لصفحة التفصيل).
  Future<PrincipleTopic?> getTopic(String id) async {
    await _loadPrinciples();
    for (final t in _topics!) {
      if (t.id == id) return t;
    }
    return null;
  }
}
