import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../domain/entities/athkar_entity.dart';
import '../providers/athkar_provider.dart';
import '../../../../core/locale/locale_provider.dart';

/// تعرض قائمة أبواب: إمّا أبواب مجموعة معيّنة، أو كل الأبواب
class AthkarCategoriesScreen extends ConsumerWidget {
  final String? groupId; // null = جميع الأقسام
  final String title;

  const AthkarCategoriesScreen({
    super.key,
    this.groupId,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t       = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);
    final lang    = ref.watch(localeProvider).languageCode;

    final AsyncValue<List<AthkarCategory>> catsAsync = groupId == null
        ? ref.watch(athkarCategoriesProvider)
        : ref.watch(athkarCategoriesInGroupProvider(groupId!));

    return AppScaffold(
      title: title,
      showBack: true,
      child: catsAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: palette.accentPrimary)),
        error: (e, _) => Center(
          child: Text(t.common_error, style: AppText.body.copyWith(
            color: palette.textPrimary))),
        data: (cats) => ListView.separated(
          itemCount: cats.length,
          separatorBuilder: (_, __) => const SizedBox(height: SirajSpacing.s2),
          itemBuilder: (context, index) {
            final cat = cats[index];
            return GestureDetector(
              onTap: () => context.push(
                '/athkar/category/${cat.id}?name=${Uri.encodeComponent(cat.nameFor(lang))}'),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SirajSpacing.s4, vertical: SirajSpacing.s4),
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: BorderRadius.circular(SirajRadiusFull.md),
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    children: [
                      Icon(Icons.circle,
                        color: palette.accentPrimary.withValues(alpha: 0.4),
                        size: 8),
                      const SizedBox(width: SirajSpacing.s3),
                      Expanded(
                        child: Text(cat.nameFor(lang),
                          style: AppText.body.copyWith(
                            color: palette.textPrimary,
                            fontWeight: FontWeight.w500)),
                      ),
                      Icon(Icons.chevron_left,
                        color: palette.textSecondary, size: 20),
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
