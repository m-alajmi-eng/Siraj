import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/main_shell.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/hadith/presentation/screens/hadith_categories_screen.dart';
import '../../features/hadith/presentation/screens/hadith_list_screen.dart';
import '../../features/qke/presentation/screens/adwaa_bayan_reader_screen.dart';
import '../../features/stories/presentation/screens/stories_screen.dart';
import '../../features/stories/presentation/screens/children_stories_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/auth_screen.dart';
import '../../features/language/presentation/screens/language_select_screen.dart';
import '../../features/auth/presentation/screens/account_screen.dart';
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
import '../../features/library/presentation/screens/library_items_screen.dart';
import '../../features/library/presentation/screens/library_type_categories_screen.dart';
import '../../features/library/presentation/screens/library_authors_screen.dart';
import '../../features/library/presentation/screens/author_items_screen.dart';
import '../../features/more/presentation/screens/more_screen.dart';
import '../../features/settings/presentation/screens/licenses_screen.dart';

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
       builder: (_, _) => const LanguageSelectScreen(),
     ),

     // ── Onboarding ──
     GoRoute(
       path:    '/onboarding',
       builder: (_, _) => const OnboardingScreen(),
     ),

     // ── Auth ──
     GoRoute(
       path: '/auth',
       builder: (_, _) => const AuthScreen(),
     ),
     GoRoute(
       path: '/account',
       builder: (_, _) => const AccountScreen(),
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
             builder: (_, _) => const HomeScreen(),
           ),
           GoRoute(
             path:    '/prayer',
             builder: (_, _) => const PrayerScreen(),
           ),
         ]),

         // ── Quran ──
         StatefulShellBranch(routes: [
           GoRoute(
             path:    '/quran',
             builder: (_, _) => const QuranHomeScreen(),
             routes: [
               GoRoute(
                 path: 'surah/:id',
                 builder: (_, state) => SurahReaderScreen(
                   surahId: int.parse(
                     state.pathParameters['id']!),
                   khatmahId: state.uri.queryParameters['khatmah'],
                 ),
               ),
               GoRoute(
                 path:    'search',
                 builder: (_, _) => const QuranSearchScreen(),
               ),
             ],
           ),
         ]),

         // ── Athkar ──
         StatefulShellBranch(routes: [
           GoRoute(
             path:    '/athkar',
             builder: (_, _) => const AthkarHomeScreen(),
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
             builder: (_, _) => const LibraryHomeScreen(),
           ),
         ]),

         // ── More ──
         StatefulShellBranch(routes: [
           GoRoute(
             path:    '/more',
             builder: (_, _) => const MoreScreen(),
             routes: [
               GoRoute(
                 path:    'search',
                 builder: (_, _) => const SearchScreen(),
               ),
               GoRoute(
                 path:    'settings',
                 builder: (_, _) => const SettingsScreen(),
                 routes: [
                   GoRoute(
                     path:    'licenses',
                     builder: (_, _) => const LicensesScreen(),
                   ),
                 ],
               ),
               GoRoute(
                 path:    'calendar',
                 builder: (_, _) => const CalendarScreen(),
               ),
               GoRoute(
                 path:    'qibla',
                 builder: (_, _) => const QiblaScreen(),
               ),
               GoRoute(
                 path:    'stats',
                 builder: (_, _) => const StatsScreen(),
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
                 builder: (_, _) => const RadioScreen(),
               ),
               // مسارات الحديث القديمة (ADR-009): تحويل دائم لـ/library/hadith/...
               // — الحديث أصبح قسماً أول داخل المكتبة، مصدر حقيقة واحد بلا تكرار.
               GoRoute(
                 path: 'hadith-categories',
                 redirect: (_, _) => '/library/hadith',
               ),
               GoRoute(
                 path: 'hadith/:categoryId',
                 redirect: (_, state) =>
                     '/library/hadith/${state.pathParameters['categoryId']}',
               ),
               GoRoute(
                 path:    'adwaa-bayan/:pageNumber',
                 builder: (context, state) {
                   final pageNumber =
                       int.parse(state.pathParameters['pageNumber']!);
                   return AdwaaBayanReaderScreen(pageNumber: pageNumber);
                 },
               ),
               GoRoute(
                 path:    'mosques',
                 builder: (_, _) => const MosquesScreen(),
               ),
    GoRoute(
      path:    'stories',
      builder: (_, _) => const StoriesScreen(),
    ),
    GoRoute(
      path:    'children_stories',
      builder: (_, _) => const ChildrenStoriesScreen(),
    ),
             ],
           ),
         ]),
       ],
     ),

     // ── بوابة غير المسلمين (خارج الـ shell: شاشات كاملة بزر رجوع) ──
     GoRoute(
       path: '/gateway',
       builder: (_, _) => const GatewayIntroScreen(),
       routes: [
         GoRoute(
           path: 'journey',
           builder: (_, _) => const GatewayJourneyScreen(),
         ),
         GoRoute(
           path: 'principles',
           builder: (_, _) => const GatewayPrinciplesScreen(),
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
     // ── الحديث: قسم أول داخل المكتبة (ADR-009) — مصدر حقيقة واحد،
     // مسارات حرفية `hadith` مُعرَّفة قبل `:sectionId` العام كي تُطابَق
     // أولاً (نفس نظام التصنيف/القوائم القديم المبني على Supabase، فقط
     // بمسار جديد؛ لا علاقة له بقسم "hadith" في مكتبة IslamHouse العامة
     // الذي يبقى يعمل لبقية الأقسام عبر LibrarySectionScreen).
     GoRoute(
       path: '/library/hadith',
       builder: (_, _) => const HadithCategoriesScreen(),
     ),
     GoRoute(
       path: '/library/hadith/:categoryId',
       builder: (context, state) {
         final categoryId = int.parse(state.pathParameters['categoryId']!);
         final categoryTitle = state.extra as String? ?? 'الأحاديث';
         return HadithListScreen(
           categoryId: categoryId,
           categoryTitle: categoryTitle,
         );
       },
     ),
     // ── المؤلفون: قسم ثامن داخل المكتبة (ADR-013) — مسارات حرفية
     // `authors` قبل `:sectionId` العام لنفس سبب `hadith` أعلاه.
     GoRoute(
       path: '/library/authors',
       builder: (_, _) => const LibraryAuthorsScreen(),
     ),
     GoRoute(
       path: '/library/authors/:authorId',
       builder: (_, state) => AuthorItemsScreen(
         authorId: state.pathParameters['authorId'] ?? '',
         authorName: state.extra as String? ?? '',
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
       builder: (_, _) => const KhatmahListScreen(),
       routes: [
         GoRoute(
           path: 'create',
           builder: (_, _) => const KhatmahCreateScreen(),
         ),
         GoRoute(
           path: 'detail/:id',
           builder: (_, state) => KhatmahDetailScreen(
             khatmahId: state.pathParameters['id']!,
           ),
         ),
       ],
     ),

   ],
 );
});