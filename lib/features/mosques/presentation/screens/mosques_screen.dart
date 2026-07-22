import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/mosques_provider.dart';

class MosquesScreen extends ConsumerStatefulWidget {
  const MosquesScreen({super.key});

  @override
  ConsumerState<MosquesScreen> createState() => _MosquesScreenState();
}

class _MosquesScreenState extends ConsumerState<MosquesScreen> {
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid || Platform.isIOS) {
      Future.microtask(() => ref.read(mosquesProvider.notifier).fetchNearbyMosques());
    }
  }

  Future<void> _openDirections(Mosque mosque) async {
    final label = Uri.encodeComponent(mosque.name.isEmpty
        ? AppLocalizations.of(context).mosques_unnamed
        : mosque.name);
    final uri = Uri.parse('geo:${mosque.lat},${mosque.lon}?q=${mosque.lat},${mosque.lon}($label)');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = ref.watch(timeThemeProvider);
    final t = AppLocalizations.of(context);
    final mosquesAsync = ref.watch(mosquesProvider);
    final isMobile = Platform.isAndroid || Platform.isIOS;

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Column(
          children: [
            // ─── Header ───────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: palette.textPrimary),
                    tooltip: t.common_back,
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      t.more_mosques,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color:      palette.textPrimary,
                        fontSize:   24,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh, color: palette.accentPrimary),
                    tooltip: t.common_refresh,
                    onPressed: mosquesAsync.isLoading
                        ? null
                        : () => ref.read(mosquesProvider.notifier).fetchNearbyMosques(),
                  ),
                ],
              ),
            ),

            if (!isMobile)
              _InfoBanner(text: t.mosques_desktopOnly, palette: palette)
            else
              Expanded(
                child: mosquesAsync.when(
                  loading: () => _CenteredMessage(
                    icon: null,
                    spinner: true,
                    message: t.mosques_searching,
                    palette: palette,
                  ),
                  error: (err, _) => _ErrorState(error: err, t: t, palette: palette,
                    onRetry: () => ref.read(mosquesProvider.notifier).fetchNearbyMosques()),
                  data: (mosques) => mosques.isEmpty
                      ? _CenteredMessage(
                          icon: Icons.mosque,
                          message: t.mosques_notFound,
                          palette: palette,
                          action: TextButton(
                            onPressed: () =>
                                ref.read(mosquesProvider.notifier).fetchNearbyMosques(),
                            child: Text(t.common_retry,
                              style: TextStyle(color: palette.accentPrimary)),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: mosques.length,
                          itemBuilder: (_, i) {
                            final mosque = mosques[i];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color:        palette.surface,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width:  44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: palette.accentPrimary.withValues(alpha: 0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(Icons.mosque,
                                      color: palette.accentPrimary, size: 22),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      mosque.name.isEmpty ? t.mosques_unnamed : mosque.name,
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color:      palette.textPrimary,
                                        fontSize:   15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.directions,
                                      color: palette.accentPrimary, size: 22),
                                    tooltip: t.mosques_directions,
                                    onPressed: () => _openDirections(mosque),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  final String text;
  final dynamic palette;
  const _InfoBanner({required this.text, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:        palette.accentPrimary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: palette.accentPrimary.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Text(text, textAlign: TextAlign.right,
              style: TextStyle(color: palette.textPrimary, fontSize: 14)),
          ),
          const SizedBox(width: 8),
          Icon(Icons.info_outline, color: palette.accentPrimary),
        ],
      ),
    );
  }
}

class _CenteredMessage extends StatelessWidget {
  final IconData? icon;
  final bool spinner;
  final String message;
  final dynamic palette;
  final Widget? action;

  const _CenteredMessage({
    this.icon,
    this.spinner = false,
    required this.message,
    required this.palette,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (spinner) CircularProgressIndicator(color: palette.accentPrimary),
          if (icon != null) Icon(icon, size: 64, color: palette.textSecondary),
          const SizedBox(height: 16),
          Text(message, textAlign: TextAlign.center,
            style: TextStyle(color: palette.textSecondary, fontSize: 14)),
          if (action != null) ...[const SizedBox(height: 8), action!],
        ],
      ),
    );
  }
}

/// أربع حالات خطأ واضحة (PHASE G) بدل صمت كامل أو رسالة واحدة عامة:
/// رفض الإذن، تعطيل خدمة الموقع، خطأ شبكة/خادم، وخطأ غير متوقّع.
class _ErrorState extends StatelessWidget {
  final Object error;
  final AppLocalizations t;
  final dynamic palette;
  final VoidCallback onRetry;

  const _ErrorState({
    required this.error,
    required this.t,
    required this.palette,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    late final String title;
    late final String hint;
    VoidCallback? settingsAction;

    if (error is PermissionDeniedException) {
      title = t.mosques_permissionDenied;
      hint = t.mosques_permissionDeniedHint;
      settingsAction = () => Geolocator.openAppSettings();
    } else if (error is LocationServiceDisabledException) {
      title = t.mosques_serviceDisabled;
      hint = t.mosques_serviceDisabledHint;
      settingsAction = () => Geolocator.openLocationSettings();
    } else if (error is MosquesNetworkException) {
      title = t.mosques_networkError;
      hint = t.mosques_networkErrorHint;
    } else {
      title = t.common_error;
      hint = t.mosques_networkErrorHint;
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 64, color: palette.textSecondary),
            const SizedBox(height: 16),
            Text(title, textAlign: TextAlign.center,
              style: TextStyle(color: palette.textPrimary, fontSize: 16, fontWeight: FontWeight.w600)),
            const SizedBox(height: 6),
            Text(hint, textAlign: TextAlign.center,
              style: TextStyle(color: palette.textSecondary, fontSize: 13)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              alignment: WrapAlignment.center,
              children: [
                if (settingsAction != null)
                  OutlinedButton(
                    onPressed: settingsAction,
                    child: Text(t.mosques_openSettings),
                  ),
                TextButton(
                  onPressed: onRetry,
                  child: Text(t.common_retry, style: TextStyle(color: palette.accentPrimary)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
