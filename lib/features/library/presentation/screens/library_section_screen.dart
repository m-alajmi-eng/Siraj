import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../providers/library_section_provider.dart';
import '../providers/category_types_provider.dart';
import '../../../../l10n/app_localizations.dart';

/// شاشة قسم واحد: تعرض أنواع المحتوى المتوفرة فعلياً (كتب/صوت/فيديو/مقالات)
/// بأعداد حقيقية من IslamHouse — تصفح مُرتّب قبل التصنيفات الفرعية.
class LibrarySectionScreen extends ConsumerStatefulWidget {
  final String sectionId;
  const LibrarySectionScreen({super.key, required this.sectionId});

  static const _typeInfo = {
    'books':    (Icons.menu_book_outlined,      'books'),
    'audios':   (Icons.headphones_outlined,     'audios'),
    'videos':   (Icons.play_circle_outline,     'videos'),
    'articles': (Icons.article_outlined,        'articles'),
  };

  static String labelFor(String blockName, AppLocalizations t) {
    switch (blockName) {
      case 'books': return t.library_type_books;
      case 'audios': return t.library_type_audios;
      case 'videos': return t.library_type_videos;
      case 'articles': return t.library_type_articles;
      default: return blockName;
    }
  }

  @override
  ConsumerState<LibrarySectionScreen> createState() => _LibrarySectionScreenState();
}

class _LibrarySectionScreenState extends ConsumerState<LibrarySectionScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final sectionId = widget.sectionId;
    final t = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);
    final lang = ref.watch(localeProvider).languageCode;
    final isAr = lang == 'ar';
    final sectionAsync = ref.watch(librarySectionProvider(sectionId));

    return sectionAsync.when(
      loading: () => AppScaffold(
        title: '', showBack: true,
        child: Center(child: CircularProgressIndicator(color: palette.accentPrimary)),
      ),
      error: (e, _) => AppScaffold(
        title: '', showBack: true,
        child: Center(
          child: Text(t.library_could_not_load,
              style: AppText.body.copyWith(color: palette.textPrimary)),
        ),
      ),
      data: (section) {
        if (section == null) {
          return AppScaffold(
            title: '', showBack: true,
            child: Center(
              child: Text(t.library_section_not_found,
                  style: AppText.body.copyWith(color: palette.textPrimary)),
            ),
          );
        }
        final typesAsync = ref.watch(categoryTypesProvider(section.islamhouseCategory));
        return AppScaffold(
          title: section.titleFor(lang),
          showBack: true,
          child: typesAsync.when(
            loading: () => Center(child: CircularProgressIndicator(color: palette.accentPrimary)),
            error: (e, _) => _EmptyView(isAr: isAr, palette: palette, t: t),
            data: (types) {
              if (types.isEmpty) {
                return _EmptyView(isAr: isAr, palette: palette, t: t);
              }
              final filteredTypes = _query.trim().isEmpty
                  ? types
                  : types.where((ct) {
           final label = LibrarySectionScreen.labelFor(ct.blockName, t);
           return label.toLowerCase().contains(_query.trim().toLowerCase());
         }).toList();
              return Directionality(
                textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
                child: ListView(
                  padding: const EdgeInsets.all(SirajSpacing.s4),
                  children: [
                    TextField(
                      onChanged: (v) => setState(() => _query = v),
                      style: AppText.body.copyWith(color: palette.textPrimary),
                      decoration: InputDecoration(
                        hintText: t.library_search_content_type,
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
                    const SizedBox(height: SirajSpacing.s4),
                    Text(
                      t.library_choose_content_type,
                      style: AppText.body.copyWith(
                        color: palette.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: SirajSpacing.s3),
                    if (filteredTypes.isEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: SirajSpacing.s6),
                        child: Center(
                          child: Text(
                            t.library_no_matching_results,
                            style: AppText.body.copyWith(color: palette.textSecondary),
                          ),
                        ),
                      ),
                    ...filteredTypes.map((ct) {
           final info = LibrarySectionScreen._typeInfo[ct.blockName];
           if (info == null) return const SizedBox.shrink();
           final label = LibrarySectionScreen.labelFor(ct.blockName, t);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: SirajSpacing.s2),
                        child: GestureDetector(
                          onTap: () => context.push(
                            '/library/${section.id}/${ct.blockName}',
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(SirajSpacing.s4),
                            decoration: BoxDecoration(
                              color: palette.surface,
                              borderRadius: BorderRadius.circular(SirajRadiusFull.md),
                            ),
                            child: Row(
                              children: [
                                Icon(info.$1, color: palette.accentPrimary, size: 24),
                                const SizedBox(width: SirajSpacing.s3),
                                Expanded(
                                  child: Text(
                                    label,
                                    style: AppText.body.copyWith(
                                      color: palette.textPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: palette.accentPrimary.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(SirajRadiusFull.pill),
                                  ),
                                  child: Text(
                                    '${ct.itemsCount}',
                                    style: AppText.caption.copyWith(
                                      color: palette.accentPrimary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: SirajSpacing.s2),
                                Icon(
                                  isAr ? Icons.chevron_left : Icons.chevron_right,
                                  color: palette.textSecondary,
                                  size: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _EmptyView extends StatelessWidget {
  final bool isAr;
  final dynamic palette;
  final AppLocalizations t;
  const _EmptyView({required this.isAr, required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SirajSpacing.s6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inbox_outlined, color: palette.textSecondary, size: 48),
            const SizedBox(height: SirajSpacing.s4),
            Text(
              t.library_no_content_lang,
              textAlign: TextAlign.center,
              style: AppText.body.copyWith(color: palette.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
