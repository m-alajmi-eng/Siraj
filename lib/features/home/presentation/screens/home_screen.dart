import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../prayer/presentation/providers/prayer_provider.dart';
import '../../../calendar/presentation/providers/calendar_provider.dart';
import '../../../../core/storage/cache_service.dart';

class HomeScreen extends ConsumerWidget {
 const HomeScreen({super.key});

 @override
 Widget build(BuildContext context, WidgetRef ref) {
   final palette     = ref.watch(timeThemeProvider);
   final prayerAsync = ref.watch(prayerTimesProvider);
   final hijriDate   = ref.watch(hijriTodayProvider);
   final hijriToday  = '${hijriDate.day} ${_monthName(hijriDate.month)} ${hijriDate.year}هـ';
   final nextEvent   = ref.watch(nextEventProvider);
    final lastSurahId    = CacheService.getSetting('last_surah_id') as int?;
    final lastAyahNumber = CacheService.getSetting('last_ayah_number') as int?;

   return Scaffold(
     backgroundColor: palette.background,
     body: SafeArea(
       child: SingleChildScrollView(
         padding: const EdgeInsets.all(20),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [

             // ─── التاريخ ──────────────────────────────
             Text(
               hijriToday,
               textAlign: TextAlign.right,
               style: TextStyle(
                 color:    palette.textSecondary,
                 fontSize: 14,
               ),
             ),

             const SizedBox(height: 4),

             Text(
               _getDayName(),
               textAlign: TextAlign.right,
               style: TextStyle(
                 color:      palette.textPrimary,
                 fontSize:   32,
                 fontWeight: FontWeight.w300,
               ),
             ),

             const SizedBox(height: 24),

             // ─── بطاقة الصلاة القادمة ─────────────────
             prayerAsync.when(
               loading: () => _PrayerCardShimmer(palette: palette),
               error:   (_, __) => const SizedBox.shrink(),
               data: (times) {
                 final next = _getNextPrayer(times);
                 return GestureDetector(
                   onTap: () => context.go('/prayer'),
                   child: Container(
                     padding: const EdgeInsets.all(20),
                     decoration: BoxDecoration(
                       gradient: LinearGradient(
                         colors: [
                           palette.accentPrimary.withOpacity(0.8),
                           palette.accentPrimary.withOpacity(0.4),
                         ],
                         begin: Alignment.topRight,
                         end:   Alignment.bottomLeft,
                       ),
                       borderRadius: BorderRadius.circular(20),
                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                         Text(
                           'الصلاة القادمة',
                           style: TextStyle(
                             color:    palette.background.withOpacity(0.8),
                             fontSize: 12,
                           ),
                         ),
                         const SizedBox(height: 4),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(
                               next['time'] ?? '',
                               style: TextStyle(
                                 color:      palette.background,
                                 fontSize:   28,
                                 fontWeight: FontWeight.w300,
                                 fontFamily: 'monospace',
                               ),
                             ),
                             Text(
                               next['name'] ?? '',
                               style: TextStyle(
                                 color:      palette.background,
                                 fontSize:   24,
                                 fontWeight: FontWeight.w500,
                               ),
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),
                 );
               },
             ),

             const SizedBox(height: 16),

             // ─── المناسبة القادمة ─────────────────────
             if (nextEvent != null)
               Container(
                 padding: const EdgeInsets.all(16),
                 decoration: BoxDecoration(
                   color:        palette.surface,
                   borderRadius: BorderRadius.circular(14),
                   border: Border.all(
                     color: palette.accentPrimary.withOpacity(0.2)),
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     Container(
                       padding: const EdgeInsets.symmetric(
                         horizontal: 10, vertical: 4),
                       decoration: BoxDecoration(
                         color: palette.accentPrimary.withOpacity(0.1),
                         borderRadius: BorderRadius.circular(8),
                       ),
                       child: Text(
                         '${nextEvent['days'] ?? '?'} يوم',
                         style: TextStyle(
                           color:    palette.accentPrimary,
                           fontSize: 12,
                         ),
                       ),
                     ),
                     Text(
                       (nextEvent['event'] as dynamic)?.title ?? '',
                       style: TextStyle(
                         color:      palette.textPrimary,
                         fontSize:   15,
                         fontWeight: FontWeight.w500,
                       ),
                     ),
                   ],
                 ),
               ),

             const SizedBox(height: 24),

             // ─── وصول سريع ───────────────────────────
             Text(
               'وصول سريع',
               textAlign: TextAlign.right,
               style: TextStyle(
                 color:    palette.textSecondary,
                 fontSize: 13,
               ),
             ),
             const SizedBox(height: 12),

             GridView.count(
               shrinkWrap:      true,
               physics:         const NeverScrollableScrollPhysics(),
               crossAxisCount:  3,
               mainAxisSpacing:  12,
               crossAxisSpacing: 12,
               childAspectRatio: 1.1,
               children: [
       _QuickTile(
         icon:    Icons.menu_book,
         label:   lastSurahId != null ? 'أكمل القراءة' : 'القرآن',
         palette: palette,
         onTap:   () => lastSurahId != null
             ? context.push('/quran/surah/${lastSurahId!}')
             : context.go('/quran'),
       ),
                 _QuickTile(
                   icon:    Icons.self_improvement,
                   label:   'أذكار',
                   palette: palette,
                   onTap:   () => context.go('/athkar'),
                 ),
                 _QuickTile(
                   icon:    Icons.format_quote,
                   label:   'حديث',
                   palette: palette,
                   onTap:   () => context.go('/hadith'),
                 ),
                 _QuickTile(
                   icon:    Icons.explore,
                   label:   'قبلة',
                   palette: palette,
                   onTap:   () => context.push('/more/qibla'),
                 ),
                 _QuickTile(
                   icon:    Icons.radio,
                   label:   'راديو',
                   palette: palette,
                   onTap:   () => context.push('/more/radio'),
                 ),
                 _QuickTile(
                   icon:    Icons.calendar_month,
                   label:   'تقويم',
                   palette: palette,
                   onTap:   () => context.push('/more/calendar'),
      ),
      _QuickTile(
        icon:    Icons.auto_stories,
        label:   'القصص والسير',
        palette: palette,
        onTap:   () => context.push('/more/stories'),
      ),
      _QuickTile(
        icon:    Icons.child_care,
        label:   'قصص الأطفال',
        palette: palette,
        onTap:   () => context.push('/more/children_stories'),
      ),
               ],
             ),

             const SizedBox(height: 24),

             // ─── آية اليوم ───────────────────────────
             _DailyAyah(palette: palette),

           ],
         ),
       ),
     ),
   );
 }

