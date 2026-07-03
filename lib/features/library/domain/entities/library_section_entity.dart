/// كيان قسم في المكتبة الشاملة (الطبقة 1: الأقسام الرئيسية)
/// يتبع نفس نمط nameFor(lang) المستخدم في ميزة الأذكار والبوابة.

Map<String, String> _readLangMap(dynamic raw) {
  final out = <String, String>{};
  if (raw is Map) {
    raw.forEach((k, v) {
      if (v != null && v.toString().isNotEmpty) {
        out[k.toString()] = v.toString();
      }
    });
  }
  return out;
}

String _pick(Map<String, String> m, String lang) {
  final v = m[lang];
  if (v != null && v.isNotEmpty) return v;
  final ar = m['ar'];
  if (ar != null && ar.isNotEmpty) return ar;
  return m.isNotEmpty ? m.values.first : '';
}

class LibrarySection {
  final String id;
  final int order;
  final String icon;
  final String islamhouseCategory;
  final Map<String, String> title;
  final Map<String, String> description;

  const LibrarySection({
    required this.id,
    required this.order,
    required this.icon,
    required this.islamhouseCategory,
    required this.title,
    required this.description,
  });

  String titleFor(String lang) => _pick(title, lang);
  String descriptionFor(String lang) => _pick(description, lang);

  factory LibrarySection.fromJson(Map<String, dynamic> json) {
    return LibrarySection(
      id: (json['id'] ?? '').toString(),
      order: json['order'] is int
          ? json['order']
          : int.tryParse('${json['order']}') ?? 0,
      icon: (json['icon'] ?? 'circle').toString(),
      islamhouseCategory: (json['islamhouse_category'] ?? '').toString(),
      title: _readLangMap(json['title']),
      description: _readLangMap(json['description']),
    );
  }
}
