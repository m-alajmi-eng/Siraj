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

/// مدخل رحلة الوعي الروحي — شاشة ترحيب هادئة، بلا حشو، تدعو للبدء.
class GatewayIntroScreen extends ConsumerWidget {
  const GatewayIntroScreen({super.key});

  static const _leadAr =
      'ليست محاضرة، ولا محاولة لإقناعك بشيء.\nبل مساحة هادئة لتفكّر… على مهلك.';
  static const _leadEn =
      'Not a lecture, nor an attempt to convince you of anything.\nA quiet space to reflect… at your own pace.';
  static const _noPressureAr = 'بلا تسجيل • بلا ضغط • توقّف متى شئت';
  static const _noPressureEn = 'No sign-up • No pressure • Stop anytime';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(timeThemeProvider);
    final lang = ref.watch(localeProvider).languageCode;
    final isAr = lang == 'ar';
    final t = AppLocalizations.of(context);
    ref.watch(gatewayStationsProvider);

    return AppScaffold(
      title: t.gateway_intro_title,
      showBack: true,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.brightness_low_outlined,
                color: palette.accentPrimary,
                size: 64,
              ),
              const SizedBox(height: SirajSpacing.s6),
              Text(
                t.gateway_intro_title,
                textAlign: TextAlign.center,
                style: AppText.headline.copyWith(
                  color: palette.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: SirajSpacing.s4),
              Text(
                isAr ? _leadAr : _leadEn,
                textAlign: TextAlign.center,
                style: AppText.body.copyWith(
                  color: palette.textSecondary,
                  height: 1.7,
                ),
              ),
              const SizedBox(height: SirajSpacing.s8),
              _BeginButton(
                label: t.gateway_begin,
                palette: palette,
                onTap: () {
                  ref.read(journeyPositionProvider.notifier).reset();
                  context.push('/gateway/journey');
                },
              ),
              const SizedBox(height: SirajSpacing.s4),
              Text(
                isAr ? _noPressureAr : _noPressureEn,
                textAlign: TextAlign.center,
                style: AppText.caption.copyWith(
                  color: palette.textSecondary.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BeginButton extends StatelessWidget {
  final String label;
  final dynamic palette;
  final VoidCallback onTap;

  const _BeginButton({
    required this.label,
    required this.palette,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: SirajSpacing.s8,
          vertical: SirajSpacing.s4,
        ),
        decoration: BoxDecoration(
          color: palette.accentPrimary,
          borderRadius: BorderRadius.circular(SirajRadiusFull.pill),
        ),
        child: Text(
          label,
          style: AppText.body.copyWith(
            color: palette.surface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
