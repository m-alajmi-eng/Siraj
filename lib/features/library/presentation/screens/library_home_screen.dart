import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/library_section_provider.dart';
import '../providers/category_types_provider.dart';

/// الشاشة الرئيسية للمكتبة الشاملة: 7 أقسام رئيسية كبطاقات.
class LibraryHomeScreen extends ConsumerWidget {
  const LibraryHomeScreen({super.key});

  static const _icons = {
    'menu_book_outlined': Icons.menu_book_outlined,
    'auto_awesome_outlined': Icons.auto_awesome_outlined,
    'balance_outlined': Icons.balance_outlined,
    'person_outline': Icons.person_outline,
    'menu_book': Icons.menu_book,
    'record_voice_over_outlined': Icons.record_voice_over_outlined,
    'favorite_border': Icons.favorite_border,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);
    final lang = ref.watch(localeProvider).languageCode;
    final isAr = lang == 'ar';
    final sectionsAsync = ref.watch(librarySectionsProvider);

    return AppScaffold(
      title: t.library_title,
      showBack: false,
      child: sectionsAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: palette.accentPrimary),
        ),
        error: (e, _) => Center(
          child: Text(
            t.library_could_not_load,
            style: AppText.body.copyWith(color: palette.textPrimary),
          ),
        ),
        data: (sections) {
          // نُخفي قسماً فقط بعد تأكيد فعلي (شبكي) أن لا محتوى فيه إطلاقاً
          // عبر أنواعه الأربعة — لا حجب لعرض الشبكة بانتظار هذا التأكيد
          // (الأقسام كلها محلية وتُرسَم فوراً)؛ كل قسم يظهر منذ اللحظة
          // الأولى ويختفي لاحقاً فقط إن ثبت فراغه (fail-open أثناء
          // التحميل/الفشل، إذ لا دليل كافٍ لإخفائه في تلك الحالة).
          final visibleSections = sections.where((s) {
            final typesAsync =
                ref.watch(categoryTypesProvider(s.islamhouseCategory));
            return typesAsync.maybeWhen(
              data: (types) => types.isNotEmpty,
              orElse: () => true,
            );
          }).toList();

          return Directionality(
          textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
          child: GridView.builder(
            padding: const EdgeInsets.all(SirajSpacing.s4),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: SirajSpacing.s3,
              mainAxisSpacing: SirajSpacing.s3,
              childAspectRatio: 0.95,
            ),
            // +1 لبطاقة "المؤلفون" الثامنة - قسم ثابت لا يأتي من
            // library_sections.json (يقرأ من public.library_authors المحصود،
            // لا من تصنيف IslamHouse مباشر)، فتُضاف يدوياً بعد الأقسام السبعة.
            itemCount: visibleSections.length + 1,
            itemBuilder: (context, index) {
              if (index == visibleSections.length) {
                return GestureDetector(
                  onTap: () => context.push('/library/authors'),
                  child: Container(
                    padding: const EdgeInsets.all(SirajSpacing.s4),
                    decoration: BoxDecoration(
                      color: palette.surface,
                      borderRadius: BorderRadius.circular(SirajRadiusFull.lg),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: palette.accentPrimary,
                          size: 32,
                        ),
                        const SizedBox(height: SirajSpacing.s3),
                        Text(
                          t.library_authorsSection,
                          style: AppText.body.copyWith(
                            color: palette.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
              final section = visibleSections[index];
              return GestureDetector(
                onTap: () => context.push('/library/${section.id}'),
                child: Container(
                  padding: const EdgeInsets.all(SirajSpacing.s4),
                  decoration: BoxDecoration(
                    color: palette.surface,
                    borderRadius: BorderRadius.circular(SirajRadiusFull.lg),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        _icons[section.icon] ?? Icons.circle_outlined,
                        color: palette.accentPrimary,
                        size: 32,
                      ),
                      const SizedBox(height: SirajSpacing.s3),
                      Text(
                        section.titleFor(lang),
                        style: AppText.body.copyWith(
                          color: palette.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: SirajSpacing.s1),
                      Text(
                        section.descriptionFor(lang),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.caption.copyWith(
                          color: palette.textSecondary,
                          height: 1.4,
                        ),
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
