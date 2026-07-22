import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../notifications/adhan_service.dart';
import '../notifications/adhan_settings_provider.dart';
import '../theme/time_theme_provider.dart';
import '../../features/prayer/presentation/providers/prayer_provider.dart';
import '../../features/quran/presentation/providers/reading_context_provider.dart';

/// الشريط السفلي: الفروع الخمسة كلها ظاهرة (رئيسية، قرآن، أذكار، مكتبة،
/// مزيد) — ADR-006. القيد التقني المذكور سابقاً ("indexedStack لا يدعم
/// تغيير عدد الفروع ديناميكياً") كان وهمياً هنا: لسنا بحاجة لتغيير العدد
/// ديناميكياً أصلاً، فقط لعرض الفروع الخمسة الثابتة الموجودة في الراوتر
/// بلا إخفاء أي منها (كانت الأذكار والمكتبة مدفونتين، الوصول لهما فقط
/// عبر شبكة الرئيسية أو "المزيد").
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
    // نفس مصدر الحقيقة الواحد الذي تقرأ منه بطاقة "متابعة القراءة" في
    // الرئيسية — لضمان أن الوجهتين تفتحان دائماً نفس الموضع بالضبط.
    final continueReadingAsync = ref.watch(continueReadingContextProvider);

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
      _TabItem(branchIndex: 0, icon: Icons.home_outlined,        activeIcon: Icons.home,             label: t.nav_home),
      _TabItem(branchIndex: 1, icon: Icons.menu_book_outlined,   activeIcon: Icons.menu_book,         label: t.nav_quran),
      _TabItem(branchIndex: 2, icon: Icons.self_improvement_outlined, activeIcon: Icons.self_improvement, label: t.nav_athkar),
      _TabItem(branchIndex: 3, icon: Icons.local_library_outlined, activeIcon: Icons.local_library,   label: t.nav_library),
      _TabItem(branchIndex: 4, icon: Icons.more_horiz,           activeIcon: Icons.more_horiz,        label: t.nav_more),
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
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            // Expanded (لا Row+spaceAround غير محدود) لأن 5 تبويبات على
            // شاشات ضيّقة (<360dp) تحتاج توزيعاً متساوياً صارماً بدل عرض
            // مبنيّ على المحتوى قد يفيض — قيد الأجهزة الضعيفة (ADR-006 §7).
            child: Row(
              children: visibleTabs.map((tab) {
                final isActive = navigationShell.currentIndex == tab.branchIndex;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // تبويب القرآن تحديداً: إن وُجد سياق قراءة محفوظ
                      // (نفس المصدر الذي تستخدمه بطاقة "متابعة القراءة")
                      // نفتح آخر موضع مباشرة بدل قائمة السور — فقط عند
                      // الدخول للتبويب من تبويب آخر، لا عند إعادة الضغط
                      // عليه وهو نشط (ذلك يبقى "إعادة ضبط" كالمعتاد).
                      if (tab.branchIndex == 1 &&
                          navigationShell.currentIndex != 1) {
                        final surahId =
                            continueReadingAsync.value?['surahId'] as int?;
                        if (surahId != null) {
                          context.go('/quran/surah/$surahId');
                          return;
                        }
                      }
                      navigationShell.goBranch(
                        tab.branchIndex,
                        initialLocation: tab.branchIndex == navigationShell.currentIndex,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 6),
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
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
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
