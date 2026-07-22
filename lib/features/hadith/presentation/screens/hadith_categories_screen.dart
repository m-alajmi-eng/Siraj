import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/hadith_provider.dart';

/// شاشة فئات الأحاديث - المدخل الرئيسي لقسم الأحاديث.
/// يعرض الفئات الموضوعية السبع (القرآن وعلومه، العقيدة، الفقه...)
/// من مصدر HadeethEnc.com (islamhouse-dev)، موثّق ومُراجَع علمياً.
class HadithCategoriesScreen extends ConsumerWidget {
  const HadithCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(timeThemeProvider);
    final t = AppLocalizations.of(context);
    final categoriesAsync = ref.watch(hadithCategoriesProvider);

    return AppScaffold(
      title: t.hadith_title,
      padding: EdgeInsets.zero,
      child: categoriesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text(t.hadith_loadError,
              style: TextStyle(color: palette.textSecondary)),
        ),
        data: (categories) => ListView.builder(
          padding: const EdgeInsets.all(SirajSpacing.s4),
          itemCount: categories.length,
          itemBuilder: (context, i) {
            final cat = categories[i];
            return GestureDetector(
              onTap: () => context.push('/library/hadith/${cat.id}',
                  extra: cat.titleAr),
              child: Container(
                margin: const EdgeInsets.only(bottom: SirajSpacing.s3),
                padding: const EdgeInsets.all(SirajSpacing.s4),
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: BorderRadius.circular(SirajRadiusFull.md),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.chevron_left, color: palette.textSecondary),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(cat.titleAr,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: AppText.body.copyWith(
                                  color: palette.textPrimary,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          Text('${cat.hadeethsCount} حديث',
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: AppText.caption
                                  .copyWith(color: palette.textSecondary)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
