import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/gateway_entity.dart';
import '../providers/gateway_provider.dart';

/// شاشة الرحلة: محطة-بمحطة عبر PageView.
class GatewayJourneyScreen extends ConsumerStatefulWidget {
  const GatewayJourneyScreen({super.key});

  @override
  ConsumerState<GatewayJourneyScreen> createState() =>
      _GatewayJourneyScreenState();
}

class _GatewayJourneyScreenState extends ConsumerState<GatewayJourneyScreen> {
  late final PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: ref.read(journeyPositionProvider),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  static const _icons = {
    'help_outline': Icons.help_outline,
    'groups_outlined': Icons.groups_outlined,
    'auto_awesome_outlined': Icons.auto_awesome_outlined,
    'forum_outlined': Icons.forum_outlined,
    'door_front_door_outlined': Icons.door_front_door_outlined,
  };

  @override
  Widget build(BuildContext context) {
    final palette = ref.watch(timeThemeProvider);
    final lang = ref.watch(localeProvider).languageCode;
    final isAr = lang == 'ar';
    final t = AppLocalizations.of(context);
    final stationsAsync = ref.watch(gatewayStationsProvider);
    final pos = ref.watch(journeyPositionProvider);

    return AppScaffold(
      title: t.gateway_journey_title,
      showBack: true,
      child: stationsAsync.when(
        loading: () => Center(
          child: CircularProgressIndicator(color: palette.accentPrimary),
        ),
        error: (e, _) => Center(
          child: Text(
            isAr ? 'تعذّر تحميل الرحلة' : 'Could not load the journey',
            style: AppText.body.copyWith(color: palette.textPrimary),
          ),
        ),
        data: (stations) {
          if (stations.isEmpty) {
            return Center(
              child: Text(
                isAr ? 'لا يوجد محتوى' : 'No content',
                style: AppText.body.copyWith(color: palette.textPrimary),
              ),
            );
          }
          return Column(
            children: [
              _ProgressDots(
                count: stations.length,
                current: pos,
                palette: palette,
              ),
              const SizedBox(height: SirajSpacing.s3),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: stations.length,
                  onPageChanged: (i) =>
                      ref.read(journeyPositionProvider.notifier).goTo(i),
                  itemBuilder: (context, index) {
                    return _StationPage(
                      station: stations[index],
                      lang: lang,
                      isAr: isAr,
                      palette: palette,
                      icon: _icons[stations[index].icon] ??
                          Icons.circle_outlined,
                      isLast: index == stations.length - 1,
                      onDeepLink: (catId) => context.push(
                        '/gateway/library/$catId',
                      ),
                      onEnterLayer2: () => context.push('/gateway/principles'),
                      onGoToShahada: () => context.push('/gateway/principles/shahada'),
                    );
                  },
                ),
              ),
              _NavBar(
                isAr: isAr,
                palette: palette,
                atStart: pos == 0,
                atEnd: pos == stations.length - 1,
                onPrev: () => _controller.previousPage(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                ),
                onNext: () => _controller.nextPage(
                  duration: const Duration(milliseconds: 350),
                  curve: Curves.easeInOut,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ProgressDots extends StatelessWidget {
  final int count;
  final int current;
  final dynamic palette;

  const _ProgressDots({
    required this.count,
    required this.current,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: active ? 22 : 7,
          height: 7,
          decoration: BoxDecoration(
            color: active
                ? palette.accentPrimary
                : palette.textSecondary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(SirajRadiusFull.pill),
          ),
        );
      }),
    );
  }
}

class _StationPage extends StatelessWidget {
  final GatewayStation station;
  final String lang;
  final bool isAr;
  final dynamic palette;
  final IconData icon;
  final bool isLast;
  final void Function(String catId) onDeepLink;
  final VoidCallback onEnterLayer2;
  final VoidCallback onGoToShahada;

  const _StationPage({
    required this.station,
    required this.lang,
    required this.isAr,
    required this.palette,
    required this.icon,
    required this.isLast,
    required this.onDeepLink,
    required this.onEnterLayer2,
    required this.onGoToShahada,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: SirajSpacing.s2,
          vertical: SirajSpacing.s4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(icon, color: palette.accentPrimary, size: 48),
            ),
            const SizedBox(height: SirajSpacing.s4),
            Text(
              station.titleFor(lang),
              style: AppText.headline.copyWith(
                color: palette.textPrimary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: SirajSpacing.s1),
            Text(
              station.subtitleFor(lang),
              style: AppText.body.copyWith(
                color: palette.accentPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: SirajSpacing.s4),
            Text(
              station.bodyFor(lang),
              style: AppText.body.copyWith(
                color: palette.textPrimary,
                height: 1.9,
              ),
            ),
            const SizedBox(height: SirajSpacing.s5),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(SirajSpacing.s4),
              decoration: BoxDecoration(
                color: palette.accentPrimary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(SirajRadiusFull.md),
                border: Border.all(
                  color: palette.accentPrimary.withValues(alpha: 0.2),
                ),
              ),
              child: Text(
                station.reflectionFor(lang),
                style: AppText.body.copyWith(
                  color: palette.textPrimary,
                  fontStyle: FontStyle.italic,
                  height: 1.7,
                ),
              ),
            ),
            if (station.deepLink != null) ...[
              const SizedBox(height: SirajSpacing.s4),
              _DeepLinkButton(
                label: station.deepLink!.labelFor(lang),
                palette: palette,
                onTap: () => onDeepLink(station.deepLink!.islamhouseCategory),
              ),
            ],
            if (isLast && station.leadsToLayer2) ...[
              const SizedBox(height: SirajSpacing.s6),
              _Layer2Invite(
                label: station.layer2InviteFor(lang),
                palette: palette,
                isAr: isAr,
                onTap: onEnterLayer2,
              ),
              const SizedBox(height: SirajSpacing.s5),
              Center(
                child: _ShahadaCallToAction(
                  isAr: isAr,
                  palette: palette,
                  onTap: onGoToShahada,
                ),
              ),
            ],
            const SizedBox(height: SirajSpacing.s6),
          ],
        ),
      ),
    );
  }
}

class _DeepLinkButton extends StatelessWidget {
  final String label;
  final dynamic palette;
  final VoidCallback onTap;

