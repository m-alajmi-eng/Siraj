import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../theme/time_theme_provider.dart';

class MainShell extends ConsumerWidget {
 final StatefulNavigationShell navigationShell;
 const MainShell({super.key, required this.navigationShell});

 @override
 Widget build(BuildContext context, WidgetRef ref) {
   final palette = ref.watch(timeThemeProvider);

   final tabs = [
     _TabItem(icon: Icons.home_outlined,          activeIcon: Icons.home,                 label: 'الرئيسية'),
     _TabItem(icon: Icons.menu_book_outlined,      activeIcon: Icons.menu_book,            label: 'القرآن'),
     _TabItem(icon: Icons.spa_outlined,            activeIcon: Icons.spa,                  label: 'الأذكار'),
     _TabItem(icon: Icons.library_books_outlined,  activeIcon: Icons.library_books,        label: 'الحديث'),
     _TabItem(icon: Icons.more_horiz,              activeIcon: Icons.more_horiz,           label: 'المزيد'),
   ];

   return Scaffold(
     backgroundColor: palette.background,
     body: navigationShell,
     bottomNavigationBar: Container(
       decoration: BoxDecoration(
         color: palette.surface,
         border: Border(
           top: BorderSide(
             color: palette.accentPrimary.withOpacity(0.15),
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
                         ? palette.accentPrimary.withOpacity(0.15)
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