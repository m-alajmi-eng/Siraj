import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

/// آية واحدة في صفحة المصحف الرسمي (KFGQPC Hafs Smart).
class MushafAyah {
  final int suraNo;
  final int ayaNo;
  final int page;
  final int lineStart;
  final int lineEnd;
  final String glyphText; // aya_text بترميز الخط الذكي (Private Use Area)
  final String emlaeyText; // النص الإملائي العادي (للبحث/المرجع)
  final String suraNameAr;

  const MushafAyah({
    required this.suraNo,
    required this.ayaNo,
    required this.page,
    required this.lineStart,
    required this.lineEnd,
    required this.glyphText,
    required this.emlaeyText,
    required this.suraNameAr,
  });
}

/// مصدر بيانات المصحف الرسمي: يقرأ hafs_smart_v8.json (KFGQPC) محلياً.
/// خط واحد رسمي (HafsSmart) + بيانات صفحات وأسطر - لا تحميل ديناميكي.
class MushafPageDataSource {
  static List<MushafAyah>? _cache;

  static Future<List<MushafAyah>> _loadAll() async {
    if (_cache != null) return _cache!;
    final raw = await rootBundle.loadString('assets/data/hafs_smart_v8.json');
    final list = jsonDecode(raw) as List;
    _cache = list.map((e) {
      final m = e as Map<String, dynamic>;
      return MushafAyah(
        suraNo: m['sura_no'] as int,
        ayaNo: m['aya_no'] as int,
        page: m['page'] as int,
        lineStart: m['line_start'] as int,
        lineEnd: m['line_end'] as int,
        glyphText: m['aya_text'] as String,
        emlaeyText: m['aya_text_emlaey'] as String,
        suraNameAr: m['sura_name_ar'] as String,
      );
    }).toList();
    return _cache!;
  }

  /// كل آيات صفحة معيّنة (1..604)، مرتبة بترتيب ورودها.
  Future<List<MushafAyah>> getPage(int pageNumber) async {
    final all = await _loadAll();
    return all.where((a) => a.page == pageNumber).toList();
  }

  /// أول صفحة تبدأ فيها سورة معيّنة (للانتقال من قارئ السورة).
  Future<int> firstPageOfSura(int suraNo) async {
    final all = await _loadAll();
    final match = all.where((a) => a.suraNo == suraNo);
    if (match.isEmpty) return 1;
    return match.first.page;
  }
}
