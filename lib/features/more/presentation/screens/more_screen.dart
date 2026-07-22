import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/mode/app_mode_provider.dart';
import '../../../../core/mode/enabled_sections_provider.dart';
import '../../../../core/mode/feature_flags.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t     = AppLocalizations.of(context);
    final mode  = ref.watch(appModeProvider);
    final enabled = ref.watch(enabledSectionsProvider);
    final flags = FeatureFlags(mode, enabledSections: enabled);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 16),
            const Text(
              'المزيد',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize:   28,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 24),

            _MoreTile(
              icon:  Icons.search,
              label: t.more_search,
              onTap: () => context.push('/more/search'),
            ),
            _MoreTile(
              icon:  Icons.settings,
              label: t.more_settings,
              onTap: () => context.push('/more/settings'),
            ),
            if (flags.showCalendar)
            _MoreTile(
              icon:  Icons.calendar_month,
              label: t.more_calendar,
              onTap: () => context.push('/more/calendar'),
            ),
            if (flags.showQibla)
            _MoreTile(
              icon:  Icons.explore,
              label: t.more_qibla,
              onTap: () => context.push('/more/qibla'),
            ),
            _MoreTile(
              icon:  Icons.bar_chart,
              label: t.more_stats,
              onTap: () => context.push('/more/stats'),
            ),
            if (flags.showKhatmah)
            _MoreTile(
              icon:  Icons.menu_book,
              label: t.khatmah_title,
              onTap: () => context.push('/khatmah'),
            ),
            if (flags.showShareCards)
            _MoreTile(
              icon:  Icons.card_giftcard,
              label: t.more_shareCards,
              onTap: () => context.push('/more/share', extra: {
                'title':    'آية كريمة',
                'subtitle': 'سورة البقرة',
                'content':  'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                'type':     'quran',
              }),
            ),
            if (flags.showRadio)
            _MoreTile(
              icon:  Icons.radio,
              label: t.more_radio,
              onTap: () => context.push('/more/radio'),
            ),
            if (flags.showMosques)
            _MoreTile(
              icon:  Icons.mosque,
              label: t.more_mosques,
              onTap: () => context.push('/more/mosques'),
            ),
          ],
        ),
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
