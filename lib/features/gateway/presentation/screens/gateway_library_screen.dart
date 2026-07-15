import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/datasources/islamhouse_remote_datasource.dart';
import '../providers/library_provider.dart';

/// الطبقة 3: المكتبة الكبرى — عناصر تصنيف من دار الإسلام (IslamHouse).
class GatewayLibraryScreen extends ConsumerWidget {
  final String categoryId;
  const GatewayLibraryScreen({super.key, required this.categoryId});

  static const _typeIcons = {
    'books': Icons.menu_book_outlined,
    'articles': Icons.article_outlined,
    'audios': Icons.headphones_outlined,
    'videos': Icons.play_circle_outline,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(timeThemeProvider);
    final lang = ref.watch(localeProvider).languageCode;
    final isAr = lang == 'ar';
    final t = AppLocalizations.of(context);
    final itemsAsync = ref.watch(libraryItemsProvider(categoryId));

    return AppScaffold(
      title: t.gateway_library_title,
      showBack: true,
      child: itemsAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: palette.accentPrimary),
        ),
        error: (e, _) => _ErrorView(palette: palette, isAr: isAr),
        data: (items) {
          if (items.isEmpty) {
            return _ErrorView(palette: palette, isAr: isAr, empty: true);
          }
          return Directionality(
            textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(SirajSpacing.s3),
                  margin: const EdgeInsets.only(bottom: SirajSpacing.s3),
                  decoration: BoxDecoration(
                    color: palette.accentPrimary.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(SirajRadiusFull.sm),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.verified_outlined,
                          color: palette.accentPrimary, size: 18),
                      const SizedBox(width: SirajSpacing.s2),
                      Expanded(
                        child: Text(
                          isAr
                              ? 'مصدر موثوق ومُشرَف عليه — دار الإسلام'
                              : 'A trusted, supervised source — IslamHouse',
                          style: AppText.caption.copyWith(
                            color: palette.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(bottom: SirajSpacing.s6),
                    itemCount: items.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: SirajSpacing.s2),
                    itemBuilder: (context, index) {
                      return _LibraryCard(
                        item: items[index],
                        palette: palette,
                        isAr: isAr,
                        icon: _typeIcons[items[index].type] ??
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

class _LibraryCard extends StatelessWidget {
  final LibraryItem item;
  final dynamic palette;
  final bool isAr;
  final IconData icon;

  const _LibraryCard({
    required this.item,
    required this.palette,
    required this.isAr,
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color:
                                palette.accentPrimary.withValues(alpha: 0.12),
                            borderRadius:
                                BorderRadius.circular(SirajRadiusFull.sm),
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
                          style: AppText.caption.copyWith(
                            color: palette.textSecondary,
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.open_in_new,
                            color: palette.textSecondary, size: 16),
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

class _ErrorView extends StatelessWidget {
  final dynamic palette;
  final bool isAr;
  final bool empty;

  const _ErrorView({
    required this.palette,
    required this.isAr,
    this.empty = false,
  });

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
              empty
                  ? (isAr
                      ? 'لا توجد مواد متاحة حالياً بهذه اللغة'
                      : 'No materials available in this language yet')
                  : (isAr
                      ? 'تعذّر الاتصال. تحقّق من الإنترنت وحاول مجدداً'
                      : 'Connection failed. Check your internet and try again'),
              textAlign: TextAlign.center,
              style: AppText.body.copyWith(color: palette.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
