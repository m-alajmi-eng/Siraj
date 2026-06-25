import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../providers/hadith_provider.dart';
import '../../data/datasources/hadith_remote_datasource.dart';
import '../../domain/entities/hadith_entity.dart';

class SearchHadithNotifier extends Notifier<String> {
  @override
  String build() => '';
  void update(String q) => state = q;
}

final hadithSearchProvider =
    NotifierProvider<SearchHadithNotifier, String>(() {
  return SearchHadithNotifier();
});

class HadithHomeScreen extends ConsumerWidget {
  const HadithHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette    = ref.watch(timeThemeProvider);
    final collection = ref.watch(selectedCollectionProvider);
    final hadiths    = ref.watch(hadithsProvider(collection));
    final query      = ref.watch(hadithSearchProvider);

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Column(
          children: [

            // ─── Header ───────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20, vertical: 16),
              child: Text(
                'الحديث الشريف',
                style: TextStyle(
                  color:      palette.textPrimary,
                  fontSize:   28,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),

            // ─── Search Bar ───────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                textDirection: TextDirection.rtl,
                style: TextStyle(color: palette.textPrimary),
                decoration: InputDecoration(
                  hintText:  'ابحث في الأحاديث...',
                  hintStyle: TextStyle(color: palette.textSecondary),
                  prefixIcon: Icon(Icons.search,
                    color: palette.textSecondary),
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
                    .read(hadithSearchProvider.notifier)
                    .update(val),
              ),
            ),

            const SizedBox(height: 12),

            // ─── Collections ──────────────────────────────────
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: HadithRemoteDataSource.collections.length,
                itemBuilder: (context, index) {
                  final entry = HadithRemoteDataSource
                      .collections.entries.elementAt(index);
                  final isSelected = collection == entry.key;

                  return GestureDetector(
                    onTap: () {
                      ref
                          .read(selectedCollectionProvider.notifier)
                          .select(entry.key);
                      ref
                          .read(hadithSearchProvider.notifier)
                          .update('');
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? palette.accentPrimary
                            : palette.surface,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        entry.value,
                        style: TextStyle(
                          color: isSelected
                              ? palette.surface
                              : palette.textSecondary,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),

            // ─── Hadiths List ─────────────────────────────────
            Expanded(
              child: hadiths.when(
                loading: () => Center(
                  child: CircularProgressIndicator(
                    color: palette.accentPrimary)),
                error: (e, _) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.wifi_off,
                        color: palette.textSecondary, size: 48),
                      const SizedBox(height: 12),
                      Text('تعذّر التحميل',
                        style: TextStyle(
                          color: palette.textSecondary, fontSize: 16)),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () =>
                            ref.refresh(hadithsProvider(collection)),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color:        palette.accentPrimary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('إعادة المحاولة',
                            style: TextStyle(
                              color: palette.surface, fontSize: 14)),
                        ),
                      ),
                    ],
                  ),
                ),
                data: (list) {
                  // فلترة البحث
                  final filtered = query.isEmpty
                      ? list
                      : list.where((h) =>
                          h.arabic.contains(query)).toList();

                  if (filtered.isEmpty) {
                    return Center(
                      child: Text(
                        query.isEmpty
                            ? 'لا توجد أحاديث'
                            : 'لا توجد نتائج للبحث',
                        style: TextStyle(
                          color:    palette.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final hadith = filtered[index];
                      return GestureDetector(
                        onTap: () => _showHadithDetail(
                          context, hadith, palette),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color:        palette.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // رقم + مصدر
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: palette.accentPrimary
                                          .withOpacity(0.15),
                                      borderRadius:
                                          BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      hadith.source,
                                      style: TextStyle(
                                        color:    palette.accentPrimary,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${hadith.id}',
                                    style: TextStyle(
                                      color:    palette.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),

                              // نص الحديث مع تمييز البحث
                              _buildHighlightedText(
                                hadith.arabic, query, palette),

                              const SizedBox(height: 8),

                              // اضغط للتفاصيل
                              Text(
                                'اضغط لعرض كامل',
                                style: TextStyle(
                                  color:    palette.accentPrimary,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── تفاصيل الحديث ────────────────────────────────────────────
  void _showHadithDetail(
    BuildContext context,
    HadithEntity hadith,
    dynamic palette,
  ) {
    showModalBottomSheet(
      context:            context,
      backgroundColor:    palette.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            const SizedBox(height: 12),
            Container(
              width:  40, height: 4,
              decoration: BoxDecoration(
                color:        palette.textSecondary.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),

            // العنوان
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color:        palette.accentPrimary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${hadith.source} — ${hadith.id}',
                    style: TextStyle(
                      color:    palette.accentPrimary,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // النص كاملاً
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  hadith.arabic,
                  textAlign:     TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color:    palette.textPrimary,
                    fontSize: 17,
                    height:   2.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightedText(
      String text, String query, dynamic palette) {
    // اختصار النص في القائمة
    final shortText = text.length > 150
        ? '${text.substring(0, 150)}...'
        : text;

    if (query.isEmpty) {
      return Text(
        shortText,
        textAlign:     TextAlign.right,
        textDirection: TextDirection.rtl,
        style: TextStyle(
          color:    palette.textPrimary,
          fontSize: 15,
          height:   1.8,
        ),
      );
    }

    final parts = shortText.split(query);
    final spans = <TextSpan>[];

    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(
        text:  parts[i],
        style: TextStyle(
          color:    palette.textPrimary,
          fontSize: 15,
          height:   1.8,
        ),
      ));
      if (i < parts.length - 1) {
        spans.add(TextSpan(
          text: query,
          style: TextStyle(
            color:           palette.accentPrimary,
            fontSize:        15,
            height:          1.8,
            fontWeight:      FontWeight.bold,
            backgroundColor: palette.accentPrimary.withOpacity(0.15),
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