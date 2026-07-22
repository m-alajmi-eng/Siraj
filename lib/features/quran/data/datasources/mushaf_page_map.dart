import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

/// مرجع آية: رقم السورة + رقم الآية داخلها.
class AyahRef {
  final int surahId;
  final int ayahNumber;
  const AyahRef(this.surahId, this.ayahNumber);
}

/// خريطة صفحة↔آية مبنية من `quran_uthmani.json` المحلي (604 صفحة، مصدر
/// حقيقة واحد لتحويل موضع القراءة القديم بالصفحات إلى السورة/الآية
/// المقابلة، بعد إزالة المصحف المطبوع (ADR-005، PHASE K). لا تُمَس بيانات
/// الختمة نفسها (لا تزال مبنية على أرقام الصفحات) — هذه الخريطة تُستهلَك
/// عند العرض/التنقّل فقط.
class MushafPageMap {
  static Map<int, List<AyahRef>>? _pageToAyahs;
  static Map<int, Map<int, int>>? _ayahToPage; // surahId -> ayahNumber -> page

  static Future<void> _ensureLoaded() async {
    if (_pageToAyahs != null) return;

    final raw = await rootBundle.loadString('assets/data/quran_uthmani.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;
    final surahs = data['surahs'] as Map<String, dynamic>;

    final pageMap = <int, List<AyahRef>>{};
    final ayahMap = <int, Map<int, int>>{};

    final surahIds = surahs.keys.map(int.parse).toList()..sort();
    for (final surahId in surahIds) {
      final ayahs = surahs[surahId.toString()] as List;
      final surahAyahToPage = <int, int>{};
      for (final a in ayahs) {
        final m = a as Map<String, dynamic>;
        final ayahNumber = m['n'] as int;
        final page = m['page'] as int;
        pageMap.putIfAbsent(page, () => []).add(AyahRef(surahId, ayahNumber));
        surahAyahToPage[ayahNumber] = page;
      }
      ayahMap[surahId] = surahAyahToPage;
    }

    _pageToAyahs = pageMap;
    _ayahToPage = ayahMap;
  }

  /// أول آية تبدأ بها صفحة مصحف معيّنة (1..604). سقوط احتياطي آمن على
  /// الفاتحة (1:1) إن كان رقم الصفحة خارج المدى.
  static Future<AyahRef> firstAyahOfPage(int page) async {
    await _ensureLoaded();
    final list = _pageToAyahs![page];
    if (list == null || list.isEmpty) return const AyahRef(1, 1);
    return list.first;
  }

  /// رقم صفحة المصحف التي تقع فيها آية معيّنة. سقوط احتياطي آمن على
  /// الصفحة 1 إن كانت الآية غير موجودة (معرّفات غير صالحة).
  static Future<int> pageOfAyah(int surahId, int ayahNumber) async {
    await _ensureLoaded();
    return _ayahToPage![surahId]?[ayahNumber] ?? 1;
  }
}
