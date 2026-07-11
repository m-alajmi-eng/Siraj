import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/main_shell.dart';
import '../mode/app_mode.dart';
import '../mode/app_mode_provider.dart';
import '../mode/feature_flags.dart';
import '../mode/enabled_sections_provider.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/stories/presentation/screens/stories_screen.dart';
import '../../features/stories/presentation/screens/children_stories_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/auth_screen.dart';
import '../../features/language/presentation/screens/language_select_screen.dart';
import '../../features/auth/presentation/screens/account_screen.dart';
import '../../features/settings/presentation/screens/customize_sections_screen.dart';
import '../../features/prayer/presentation/screens/prayer_screen.dart';
import '../../features/quran/presentation/screens/quran_home_screen.dart';
import '../../features/quran/presentation/screens/surah_reader_screen.dart';
import '../../features/quran/presentation/screens/quran_search_screen.dart';
import '../../features/athkar/presentation/screens/athkar_home_screen.dart';
import '../../features/athkar/presentation/screens/athkar_category_screen.dart';
import '../../features/athkar/presentation/screens/athkar_categories_screen.dart';
import '../../features/qibla/presentation/screens/qibla_screen.dart';
import '../../features/stats/presentation/screens/stats_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/calendar/presentation/screens/calendar_screen.dart';
import '../../features/sharing/presentation/screens/share_card_screen.dart';
import '../../features/radio/presentation/screens/radio_screen.dart';
import '../../features/mosques/presentation/screens/mosques_screen.dart';
import '../../features/search/presentation/screens/search_screen.dart';
import '../../features/gateway/presentation/screens/gateway_intro_screen.dart';
import '../../features/gateway/presentation/screens/gateway_journey_screen.dart';
import '../../features/gateway/presentation/screens/gateway_principles_screen.dart';
import '../../features/gateway/presentation/screens/gateway_topic_screen.dart';
import '../../features/gateway/presentation/screens/gateway_library_screen.dart';
import '../../features/library/presentation/screens/library_home_screen.dart';
import '../../features/library/presentation/screens/library_section_screen.dart';
import '../../features/khatmah/presentation/screens/khatmah_list_screen.dart';
import '../../features/khatmah/presentation/screens/khatmah_create_screen.dart';
import '../../features/khatmah/presentation/screens/khatmah_detail_screen.dart';
import '../../features/quran/presentation/screens/page_reader_screen.dart';
import '../../features/library/presentation/screens/library_items_screen.dart';
import '../../features/library/presentation/screens/library_type_categories_screen.dart';

// ─── More Screen ──────────────────────────────────────────
class MoreScreen extends ConsumerWidget {
 const MoreScreen({super.key});

 @override
 Widget build(BuildContext context, WidgetRef ref) {
   final t     = AppLocalizations.of(context);
   final mode  = ref.watch(appModeProvider);
   final enabled = ref.watch(enabledSectionsProvider);
   final flags = FeatureFlags(mode, enabledSections: enabled);

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
             icon:  Icons.search,
             label: t.more_search,
             onTap: () => context.push('/more/search'),
           ),
           _MoreTile(
             icon:  Icons.settings,
             label: t.more_settings,
             onTap: () => context.push('/more/settings'),
           ),
           if (flags.showCalendar)
           _MoreTile(
             icon:  Icons.calendar_month,
             label: t.more_calendar,
             onTap: () => context.push('/more/calendar'),
           ),
           if (flags.showQibla)
           _MoreTile(
             icon:  Icons.explore,
             label: t.more_qibla,
             onTap: () => context.push('/more/qibla'),
           ),
           _MoreTile(
             icon:  Icons.bar_chart,
             label: t.more_stats,
             onTap: () => context.push('/more/stats'),
           ),
           if (flags.showKhatmah)
           _MoreTile(
             icon:  Icons.menu_book,
             label: t.khatmah_title,
             onTap: () => context.push('/khatmah'),
           ),
           if (flags.showShareCards)
           _MoreTile(
             icon:  Icons.card_giftcard,
             label: t.more_shareCards,
             onTap: () => context.push('/more/share', extra: {
               'title':    'آية كريمة',
               'subtitle': 'سورة البقرة',
               'content':  'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
               'type':     'quran',
             }),
           ),
           if (flags.showRadio)
           _MoreTile(
             icon:  Icons.radio,
             label: t.more_radio,
             onTap: () => context.push('/more/radio'),
           ),
           if (flags.showMosques)
           _MoreTile(
             icon:  Icons.mosque,
             label: t.more_mosques,
             onTap: () => context.push('/more/mosques'),
           ),
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
 final box          = Hive.box('settings');
 final isDone       = box.get('onboarding_done', defaultValue: false);
 final localeChosen = box.get('locale_chosen', defaultValue: false);
 final initialLoc = !localeChosen
     ? '/language'
     : (isDone ? '/home' : '/onboarding');

