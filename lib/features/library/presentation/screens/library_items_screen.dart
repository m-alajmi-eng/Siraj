import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../gateway/data/datasources/islamhouse_remote_datasource.dart';
import '../providers/library_items_provider.dart';
import '../../../../l10n/app_localizations.dart';

/// المستوى 3 (الأخير): عناصر تصنيف فرعي — كتب/مقالات/صوتيات قابلة للفتح.
class LibraryItemsScreen extends ConsumerStatefulWidget {
  final String categoryId;
  final String type;
  const LibraryItemsScreen({
    super.key,
    required this.categoryId,
    this.type = 'showall',
  });

  static const _typeIcons = {
    'books': Icons.menu_book_outlined,
    'articles': Icons.article_outlined,
    'audios': Icons.headphones_outlined,
    'videos': Icons.play_circle_outline,
  };

  @override
  ConsumerState<LibraryItemsScreen> createState() => _LibraryItemsScreenState();
}

class _LibraryItemsScreenState extends ConsumerState<LibraryItemsScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final categoryId = widget.categoryId;
    final type = widget.type;
    final t = AppLocalizations.of(context);
    final typeIcons = LibraryItemsScreen._typeIcons;
    final palette = ref.watch(timeThemeProvider);
    final lang = ref.watch(localeProvider).languageCode;
    final isAr = lang == 'ar';
    final itemsAsync = ref.watch(librarySectionItemsProvider(
      LibraryItemsParams(categoryId: categoryId, type: type),
    ));

    return AppScaffold(
      title: t.library_content_title,
      showBack: true,
      child: itemsAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: palette.accentPrimary),
        ),
        error: (e, _) => LibraryErrorView(palette: palette, isAr: isAr, t: t),
        data: (items) {
          if (items.isEmpty) {
            return LibraryErrorView(palette: palette, isAr: isAr, t: t, empty: true);
          }
          final filtered = _query.trim().isEmpty
              ? items
              : items.where((it) {
                  final q = _query.trim().toLowerCase();
                  return it.title.toLowerCase().contains(q) ||
                      it.description.toLowerCase().contains(q);
                }).toList();

          return Directionality(
            textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    SirajSpacing.s4, SirajSpacing.s4, SirajSpacing.s4, SirajSpacing.s2,
                  ),
                  child: TextField(
                    onChanged: (v) => setState(() => _query = v),
                    style: AppText.body.copyWith(color: palette.textPrimary),
                    decoration: InputDecoration(
                      hintText: t.library_search_in_category,
                      hintStyle: AppText.body.copyWith(color: palette.textSecondary),
                      prefixIcon: Icon(Icons.search, color: palette.textSecondary),
                      filled: true,
                      fillColor: palette.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(SirajRadiusFull.md),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: SirajSpacing.s4, vertical: SirajSpacing.s3,
                      ),
                    ),
                  ),
                ),
                if (filtered.isEmpty)
                  Expanded(
                    child: Center(
                      child: Text(
                        t.library_no_matching_results,
                        style: AppText.body.copyWith(color: palette.textSecondary),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s4)
                          .copyWith(bottom: SirajSpacing.s4),
                      itemCount: filtered.length,
                      separatorBuilder: (_, _) => const SizedBox(height: SirajSpacing.s2),
                      itemBuilder: (context, index) {
                        return ContentCard(
                          item: filtered[index],
                          palette: palette,
                          icon: typeIcons[filtered[index].type] ??
                              Icons.description_outlined,
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ContentCard extends StatelessWidget {
  final LibraryItem item;
  final dynamic palette;
  final IconData icon;

  const ContentCard({
    super.key,
    required this.item,
    required this.palette,
    required this.icon,
  });

  Future<void> _open(String url) async {
    final uri = Uri.tryParse(url);
    if (uri != null) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstAttachment =
        item.attachments.isNotEmpty ? item.attachments.first : null;

    return GestureDetector(
      onTap: firstAttachment == null ? null : () => _open(firstAttachment.url),
      child: Container(
        padding: const EdgeInsets.all(SirajSpacing.s4),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(SirajRadiusFull.md),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: palette.accentPrimary, size: 24),
            const SizedBox(width: SirajSpacing.s3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: AppText.body.copyWith(
                      color: palette.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (item.description.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      item.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.caption.copyWith(
                        color: palette.textSecondary,
                        height: 1.5,
                      ),
                    ),
                  ],
                  if (firstAttachment != null) ...[
                    const SizedBox(height: SirajSpacing.s2),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: palette.accentPrimary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(SirajRadiusFull.sm),
                          ),
                          child: Text(
                            firstAttachment.extension,
                            style: AppText.caption.copyWith(
                              color: palette.accentPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: SirajSpacing.s2),
                        Text(
                          firstAttachment.size,
                          style: AppText.caption.copyWith(color: palette.textSecondary),
                        ),
                        const Spacer(),
                        Icon(Icons.open_in_new, color: palette.textSecondary, size: 16),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LibraryErrorView extends StatelessWidget {
  final dynamic palette;
  final bool isAr;
  final AppLocalizations t;
  final bool empty;

  const LibraryErrorView({super.key, required this.palette, required this.isAr, required this.t, this.empty = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SirajSpacing.s6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              empty ? Icons.inbox_outlined : Icons.wifi_off_outlined,
              color: palette.textSecondary,
              size: 48,
            ),
            const SizedBox(height: SirajSpacing.s4),
            Text(
              empty ? t.library_no_materials_lang : t.library_connection_failed,
              textAlign: TextAlign.center,
              style: AppText.body.copyWith(color: palette.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
