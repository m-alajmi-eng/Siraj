import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/hadith_repository.dart';
import '../../../../core/storage/cache_service.dart';

final hadithRepositoryProvider = Provider<HadithRepository>((ref) {
  return HadithRepository(Supabase.instance.client);
});

final hadithCategoriesProvider = FutureProvider<List<HadithCategory>>((ref) async {
  return ref.read(hadithRepositoryProvider).getCategories();
});

final hadithsByCategoryProvider =
    FutureProvider.family<List<Hadith>, int>((ref, categoryId) async {
  return ref.read(hadithRepositoryProvider).getHadithsByCategory(categoryId);
});

/// معرّفات الأحاديث "المقروءة" (فُتحت/عُرض نصّها الكامل مرة واحدة على
/// الأقل) — محفوظة محلياً عبر CacheService تحت مفتاح hadith_read_ids.
/// الواجهة لا تقرأ Hive مباشرة، فقط عبر هذا الـprovider.
class HadithReadIdsNotifier extends Notifier<Set<int>> {
  static const _key = 'hadith_read_ids';

  @override
  Set<int> build() {
    final raw = CacheService.getSetting(_key, defaultValue: const <dynamic>[]) as List;
    return raw.map((e) => e as int).toSet();
  }

  void markRead(int hadithId) {
    if (state.contains(hadithId)) return;
    state = {...state, hadithId};
    CacheService.saveSetting(_key, state.toList());
  }
}

final hadithReadIdsProvider =
    NotifierProvider<HadithReadIdsNotifier, Set<int>>(HadithReadIdsNotifier.new);
