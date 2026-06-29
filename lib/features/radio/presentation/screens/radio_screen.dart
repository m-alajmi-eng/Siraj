import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../providers/radio_provider.dart';

class RadioScreen extends ConsumerWidget {
  const RadioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t                = AppLocalizations.of(context);
    final palette          = ref.watch(timeThemeProvider);
    final stations         = ref.watch(filteredStationsProvider);
    final radioState       = ref.watch(radioProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return AppScaffold(
      title: t.radio_title,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _CategorySelector(ref: ref, selected: selectedCategory, t: t, palette: palette),
          if (radioState.isLoading)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: SirajSpacing.s4),
              child: LinearProgressIndicator(),
            ),
          if (radioState.error != null)
            Padding(
              padding: const EdgeInsets.all(SirajSpacing.s2),
              child: Text(radioState.error!, textAlign: TextAlign.center,
                style: AppText.bodySmall.copyWith(color: SirajSemantic.errorText)),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: stations.length,
              itemBuilder: (context, index) {
                final station = stations[index];
                final isCurrent = radioState.currentStation?.id == station.id;
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: SirajSpacing.s4, vertical: SirajSpacing.s1),
                  leading: Text(station.flag, style: const TextStyle(fontSize: 32)),
                  title: Text(station.nameAr, style: AppText.body.copyWith(
                    color: isCurrent ? palette.accentPrimary : palette.textPrimary,
                    fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal)),
                  subtitle: Text(station.country, style: AppText.caption.copyWith(
                    color: palette.textSecondary)),
                  trailing: IconButton(
                    icon: Icon(
                      (isCurrent && radioState.isPlaying)
                          ? Icons.pause_circle_filled
                          : Icons.play_circle_fill,
                      color: isCurrent ? palette.accentPrimary
                          : palette.textSecondary,
                      size: 38),
                    onPressed: () => ref.read(radioProvider.notifier).play(station),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CategorySelector extends StatelessWidget {
  final WidgetRef ref;
  final String selected;
  final AppLocalizations t;
  final dynamic palette;
  const _CategorySelector({
    required this.ref, required this.selected,
    required this.t, required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    final categories = {
      'all':          t.radio_all,
      'quran_ar':     t.radio_quran,
      'quran_trans':  t.radio_translations,
      'tafseer':      t.radio_tafsir,
      'adhkar':       t.radio_athkar,
      'international': t.radio_international,
    };

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: SirajSpacing.s4, vertical: SirajSpacing.s3),
      child: Row(
        children: categories.entries.map((entry) {
          final isSelected = selected == entry.key;
          return Padding(
            padding: const EdgeInsetsDirectional.only(end: SirajSpacing.s2),
            child: GestureDetector(
              onTap: () => ref.read(selectedCategoryProvider.notifier).select(entry.key),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SirajSpacing.s4, vertical: SirajSpacing.s2),
                decoration: BoxDecoration(
                  color: isSelected ? palette.accentPrimary : palette.surface,
                  borderRadius: BorderRadius.circular(SirajRadiusFull.xl),
                ),
                child: Text(entry.value, style: AppText.bodySmall.copyWith(
                  color: isSelected ? palette.surface : palette.textSecondary)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
