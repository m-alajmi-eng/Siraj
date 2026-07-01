import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/athkar_entity.dart';

class AthkarLocalDataSource {
  static List<AthkarCategory>? _categories;
  static List<AthkarEntity>?   _athkar;
  static List<AthkarGroup>?    _groups;

  Future<void> _load() async {
    if (_categories != null) return;

    // الأذكار والفئات
    final json = await rootBundle.loadString('assets/data/athkar_full.json');
    final data = jsonDecode(json);
    _categories = (data['categories'] as List)
        .map((c) => AthkarCategory.fromJson(c))
        .toList();
    _athkar = (data['athkar'] as List)
        .map((a) => AthkarEntity.fromJson(a))
        .toList();

    // المجموعات الكبرى
    final gJson = await rootBundle.loadString('assets/data/athkar_groups.json');
    final gData = jsonDecode(gJson) as Map<String, dynamic>;
    _groups = gData.entries.map((e) {
      final v = e.value as Map<String, dynamic>;
      return AthkarGroup(
        id:          e.key,
        nameAr:      v['name_ar'] as String,
        icon:        v['icon'] as String,
        categoryIds: (v['ids'] as List).map((i) => i.toString()).toList(),
        names:       _readNames(v),
      );
    }).toList();
  }

  Future<List<AthkarGroup>> getGroups() async {
    await _load();
    return _groups!;
  }

  Future<List<AthkarCategory>> getCategories() async {
    await _load();
    return _categories!;
  }

  /// فئات مجموعة معيّنة
  Future<List<AthkarCategory>> getCategoriesInGroup(String groupId) async {
    await _load();
    final group = _groups!.firstWhere((g) => g.id == groupId);
    return _categories!
        .where((c) => group.categoryIds.contains(c.id))
        .toList();
  }

  Future<List<AthkarEntity>> getByCategory(String categoryId) async {
    await _load();
    return _athkar!.where((a) => a.category == categoryId).toList();
  }
}

Map<String, String> _readNames(Map v) {
  final names = <String, String>{};
  if (v['names'] is Map) {
    (v['names'] as Map).forEach((k, val) {
      if (val != null) names[k.toString()] = val.toString();
    });
  }
  return names;
}
