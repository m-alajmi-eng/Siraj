import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/mode/app_mode.dart';
import '../../../../core/mode/app_mode_provider.dart';

String _madhabName(AppLocalizations t, String id) {
  switch (id) {
    case 'hanafi':  return t.madhab_hanafi;
    case 'maliki':  return t.madhab_maliki;
    case 'shafi':   return t.madhab_shafi;
    default:        return t.madhab_hanbali;
  }
}

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  // اختيارات المستخدم
  String   _selectedLocale = 'ar';
  AppMode  _selectedMode   = AppMode.full;
  String   _selectedMadhab = 'shafi';

  final _locales = [
    {'code': 'ar', 'name': 'العربية',      'flag': '🇸🇦'},
    {'code': 'en', 'name': 'English',      'flag': '🇬🇧'},
    {'code': 'id', 'name': 'Indonesia',    'flag': '🇮🇩'},
    {'code': 'ur', 'name': 'اردو',         'flag': '🇵🇰'},
    {'code': 'tr', 'name': 'Türkçe',       'flag': '🇹'},
    {'code': 'fr', 'name': 'Français',     'flag': '🇫🇷'},
    {'code': 'bn', 'name': 'বাংলা',        'flag': '🇧🇩'},
    {'code': 'ms', 'name': 'Melayu',       'flag': '🇲🇾'},
    {'code': 'fa', 'name': 'فارسی',        'flag': '🇮🇷'},
    {'code': 'ru', 'name': 'Русский',      'flag': '🇷🇺'},
  ];

  final _madhabIds = ['hanafi', 'maliki', 'shafi', 'hanbali'];

  void _next() {
    if (_currentPage < 3) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve:    Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  void _finish() async {
    final box = Hive.box('settings');
    await box.put('onboarding_done', true);
    await box.put('madhab',          _selectedMadhab);

    ref.read(appModeProvider.notifier).setMode(_selectedMode);

    if (mounted) context.go('/prayer');
  }

  void _selectLocale(String code) {
    setState(() => _selectedLocale = code);
    // تبديل حي فوري - بدل الانتظار لنهاية الإعداد الأولي - حتى تُعرض
    // بقية الخطوات (الوضع/المذهب/الموقع) فعلياً باللغة المختارة واتجاهها
    // الصحيح (RTL/LTR)، لا بلغة الجهاز الافتراضية.
    ref.read(localeProvider.notifier).setLocale(code);
  }

  @override
  Widget build(BuildContext context) {
    final t       = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);

    final liteFeatures =
        '${t.prayer_title} · ${t.quran_title} · ${t.athkar_title} · ${t.qibla_title}';
    final fullFeatures =
        '${t.prayer_title} · ${t.quran_title} · ${t.athkar_title} · '
        '${t.hadith_title} · ${t.qibla_title} ${t.onboarding_andMore}';

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Column(
          children: [

            // ─── Progress Bar ──────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24, vertical: 16),
              child: Row(
                children: List.generate(4, (i) => Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve:    Curves.easeInOut,
                    height:   i <= _currentPage ? 5 : 3,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: i <= _currentPage
                          ? palette.accentPrimary
                          : palette.accentPrimary.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                )),
              ),
            ),

            // ─── Pages ────────────────────────────────────
            Expanded(
              child: PageView(
                controller:    _controller,
                physics:       const NeverScrollableScrollPhysics(),
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: [
                  _FadeSlidePage(
                    index: 0,
                    controller: _controller,
                    child: _LanguagePage(
                      locales:  _locales,
                      selected: _selectedLocale,
                      palette:  palette,
                      onSelect: _selectLocale,
                    ),
                  ),
                  _FadeSlidePage(
                    index: 1,
                    controller: _controller,
                    child: _ModePage(
                      selected:     _selectedMode,
                      palette:      palette,
                      t:            t,
                      liteFeatures: liteFeatures,
                      fullFeatures: fullFeatures,
                      onSelect: (mode) => setState(
                        () => _selectedMode = mode),
                    ),
                  ),
                  _FadeSlidePage(
                    index: 2,
                    controller: _controller,
                    child: _MadhabPage(
                      madhabIds: _madhabIds,
                      selected:  _selectedMadhab,
                      palette:   palette,
                      t:         t,
                      onSelect: (id) => setState(
                        () => _selectedMadhab = id),
                    ),
                  ),
                  _FadeSlidePage(
                    index: 3,
                    controller: _controller,
                    child: _LocationPage(
                      palette: palette,
                      t:       t,
                    ),
                  ),
                ],
              ),
            ),

            // ─── Next Button ───────────────────────────────
            Padding(
              padding: const EdgeInsets.all(24),
              child: GestureDetector(
                onTap: _next,
                child: Container(
                  width:  double.infinity,
                  height: 54,
                  decoration: BoxDecoration(
                    color:        palette.accentPrimary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      _currentPage < 3 ? t.common_next : t.onboarding_start,
                      style: TextStyle(
                        color:      palette.background,
                        fontSize:   17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── انتقال fade + slide رأسي بين الصفحات ─────────────────
// انزلاق رأسي (لا أفقي) عمداً حتى لا يتطلب أي منطق خاص باتجاه RTL/LTR.
class _FadeSlidePage extends StatelessWidget {
  final int index;
  final PageController controller;
  final Widget child;

  const _FadeSlidePage({
    required this.index,
    required this.controller,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        var page = index.toDouble();
        if (controller.hasClients && controller.position.haveDimensions) {
          page = controller.page ?? index.toDouble();
        }
        final delta   = (page - index).clamp(-1.0, 1.0);
        final opacity = (1 - delta.abs()).clamp(0.0, 1.0);
        return Opacity(
          opacity: opacity,
          child: Transform.translate(
            offset: Offset(0, delta * 24),
            child: child,
          ),
        );
      },
    );
  }
}

// ─── Page 1: اختيار اللغة ─────────────────────────────────
// العنوان الفرعي "Choose your language" يبقى ثابتاً بالإنجليزية عمداً (غير
// مُدوَّل) - هذه هي الصفحة الوحيدة التي تُعرض قبل معرفة لغة المستخدم أصلاً،
// فإبقاء نص إنجليزي عالمي هنا يساعد أي مستخدم أول مرة على فهمها بغض النظر
// عن لغته، وهذا هو التصميم الأصلي المقصود لا نصاً منسياً بلا ترجمة.
class _LanguagePage extends StatelessWidget {
  final List<Map<String, String>> locales;
  final String   selected;
  final dynamic  palette;
  final Function(String) onSelect;

  const _LanguagePage({
    required this.locales,
    required this.selected,
    required this.palette,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 24),
          Text(
            'اختر لغتك',
            style: TextStyle(
              color:      palette.textPrimary,
              fontSize:   32,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose your language',
            style: TextStyle(
              color:    palette.textSecondary,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: GridView.builder(
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:   2,
                childAspectRatio: 2.8,
                crossAxisSpacing: 12,
                mainAxisSpacing:  12,
              ),
              itemCount: locales.length,
              itemBuilder: (_, i) {
                final locale     = locales[i];
                final isSelected = selected == locale['code'];

                return GestureDetector(
                  onTap: () => onSelect(locale['code']!),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? palette.accentPrimary
                          : palette.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? palette.accentPrimary
                            : palette.accentPrimary.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          locale['flag']!,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          locale['name']!,
                          style: TextStyle(
                            color: isSelected
                                ? palette.background
                                : palette.textPrimary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
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

// ─── Page 2: اختيار الوضع ─────────────────────────────────
class _ModePage extends StatelessWidget {
  final AppMode  selected;
  final dynamic  palette;
  final AppLocalizations t;
  final String liteFeatures;
  final String fullFeatures;
  final Function(AppMode) onSelect;

  const _ModePage({
    required this.selected,
    required this.palette,
    required this.t,
    required this.liteFeatures,
    required this.fullFeatures,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 24),
          Text(
            t.onboarding_modeTitle,
            style: TextStyle(
              color:      palette.textPrimary,
              fontSize:   32,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.onboarding_modeSubtitle,
            style: TextStyle(
              color:    palette.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 40),

          // Lite Mode
          _ModeCard(
            title:       t.settings_liteMode,
            subtitle:    t.onboarding_liteSubtitle,
            description: liteFeatures,
            icon:        Icons.wb_sunny_outlined,
            isSelected:  selected == AppMode.lite,
            palette:     palette,
            onTap: () => onSelect(AppMode.lite),
          ),

          const SizedBox(height: 16),

          // Full Mode
          _ModeCard(
            title:       t.settings_fullMode,
            subtitle:    t.onboarding_fullSubtitle,
            description: fullFeatures,
            icon:        Icons.auto_awesome,
            isSelected:  selected == AppMode.full,
            palette:     palette,
            onTap: () => onSelect(AppMode.full),
          ),
        ],
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final String   title;
  final String   subtitle;
  final String   description;
  final IconData icon;
  final bool     isSelected;
  final dynamic  palette;
  final VoidCallback onTap;

  const _ModeCard({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.palette,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? palette.accentPrimary.withValues(alpha: 0.15)
              : palette.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? palette.accentPrimary
                : palette.accentPrimary.withValues(alpha: 0.1),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            if (isSelected)
              Icon(Icons.check_circle,
                color: palette.accentPrimary, size: 24)
            else
              Icon(Icons.circle_outlined,
                color: palette.textSecondary, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color:      palette.textPrimary,
                          fontSize:   17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(icon,
                        color: palette.accentPrimary, size: 20),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color:    palette.accentPrimary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color:    palette.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Page 3: المذهب ───────────────────────────────────────
class _MadhabPage extends StatelessWidget {
  final List<String> madhabIds;
  final String   selected;
  final dynamic  palette;
  final AppLocalizations t;
  final Function(String) onSelect;

  const _MadhabPage({
    required this.madhabIds,
    required this.selected,
    required this.palette,
    required this.t,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 24),
          Text(
            t.onboarding_madhabTitle,
            style: TextStyle(
              color:      palette.textPrimary,
              fontSize:   32,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.onboarding_madhabSubtitle,
            style: TextStyle(
              color:    palette.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 32),
          ...madhabIds.map((id) {
            final isSelected = selected == id;
            return GestureDetector(
              onTap: () => onSelect(id),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isSelected
                      ? palette.accentPrimary.withValues(alpha: 0.15)
                      : palette.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? palette.accentPrimary
                        : palette.accentPrimary.withValues(alpha: 0.1),
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (isSelected)
                      Icon(Icons.check_circle,
                        color: palette.accentPrimary)
                    else
                      Icon(Icons.circle_outlined,
                        color: palette.textSecondary),
                    Text(
                      _madhabName(t, id),
                      style: TextStyle(
                        color:      palette.textPrimary,
                        fontSize:   16,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─── Page 4: الموقع ───────────────────────────────────────
class _LocationPage extends StatelessWidget {
  final dynamic palette;
  final AppLocalizations t;
  const _LocationPage({required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 24),
          Text(
            t.onboarding_locationTitle,
            style: TextStyle(
              color:      palette.textPrimary,
              fontSize:   32,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.onboarding_locationSubtitle,
            style: TextStyle(
              color:    palette.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 60),
          Center(
            child: Icon(
              Icons.location_on,
              size:  80,
              color: palette.accentPrimary,
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: Text(
              t.onboarding_locationBody,
              textAlign: TextAlign.center,
              style: TextStyle(
                color:    palette.textSecondary,
                fontSize: 16,
                height:   1.6,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Text(
              t.onboarding_locationPrivacy,
              style: TextStyle(
                color:    palette.accentPrimary,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
