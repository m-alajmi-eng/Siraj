/// فئة (باب) من أذكار حصن المسلم
class AthkarCategory {
  final String id;
  final String name; // الاسم العربي من المصدر
  final Map<String, String> names; // lang -> اسم مترجم

  const AthkarCategory({
    required this.id,
    required this.name,
    this.names = const {},
  });

  /// الاسم بلغة معينة (يرجع للعربي إن لم تتوفر)
  String nameFor(String lang) {
    final n = names[lang];
    if (n != null && n.isNotEmpty) return n;
    return name;
  }

  factory AthkarCategory.fromJson(Map<String, dynamic> json) {
    final names = <String, String>{};
    if (json['names'] is Map) {
      (json['names'] as Map).forEach((k, v) {
        if (v != null) names[k.toString()] = v.toString();
      });
    }
    return AthkarCategory(
      id:    json['id'].toString(),
      name:  json['name'] as String,
      names: names,
    );
  }
}

/// مجموعة كبرى تضم عدة أبواب
class AthkarGroup {
  final String id;
  final String nameAr;
  final String icon;
  final List<String> categoryIds;
  final Map<String, String> names; // lang -> اسم مترجم

  const AthkarGroup({
    required this.id,
    required this.nameAr,
    required this.icon,
    required this.categoryIds,
    this.names = const {},
  });

  /// الاسم بلغة معيّنة (يرجع للعربي إن لم تتوفر)
  String nameFor(String lang) {
    final n = names[lang];
    if (n != null && n.isNotEmpty) return n;
    return nameAr;
  }
}

/// ذكر مفرد
class AthkarEntity {
  final int id;
  final String category;
  final String arabic;
  final Map<String, String> translations; // lang -> نص مترجم
  final int count;
  final String source;
  final String audio;

  const AthkarEntity({
    required this.id,
    required this.category,
    required this.arabic,
    required this.translations,
    required this.count,
    this.source = '',
    this.audio = '',
  });

  /// الترجمة بلغة معيّنة (فارغة إن لم تتوفر)
  String translationFor(String lang) => translations[lang] ?? '';

  factory AthkarEntity.fromJson(Map<String, dynamic> json) {
    final rawTrans = json['translations'];
    final trans = <String, String>{};
    if (rawTrans is Map) {
      rawTrans.forEach((k, v) {
        if (v != null && v.toString().isNotEmpty) {
          trans[k.toString()] = v.toString();
        }
      });
    }
    return AthkarEntity(
      id:           json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      category:     json['category'].toString(),
      arabic:       (json['arabic'] ?? '').toString(),
      translations: trans,
      count:        json['count'] is int ? json['count'] : int.parse((json['count'] ?? '1').toString()),
      source:       (json['source'] ?? '').toString(),
      audio:        (json['audio'] ?? '').toString(),
    );
  }
}
