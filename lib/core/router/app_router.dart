import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/prayer/presentation/screens/prayer_screen.dart';
import '../../features/quran/presentation/screens/quran_home_screen.dart';
import '../../features/quran/presentation/screens/surah_reader_screen.dart';
import '../../features/athkar/presentation/screens/athkar_home_screen.dart';
import '../../features/athkar/presentation/screens/athkar_category_screen.dart';
import '../widgets/main_shell.dart';

final appRouter = GoRouter(
  initialLocation: '/prayer',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => MainShell(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/prayer',
              builder: (context, state) => const PrayerScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/quran',
              builder: (context, state) => const QuranHomeScreen(),
              routes: [
                GoRoute(
                  path: 'surah/:id',
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
              path: '/athkar',
              builder: (context, state) => const AthkarHomeScreen(),
              routes: [
                GoRoute(
                  path: ':categoryId',
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
              path: '/hadith',
              builder: (context, state) => const Scaffold(
                body: Center(child: Text('الحديث — قريباً')),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/more',
              builder: (context, state) => const Scaffold(
                body: Center(child: Text('المزيد — قريباً')),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
);