/// قاعدة تجويد واحدة مُطبَّقة على نطاق حرفي داخل نص آية.
/// المواضع (start/end) هي فهرس أحرف Unicode ضمن النص العثماني النظيف
/// (plain) لنفس الآية — لا تُستخدم مستقلة عن نصها المقابل.
class TajweedAnnotation {
  final String rule; // رمز القاعدة (h, l, n, q, ...)
  final int start;
  final int end;

  const TajweedAnnotation({
    required this.rule,
    required this.start,
    required this.end,
  });

  factory TajweedAnnotation.fromJson(Map<String, dynamic> json) {
    return TajweedAnnotation(
      rule: (json['r'] ?? '').toString(),
      start: json['s'] is int ? json['s'] : int.tryParse('${json['s']}') ?? 0,
      end: json['e'] is int ? json['e'] : int.tryParse('${json['e']}') ?? 0,
    );
  }
}

/// نص آية بصيغة التجويد: نص عثماني نظيف + قواعد التجويد المُطبَّقة عليه.
class TajweedAyah {
  final int number; // رقم الآية داخل السورة
  final String plain; // النص العثماني النظيف (بلا رموز تشفير)
  final List<TajweedAnnotation> annotations;

  const TajweedAyah({
    required this.number,
    required this.plain,
    required this.annotations,
  });

  factory TajweedAyah.fromJson(Map<String, dynamic> json) {
    final rawAnnotations = json['tajweed'] as List? ?? [];
    return TajweedAyah(
      number: json['n'] is int ? json['n'] : int.tryParse('${json['n']}') ?? 0,
      plain: (json['plain'] ?? '').toString(),
      annotations: rawAnnotations
          .whereType<Map>()
          .map((e) => TajweedAnnotation.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }
}
