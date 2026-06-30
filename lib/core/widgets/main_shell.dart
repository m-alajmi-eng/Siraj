import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../theme/time_theme_provider.dart';

class MainShell extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t       = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);

    final tabs = [
      _TabItem(icon: Icons.home_outlined,         activeIcon: Icons.home,          label: t.nav_home),
      _TabItem(icon: Icons.menu_book_outlined,    activeIcon: Icons.menu_book,     label: t.nav_quran),
      _TabItem(icon: Icons.spa_outlined,          activeIcon: Icons.spa,           label: t.nav_athkar),
      _TabItem(icon: Icons.library_books_outlined,activeIcon: Icons.library_books, label: t.nav_hadith),
      _TabItem(icon: Icons.more_horiz,            activeIcon: Icons.more_horiz,    label: t.nav_more),
    ];

    return Scaffold(
      backgroundColor: palette.background,
      body: navigationShell,
      floatingActionButton: FloatingActionButton(
        mini:            true,
        backgroundColor: palette.accentPrimary,
        onPressed:       () => context.push('/more/search'),
        child: const Icon(Icons.search, color: Colors.white, size: 20),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: palette.surface,
          border: Border(
            top: BorderSide(
              color: palette.accentPrimary.withValues(alpha: 0.15),
              width: 0.5,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: tabs.asMap().entries.map((entry) {
                final index    = entry.key;
                final tab      = entry.value;
                final isActive = navigationShell.currentIndex == index;

                return GestureDetector(
                  onTap: () => navigationShell.goBranch(
                    index,
                    initialLocation: index == navigationShell.currentIndex,
                  ),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: isActive
                          ? palette.accentPrimary.withValues(alpha: 0.15)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          isActive ? tab.activeIcon : tab.icon,
                          color: isActive
                              ? palette.accentPrimary
                              : palette.textSecondary,
                          size: 22,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          tab.label,
                          style: TextStyle(
                            color: isActive
                                ? palette.accentPrimary
                                : palette.textSecondary,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _TabItem {
  final IconData icon;
  final IconData activeIcon;
  final String   label;
  const _TabItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
