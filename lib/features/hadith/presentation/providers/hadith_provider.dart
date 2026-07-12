import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/hadith_repository.dart';

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
