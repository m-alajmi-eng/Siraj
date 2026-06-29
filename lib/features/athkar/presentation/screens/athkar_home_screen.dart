import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../providers/athkar_provider.dart';

class AthkarHomeScreen extends ConsumerWidget {
  const AthkarHomeScreen({super.key});

  String _catName(AppLocalizations t, String id, String fallback) {
    switch (id) {
      case 'morning': return t.athkar_morning;
      case 'evening': return t.athkar_evening;
      case 'sleep':   return t.athkar_sleep;
      case 'wake':    return t.athkar_wake;
      case 'prayer':  return t.athkar_prayer;
      case 'general': return t.athkar_general;
      default:        return fallback;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t          = AppLocalizations.of(context);
    final palette    = ref.watch(timeThemeProvider);
    final categories = ref.watch(athkarCategoriesProvider);

    const icons = {
      'morning': Icons.wb_sunny_outlined,
      'evening': Icons.nights_stay_outlined,
      'sleep':   Icons.bedtime_outlined,
      'wake':    Icons.alarm_outlined,
      'prayer':  Icons.mosque_outlined,
      'general': Icons.favorite_border,
    };

    return AppScaffold(
      title: t.athkar_title,
      showBack: false,
      child: categories.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: palette.accentPrimary),
        ),
        error: (e, _) => Center(
          child: Text(t.common_error, style: AppText.body.copyWith(
            color: palette.textPrimary)),
        ),
        data: (cats) => GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:   2,
            crossAxisSpacing: SirajSpacing.s3,
            mainAxisSpacing:  SirajSpacing.s3,
            childAspectRatio: 1.3,
          ),
          itemCount: cats.length,
          itemBuilder: (context, index) {
            final cat = cats[index];
            return GestureDetector(
              onTap: () => context.go('/athkar/${cat.id}?name=${cat.name}'),
              child: Container(
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: BorderRadius.circular(SirajRadiusFull.lg),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icons[cat.id] ?? Icons.star_outline,
                      color: palette.accentPrimary, size: 32),
                    const SizedBox(height: SirajSpacing.s2),
                    Text(_catName(t, cat.id, cat.name),
                      textAlign: TextAlign.center,
                      style: AppText.body.copyWith(
                        color: palette.textPrimary, fontWeight: FontWeight.w500)),
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
