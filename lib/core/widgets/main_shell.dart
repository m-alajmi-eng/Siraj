import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../theme/time_theme_provider.dart';

class MainShell extends ConsumerWidget {
  final StatefulNavigationShell shell;
  const MainShell({super.key, required this.shell});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(timeThemeProvider);

    return Scaffold(
      backgroundColor: palette.background,
      body: shell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: palette.surface,
          boxShadow: [
            BoxShadow(
              color:         Colors.black.withOpacity(0.1),
              blurRadius:    8,
              offset:        const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon:    Icons.access_time_outlined,
                  label:   'الصلاة',
                  index:   0,
                  current: shell.currentIndex,
                  palette: palette,
                  onTap:   () => shell.goBranch(0),
                ),
                _NavItem(
                  icon:    Icons.menu_book_outlined,
                  label:   'القرآن',
                  index:   1,
                  current: shell.currentIndex,
                  palette: palette,
                  onTap:   () => shell.goBranch(1),
                ),
                _NavItem(
                  icon:    Icons.spa_outlined,
                  label:   'الأذكار',
                  index:   2,
                  current: shell.currentIndex,
                  palette: palette,
                  onTap:   () => shell.goBranch(2),
                ),
                _NavItem(
                  icon:    Icons.auto_stories_outlined,
                  label:   'الحديث',
                  index:   3,
                  current: shell.currentIndex,
                  palette: palette,
                  onTap:   () => shell.goBranch(3),
                ),
                _NavItem(
                  icon:    Icons.more_horiz,
                  label:   'المزيد',
                  index:   4,
                  current: shell.currentIndex,
                  palette: palette,
                  onTap:   () => shell.goBranch(4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String   label;
  final int      index;
  final int      current;
  final dynamic  palette;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.index,
    required this.current,
    required this.palette,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = index == current;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive
                  ? palette.accentPrimary
                  : palette.textSecondary,
              size: 22,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: isActive
                    ? palette.accentPrimary
                    : palette.textSecondary,
                fontSize:   10,
                fontWeight: isActive
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}