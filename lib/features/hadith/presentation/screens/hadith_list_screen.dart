import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../core/widgets/glass_card.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../qke/presentation/screens/verse_portal_screen.dart';
import '../../data/hadith_repository.dart';
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
    final readIds = ref.watch(hadithReadIdsProvider);

    return AppScaffold(
      title: categoryTitle,
      padding: EdgeInsets.zero,
      child: hadithsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text(
            t.hadith_loadError,
            style: TextStyle(color: palette.textSecondary),
          ),
        ),
        data: (hadiths) {
          final readCount = hadiths.where((h) => readIds.contains(h.id)).length;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  SirajSpacing.s4,
                  SirajSpacing.s3,
                  SirajSpacing.s4,
                  SirajSpacing.s1,
                ),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    t.hadith_readProgress(readCount, hadiths.length),
                    style: AppText.caption.copyWith(
                      color: palette.textSecondary,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(SirajSpacing.s4),
                  itemCount: hadiths.length,
                  itemBuilder: (context, i) {
                    final h = hadiths[i];
                    final isRead = readIds.contains(h.id);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: SirajSpacing.s3),
                      child: Opacity(
                        opacity: isRead ? 0.75 : 1.0,
                        child: GlassCard(
                          radius: SirajRadiusFull.md,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Theme(
                              data: Theme.of(
                                context,
                              ).copyWith(dividerColor: Colors.transparent),
                              child: ExpansionTile(
                                onExpansionChanged: (expanded) {
                                  if (expanded) {
                                    ref
                                        .read(hadithReadIdsProvider.notifier)
                                        .markRead(h.id);
                                  }
                                },
                                title: Row(
                                  children: [
                                    if (isRead) ...[
                                      Icon(
                                        Icons.check_circle,
                                        color: palette.accentPrimary,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 6),
                                    ],
                                    Expanded(
                                      child: Text(
                                        h.title,
                                        style: AppText.body.copyWith(
                                          color: isRead
                                              ? palette.textSecondary
                                              : palette.textPrimary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: h.grade != null && h.grade!.isNotEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 4),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.green.withValues(
                                              alpha: 0.1,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          child: Text(
                                            h.grade!,
                                            style: TextStyle(
                                              color: Colors.green.shade700,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      )
                                    : null,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      16,
                                      0,
                                      16,
                                      16,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        // ١. المتن - النص الحرفي الكامل، أوضح مساحة
                                        Text(
                                          h.textAr,
                                          style: TextStyle(
                                            color: palette.textPrimary,
                                            fontSize: 15,
                                            height: 1.8,
                                          ),
                                        ),
                                        if (h.narrator != null &&
                                            h.narrator!.isNotEmpty) ...[
                                          const SizedBox(height: 10),
                                          Text(
                                            h.narrator!,
                                            style: TextStyle(
                                              color: palette.textSecondary,
                                              fontSize: 12,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                        ],
                                        // ٢. الدرجة/الحكم - قسم منفصل بصرياً
                                        _GradeSection(
                                          hadith: h,
                                          palette: palette,
                                        ),
                                        // ٣+٤. الشرح المبسَّط + المراجع تحته
                                        _ExplanationSection(
                                          hadith: h,
                                          palette: palette,
                                        ),
                                        // ٥. رابط الآية المرتبطة (إن وُجد)
                                        if (h.linkedAyah != null) ...[
                                          const SizedBox(
                                            height: SirajSpacing.s3,
                                          ),
                                          Divider(
                                            height: 1,
                                            color: palette.textSecondary
                                                .withValues(alpha: 0.15),
                                          ),
                                          const SizedBox(
                                            height: SirajSpacing.s3,
                                          ),
                                          _AyahLinkChip(
                                            link: h.linkedAyah!,
                                            palette: palette,
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// قسم الدرجة/الحكم - كل عالِم بسطر مستقل بنفس الوزن البصري بلا ترجيح
/// بينهم (عمود grades). لبخاري/مسلم (بلا grades بقرار متعمَّد سابق)
/// شارة ببليوغرافية بحتة باسم الكتاب - تسمية لا حكم مخترَع.
class _GradeSection extends StatelessWidget {
  final Hadith hadith;
  final SirajPalette palette;

  const _GradeSection({required this.hadith, required this.palette});

  @override
  Widget build(BuildContext context) {
    final grades = hadith.grades;
    final hasGrades = grades != null && grades.isNotEmpty;
    final sahihaynName = !hasGrades ? sahihaynBookNames[hadith.bookId] : null;

    if (!hasGrades && sahihaynName == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: SirajSpacing.s3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Divider(
            height: 1,
            color: palette.textSecondary.withValues(alpha: 0.15),
          ),
          const SizedBox(height: SirajSpacing.s3),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(SirajSpacing.s3),
            decoration: BoxDecoration(
              color: palette.accentPrimary.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(SirajRadiusFull.sm),
              border: Border.all(
                color: palette.accentPrimary.withValues(alpha: 0.15),
              ),
            ),
            child: hasGrades
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (final g in grades)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                g.gradeAr,
                                style: TextStyle(
                                  color: palette.textPrimary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              if (g.scholar != null)
                                Flexible(
                                  child: Text(
                                    g.scholar!,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      color: palette.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                    ],
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified,
                        size: 14,
                        color: palette.accentPrimary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        sahihaynName!,
                        style: TextStyle(
                          color: palette.accentPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

/// قسم الشرح المبسَّط (معنون بمصدره صراحة) + المراجع الحقيقية تحته -
/// يعطي الشرح سنداً موثقاً بدل أن يبدو معلَّقاً بلا مصدر.
class _ExplanationSection extends StatelessWidget {
  final Hadith hadith;
  final SirajPalette palette;

  const _ExplanationSection({required this.hadith, required this.palette});

  @override
  Widget build(BuildContext context) {
    final explanation = hadith.explanation;
    if (explanation == null || explanation.isEmpty) {
      return const SizedBox.shrink();
    }
    final references = hadith.references;

    return Padding(
      padding: const EdgeInsets.only(top: SirajSpacing.s3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Divider(
            height: 1,
            color: palette.textSecondary.withValues(alpha: 0.15),
          ),
          const SizedBox(height: SirajSpacing.s3),
          Text(
            'شرح مبسَّط من موسوعة الحديث (HadeethEnc.com)',
            style: AppText.caption.copyWith(
              color: palette.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            explanation,
            style: TextStyle(
              color: palette.textSecondary,
              fontSize: 13,
              height: 1.6,
            ),
          ),
          if (references != null && references.isNotEmpty) ...[
            const SizedBox(height: SirajSpacing.s3),
            Text(
              'المراجع',
              style: AppText.caption.copyWith(
                color: palette.textSecondary,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            for (final r in references)
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Text(
                  '• $r',
                  style: TextStyle(
                    color: palette.textSecondary,
                    fontSize: 11,
                    height: 1.5,
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

/// شارة قابلة للنقر تنقل مباشرة لموضع الآية المرتبطة بالمصحف.
class _AyahLinkChip extends StatelessWidget {
  final AyahLink link;
  final SirajPalette palette;

  const _AyahLinkChip({required this.link, required this.palette});

  static String _truncate(String s, [int max = 50]) {
    final trimmed = s.trim();
    if (trimmed.length <= max) return trimmed;
    return '${trimmed.substring(0, max)}…';
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(SirajRadiusFull.sm),
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: SirajMotion.normal,
            pageBuilder: (_, _, _) => VersePortalScreen(
              surahId: link.surahId,
              ayahNumber: link.ayahNumber,
            ),
            transitionsBuilder: (_, animation, _, child) =>
                FadeTransition(opacity: animation, child: child),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: palette.accentPrimary.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(SirajRadiusFull.sm),
        ),
        child: Row(
          children: [
            Icon(
              Icons.menu_book_outlined,
              size: 14,
              color: palette.accentPrimary,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                'مرتبط بآية: ${link.surahName} ${link.ayahNumber} - '
                '${_truncate(link.ayahText)}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: palette.accentPrimary, fontSize: 12),
              ),
            ),
            Icon(Icons.chevron_left, size: 16, color: palette.accentPrimary),
          ],
        ),
      ),
    );
  }
}
