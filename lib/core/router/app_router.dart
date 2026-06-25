import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/prayer/presentation/screens/prayer_screen.dart';
import '../../features/quran/presentation/screens/quran_home_screen.dart';
import '../../features/quran/presentation/screens/surah_reader_screen.dart';
import '../../features/athkar/presentation/screens/athkar_home_screen.dart';
import '../../features/athkar/presentation/screens/athkar_category_screen.dart';
import '../../features/hadith/presentation/screens/hadith_home_screen.dart';
import '../../features/qibla/presentation/screens/qibla_screen.dart';
import '../../features/stats/presentation/screens/stats_screen.dart';
import '../widgets/main_shell.dart';
import '../theme/time_theme_provider.dart';

final appRouter = GoRouter(
  initialLocation: '/prayer',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => MainShell(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path:    '/prayer',
              builder: (context, state) => const PrayerScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path:    '/quran',
              builder: (context, state) => const QuranHomeScreen(),
              routes: [
                GoRoute(
                  path:    'surah/:id',
                  builder: (context, state) => SurahReaderScreen(
                    surahId: int.parse(state.pathParameters['id']!),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path:    '/athkar',
              builder: (context, state) => const AthkarHomeScreen(),
              routes: [
                GoRoute(
                  path:    ':categoryId',
                  builder: (context, state) => AthkarCategoryScreen(
                    categoryId:   state.pathParameters['categoryId']!,
                    categoryName: state.uri.queryParameters['name'] ?? '',
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path:    '/hadith',
              builder: (context, state) => const HadithHomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path:    '/more',
              builder: (context, state) => const MoreScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(timeThemeProvider);

    final items = [
      {
        'title': 'اتجاه القبلة',
        'icon':  Icons.explore,
        'screen': const QiblaScreen(),
      },
      {
        'title': 'إحصائياتي',
        'icon':  Icons.bar_chart,
        'screen': const StatsScreen(),
      },
    ];

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'المزيد',
                style: TextStyle(
                  color:      palette.textPrimary,
                  fontSize:   28,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 24),
              ...items.map((item) => GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => item['screen'] as Widget),
                ),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color:        palette.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        item['icon'] as IconData,
                        color: palette.accentPrimary,
                        size:  28,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        item['title'] as String,
                        style: TextStyle(
                          color:      palette.textPrimary,
                          fontSize:   17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: palette.textSecondary,
                        size:  14,
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}