import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/entities/athkar_entity.dart';

class AthkarLocalDataSource {
  static List<AthkarCategory>? _categories;
  static List<AthkarEntity>?   _athkar;

  Future<void> _load() async {
    if (_categories != null) return;
    final json = await rootBundle.loadString('assets/data/athkar.json');
    final data = jsonDecode(json);
    _categories = (data['categories'] as List)
        .map((c) => AthkarCategory.fromJson(c))
        .toList();
    _athkar = (data['athkar'] as List)
        .map((a) => AthkarEntity.fromJson(a))
        .toList();
  }

  Future<List<AthkarCategory>> getCategories() async {
    await _load();
    return _categories!;
  }

  Future<List<AthkarEntity>> getByCategory(String categoryId) async {
    await _load();
    return _athkar!.where((a) => a.category == categoryId).toList();
  }
}