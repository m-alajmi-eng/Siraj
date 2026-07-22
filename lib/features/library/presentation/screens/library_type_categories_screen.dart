import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../providers/library_section_provider.dart';
import '../providers/library_items_provider.dart';
import '../../../../l10n/app_localizations.dart';

/// المستوى 3: تصنيفات فرعية لقسم، ضمن نوع محتوى محدّد (كتب/صوت/فيديو/مقالات).
class LibraryTypeCategoriesScreen extends ConsumerStatefulWidget {
  final String sectionId;
  final String blockType;
  const LibraryTypeCategoriesScreen({
    super.key,
    required this.sectionId,
    required this.blockType,
  });

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
  ConsumerState<LibraryTypeCategoriesScreen> createState() =>
      _LibraryTypeCategoriesScreenState();
}

class _LibraryTypeCategoriesScreenState
    extends ConsumerState<LibraryTypeCategoriesScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final sectionId = widget.sectionId;
    final blockType = widget.blockType;
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
        child: Center(child: Text(t.library_could_not_load,
            style: AppText.body.copyWith(color: palette.textPrimary))),
      ),
      data: (section) {
        if (section == null) {
          return AppScaffold(
            title: '', showBack: true,
            child: Center(child: Text(t.library_not_found,
                style: AppText.body.copyWith(color: palette.textPrimary))),
          );
        }
        final subsAsync = ref.watch(subCategoriesProvider(section.islamhouseCategory));
        final label = LibraryTypeCategoriesScreen.labelFor(blockType, t);
        return AppScaffold(
          title: label,
          showBack: true,
          child: subsAsync.when(
            loading: () => Center(child: CircularProgressIndicator(color: palette.accentPrimary)),
            error: (e, _) => _EmptyView(isAr: isAr, palette: palette, t: t),
            data: (subs) {
              if (subs.isEmpty) {
                return _EmptyView(isAr: isAr, palette: palette, t: t);
              }
              // نُخفي مجلداً فرعياً فقط بعد تأكيد فعلي (شبكي) أن عدد
              // عناصره لنوع المحتوى الحالي تحديداً صفر — لا حجب لعرض
              // القائمة بانتظار هذا التأكيد؛ كل مجلد يظهر فوراً ويختفي
              // لاحقاً فقط إن ثبت فراغه (fail-open أثناء التحميل/الفشل).
              final visibleSubs = subs.where((s) {
                final itemsAsync = ref.watch(librarySectionItemsProvider(
                    LibraryItemsParams(categoryId: s.id, type: blockType)));
                return itemsAsync.maybeWhen(
                  data: (items) => items.isNotEmpty,
                  orElse: () => true,
                );
              }).toList();
              if (visibleSubs.isEmpty) {
                return _EmptyView(isAr: isAr, palette: palette, t: t);
              }
              final filtered = _query.trim().isEmpty
                  ? visibleSubs
                  : visibleSubs.where((s) =>
                      s.title.toLowerCase().contains(_query.trim().toLowerCase())
                  ).toList();
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
                          hintText: t.library_search_in_section,
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
                    // تسمية صريحة "X مجلدات" — مختلفة عمداً عن بادج
                    // إجمالي المحتوى في الشاشة السابقة (شاشة اختيار نوع
                    // المحتوى)، حتى لا يظنّ المستخدم أنه نفس نوع العدّ:
                    // هذا عدد المجلدات الظاهرة هنا فعلياً، لا إجمالي
                    // العناصر داخلها كلها.
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        start: SirajSpacing.s4, end: SirajSpacing.s4,
                        bottom: SirajSpacing.s2,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          t.library_subcategoryCount(visibleSubs.length),
                          style: AppText.caption.copyWith(
                            color: palette.textSecondary),
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
                    final sub = filtered[index];
                    return GestureDetector(
                      onTap: () => context.push(
                        '/library/items/${sub.id}?type=$blockType',
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(SirajSpacing.s4),
                        decoration: BoxDecoration(
                          color: palette.surface,
                          borderRadius: BorderRadius.circular(SirajRadiusFull.md),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.folder_outlined, color: palette.accentPrimary, size: 22),
                            const SizedBox(width: SirajSpacing.s3),
                            Expanded(
                              child: Text(
                                sub.title,
                                style: AppText.body.copyWith(
                                  color: palette.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
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
              ),
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
              t.library_no_categories,
              textAlign: TextAlign.center,
              style: AppText.body.copyWith(color: palette.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
