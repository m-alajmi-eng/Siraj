import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/storage/cache_service.dart';

/// حالة مراجعة المجتمع لترجمات القرآن الـ14 (جدول
/// translation_review_status في Supabase - انظر migration المرفقة).
/// عند فشل الاتصال، الافتراض الآمن دائماً "غير مراجَعة" (false) - لا
/// نُخفي الشارة ولا نفترض مراجعة لم تحدث فعلياً.
class TranslationReviewStatusService {
  static const _cacheKey = 'translation_review_status';

  static Future<Map<String, bool>> fetch() async {
    try {
      final rows = await Supabase.instance.client
          .from('translation_review_status')
          .select('language_code, reviewed_by_community');
      final map = <String, bool>{
        for (final row in rows)
          row['language_code'] as String: row['reviewed_by_community'] as bool,
      };
      await CacheService.saveSetting(_cacheKey, map);
      return map;
    } catch (_) {
      final cached = CacheService.getSetting(_cacheKey);
      if (cached is Map) {
        return cached.map((k, v) => MapEntry(k as String, v as bool));
      }
      return const {};
    }
  }
}

final translationReviewStatusProvider = FutureProvider<Map<String, bool>>(
  (ref) => TranslationReviewStatusService.fetch(),
);
