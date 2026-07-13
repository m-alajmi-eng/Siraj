import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdwaaBayanPage {
  final int    pageNumber;
  final String shamelaUrl;
  final String pageTitle;
  final String pageText;

  AdwaaBayanPage({
    required this.pageNumber,
    required this.shamelaUrl,
    required this.pageTitle,
    required this.pageText,
  });

  factory AdwaaBayanPage.fromJson(Map<String, dynamic> j) {
    return AdwaaBayanPage(
      pageNumber: j['page_number'] ?? 0,
      shamelaUrl: j['shamela_url'] ?? '',
      pageTitle:  j['page_title']  ?? '',
      pageText:   j['page_text']   ?? '',
    );
  }
}

class AdwaaBayanRepository {
  final _client = Supabase.instance.client;

  static const int firstPage = 1;
  static const int lastPage  = 4343;

  Future<AdwaaBayanPage> getPage(int pageNumber) async {
    final res = await _client
        .from('adwaa_al_bayan_pages')
        .select()
        .eq('page_number', pageNumber)
        .single();
    return AdwaaBayanPage.fromJson(res);
  }
}

final adwaaBayanRepositoryProvider =
    Provider<AdwaaBayanRepository>((ref) => AdwaaBayanRepository());

final adwaaBayanPageProvider =
    FutureProvider.family<AdwaaBayanPage, int>((ref, pageNumber) async {
  final repo = ref.watch(adwaaBayanRepositoryProvider);
  return repo.getPage(pageNumber);
});
