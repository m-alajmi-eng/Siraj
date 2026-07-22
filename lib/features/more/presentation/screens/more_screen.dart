import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/mode/app_mode_provider.dart';
import '../../../../core/mode/enabled_sections_provider.dart';
import '../../../../core/mode/feature_flags.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';

/// "المزيد" مُقسَّمة لثلاث مجموعات معنونة بدل قائمة مسطّحة بلا ترتيب
/// (ADR-008): أدوات الصلاة / محتوى / التطبيق.
class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t     = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);
    final mode  = ref.watch(appModeProvider);
    final enabled = ref.watch(enabledSectionsProvider);
    final flags = FeatureFlags(mode, enabledSections: enabled);

    return AppScaffold(
      title: t.more_title,
      showBack: false,
      padding: EdgeInsets.zero,
      child: ListView(
        padding: const EdgeInsets.all(SirajSpacing.s4),
        children: [
          _MoreGroup(
            title: t.more_groupPrayerTools,
            palette: palette,
            children: [
              if (flags.showQibla)
                _MoreTile(icon: Icons.explore, label: t.more_qibla,
                  onTap: () => context.push('/more/qibla')),
              if (flags.showCalendar)
                _MoreTile(icon: Icons.calendar_month, label: t.more_calendar,
                  onTap: () => context.push('/more/calendar')),
              if (flags.showMosques)
                _MoreTile(icon: Icons.mosque, label: t.more_mosques,
                  onTap: () => context.push('/more/mosques')),
              _MoreTile(icon: Icons.bar_chart, label: t.more_stats,
                onTap: () => context.push('/more/stats')),
            ],
          ),
          _MoreGroup(
            title: t.more_groupContent,
            palette: palette,
            children: [
              if (flags.showAthkar)
                _MoreTile(icon: Icons.self_improvement, label: t.nav_athkar,
                  onTap: () => context.push('/athkar')),
              if (flags.showLibrary)
                _MoreTile(icon: Icons.local_library, label: t.nav_library,
                  onTap: () => context.push('/library')),
              if (flags.showRadio)
                _MoreTile(icon: Icons.radio, label: t.more_radio,
                  onTap: () => context.push('/more/radio')),
              if (flags.showShareCards)
                _MoreTile(icon: Icons.card_giftcard, label: t.more_shareCards,
                  onTap: () => context.push('/more/share', extra: {
                    'title':    'آية كريمة',
                    'subtitle': 'سورة البقرة',
                    'content':  'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                    'type':     'quran',
                  })),
              if (flags.showKhatmah)
                _MoreTile(icon: Icons.menu_book, label: t.khatmah_title,
                  onTap: () => context.push('/khatmah')),
              if (flags.showStories)
                _MoreTile(icon: Icons.auto_stories, label: t.home_stories,
                  onTap: () => context.push('/more/stories')),
              if (flags.showChildrenStories)
                _MoreTile(icon: Icons.child_care, label: t.home_children,
                  onTap: () => context.push('/more/children_stories')),
              if (flags.showGateway)
                _MoreTile(icon: Icons.mosque_outlined, label: t.gateway_entry_title,
                  onTap: () => context.push('/gateway')),
            ],
          ),
          _MoreGroup(
            title: t.settings_secApp,
            palette: palette,
            children: [
              _MoreTile(icon: Icons.search, label: t.more_search,
                onTap: () => context.push('/more/search')),
              _MoreTile(icon: Icons.settings, label: t.more_settings,
                onTap: () => context.push('/more/settings')),
            ],
          ),
        ],
      ),
    );
  }
}

/// مجموعة معنونة: عنوان صغير بلون التمييز فوق بطاقة زجاجية تجمّع صفوفها
/// — نفس نمط `_SettingsGroup` في settings_screen.dart لاتّساق بصري.
class _MoreGroup extends StatelessWidget {
  final String title;
  final dynamic palette;
  final List<Widget> children;

  const _MoreGroup({
    required this.title,
    required this.palette,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: SirajSpacing.s5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.only(
              start: SirajSpacing.s1, bottom: SirajSpacing.s2),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(title, style: AppText.bodySmall.copyWith(
                color: palette.accentPrimary,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.2,
              )),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: palette.surface,
              borderRadius: BorderRadius.circular(SirajRadiusFull.lg),
              border: Border.all(
                color: palette.accentPrimary.withValues(alpha: 0.10), width: 1),
              boxShadow: SirajElevation.e2,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s4),
              child: Column(
                children: [
                  for (var i = 0; i < children.length; i++) ...[
                    children[i],
                    if (i != children.length - 1)
                      Divider(
                        height: 1,
                        color: palette.textSecondary.withValues(alpha: 0.10)),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MoreTile extends StatelessWidget {
  final IconData     icon;
  final String       label;
  final VoidCallback onTap;

  const _MoreTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading:        Icon(icon),
      title:          Text(label, textAlign: TextAlign.right),
      trailing:       const Icon(Icons.chevron_left),
      onTap:          onTap,
    );
  }
}
