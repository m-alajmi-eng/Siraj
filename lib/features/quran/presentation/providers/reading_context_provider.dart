import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/storage/cache_service.dart';
import '../../data/datasources/mushaf_page_map.dart';

/// سياق "متابعة القراءة" الموحّد بعد تطبيع الأنواع القديمة (page/
/// khatmah_page) لسياق سورة/آية فعلي عبر [MushafPageMap] — بعد إزالة
/// المصحف المطبوع (PHASE K، ADR-005) لا وجهة "صفحة حرة" لفتحها بعد
/// الآن، فكل سياق قديم محفوظ في Hive قبل هذا التحديث يُحوَّل تلقائياً
/// لأقرب آية مقابلة عند القراءة، بلا أي ترحيل بيانات فعلي.
final continueReadingContextProvider =
    FutureProvider<Map<String, dynamic>?>((ref) async {
  final raw = CacheService.getLastReadingContext();
  if (raw == null) return null;

  final type = raw['type'] as String?;
  if (type == 'page' || type == 'khatmah_page') {
    final page = raw['page'] as int?;
    if (page == null) return null;
    final ayahRef = await MushafPageMap.firstAyahOfPage(page);
    return {
      'type': 'surah',
      'surahId': ayahRef.surahId,
      'ayahNumber': ayahRef.ayahNumber,
    };
  }

  return raw;
});
