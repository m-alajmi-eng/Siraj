import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../domain/entities/gateway_entity.dart';
import '../providers/gateway_provider.dart';

/// تفصيل موضوع من مبادئ الإسلام: شرح مُبسّط + خطوات + نص تعبّدي + تعمّق.
class GatewayTopicScreen extends ConsumerWidget {
  final String topicId;
  const GatewayTopicScreen({super.key, required this.topicId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(timeThemeProvider);
    final lang = ref.watch(localeProvider).languageCode;
    final isAr = lang == 'ar';
    final topicAsync = ref.watch(gatewayTopicProvider(topicId));

    return AppScaffold(
      title: topicAsync.maybeWhen(
        data: (t) => t?.titleFor(lang) ?? (isAr ? 'موضوع' : 'Topic'),
        orElse: () => isAr ? 'موضوع' : 'Topic',
      ),
      showBack: true,
      child: topicAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: palette.accentPrimary),
        ),
        error: (e, _) => Center(
          child: Text(
            isAr ? 'تعذّر التحميل' : 'Could not load',
            style: AppText.body.copyWith(color: palette.textPrimary),
          ),
        ),
        data: (topic) {
          if (topic == null) {
            return Center(
              child: Text(
                isAr ? 'الموضوع غير موجود' : 'Topic not found',
                style: AppText.body.copyWith(color: palette.textPrimary),
              ),
            );
          }
          return Directionality(
            textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: SirajSpacing.s6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    topic.summaryFor(lang),
                    style: AppText.body.copyWith(
                      color: palette.textPrimary,
                      height: 1.9,
                    ),
                  ),
                  const SizedBox(height: SirajSpacing.s5),
                  if (topic.devotional != null)
                    _DevotionalCard(
                      dev: topic.devotional!,
                      lang: lang,
                      isAr: isAr,
                      palette: palette,
                    ),
                  if (topic.steps.isNotEmpty) ...[
                    const SizedBox(height: SirajSpacing.s2),
                    ...List.generate(topic.steps.length, (i) {
                      return _StepRow(
                        number: i + 1,
                        text: topic.steps[i].textFor(lang),
                        palette: palette,
                      );
                    }),
                  ],
                  if (topic.noteFor(lang).isNotEmpty) ...[
                    const SizedBox(height: SirajSpacing.s4),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(SirajSpacing.s4),
                      decoration: BoxDecoration(
                        color: palette.accentPrimary.withValues(alpha: 0.07),
                        borderRadius:
                            BorderRadius.circular(SirajRadiusFull.md),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.lightbulb_outline,
                              color: palette.accentPrimary, size: 20),
                          const SizedBox(width: SirajSpacing.s3),
                          Expanded(
                            child: Text(
                              topic.noteFor(lang),
                              style: AppText.bodySmall.copyWith(
                                color: palette.textPrimary,
                                height: 1.6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  if (topic.deepLink != null) ...[
                    const SizedBox(height: SirajSpacing.s5),
                    GestureDetector(
                      onTap: () => context.push(
                        '/gateway/library/${topic.deepLink!.islamhouseCategory}',
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(SirajSpacing.s4),
                        decoration: BoxDecoration(
                          color: palette.surface,
                          borderRadius:
                              BorderRadius.circular(SirajRadiusFull.md),
                          border: Border.all(
                            color:
                                palette.textSecondary.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.menu_book_outlined,
                                color: palette.accentPrimary, size: 20),
                            const SizedBox(width: SirajSpacing.s3),
                            Expanded(
                              child: Text(
                                topic.deepLink!.labelFor(lang),
                                style: AppText.bodySmall.copyWith(
                                  color: palette.textPrimary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Icon(
                              isAr
                                  ? Icons.chevron_left
                                  : Icons.chevron_right,
                              color: palette.textSecondary,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _DevotionalCard extends StatelessWidget {
  final DevotionalText dev;
  final String lang;
  final bool isAr;
  final dynamic palette;

  const _DevotionalCard({
    required this.dev,
    required this.lang,
    required this.isAr,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: SirajSpacing.s4),
      padding: const EdgeInsets.all(SirajSpacing.s5),
      decoration: BoxDecoration(
        color: palette.accentPrimary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(SirajRadiusFull.lg),
        border: Border.all(
          color: palette.accentPrimary.withValues(alpha: 0.25),
        ),
      ),
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              dev.arabic,
              textAlign: TextAlign.center,
              style: AppText.quran.copyWith(
                color: palette.textPrimary,
                height: 1.9,
              ),
            ),
          ),
          if (!isAr && dev.transliterationEn.isNotEmpty) ...[
            const SizedBox(height: SirajSpacing.s3),
            Text(
              dev.transliterationEn,
              textAlign: TextAlign.center,
              style: AppText.bodySmall.copyWith(
                color: palette.accentPrimary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
          if (dev.meaningFor(lang).isNotEmpty) ...[
            const SizedBox(height: SirajSpacing.s3),
            Divider(
              color: palette.accentPrimary.withValues(alpha: 0.2),
              height: 1,
            ),
            const SizedBox(height: SirajSpacing.s3),
            Text(
              dev.meaningFor(lang),
              textAlign: isAr ? TextAlign.right : TextAlign.left,
              style: AppText.body.copyWith(
                color: palette.textPrimary,
                height: 1.8,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final int number;
  final String text;
  final dynamic palette;

  const _StepRow({
    required this.number,
    required this.text,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SirajSpacing.s2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: palette.accentPrimary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Text(
              '$number',
              style: AppText.caption.copyWith(
                color: palette.accentPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: SirajSpacing.s3),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                text,
                style: AppText.body.copyWith(
                  color: palette.textPrimary,
                  height: 1.7,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
