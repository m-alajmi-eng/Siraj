import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/library_section_entity.dart';

/// مصدر بيانات الأقسام الرئيسية للمكتبة الشاملة (محلي، JSON).
class LibraryLocalDataSource {
  static List<LibrarySection>? _sections;

  Future<void> _load() async {
    if (_sections != null) return;
    final raw = await rootBundle.loadString('assets/data/library_sections.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;
    final list = (data['sections'] as List)
        .map((s) => LibrarySection.fromJson(Map<String, dynamic>.from(s)))
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));
    _sections = list;
  }

  Future<List<LibrarySection>> getSections() async {
    await _load();
    return _sections!;
  }

  Future<LibrarySection?> getSection(String id) async {
    await _load();
    for (final s in _sections!) {
      if (s.id == id) return s;
    }
    return null;
  }
}
