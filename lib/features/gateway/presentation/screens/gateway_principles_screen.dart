import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/gateway_provider.dart';

/// الطبقة 2: قائمة مبادئ الإسلام (7 مواضيع مرتّبة تربوياً).
class GatewayPrinciplesScreen extends ConsumerWidget {
  const GatewayPrinciplesScreen({super.key});

  static const _icons = {
    'favorite_outline': Icons.favorite_outline,
    'record_voice_over_outlined': Icons.record_voice_over_outlined,
    'water_drop_outlined': Icons.water_drop_outlined,
    'self_improvement': Icons.self_improvement,
    'nightlight_outlined': Icons.nightlight_outlined,
    'volunteer_activism_outlined': Icons.volunteer_activism_outlined,
    'hexagon_outlined': Icons.hexagon_outlined,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(timeThemeProvider);
    final lang = ref.watch(localeProvider).languageCode;
    final isAr = lang == 'ar';
    final t = AppLocalizations.of(context);
    final topicsAsync = ref.watch(gatewayPrinciplesProvider);

    return AppScaffold(
      title: t.gateway_principles_title,
      showBack: true,
      child: topicsAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: palette.accentPrimary),
        ),
        error: (e, _) => Center(
          child: Text(
            isAr ? 'تعذّر التحميل' : 'Could not load',
            style: AppText.body.copyWith(color: palette.textPrimary),
          ),
        ),
        data: (topics) => Directionality(
          textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: SirajSpacing.s6),
            itemCount: topics.length + 1,
            separatorBuilder: (_, _) =>
                const SizedBox(height: SirajSpacing.s3),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: SirajSpacing.s2),
                  child: Text(
                    isAr
                        ? 'خطوةً بخطوة، تتعلّم أساسيات دينك الجديد. لا استعجال — تقدّم على راحتك.'
                        : 'Step by step, you learn the foundations of your new faith. No rush — proceed at your ease.',
                    style: AppText.body.copyWith(
                      color: palette.textSecondary,
                      height: 1.7,
                    ),
                  ),
                );
              }
              final topic = topics[index - 1];
              return GestureDetector(
                onTap: () => context.push('/gateway/principles/${topic.id}'),
                child: Container(
                  padding: const EdgeInsets.all(SirajSpacing.s4),
                  decoration: BoxDecoration(
                    color: palette.surface,
                    borderRadius: BorderRadius.circular(SirajRadiusFull.lg),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:
                              palette.accentPrimary.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${topic.order}',
                          style: AppText.body.copyWith(
                            color: palette.accentPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: SirajSpacing.s3),
                      Icon(
                        _icons[topic.icon] ?? Icons.circle_outlined,
                        color: palette.accentPrimary,
                        size: 22,
                      ),
                      const SizedBox(width: SirajSpacing.s3),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              topic.titleFor(lang),
                              style: AppText.body.copyWith(
                                color: palette.textPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              topic.summaryFor(lang),
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
      ),
    );
  }
}
