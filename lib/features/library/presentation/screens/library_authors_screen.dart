import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../providers/library_authors_provider.dart';
import '../../../../l10n/app_localizations.dart';

/// القسم الثامن في المكتبة: مؤلفون محصودون تدريجياً من IslamHouse أثناء
/// التصفّح العادي (لا نداء شبكي مباشر هنا - قراءة من public.library_authors).
class LibraryAuthorsScreen extends ConsumerWidget {
  const LibraryAuthorsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);
    final lang = ref.watch(localeProvider).languageCode;
    final isAr = lang == 'ar';
    final authorsAsync = ref.watch(libraryAuthorsProvider);

    return AppScaffold(
      title: t.library_authorsSection,
      showBack: true,
      child: authorsAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: palette.accentPrimary),
        ),
        error: (e, _) => Center(
          child: Text(
            t.library_could_not_load,
            style: AppText.body.copyWith(color: palette.textPrimary),
          ),
        ),
        data: (authors) {
          if (authors.isEmpty) {
            return Center(
              child: Text(
                t.library_no_categories,
                style: AppText.body.copyWith(color: palette.textSecondary),
              ),
            );
          }
          return Directionality(
            textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
            child: ListView.separated(
              padding: const EdgeInsets.all(SirajSpacing.s4),
              itemCount: authors.length,
              separatorBuilder: (_, _) => const SizedBox(height: SirajSpacing.s2),
              itemBuilder: (context, index) {
                final author = authors[index];
                return GestureDetector(
                  onTap: () => context.push(
                    '/library/authors/${author.authorId}',
                    extra: author.title,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(SirajSpacing.s4),
                    decoration: BoxDecoration(
                      color: palette.surface,
                      borderRadius: BorderRadius.circular(SirajRadiusFull.md),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.person_outline,
                            color: palette.accentPrimary, size: 24),
                        const SizedBox(width: SirajSpacing.s3),
                        Expanded(
                          child: Text(
                            author.title,
                            style: AppText.body.copyWith(
                              color: palette.textPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        if (author.itemsCount != null) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: palette.accentPrimary.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(SirajRadiusFull.pill),
                            ),
                            child: Text(
                              '${author.itemsCount}',
                              style: AppText.caption.copyWith(
                                color: palette.accentPrimary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          const SizedBox(width: SirajSpacing.s2),
                        ],
                        Icon(
                          isAr ? Icons.chevron_left : Icons.chevron_right,
                          color: palette.textSecondary,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
