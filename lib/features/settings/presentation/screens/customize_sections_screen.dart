import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/mode/app_mode.dart';
import '../../../../core/mode/app_mode_provider.dart';
import '../../../../core/mode/feature_flags.dart';
import '../../../../core/mode/enabled_sections_provider.dart';
import '../../../../l10n/app_localizations.dart';

/// شاشة تخصيص الأقسام: يختار المستخدم أي أقسام يريد إظهارها في
/// الوضع الخفيف (بما فيها القرآن والأذان وأوقات الصلاة - لا نواة
/// مفروضة). لا تُعرض في الوضع الكامل لأن كل شيء مفعَّل تلقائياً فيه.
class CustomizeSectionsScreen extends ConsumerWidget {
  const CustomizeSectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(timeThemeProvider);
    final t = AppLocalizations.of(context);
    final mode = ref.watch(appModeProvider);
    final enabled = ref.watch(enabledSectionsProvider);
    final effective =
        enabled.isEmpty ? FeatureFlags.defaultLiteSections : enabled;

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        backgroundColor: palette.background,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: palette.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(t.sections_customize_title,
            style: TextStyle(color: palette.textPrimary)),
      ),
      body: SafeArea(
        child: mode == AppMode.full
            ? _FullModeNotice(palette: palette, t: t)
            : ListView(
                padding: const EdgeInsets.all(SirajSpacing.s4),
                children: [
                  Text(t.sections_customize_subtitle,
                      style: TextStyle(
                          color: palette.textSecondary, fontSize: 13)),
                  const SizedBox(height: SirajSpacing.s5),
                  ...FeatureFlags.allSections.map((section) {
                    final (id, labelKey) = section;
                    final label = _labelFor(t, labelKey);
                    return _SectionToggleTile(
                      label: label,
                      isEnabled: effective.contains(id),
                      palette: palette,
                      onChanged: (_) => ref
                          .read(enabledSectionsProvider.notifier)
                          .toggle(id),
                    );
                  }),
                ],
              ),
      ),
    );
  }
}

class _FullModeNotice extends StatelessWidget {
  final dynamic palette;
  final AppLocalizations t;
  const _FullModeNotice({required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SirajSpacing.s8),
        child: Text(
          t.sections_full_mode_notice,
          textAlign: TextAlign.center,
          style: TextStyle(color: palette.textSecondary, fontSize: 14),
        ),
      ),
    );
  }
}

/// يحوّل مفتاح النص (labelKey) لاسم القسم المترجم فعلياً.
String _labelFor(AppLocalizations t, String labelKey) {
  switch (labelKey) {
    case 'section_quran_reader': return t.section_quran_reader;
    case 'section_adhan': return t.section_adhan;
    case 'section_prayer': return t.section_prayer;
    case 'section_qibla': return t.section_qibla;
    case 'section_athkar': return t.section_athkar;
    case 'section_hadith': return t.section_hadith;
    case 'section_radio': return t.section_radio;
    case 'section_hifz': return t.section_hifz;
    case 'section_khatmah': return t.section_khatmah;
    case 'section_library': return t.section_library;
    case 'section_mosques': return t.section_mosques;
    case 'section_ruqyah': return t.section_ruqyah;
    case 'section_dua_journal': return t.section_dua_journal;
    case 'section_mihrab': return t.section_mihrab;
    case 'section_qke': return t.section_qke;
    case 'section_timeline': return t.section_timeline;
    case 'section_new_muslim': return t.section_new_muslim;
    case 'section_calendar': return t.section_calendar;
    case 'section_share_cards': return t.section_share_cards;
    default: return labelKey;
  }
}

class _SectionToggleTile extends StatelessWidget {
  final String label;
  final bool isEnabled;
  final dynamic palette;
  final ValueChanged<bool> onChanged;

  const _SectionToggleTile({
    required this.label,
    required this.isEnabled,
    required this.palette,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: SirajSpacing.s2),
      padding: const EdgeInsets.symmetric(
          horizontal: SirajSpacing.s4, vertical: SirajSpacing.s1),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(SirajRadiusFull.md),
      ),
      child: SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(label, style: TextStyle(color: palette.textPrimary)),
        value: isEnabled,
        activeThumbColor: palette.accentPrimary,
        onChanged: onChanged,
      ),
    );
  }
}
