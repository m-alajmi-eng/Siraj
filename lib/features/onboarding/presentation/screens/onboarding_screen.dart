import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/mode/app_mode.dart';
import '../../../../core/mode/app_mode_provider.dart';

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

  final _madhabs = [
    {'id': 'hanafi',  'name': 'الحنفي',  'nameEn': 'Hanafi'},
    {'id': 'maliki',  'name': 'المالكي', 'nameEn': 'Maliki'},
    {'id': 'shafi',   'name': 'الشافعي', 'nameEn': 'Shafi\'i'},
    {'id': 'hanbali', 'name': 'الحنبلي', 'nameEn': 'Hanbali'},
  ];

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
    await box.put('locale',          _selectedLocale);
    await box.put('madhab',          _selectedMadhab);

    ref.read(appModeProvider.notifier).setMode(_selectedMode);

    if (mounted) context.go('/prayer');
  }

  @override
  Widget build(BuildContext context) {
    final palette = ref.watch(timeThemeProvider);

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
                  child: Container(
                    height: 3,
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    decoration: BoxDecoration(
                      color: i <= _currentPage
                          ? palette.accentPrimary
                          : palette.accentPrimary.withOpacity(0.2),
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
                  _LanguagePage(
                    locales:        _locales,
                    selected:       _selectedLocale,
                    palette:        palette,
                    onSelect: (code) => setState(
                      () => _selectedLocale = code),
                  ),
                  _ModePage(
                    selected: _selectedMode,
                    palette:  palette,
                    onSelect: (mode) => setState(
                      () => _selectedMode = mode),
                  ),
                  _MadhabPage(
                    madhabs:  _madhabs,
                    selected: _selectedMadhab,
                    palette:  palette,
                    onSelect: (id) => setState(
                      () => _selectedMadhab = id),
                  ),
                  _LocationPage(
                    palette: palette,
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
                      _currentPage < 3 ? 'التالي' : 'ابدأ',
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

// ─── Page 1: اختيار اللغة ─────────────────────────────────
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
                            : palette.accentPrimary.withOpacity(0.1),
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
  final Function(AppMode) onSelect;

  const _ModePage({
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
            'اختر وضع التطبيق',
            style: TextStyle(
              color:      palette.textPrimary,
              fontSize:   32,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'يمكنك تغييره لاحقاً من الإعدادات',
            style: TextStyle(
              color:    palette.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 40),

          // Lite Mode
          _ModeCard(
            title:       'الوضع الخفيف',
            subtitle:    'الأساسيات · سريع · offline كامل',
            description: 'صلاة · قرآن · أذكار · قبلة',
            icon:        Icons.wb_sunny_outlined,
            isSelected:  selected == AppMode.lite,
            palette:     palette,
            onTap: () => onSelect(AppMode.lite),
          ),

          const SizedBox(height: 16),

          // Full Mode
          _ModeCard(
            title:       'الوضع الكامل',
            subtitle:    'كل الميزات · شامل · عميق',
            description: 'صلاة · قرآن · أذكار · حديث · قبلة + المزيد',
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
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? palette.accentPrimary.withOpacity(0.15)
              : palette.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? palette.accentPrimary
                : palette.accentPrimary.withOpacity(0.1),
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
  final List<Map<String, String>> madhabs;
  final String   selected;
  final dynamic  palette;
  final Function(String) onSelect;

  const _MadhabPage({
    required this.madhabs,
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
            'المذهب الفقهي',
            style: TextStyle(
              color:      palette.textPrimary,
              fontSize:   32,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'لحساب أوقات الصلاة بدقة',
            style: TextStyle(
              color:    palette.textSecondary,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 32),
          ...madhabs.map((m) {
            final isSelected = selected == m['id'];
            return GestureDetector(
              onTap: () => onSelect(m['id']!),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: isSelected
                      ? palette.accentPrimary.withOpacity(0.15)
                      : palette.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? palette.accentPrimary
                        : palette.accentPrimary.withOpacity(0.1),
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
                      '${m['name']} · ${m['nameEn']}',
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
  const _LocationPage({required this.palette});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 24),
          Text(
            'تحديد موقعك',
            style: TextStyle(
              color:      palette.textPrimary,
              fontSize:   32,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'لأوقات صلاة دقيقة',
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
              'التطبيق سيطلب إذن الموقع\nلتحديد أوقات الصلاة تلقائياً',
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
              'بياناتك تبقى على جهازك فقط',
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