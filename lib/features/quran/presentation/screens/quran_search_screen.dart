import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../providers/quran_provider.dart';
import '../../domain/entities/ayah_entity.dart';

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';
  void update(String q) => state = q;
}

final searchQueryProvider =
    NotifierProvider<SearchQueryNotifier, String>(() {
  return SearchQueryNotifier();
});

final searchResultsProvider = FutureProvider<List<AyahEntity>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if (query.length < 2) return [];

  final surahsAsync = await ref.watch(surahsProvider.future);
  final results     = <AyahEntity>[];

  for (final surah in surahsAsync.take(10)) {
    try {
      final ayahs = await ref.watch(ayahsProvider(surah.id).future);
      for (final ayah in ayahs) {
        if (ayah.textUthmani.contains(query)) {
          results.add(ayah);
          if (results.length >= 30) return results;
        }
      }
    } catch (_) {}
  }
  return results;
});

class QuranSearchScreen extends ConsumerStatefulWidget {
  const QuranSearchScreen({super.key});

  @override
  ConsumerState<QuranSearchScreen> createState() =>
      _QuranSearchScreenState();
}

class _QuranSearchScreenState extends ConsumerState<QuranSearchScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette = ref.watch(timeThemeProvider);
    final query   = ref.watch(searchQueryProvider);
    final results = ref.watch(searchResultsProvider);
    final surahs  = ref.watch(surahsProvider);

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Column(
          children: [

            // ─── Search Bar ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back,
                      color: palette.textPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: TextField(
                      controller:    _controller,
                      textDirection: TextDirection.rtl,
                      autofocus:     true,
                      style: TextStyle(color: palette.textPrimary),
                      decoration: InputDecoration(
                        hintText:  'ابحث في القرآن الكريم...',
                        hintStyle: TextStyle(color: palette.textSecondary),
                        filled:    true,
                        fillColor: palette.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide:   BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      ),
                      onChanged: (val) => ref
                          .read(searchQueryProvider.notifier)
                          .update(val),
                    ),
                  ),
                ],
              ),
            ),

            // ─── Results ──────────────────────────────────────
            Expanded(
              child: query.length < 2
                  ? Center(
                      child: Text(
                        'اكتب كلمة للبحث',
                        style: TextStyle(
                          color:    palette.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : results.when(
                      loading: () => Center(
                        child: CircularProgressIndicator(
                          color: palette.accentPrimary)),
                      error: (e, _) => Center(
                        child: Text('خطأ في البحث',
                          style: TextStyle(color: palette.textPrimary))),
                      data: (list) => list.isEmpty
                          ? Center(
                              child: Text(
                                'لا توجد نتائج',
                                style: TextStyle(
                                  color:    palette.textSecondary,
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16),
                              itemCount: list.length,
                              itemBuilder: (context, index) {
                                final ayah      = list[index];
                                final surahName = surahs.maybeWhen(
                                  data: (s) => s
                                      .firstWhere(
                                          (x) => x.id == ayah.surahId,
                                          orElse: () => s.first)
                                      .nameArabic,
                                  orElse: () => '',
                                );

                                return GestureDetector(
                                  onTap: () => context.go(
                                    '/quran/surah/${ayah.surahId}'),
                                  child: Container(
                                    margin: const EdgeInsets.only(bottom: 12),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color:        palette.surface,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'آية ${ayah.ayahNumber}',
                                              style: TextStyle(
                                                color:    palette.textSecondary,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 4),
                                              decoration: BoxDecoration(
                                                color: palette.accentPrimary
                                                    .withValues(alpha: 0.15),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                surahName,
                                                style: TextStyle(
                                                  color:      palette.accentPrimary,
                                                  fontSize:   12,
                                                  fontFamily: 'QuranFont',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        _buildHighlightedText(
                                          ayah.textUthmani, query, palette),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightedText(
      String text, String query, dynamic palette) {
    if (query.isEmpty) {
      return Text(
        text,
        textAlign:     TextAlign.right,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          fontFamily: 'QuranFont',
          color:      palette.textPrimary,
          fontSize:   18,
          height:     1.8,
        ),
      );
    }

    final parts = text.split(query);
    final spans = <TextSpan>[];

    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(
        text:  parts[i],
        style: TextStyle(
          fontFamily: 'QuranFont',
          color:      palette.textPrimary,
          fontSize:   18,
          height:     1.8,
        ),
      ));
      if (i < parts.length - 1) {
        spans.add(TextSpan(
          text: query,
          style: TextStyle(
            fontFamily:      'QuranFont',
            color:           palette.accentPrimary,
            fontSize:        18,
            height:          1.8,
            fontWeight:      FontWeight.bold,
            backgroundColor: palette.accentPrimary.withValues(alpha: 0.15),
          ),
        ));
      }
    }

    return RichText(
      textAlign:     TextAlign.right,
      textDirection: TextDirection.rtl,
      text:          TextSpan(children: spans),
    );
  }
}