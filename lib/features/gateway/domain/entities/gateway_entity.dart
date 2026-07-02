/// كيانات بوابة الوعي الروحي (رحلة تعريف الإسلام لغير المسلمين)
/// تتبع نمط الأذكار: كل حقل نصّي له خريطة لغات + دالة fieldFor(lang)
/// ترجع للعربية إن لم تتوفر اللغة المطلوبة.

/// دالة مساعدة عليا: تقرأ خريطة {lang: text} من JSON بأمان.
Map<String, String> readLangMap(dynamic raw) {
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

/// يختار النص باللغة المطلوبة، ويرجع للعربية ثم لأول متاح.
String pick(Map<String, String> m, String lang) {
  final v = m[lang];
  if (v != null && v.isNotEmpty) return v;
  final ar = m['ar'];
  if (ar != null && ar.isNotEmpty) return ar;
  return m.isNotEmpty ? m.values.first : '';
}

/// رابط تعمّق يشير إلى تصنيف في IslamHouse.
class DeepLink {
  final String islamhouseCategory;
  final Map<String, String> label;

  const DeepLink({
    required this.islamhouseCategory,
    required this.label,
  });

  String labelFor(String lang) => pick(label, lang);

  factory DeepLink.fromJson(Map<String, dynamic> json) {
    return DeepLink(
      islamhouseCategory: (json['islamhouse_category'] ?? '').toString(),
      label: readLangMap(json['label']),
    );
  }
}

/// الطبقة 1: محطة في رحلة الوعي
class GatewayStation {
  final String id;
  final int order;
  final String icon;
  final String mood;
  final Map<String, String> title;
  final Map<String, String> subtitle;
  final Map<String, String> body;
  final Map<String, String> reflection;
  final DeepLink? deepLink;
  final bool leadsToLayer2;
  final Map<String, String> layer2Invite;
  final int? quranSurah;
  final int? quranAyah;

  const GatewayStation({
    required this.id,
    required this.order,
    required this.icon,
    required this.mood,
    required this.title,
    required this.subtitle,
    required this.body,
    required this.reflection,
    this.deepLink,
    this.leadsToLayer2 = false,
    this.layer2Invite = const {},
    this.quranSurah,
    this.quranAyah,
  });

  String titleFor(String lang) => pick(title, lang);
  String subtitleFor(String lang) => pick(subtitle, lang);
  String bodyFor(String lang) => pick(body, lang);
  String reflectionFor(String lang) => pick(reflection, lang);
  String layer2InviteFor(String lang) => pick(layer2Invite, lang);

  factory GatewayStation.fromJson(Map<String, dynamic> json) {
    DeepLink? dl;
    if (json['deep_link'] is Map) {
      dl = DeepLink.fromJson(Map<String, dynamic>.from(json['deep_link']));
    }
    int? surah;
    int? ayah;
    if (json['quran_ref'] is Map) {
      final q = json['quran_ref'] as Map;
      surah = q['surah'] is int ? q['surah'] : int.tryParse('${q['surah']}');
      ayah = q['ayah'] is int ? q['ayah'] : int.tryParse('${q['ayah']}');
    }
    return GatewayStation(
      id: (json['id'] ?? '').toString(),
      order: json['order'] is int ? json['order'] : int.tryParse('${json['order']}') ?? 0,
      icon: (json['icon'] ?? 'circle').toString(),
      mood: (json['mood'] ?? 'midday').toString(),
      title: readLangMap(json['title']),
      subtitle: readLangMap(json['subtitle']),
      body: readLangMap(json['body']),
      reflection: readLangMap(json['reflection']),
      deepLink: dl,
      leadsToLayer2: json['leads_to_layer2'] == true,
      layer2Invite: readLangMap(json['layer2_invite']),
      quranSurah: surah,
      quranAyah: ayah,
    );
  }
}

/// الطبقة 2: موضوع في مبادئ الإسلام
class DevotionalText {
  final bool needsVerification;
  final String arabic;
  final String transliterationEn;
  final Map<String, String> meaning;

  const DevotionalText({
    required this.needsVerification,
    required this.arabic,
    required this.transliterationEn,
    required this.meaning,
  });

  String meaningFor(String lang) => pick(meaning, lang);

  factory DevotionalText.fromJson(Map<String, dynamic> json) {
    return DevotionalText(
      needsVerification: json['needs_verification'] == true,
      arabic: (json['arabic'] ?? '').toString(),
      transliterationEn: (json['transliteration_en'] ?? '').toString(),
      meaning: readLangMap(json['meaning']),
    );
  }
}

class PrincipleStep {
  final Map<String, String> text;
  const PrincipleStep(this.text);
  String textFor(String lang) => pick(text, lang);
  factory PrincipleStep.fromJson(Map<String, dynamic> json) =>
      PrincipleStep(readLangMap(json));
}

class PrincipleTopic {
  final String id;
  final int order;
  final String icon;
  final Map<String, String> title;
  final Map<String, String> summary;
  final List<PrincipleStep> steps;
  final Map<String, String> note;
  final DevotionalText? devotional;
  final DeepLink? deepLink;

  const PrincipleTopic({
    required this.id,
    required this.order,
    required this.icon,
    required this.title,
    required this.summary,
    required this.steps,
    required this.note,
    this.devotional,
    this.deepLink,
  });

  String titleFor(String lang) => pick(title, lang);
  String summaryFor(String lang) => pick(summary, lang);
  String noteFor(String lang) => pick(note, lang);

  factory PrincipleTopic.fromJson(Map<String, dynamic> json) {
    final steps = <PrincipleStep>[];
    if (json['steps'] is List) {
      for (final s in (json['steps'] as List)) {
        if (s is Map) steps.add(PrincipleStep.fromJson(Map<String, dynamic>.from(s)));
      }
    }
    DevotionalText? dev;
    if (json['devotional_text'] is Map) {
      dev = DevotionalText.fromJson(Map<String, dynamic>.from(json['devotional_text']));
    }
    DeepLink? dl;
    if (json['deep_link'] is Map) {
      dl = DeepLink.fromJson(Map<String, dynamic>.from(json['deep_link']));
    }
    return PrincipleTopic(
      id: (json['id'] ?? '').toString(),
      order: json['order'] is int ? json['order'] : int.tryParse('${json['order']}') ?? 0,
      icon: (json['icon'] ?? 'circle').toString(),
      title: readLangMap(json['title']),
      summary: readLangMap(json['summary']),
      steps: steps,
      note: readLangMap(json['note']),
      devotional: dev,
      deepLink: dl,
    );
  }
}
