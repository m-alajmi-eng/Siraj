import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../providers/author_items_provider.dart';
import '../../../../l10n/app_localizations.dart';
import 'library_items_screen.dart' show ContentCard, LibraryErrorView;

/// أعمال مؤلف معيّن (يُفتح من شاشة المؤلفين) — يعيد استخدام ContentCard/
/// LibraryErrorView من LibraryItemsScreen بدل بناء عرض جديد من الصفر.
class AuthorItemsScreen extends ConsumerWidget {
  final String authorId;
  final String authorName;
  const AuthorItemsScreen({
    super.key,
    required this.authorId,
    required this.authorName,
  });

  static const _typeIcons = {
    'books': Icons.menu_book_outlined,
    'articles': Icons.article_outlined,
    'audios': Icons.headphones_outlined,
    'videos': Icons.play_circle_outline,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);
    final lang = ref.watch(localeProvider).languageCode;
    final isAr = lang == 'ar';
    final itemsAsync = ref.watch(authorItemsProvider(authorId));

    return AppScaffold(
      title: authorName,
      showBack: true,
      child: itemsAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: palette.accentPrimary),
        ),
        error: (e, _) => LibraryErrorView(palette: palette, isAr: isAr, t: t),
        data: (items) {
          if (items.isEmpty) {
            return LibraryErrorView(
                palette: palette, isAr: isAr, t: t, empty: true);
          }
          return Directionality(
            textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
            child: ListView.separated(
              padding: const EdgeInsets.all(SirajSpacing.s4),
              itemCount: items.length,
              separatorBuilder: (_, _) => const SizedBox(height: SirajSpacing.s2),
              itemBuilder: (context, index) => ContentCard(
                item: items[index],
                palette: palette,
                icon: _typeIcons[items[index].type] ?? Icons.description_outlined,
              ),
            ),
          );
        },
      ),
    );
  }
}
