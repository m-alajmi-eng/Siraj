import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/main_shell.dart';
import '../mode/app_mode.dart';
import '../mode/app_mode_provider.dart';
import '../mode/feature_flags.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/prayer/presentation/screens/prayer_screen.dart';
import '../../features/quran/presentation/screens/quran_home_screen.dart';
import '../../features/quran/presentation/screens/surah_reader_screen.dart';
import '../../features/quran/presentation/screens/quran_search_screen.dart';
import '../../features/athkar/presentation/screens/athkar_home_screen.dart';
import '../../features/athkar/presentation/screens/athkar_category_screen.dart';
import '../../features/hadith/presentation/screens/hadith_home_screen.dart';
import '../../features/qibla/presentation/screens/qibla_screen.dart';
import '../../features/stats/presentation/screens/stats_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';

// ─── More Screen ──────────────────────────────────────────
class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode  = ref.watch(appModeProvider);
    final flags = FeatureFlags(mode);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 16),
            const Text(
              'المزيد',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize:   28,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(height: 24),

            _MoreTile(
              icon:  Icons.settings,
              label: 'الإعدادات',
              onTap: () => context.push('/more/settings'),
            ),
            _MoreTile(
              icon:  Icons.explore,
              label: 'اتجاه القبلة',
              onTap: () => context.push('/more/qibla'),
            ),
            _MoreTile(
              icon:  Icons.bar_chart,
              label: 'إحصائياتي',
              onTap: () => context.push('/more/stats'),
            ),

            if (flags.isFull) ...[
              const Divider(height: 32),
              const Text(
                'الوضع الكامل',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              _MoreTile(
                icon:  Icons.radio,
                label: 'راديو القرآن',
                onTap: () {},
              ),
              _MoreTile(
                icon:  Icons.mosque,
                label: 'المساجد القريبة',
                onTap: () {},
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── More Tile ────────────────────────────────────────────
class _MoreTile extends StatelessWidget {
  final IconData     icon;
  final String       label;
  final VoidCallback onTap;

  const _MoreTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading:        Icon(icon),
      title:          Text(label, textAlign: TextAlign.right),
      trailing:       const Icon(Icons.chevron_left),
      onTap:          onTap,
    );
  }
}

// ─── Category Names ───────────────────────────────────────
const _categoryNames = {
  'morning': 'أذكار الصباح',
  'evening': 'أذكار المساء',
  'sleep':   'أذكار النوم',
  'wake':    'أذكار الاستيقاظ',
  'prayer':  'أذكار بعد الصلاة',
  'general': 'أذكار متنوعة',
};

// ─── Router ───────────────────────────────────────────────
final appRouterProvider = Provider<GoRouter>((ref) {
  final box        = Hive.box('settings');
  final isDone     = box.get('onboarding_done', defaultValue: false);
  final initialLoc = isDone ? '/prayer' : '/onboarding';

  return GoRouter(
    initialLocation: initialLoc,
    routes: [

      // ── Onboarding ──
      GoRoute(
        path:    '/onboarding',
        builder: (_, __) => const OnboardingScreen(),
      ),

      // ── Main Shell ──
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) =>
            MainShell(navigationShell: shell),
        branches: [

          // ── Prayer ──
          StatefulShellBranch(routes: [
            GoRoute(
              path:    '/prayer',
              builder: (_, __) => const PrayerScreen(),
            ),
          ]),

          // ── Quran ──
          StatefulShellBranch(routes: [
            GoRoute(
              path:    '/quran',
              builder: (_, __) => const QuranHomeScreen(),
              routes: [
                GoRoute(
                  path: 'surah/:id',
                  builder: (_, state) => SurahReaderScreen(
                    surahId: int.parse(
                      state.pathParameters['id']!),
                  ),
                ),
                GoRoute(
                  path:    'search',
                  builder: (_, __) => const QuranSearchScreen(),
                ),
              ],
            ),
          ]),

          // ── Athkar ──
          StatefulShellBranch(routes: [
            GoRoute(
              path:    '/athkar',
              builder: (_, __) => const AthkarHomeScreen(),
              routes: [
                GoRoute(
                  path: ':category',
                  builder: (_, state) {
                    final cat  = state.pathParameters['category']!;
                    final name = _categoryNames[cat] ?? cat;
                    return AthkarCategoryScreen(
                      categoryId:   cat,
                      categoryName: name,
                    );
                  },
                ),
              ],
            ),
          ]),

          // ── Hadith ──
          StatefulShellBranch(routes: [
            GoRoute(
              path:    '/hadith',
              builder: (_, __) => const HadithHomeScreen(),
            ),
          ]),

          // ── More ──
          StatefulShellBranch(routes: [
            GoRoute(
              path:    '/more',
              builder: (_, __) => const MoreScreen(),
              routes: [
                GoRoute(
                  path:    'settings',
                  builder: (_, __) => const SettingsScreen(),
                ),
                GoRoute(
                  path:    'qibla',
                  builder: (_, __) => const QiblaScreen(),
                ),
                GoRoute(
                  path:    'stats',
                  builder: (_, __) => const StatsScreen(),
                ),
              ],
            ),
          ]),
        ],
      ),
    ],
  );
});