import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'dart:math' as math;
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';

class QiblaScreen extends ConsumerWidget {
  const QiblaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t       = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);

    // Linux/Desktop لا يدعم البوصلة
    if (!Platform.isAndroid && !Platform.isIOS) {
      return AppScaffold(
        title: t.qibla_title,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.explore, color: palette.textSecondary, size: 60),
              const SizedBox(height: SirajSpacing.s4),
              Text(t.qibla_error, textAlign: TextAlign.center,
                style: AppText.body.copyWith(color: palette.textSecondary)),
              const SizedBox(height: SirajSpacing.s2),
              Text('Android / iOS', style: AppText.bodySmall.copyWith(
                color: palette.accentPrimary)),
            ],
          ),
        ),
      );
    }

    return AppScaffold(
      title: t.qibla_title,
      child: StreamBuilder(
        stream: FlutterQiblah.qiblahStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: palette.accentPrimary));
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.compass_calibration,
                    color: palette.textSecondary, size: 60),
                  const SizedBox(height: SirajSpacing.s4),
                  Text(t.qibla_error, textAlign: TextAlign.center,
                    style: AppText.body.copyWith(color: palette.textSecondary)),
                  const SizedBox(height: SirajSpacing.s2),
                  Text(t.qibla_errorHint, textAlign: TextAlign.center,
                    style: AppText.bodySmall.copyWith(color: palette.textSecondary)),
                ],
              ),
            );
          }

          final qiblah = snapshot.data!;
          final angle  = (qiblah.qiblah * (math.pi / 180)) * -1;

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 280, height: 280,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, color: palette.surface),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 260, height: 260,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: palette.accentPrimary.withValues(alpha: 0.2),
                            width: 1),
                        ),
                      ),
                      Container(
                        width: 200, height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: palette.accentPrimary.withValues(alpha: 0.1),
                            width: 1),
                        ),
                      ),
                      Transform.rotate(
                        angle: angle,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.navigation,
                              color: palette.accentPrimary, size: 80),
                            Text(t.qibla_kaaba, style: AppText.caption.copyWith(
                              color: palette.accentPrimary)),
                          ],
                        ),
                      ),
                      Container(
                        width: 12, height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, color: palette.accentPrimary),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: SirajSpacing.s8),
              Text('${qiblah.qiblah.toStringAsFixed(1)}°',
                style: AppText.displayLarge.copyWith(
                  color: palette.textPrimary, fontSize: 48)),
              const SizedBox(height: SirajSpacing.s2),
              Text(t.qibla_fromNorth, textAlign: TextAlign.center,
                style: AppText.bodySmall.copyWith(color: palette.textSecondary)),
              const SizedBox(height: SirajSpacing.s8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SirajSpacing.s4, vertical: SirajSpacing.s2),
                decoration: BoxDecoration(
                  color: palette.surface,
                  borderRadius: BorderRadius.circular(SirajRadiusFull.xl),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8, height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, color: palette.accentPrimary),
                    ),
                    const SizedBox(width: SirajSpacing.s2),
                    Text(t.qibla_active, style: AppText.bodySmall.copyWith(
                      color: palette.textSecondary)),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
