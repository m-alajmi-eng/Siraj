import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../data/adwaa_bayan_repository.dart';

/// شاشة قراءة كتاب "أضواء البيان في إيضاح القرآن بالقرآن" داخل التطبيق،
/// صفحة بصفحة (نفس ترقيم صفحات شاملة الأصلية)، مصدر داخلي كامل بدل
/// الاعتماد على رابط خارجي.
class AdwaaBayanReaderScreen extends ConsumerWidget {
  final int pageNumber;

  const AdwaaBayanReaderScreen({super.key, required this.pageNumber});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(timeThemeProvider);
    final pageAsync = ref.watch(adwaaBayanPageProvider(pageNumber));

    final canGoPrev = pageNumber > AdwaaBayanRepository.firstPage;
    final canGoNext = pageNumber < AdwaaBayanRepository.lastPage;

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        backgroundColor: palette.background,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: palette.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text('أضواء البيان - صفحة $pageNumber',
            style: AppText.headline.copyWith(
                color: palette.textPrimary, fontSize: 16)),
      ),
      body: pageAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text('تعذّر تحميل الصفحة',
              style: TextStyle(color: palette.textSecondary)),
        ),
        data: (page) => Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    page.pageText,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color:    palette.textPrimary,
                      fontSize: 16,
                      height:   2.0,
                    ),
                  ),
                ),
              ),
            ),
            // ─── شريط التنقّل بين الصفحات ───
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: palette.surface,
                border: Border(top: BorderSide(
                    color: palette.textSecondary.withOpacity(0.1))),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_right,
                        color: canGoPrev
                            ? palette.accentPrimary
                            : palette.textSecondary.withOpacity(0.3)),
                    onPressed: canGoPrev
                        ? () => context.pushReplacement(
                            '/more/adwaa-bayan/${pageNumber - 1}')
                        : null,
                  ),
                  Text('$pageNumber / ${AdwaaBayanRepository.lastPage}',
                      style: TextStyle(
                          color: palette.textSecondary, fontSize: 13)),
                  IconButton(
                    icon: Icon(Icons.chevron_left,
                        color: canGoNext
                            ? palette.accentPrimary
                            : palette.textSecondary.withOpacity(0.3)),
                    onPressed: canGoNext
                        ? () => context.pushReplacement(
                            '/more/adwaa-bayan/${pageNumber + 1}')
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
