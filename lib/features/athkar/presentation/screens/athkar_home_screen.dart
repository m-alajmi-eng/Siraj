import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../providers/athkar_provider.dart';
import '../../../../core/locale/locale_provider.dart';

class AthkarHomeScreen extends ConsumerWidget {
  const AthkarHomeScreen({super.key});

  static const _groupIcons = {
    'sun':    Icons.wb_sunny_outlined,
    'moon':   Icons.bedtime_outlined,
    'water':  Icons.water_drop_outlined,
    'mosque': Icons.mosque_outlined,
    'pray':   Icons.self_improvement,
    'food':   Icons.restaurant_outlined,
    'travel': Icons.travel_explore_outlined,
    'heart':  Icons.favorite_border,
    'health': Icons.healing_outlined,
    'star':   Icons.auto_awesome_outlined,
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t       = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);
    final lang    = ref.watch(localeProvider).languageCode;
    final groups  = ref.watch(athkarGroupsProvider);

    return AppScaffold(
      title: t.athkar_title,
      showBack: false,
      child: groups.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: palette.accentPrimary),
        ),
        error: (e, _) => Center(
          child: Text(t.common_error, style: AppText.body.copyWith(
            color: palette.textPrimary)),
        ),
        data: (grps) => GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:   2,
            crossAxisSpacing: SirajSpacing.s3,
            mainAxisSpacing:  SirajSpacing.s3,
            childAspectRatio: 1.3,
          ),
          // +1 لبطاقة "جميع الأقسام"
          itemCount: grps.length + 1,
          itemBuilder: (context, index) {
            // آخر بطاقة = جميع الأقسام
            if (index == grps.length) {
              return _GroupCard(
                icon:    Icons.grid_view_rounded,
                label:   t.athkar_allSections,
                palette: palette,
                highlight: true,
                onTap: () => context.push('/athkar/all'),
              );
            }
            final g = grps[index];
            return _GroupCard(
              icon:    _groupIcons[g.icon] ?? Icons.star_outline,
              label:   g.nameFor(lang),
              palette: palette,
              onTap: () => context.push('/athkar/group/${g.id}?name=${Uri.encodeComponent(g.nameFor(lang))}'),
            );
          },
        ),
      ),
    );
  }
}

class _GroupCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final dynamic palette;
  final VoidCallback onTap;
  final bool highlight;

  const _GroupCard({
    required this.icon,
    required this.label,
    required this.palette,
    required this.onTap,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: highlight
              ? palette.accentPrimary.withValues(alpha: 0.12)
              : palette.surface,
          borderRadius: BorderRadius.circular(SirajRadiusFull.lg),
          border: highlight
              ? Border.all(color: palette.accentPrimary.withValues(alpha: 0.4))
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: palette.accentPrimary, size: 32),
            const SizedBox(height: SirajSpacing.s2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s2),
              child: Text(label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppText.body.copyWith(
                  color: palette.textPrimary, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
      ),
    );
  }
}