 String _monthName(int m) {
   const months = [
     '', 'محرم', 'صفر', 'ربيع الأول', 'ربيع الثاني',
     'جمادى الأولى', 'جمادى الآخرة', 'رجب', 'شعبان',
     'رمضان', 'شوال', 'ذو القعدة', 'ذو الحجة'
   ];
   return m < months.length ? months[m] : '';
 }

 String _getDayName() {
   const days = [
     'الأحد', 'الإثنين', 'الثلاثاء',
     'الأربعاء', 'الخميس', 'الجمعة', 'السبت'
   ];
   return days[DateTime.now().weekday % 7];
 }

 Map<String, String> _getNextPrayer(dynamic times) {
   return {
     'name': times.nextPrayerName,
     'time': '${times.nextPrayerTime.hour.toString().padLeft(2, '0')}:${times.nextPrayerTime.minute.toString().padLeft(2, '0')}',
   };
 }
}

// ─── Quick Tile ───────────────────────────────────────────
class _QuickTile extends StatelessWidget {
 final IconData     icon;
 final String       label;
 final dynamic      palette;
 final VoidCallback onTap;

 const _QuickTile({
   required this.icon,
   required this.label,
   required this.palette,
   required this.onTap,
 });

 @override
 Widget build(BuildContext context) {
   return GestureDetector(
     onTap: onTap,
     child: Container(
       decoration: BoxDecoration(
         color:        palette.surface,
         borderRadius: BorderRadius.circular(16),
       ),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Icon(icon, color: palette.accentPrimary, size: 28),
           const SizedBox(height: 8),
           Text(
             label,
             style: TextStyle(
               color:    palette.textPrimary,
               fontSize: 13,
             ),
           ),
         ],
       ),
     ),
   );
 }
}

// ─── Prayer Card Shimmer ──────────────────────────────────
class _PrayerCardShimmer extends StatelessWidget {
 final dynamic palette;
 const _PrayerCardShimmer({required this.palette});

 @override
 Widget build(BuildContext context) {
   return Container(
     height: 90,
     decoration: BoxDecoration(
       color:        palette.surface,
       borderRadius: BorderRadius.circular(20),
     ),
   );
 }
}

// ─── Daily Ayah ──────────────────────────────────────────
class _DailyAyah extends StatelessWidget {
 final dynamic palette;
 const _DailyAyah({required this.palette});

 static final List<Map<String, String>> _ayahs = [
   {'text': 'إنَّ مَعَ الْعُسْرِ يسْرًا',                           'ref': 'الشرح: ٦'},
   {'text': 'وَمَن يَتقِ اللَّهَ يَجْعَل لَّهُ مخْرَجًا',         'ref': 'الطلاق: ٢'},
   {'text': 'إِنَّ اللَّهَ مَعَ الصَّابِرِينَ',                       'ref': 'البقرة: ١٥٣'},
   {'text': 'وَقُل رَّبِّ زدْنِي عِلْمًا',                           'ref': 'طه: ١١٤'},
   {'text': 'حَسْبُنَا اللَّهُ وَنِعْمَ الْوَكِيلُ',                  'ref': 'آل عمران: ١٧٣'},
   {'text': 'فَإِنَّ معَ الْعُسْرِ يُسْرًا',                         'ref': 'الشرح: ٥'},
   {'text': 'وَتوَكَّلْ عَلَى اللَّهِ وَكَفَىٰ بِاللَّهِ وَكِيلًا', 'ref': 'الأحزاب: ٣'},
 ];

 @override
 Widget build(BuildContext context) {
   final ayah = _ayahs[DateTime.now().weekday % _ayahs.length];

   return Container(
     padding: const EdgeInsets.all(24),
     decoration: BoxDecoration(
       color:        palette.surface,
       borderRadius: BorderRadius.circular(20),
       border: Border.all(
         color: palette.accentPrimary.withOpacity(0.15)),
     ),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.stretch,
       children: [
         Row(
           mainAxisAlignment: MainAxisAlignment.end,
           children: [
             Text(
               'آية اليوم',
               style: TextStyle(
                 color:    palette.textSecondary,
                 fontSize: 12,
               ),
             ),
             const SizedBox(width: 6),
             Icon(Icons.auto_awesome,
               color: palette.accentPrimary, size: 14),
           ],
         ),
         const SizedBox(height: 16),
         Text(
           ayah['text']!,
           textAlign:     TextAlign.center,
           textDirection: TextDirection.rtl,
           style: TextStyle(
             color:      palette.textPrimary,
             fontSize:   22,
             fontFamily: 'QuranFont',
             height:     1.8,
           ),
         ),
         const SizedBox(height: 12),
         Text(
           ayah['ref']!,
           textAlign: TextAlign.center,
           style: TextStyle(
             color:    palette.accentPrimary,
             fontSize: 13,
           ),
         ),
       ],
     ),
   );
 }
}