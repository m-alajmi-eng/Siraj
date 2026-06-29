import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
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
    final t          = AppLocalizations.of(context);
    final palette    = ref.watch(timeThemeProvider);
    final collection = ref.watch(selectedCollectionProvider);
    final hadiths    = ref.watch(hadithsProvider(collection));
    final query      = ref.watch(hadithSearchProvider);

    return AppScaffold(
      title: t.hadith_title,
      showBack: false,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          // ─── Search Bar ───
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s4),
            child: TextField(
              style: AppText.body.copyWith(color: palette.textPrimary),
              decoration: InputDecoration(
                hintText:  t.hadith_searchHint,
                hintStyle: AppText.body.copyWith(color: palette.textSecondary),
                prefixIcon: Icon(Icons.search, color: palette.textSecondary),
                filled:    true,
                fillColor: palette.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(SirajRadiusFull.md),
                  borderSide:   BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: SirajSpacing.s4, vertical: SirajSpacing.s3),
              ),
              onChanged: (val) =>
                  ref.read(hadithSearchProvider.notifier).update(val),
            ),
          ),
          const SizedBox(height: SirajSpacing.s3),

          // ─── Collections ───
          SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s4),
              itemCount: HadithRemoteDataSource.collections.length,
              itemBuilder: (context, index) {
                final entry = HadithRemoteDataSource
                    .collections.entries.elementAt(index);
                final isSelected = collection == entry.key;
                return GestureDetector(
                  onTap: () {
                    ref.read(selectedCollectionProvider.notifier).select(entry.key);
                    ref.read(hadithSearchProvider.notifier).update('');
                  },
                  child: Container(
                    margin: const EdgeInsetsDirectional.only(end: SirajSpacing.s2),
                    padding: const EdgeInsets.symmetric(
                      horizontal: SirajSpacing.s4, vertical: SirajSpacing.s2),
                    decoration: BoxDecoration(
                      color: isSelected ? palette.accentPrimary : palette.surface,
                      borderRadius: BorderRadius.circular(SirajRadiusFull.xl),
                    ),
                    child: Center(
                      child: Text(entry.value, style: AppText.bodySmall.copyWith(
                        color: isSelected ? palette.surface : palette.textSecondary)),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: SirajSpacing.s3),

          // ─── Hadiths List ───
          Expanded(
            child: hadiths.when(
              loading: () => Center(
                child: CircularProgressIndicator(color: palette.accentPrimary)),
              error: (e, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.wifi_off, color: palette.textSecondary, size: 48),
                    const SizedBox(height: SirajSpacing.s3),
                    Text(t.hadith_loadError, style: AppText.body.copyWith(
                      color: palette.textSecondary)),
                    const SizedBox(height: SirajSpacing.s2),
                    GestureDetector(
                      onTap: () => ref.refresh(hadithsProvider(collection)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: SirajSpacing.s5, vertical: SirajSpacing.s2),
                        decoration: BoxDecoration(
                          color: palette.accentPrimary,
                          borderRadius: BorderRadius.circular(SirajRadiusFull.sm),
                        ),
                        child: Text(t.hadith_retryButton, style: AppText.bodySmall.copyWith(
                          color: palette.surface)),
                      ),
                    ),
                  ],
                ),
              ),
              data: (list) {
                final filtered = query.isEmpty
                    ? list
                    : list.where((h) => h.arabic.contains(query)).toList();
                if (filtered.isEmpty) {
                  return Center(
                    child: Text(t.hadith_noResults, style: AppText.body.copyWith(
                      color: palette.textSecondary)),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s4),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final hadith = filtered[index];
                    return GestureDetector(
                      onTap: () => _showHadithDetail(context, hadith, palette, t),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: SirajSpacing.s3),
                        padding: const EdgeInsets.all(SirajSpacing.s4),
                        decoration: BoxDecoration(
                          color: palette.surface,
                          borderRadius: BorderRadius.circular(SirajRadiusFull.md),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: SirajSpacing.s3, vertical: SirajSpacing.s1),
                                  decoration: BoxDecoration(
                                    color: palette.accentPrimary.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(SirajRadiusFull.sm),
                                  ),
                                  child: Text(hadith.source, style: AppText.caption.copyWith(
                                    color: palette.accentPrimary, fontSize: SirajSizes.sSm)),
                                ),
                                Text('${hadith.id}', style: AppText.caption.copyWith(
                                  color: palette.textSecondary)),
                              ],
                            ),
                            const SizedBox(height: SirajSpacing.s3),
                            _buildHighlightedText(hadith.arabic, query, palette),
                            const SizedBox(height: SirajSpacing.s2),
                            Text(t.hadith_tapForDetail, style: AppText.caption.copyWith(
                              color: palette.accentPrimary, fontSize: SirajSizes.sSm)),
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
    );
  }

  void _showHadithDetail(BuildContext context, HadithEntity hadith,
      dynamic palette, AppLocalizations t) {
    showModalBottomSheet(
      context: context,
      backgroundColor: palette.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(SirajRadiusFull.xl)),
      ),
      builder: (_) => SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            const SizedBox(height: SirajSpacing.s3),
            Container(
              width: 40, height: 4,
              decoration: BoxDecoration(
                color: palette.textSecondary.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: SirajSpacing.s4),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: SirajSpacing.s3, vertical: SirajSpacing.s1),
              decoration: BoxDecoration(
                color: palette.accentPrimary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(SirajRadiusFull.sm),
              ),
              child: Text('${hadith.source} — ${hadith.id}',
                style: AppText.bodySmall.copyWith(color: palette.accentPrimary)),
            ),
            const SizedBox(height: SirajSpacing.s4),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s5),
                child: Text(hadith.arabic,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: AppText.bodyLarge.copyWith(
                    color: palette.textPrimary, height: 2.0)),
              ),
            ),
            const SizedBox(height: SirajSpacing.s4),
          ],
        ),
      ),
    );
  }

  Widget _buildHighlightedText(String text, String query, dynamic palette) {
    final shortText = text.length > 150 ? '${text.substring(0, 150)}...' : text;
    final base = AppText.body.copyWith(color: palette.textPrimary, height: 1.8);

    if (query.isEmpty) {
      return Text(shortText, textAlign: TextAlign.right,
        textDirection: TextDirection.rtl, style: base);
    }

    final parts = shortText.split(query);
    final spans = <TextSpan>[];
    for (int i = 0; i < parts.length; i++) {
      spans.add(TextSpan(text: parts[i], style: base));
      if (i < parts.length - 1) {
        spans.add(TextSpan(text: query, style: base.copyWith(
          color: palette.accentPrimary, fontWeight: FontWeight.bold,
          backgroundColor: palette.accentPrimary.withValues(alpha: 0.15))));
      }
    }
    return RichText(
      textAlign: TextAlign.right,
      textDirection: TextDirection.rtl,
      text: TextSpan(children: spans),
    );
  }
}
