import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../notifications/adhan_service.dart';
import '../notifications/adhan_settings_provider.dart';
import '../theme/time_theme_provider.dart';
import '../../features/prayer/presentation/providers/prayer_provider.dart';

/// الشريط السفلي: 3 وجهات فقط (رئيسية، قرآن، مزيد) - القيد التقني
/// المؤكَّد (يوليو 2026): StatefulShellRoute.indexedStack لا يدعم
/// تغيير عدد الفروع ديناميكياً، فتبقى الفروع الخمسة كما هي في
/// الراوتر (لتفادي كسر أي مسار فرعي عميق يعتمد عليها)، لكن الشريط
/// المرئي يعرض فقط 3 منها، مع فهرس الفرع الفعلي محفوظاً لكل زر.
/// الأذكار والمكتبة يبقى الوصول لهما عبر شبكة الرئيسية و"المزيد".
class MainShell extends ConsumerWidget {
  final StatefulNavigationShell navigationShell;
  const MainShell({super.key, required this.navigationShell});

  /// يعيد جدولة إشعارات الصلاة (كل الإعدادات التسعة ذات الصلة تُقرأ
  /// طازجة من داخل AdhanService نفسه). يُستدعى عند: فتح التطبيق (أول
  /// موقع متاح)، تغيّر الموقع الفعلي >10كم، أو تغيّر أي إعداد أذان
  /// (PHASE B4 — نُقلت من MaterialApp.builder ذي التنفيذ الواحد).
  void _reschedule(BuildContext context, LocationState location) {
    AdhanService.schedulePrayerNotifications(
      latitude: location.latitude,
      longitude: location.longitude,
      t: AppLocalizations.of(context),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t       = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);

    // مستمعات إعادة الجدولة: مصدر واحد للتشغيل الأول (تحوّل الموقع من
    // "جارٍ التحميل" إلى بيانات فعلية عند أول تحميل للتطبيق — WidgetRef.listen
    // في هذا الإصدار بلا fireImmediately، لكن انتقال loading→data نفسه
    // "تغيّر" يلتقطه listen طبيعياً بلا حاجة له)، وبقية الإعدادات تُعيد
    // الجدولة عند تغيّرها فقط (AdhanService يقرأ كل الإعدادات طازجة من
    // CacheService عند كل استدعاء بصرف النظر عن أيها استدعى).
    ref.listen<AsyncValue<LocationState>>(locationProvider, (prev, next) {
      final location = next.value;
      if (location == null) return;
      _reschedule(context, location);
    });

    ref.listen(calcMethodProvider, (prev, next) {
      final location = ref.read(locationProvider).value;
      if (location != null && prev != next) _reschedule(context, location);
    });
    ref.listen(madhabProvider, (prev, next) {
      final location = ref.read(locationProvider).value;
      if (location != null && prev != next) _reschedule(context, location);
    });
    ref.listen(adhanEnabledProvider, (prev, next) {
      final location = ref.read(locationProvider).value;
      if (location != null && prev != next) _reschedule(context, location);
    });
    ref.listen(adhanSoundProvider, (prev, next) {
      final location = ref.read(locationProvider).value;
      if (location != null && prev != next) _reschedule(context, location);
    });
    ref.listen(vibrationProvider, (prev, next) {
      final location = ref.read(locationProvider).value;
      if (location != null && prev != next) _reschedule(context, location);
    });
    ref.listen(iqamaAlertProvider, (prev, next) {
      final location = ref.read(locationProvider).value;
      if (location != null && prev != next) _reschedule(context, location);
    });

    final visibleTabs = [
      _TabItem(branchIndex: 0, icon: Icons.home_outlined,      activeIcon: Icons.home,      label: t.nav_home),
      _TabItem(branchIndex: 1, icon: Icons.menu_book_outlined, activeIcon: Icons.menu_book, label: t.nav_quran),
      _TabItem(branchIndex: 4, icon: Icons.more_horiz,         activeIcon: Icons.more_horiz, label: t.nav_more),
    ];

    return Scaffold(
      backgroundColor: palette.background,
      body: navigationShell,
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
              children: visibleTabs.map((tab) {
                final isActive = navigationShell.currentIndex == tab.branchIndex;

                return GestureDetector(
                  onTap: () => navigationShell.goBranch(
                    tab.branchIndex,
                    initialLocation: tab.branchIndex == navigationShell.currentIndex,
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
  final int      branchIndex;
  final IconData icon;
  final IconData activeIcon;
  final String   label;
  const _TabItem({
    required this.branchIndex,
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}