  const _DeepLinkButton({
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
          horizontal: SirajSpacing.s4,
          vertical: SirajSpacing.s3,
        ),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(SirajRadiusFull.md),
          border: Border.all(
            color: palette.textSecondary.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.menu_book_outlined,
                color: palette.accentPrimary, size: 18),
            const SizedBox(width: SirajSpacing.s2),
            Flexible(
              child: Text(
                label,
                style: AppText.bodySmall.copyWith(
                  color: palette.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Layer2Invite extends StatelessWidget {
  final String label;
  final dynamic palette;
  final bool isAr;
  final VoidCallback onTap;

  const _Layer2Invite({
    required this.label,
    required this.palette,
    required this.isAr,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(SirajSpacing.s4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              palette.accentPrimary,
              palette.accentPrimary.withValues(alpha: 0.75),
            ],
          ),
          borderRadius: BorderRadius.circular(SirajRadiusFull.lg),
        ),
        child: Row(
          children: [
            Icon(Icons.auto_stories_outlined, color: palette.surface, size: 24),
            const SizedBox(width: SirajSpacing.s3),
            Expanded(
              child: Text(
                label,
                style: AppText.body.copyWith(
                  color: palette.surface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              isAr ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
              color: palette.surface,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}

/// دعوة بارزة للفعل: أيقونة دائرية تقود مباشرة لصفحة الشهادتين.
/// تظهر فقط في محطة "الباب مفتوح"، لجذب من هو مستعد فعلاً.
class _ShahadaCallToAction extends StatelessWidget {
  final bool isAr;
  final dynamic palette;
  final VoidCallback onTap;

  const _ShahadaCallToAction({
    required this.isAr,
    required this.palette,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 76,
            height: 76,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  palette.accentPrimary,
                  palette.accentPrimary.withValues(alpha: 0.6),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: palette.accentPrimary.withValues(alpha: 0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              Icons.favorite,
              color: palette.surface,
              size: 32,
            ),
          ),
          const SizedBox(height: SirajSpacing.s2),
          Text(
            AppLocalizations.of(context).gateway_shahada_cta,
            textAlign: TextAlign.center,
            style: AppText.bodySmall.copyWith(
              color: palette.accentPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  final bool isAr;
  final dynamic palette;
  final bool atStart;
  final bool atEnd;
  final VoidCallback onPrev;
  final VoidCallback onNext;

  const _NavBar({
    required this.isAr,
    required this.palette,
    required this.atStart,
    required this.atEnd,
    required this.onPrev,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SirajSpacing.s3),
      child: Directionality(
        textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Opacity(
            opacity: atStart ? 0.3 : 1.0,
            child: GestureDetector(
              onTap: atStart ? null : onPrev,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back,
                      color: palette.textSecondary, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    t.gateway_prev,
                    style: AppText.bodySmall
                        .copyWith(color: palette.textSecondary),
                  ),
                ],
              ),
            ),
          ),
          Opacity(
            opacity: atEnd ? 0.3 : 1.0,
            child: GestureDetector(
              onTap: atEnd ? null : onNext,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    t.gateway_next,
                    style: AppText.bodySmall.copyWith(
                      color: palette.accentPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(Icons.arrow_forward,
                      color: palette.accentPrimary, size: 18),
                ],
              ),
            ),
          ),
        ],
        ),
      ),
    );
  }
}
