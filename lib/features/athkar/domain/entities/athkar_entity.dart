class AthkarCategory {
  final String id;
  final String name;
  final String time;

  const AthkarCategory({
    required this.id,
    required this.name,
    required this.time,
  });

  factory AthkarCategory.fromJson(Map<String, dynamic> json) {
    return AthkarCategory(
      id:   json['id'],
      name: json['name'],
      time: json['time'],
    );
  }
}

class AthkarEntity {
  final int id;
  final String category;
  final String arabic;
  final String translation;
  final int count;
  final String source;

  const AthkarEntity({
    required this.id,
    required this.category,
    required this.arabic,
    required this.translation,
    required this.count,
    required this.source,
  });

  factory AthkarEntity.fromJson(Map<String, dynamic> json) {
    return AthkarEntity(
      id:          json['id'],
      category:    json['category'],
      arabic:      json['arabic'],
      translation: json['translation'],
      count:       json['count'],
      source:      json['source'],
    );
  }
}