 return GoRouter(
   initialLocation: initialLoc,
   routes: [

     // ── Language Selection ──
     GoRoute(
       path: '/language',
       builder: (_, __) => const LanguageSelectScreen(),
     ),

     // ── Onboarding ──
     GoRoute(
       path:    '/onboarding',
       builder: (_, __) => const OnboardingScreen(),
     ),

     // ── Auth ──
     GoRoute(
       path: '/auth',
       builder: (_, __) => const AuthScreen(),
     ),
     GoRoute(
       path: '/account',
       builder: (_, __) => const AccountScreen(),
     ),
     GoRoute(
       path: '/customize-sections',
       builder: (_, __) => const CustomizeSectionsScreen(),
     ),

     // ── Main Shell ──
     StatefulShellRoute.indexedStack(
       builder: (context, state, shell) =>
           MainShell(navigationShell: shell),
       branches: [

         // ── Home + Prayer ──
         StatefulShellBranch(routes: [
           GoRoute(
             path:    '/home',
             builder: (_, __) => const HomeScreen(),
           ),
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
      path: 'group/:id',
      builder: (_, state) => AthkarCategoriesScreen(
        groupId: state.pathParameters['id']!,
        title:   state.uri.queryParameters['name'] ?? '',
      ),
    ),
    GoRoute(
      path: 'all',
      builder: (_, state) => AthkarCategoriesScreen(
        groupId: null,
        title:   state.uri.queryParameters['name'] ?? 'جميع الأقسام',
      ),
    ),
    GoRoute(
      path: 'category/:category',
      builder: (_, state) {
        final cat  = state.pathParameters['category']!;
        final name = state.uri.queryParameters['name'] ?? cat;
        return AthkarCategoryScreen(
          categoryId:   cat,
          categoryName: name,
        );
      },
    ),
             ],
           ),
         ]),

         // ── Library (formerly Hadith) ──
         StatefulShellBranch(routes: [
           GoRoute(
             path:    '/library',
             builder: (_, __) => const LibraryHomeScreen(),
           ),
         ]),

         // ── More ──
         StatefulShellBranch(routes: [
           GoRoute(
             path:    '/more',
             builder: (_, __) => const MoreScreen(),
             routes: [
               GoRoute(
                 path:    'search',
                 builder: (_, __) => const SearchScreen(),
               ),
               GoRoute(
                 path:    'settings',
                 builder: (_, __) => const SettingsScreen(),
               ),
               GoRoute(
                 path:    'calendar',
                 builder: (_, __) => const CalendarScreen(),
               ),
               GoRoute(
                 path:    'qibla',
                 builder: (_, __) => const QiblaScreen(),
               ),
               GoRoute(
                 path:    'stats',
                 builder: (_, __) => const StatsScreen(),
               ),
               GoRoute(
                 path: 'share',
                 builder: (_, state) {
                   final extra = state.extra as Map<String, String>? ?? {};
                   return ShareCardScreen(
                     title:    extra['title']    ?? '',
                     subtitle: extra['subtitle'] ?? '',
                     content:  extra['content']  ?? '',
                     type:     extra['type']     ?? 'quran',
                   );
                 },
               ),
               GoRoute(
                 path:    'radio',
                 builder: (_, __) => const RadioScreen(),
               ),
               GoRoute(
                 path:    'mosques',
                 builder: (_, __) => const MosquesScreen(),
               ),
    GoRoute(
      path:    'stories',
      builder: (_, __) => const StoriesScreen(),
    ),
    GoRoute(
      path:    'children_stories',
      builder: (_, __) => const ChildrenStoriesScreen(),
    ),
             ],
           ),
         ]),
       ],
     ),

     // ── بوابة غير المسلمين (خارج الـ shell: شاشات كاملة بزر رجوع) ──
     GoRoute(
       path: '/gateway',
       builder: (_, __) => const GatewayIntroScreen(),
       routes: [
         GoRoute(
           path: 'journey',
           builder: (_, __) => const GatewayJourneyScreen(),
         ),
         GoRoute(
           path: 'principles',
           builder: (_, __) => const GatewayPrinciplesScreen(),
           routes: [
             GoRoute(
               path: ':topicId',
               builder: (_, state) => GatewayTopicScreen(
                 topicId: state.pathParameters['topicId'] ?? '',
               ),
             ),
           ],
         ),
         GoRoute(
           path: 'library/:categoryId',
           builder: (_, state) => GatewayLibraryScreen(
             categoryId: state.pathParameters['categoryId'] ?? '',
           ),
         ),
       ],
     ),

     // ── المكتبة الشاملة: قسم وتصنيفات فرعية وعناصر ──
     GoRoute(
       path: '/library/items/:categoryId',
       builder: (_, state) => LibraryItemsScreen(
         categoryId: state.pathParameters['categoryId'] ?? '',
         type: state.uri.queryParameters['type'] ?? 'showall',
       ),
     ),
     GoRoute(
       path: '/library/:sectionId/:blockType',
       builder: (_, state) => LibraryTypeCategoriesScreen(
         sectionId: state.pathParameters['sectionId'] ?? '',
         blockType: state.pathParameters['blockType'] ?? 'books',
       ),
     ),
     GoRoute(
       path: '/library/:sectionId',
       builder: (_, state) => LibrarySectionScreen(
         sectionId: state.pathParameters['sectionId'] ?? '',
       ),
     ),

     // ── الختمة (خارج الـ shell: شاشات كاملة بزر رجوع) ──
     GoRoute(
       path: '/khatmah',
       builder: (_, __) => const KhatmahListScreen(),
       routes: [
         GoRoute(
           path: 'create',
           builder: (_, __) => const KhatmahCreateScreen(),
         ),
         GoRoute(
           path: 'detail/:id',
           builder: (_, state) => KhatmahDetailScreen(
             khatmahId: state.pathParameters['id']!,
           ),
         ),
       ],
     ),

     // ── وضع قراءة الصفحات (المصحف بالصفحات) ──
     GoRoute(
       path: '/page-reader',
       builder: (_, state) => PageReaderScreen(
         initialPage: int.tryParse(
                 state.uri.queryParameters['page'] ?? '1') ??
             1,
         khatmahId: state.uri.queryParameters['khatmah'],
       ),
     ),
   ],
 );
});