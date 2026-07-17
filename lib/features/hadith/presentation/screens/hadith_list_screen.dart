import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/hadith_provider.dart';

/// شاشة أحاديث فئة واحدة - قائمة قابلة للتوسيع، كل بطاقة تعرض
/// العنوان دائماً، والنص الكامل + الدرجة + الشرح عند الضغط.
class HadithListScreen extends ConsumerWidget {
  final int categoryId;
  final String categoryTitle;

  const HadithListScreen({
    super.key,
    required this.categoryId,
    required this.categoryTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(timeThemeProvider);
    final t = AppLocalizations.of(context);
    final hadithsAsync = ref.watch(hadithsByCategoryProvider(categoryId));

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        backgroundColor: palette.background,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: palette.textPrimary),
          tooltip: t.common_back,
          onPressed: () => context.pop(),
        ),
        title: Text(categoryTitle,
            style: AppText.headline.copyWith(
                color: palette.textPrimary, fontSize: 18)),
      ),
      body: hadithsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text('حدث خطأ في تحميل الأحاديث',
              style: TextStyle(color: palette.textSecondary)),
        ),
        data: (hadiths) => ListView.builder(
          padding: const EdgeInsets.all(SirajSpacing.s4),
          itemCount: hadiths.length,
          itemBuilder: (context, i) {
            final h = hadiths[i];
            return Container(
              margin: const EdgeInsets.only(bottom: SirajSpacing.s3),
              decoration: BoxDecoration(
                color: palette.surface,
                borderRadius: BorderRadius.circular(SirajRadiusFull.md),
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text(h.title,
                        style: AppText.body.copyWith(
                            color: palette.textPrimary,
                            fontWeight: FontWeight.w600)),
                    subtitle: h.grade != null && h.grade!.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.green.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(h.grade!,
                                  style: TextStyle(
                                      color: Colors.green.shade700,
                                      fontSize: 11)),
                            ),
                          )
                        : null,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(h.textAr,
                                style: TextStyle(
                                    color: palette.textPrimary,
                                    fontSize: 15,
                                    height: 1.8)),
                            if (h.narrator != null &&
                                h.narrator!.isNotEmpty) ...[
                              const SizedBox(height: 10),
                              Text(h.narrator!,
                                  style: TextStyle(
                                      color: palette.textSecondary,
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic)),
                            ],
                            if (h.explanation != null &&
                                h.explanation!.isNotEmpty) ...[
                              const SizedBox(height: 12),
                              Text('الشرح:',
                                  style: AppText.caption.copyWith(
                                      color: palette.textPrimary,
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Text(h.explanation!,
                                  style: TextStyle(
                                      color: palette.textSecondary,
                                      fontSize: 13,
                                      height: 1.6)),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
