import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/citation_badge.dart';
import '../../data/qke_repository.dart';

class VersePortalScreen extends ConsumerStatefulWidget {
 final int surahId;
 final int ayahNumber;

 const VersePortalScreen({
   super.key,
   required this.surahId,
   required this.ayahNumber,
 });

 @override
 ConsumerState<VersePortalScreen> createState() => _VersePortalScreenState();
}

class _VersePortalScreenState extends ConsumerState<VersePortalScreen> {
 final PageController _pageController = PageController();
 int _currentPage = 0;

 @override
 void dispose() {
   _pageController.dispose();
   super.dispose();
 }

 @override
 Widget build(BuildContext context) {
   final palette = ref.watch(timeThemeProvider);
   final portalAsync = ref.watch(portalProvider((
     surahId:    widget.surahId,
     ayahNumber: widget.ayahNumber,
   )));

   return Scaffold(
     backgroundColor: palette.background,
     body: portalAsync.when(
       loading: () => Center(
         child: CircularProgressIndicator(color: palette.accentPrimary),
       ),
       error: (e, _) => Center(
         child: Padding(
           padding: const EdgeInsets.all(24),
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               Icon(Icons.error_outline,
                 color: palette.textSecondary, size: 48),
               const SizedBox(height: 16),
               Text(
                 'تعذّر فتح البوابة',
                 textAlign: TextAlign.center,
                 style: TextStyle(color: palette.textPrimary, fontSize: 16),
               ),
               const SizedBox(height: 8),
               TextButton(
                 onPressed: () => Navigator.pop(context),
                 child: Text('رجوع',
                   style: TextStyle(color: palette.accentPrimary)),
               ),
             ],
           ),
         ),
       ),
       data: (portal) => SafeArea(
         child: Column(
           children: [

             // ─── Header ─────────────────────────────
             Padding(
               padding: const EdgeInsets.all(16),
               child: Row(
                 children: [
                   IconButton(
                     icon: Icon(Icons.close, color: palette.textPrimary),
                     onPressed: () => Navigator.pop(context),
                   ),
                   IconButton(
                     icon: Icon(Icons.share_outlined,
                       color: palette.accentPrimary),
                     onPressed: () {
                       context.push('/more/share', extra: {
                         'title':    'آية كريمة',
                         'subtitle': '${portal.surahName} · آية ${portal.ayahNumber}',
                         'content':  portal.textUthmani,
                         'type':     'quran',
                       });
                     },
                   ),
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                         Text(
                           portal.surahName,
                           style: TextStyle(
                             color:      palette.textPrimary,
                             fontSize:   18,
                             fontWeight: FontWeight.w500,
                           ),
                         ),
                         Text(
                           'آية ${portal.ayahNumber} · ${portal.revelationType == "Meccan" ? "مكية" : "مدنية"}',
                           style: TextStyle(
                             color:    palette.accentPrimary,
                             fontSize: 12,
                           ),
                         ),
                       ],
                     ),
                   ),
                 ],
               ),
             ),

             // ─── الآية ──────────────────────────────
             Container(
               width: double.infinity,
               constraints: const BoxConstraints(maxHeight: 180),
               margin: const EdgeInsets.symmetric(horizontal: 20),
               padding: const EdgeInsets.all(20),
               decoration: BoxDecoration(
                 color: palette.accentPrimary.withOpacity(0.08),
                 borderRadius: BorderRadius.circular(20),
                 border: Border.all(
                   color: palette.accentPrimary.withOpacity(0.2)),
               ),
               child: SingleChildScrollView(
                 child: Text(
                   portal.textUthmani,
                   textAlign: TextAlign.center,
                   textDirection: TextDirection.rtl,
                   style: TextStyle(
                     color:      palette.textPrimary,
                     fontSize:   24,
                     height:     2.0,
                     fontFamily: 'QuranFont',
                   ),
                 ),
               ),
             ),

             const SizedBox(height: 16),

             // ─── أزرار التنقل + مؤشر الصفحات ─────────
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                 IconButton(
                   icon: Icon(Icons.chevron_left,
                     color: _currentPage < _pageCount(portal) - 1
                         ? palette.accentPrimary
                         : palette.textSecondary.withOpacity(0.3),
                     size: 32),
                   onPressed: _currentPage < _pageCount(portal) - 1
                       ? () => _pageController.nextPage(
                           duration: const Duration(milliseconds: 300),
                           curve: Curves.easeInOut)
                       : null,
                 ),
                 Row(
                   mainAxisSize: MainAxisSize.min,
                   children: List.generate(_pageCount(portal), (i) {
                     final active = i == _currentPage;
                     return AnimatedContainer(
                       duration: const Duration(milliseconds: 250),
                       margin: const EdgeInsets.symmetric(horizontal: 4),
                       width:  active ? 24 : 8,
                       height: 8,
                       decoration: BoxDecoration(
                         color: active
                             ? palette.accentPrimary
                             : palette.accentPrimary.withOpacity(0.3),
                         borderRadius: BorderRadius.circular(4),
                       ),
                     );
                   }),
                 ),
                 IconButton(
                   icon: Icon(Icons.chevron_right,
                     color: _currentPage > 0
                         ? palette.accentPrimary
                         : palette.textSecondary.withOpacity(0.3),
                     size: 32),
                   onPressed: _currentPage > 0
                       ? () => _pageController.previousPage(
                           duration: const Duration(milliseconds: 300),
                           curve: Curves.easeInOut)
                       : null,
                 ),
               ],
             ),

             const SizedBox(height: 8),

             // ─── الطبقات (PageView) ─────────────────
             Expanded(
               child: PageView(
                 controller: _pageController,
                 onPageChanged: (i) => setState(() => _currentPage = i),
                 children: _buildPages(portal, palette),
               ),
             ),
           ],
         ),
       ),
     ),
   );
 }

 int _pageCount(PortalData p) {
   int count = 1;
   if (p.words.isNotEmpty)     count++;
   if (p.asbabAlNuzul != null) count++;
   if (p.tafsirs.isNotEmpty)   count++;
   return count;
 }

 List<Widget> _buildPages(PortalData portal, dynamic palette) {
   final pages = <Widget>[];

   final muyassar = portal.tafsirs
       .where((t) => t.sourceId == 'muyassar-ar')
       .firstOrNull;
   pages.add(_QuickUnderstanding(
     portal:   portal,
     muyassar: muyassar,
     palette:  palette,
   ));

   if (portal.words.isNotEmpty) {
     pages.add(_WordExplorer(words: portal.words, palette: palette));
   }

   if (portal.asbabAlNuzul != null) {
     pages.add(_AsbabPage(text: portal.asbabAlNuzul!, palette: palette));
   }

   if (portal.tafsirs.isNotEmpty) {
     pages.add(_TafsirExplorer(tafsirs: portal.tafsirs, palette: palette));
   }

   return pages;
 }
}

// ═══════════════════════════════════════════════════════════
// صفحة الفهم السريع
// ═══════════════════════════════════════════════════════════
class _QuickUnderstanding extends StatelessWidget {
 final PortalData    portal;
 final TafsirEntry?  muyassar;
 final dynamic       palette;

 const _QuickUnderstanding({
   required this.portal,
   required this.muyassar,
   required this.palette,
 });

 @override
 Widget build(BuildContext context) {
   return SingleChildScrollView(
     padding: const EdgeInsets.all(20),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.stretch,
       children: [
         _SectionTitle('المعنى الإجمالي', Icons.lightbulb_outline, palette),
         const SizedBox(height: 12),
         Text(
           muyassar?.text ?? 'لا يتوفر تفسير ميسّر لهذه الآية.',
           textAlign: TextAlign.right,
           textDirection: TextDirection.rtl,
           style: TextStyle(
             color:    palette.textPrimary,
             fontSize: 16,
             height:   1.9,
           ),
         ),
         if (muyassar != null) ...[
           const SizedBox(height: 16),
           CitationBadge(
             scholar:   'مجمع الملك فهد',
             bookTitle: 'التفسير الميسّر',
             palette:   palette,
             compact:   true,
           ),
         ],
       ],
     ),
   );
 }
}

// ═══════════════════════════════════════════════════════════
// مستكشف الكلمات
// ═══════════════════════════════════════════════════════════
class _WordExplorer extends StatelessWidget {
 final List<WordMeaning> words;
 final dynamic           palette;

 const _WordExplorer({required this.words, required this.palette});

 @override
 Widget build(BuildContext context) {
   return SingleChildScrollView(
     padding: const EdgeInsets.all(20),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.stretch,
       children: [
         _SectionTitle('مستكشف الكلمات', Icons.translate, palette),
         const SizedBox(height: 8),
         CitationBadge(
           scholar:   'مركز تفسير',
           bookTitle: 'Tafsir MCP — 77,432 كلمة',
           palette:   palette,
           compact:   true,
         ),
         const SizedBox(height: 16),
         ...words.map((w) => Container(
           margin: const EdgeInsets.only(bottom: 12),
           padding: const EdgeInsets.all(16),
           decoration: BoxDecoration(
             color:        palette.surface,
             borderRadius: BorderRadius.circular(14),
           ),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.end,
             children: [
               Text(
                 w.meaningAr,
                 textAlign:     TextAlign.right,
                 textDirection: TextDirection.rtl,
                 style: TextStyle(
                   color:    palette.textPrimary,
                   fontSize: 15,
                   height:   1.7,
                 ),
               ),
               if (w.morphology.isNotEmpty) ...[
                 const SizedBox(height: 8),
                 Text(
                   w.morphology,
                   textAlign:     TextAlign.right,
                   textDirection: TextDirection.rtl,
                   style: TextStyle(
                     color:    palette.textSecondary,
                     fontSize: 13,
                     height:   1.6,
                   ),
                 ),
               ],
             ],
           ),
         )),
       ],
     ),
   );
 }
}

// ═══════════════════════════════════════════════════════════
// أسباب النزول
// ═══════════════════════════════════════════════════════════
class _AsbabPage extends StatelessWidget {
 final String  text;
 final dynamic palette;

 const _AsbabPage({required this.text, required this.palette});

 @override
 Widget build(BuildContext context) {
   return SingleChildScrollView(
     padding: const EdgeInsets.all(20),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.stretch,
       children: [
         _SectionTitle('سبب النزول', Icons.history_edu, palette),
         const SizedBox(height: 12),
         Text(
           text,
           textAlign:     TextAlign.right,
           textDirection: TextDirection.rtl,
           style: TextStyle(
             color:    palette.textPrimary,
             fontSize: 16,
             height:   1.9,
           ),
         ),
         const SizedBox(height: 16),
         CitationBadge(
           scholar:   'مركز تفسير',
           bookTitle: 'Tafsir MCP — أسباب النزول',
           palette:   palette,
           compact:   true,
         ),
       ],
     ),
   );
 }
}

// ═══════════════════════════════════════════════════════════
// مستكشف التفاسير
// ═══════════════════════════════════════════════════════════
class _TafsirExplorer extends StatelessWidget {
 final List<TafsirEntry> tafsirs;
 final dynamic           palette;

 const _TafsirExplorer({required this.tafsirs, required this.palette});

 @override
 Widget build(BuildContext context) {
   return SingleChildScrollView(
     padding: const EdgeInsets.all(20),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.stretch,
       children: [
         _SectionTitle('التفاسير', Icons.menu_book, palette),
         const SizedBox(height: 16),
         ...tafsirs.map((t) {
           final src = tafsirSourcesMap[t.sourceId];
           return Container(
             margin: const EdgeInsets.only(bottom: 16),
             padding: const EdgeInsets.all(16),
             decoration: BoxDecoration(
               color:        palette.surface,
               borderRadius: BorderRadius.circular(14),
             ),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.end,
               children: [
                 CitationBadge(
                   scholar:   src?['scholar'] ?? t.scholar,
                   bookTitle: src?['bookTitle'] ?? t.bookTitle,
                   palette:   palette,
                 ),
                 const SizedBox(height: 12),
                 Text(
                   t.text,
                   textAlign:     TextAlign.right,
                   textDirection: TextDirection.rtl,
                   style: TextStyle(
                     color:    palette.textPrimary,
                     fontSize: 15,
                     height:   1.9,
                   ),
                 ),
               ],
             ),
           );
         }),
       ],
     ),
   );
 }
}

// ═══════════════════════════════════════════════════════════
// عناصر مساعدة
// ═══════════════════════════════════════════════════════════
class _SectionTitle extends StatelessWidget {
 final String   title;
 final IconData icon;
 final dynamic  palette;

 const _SectionTitle(this.title, this.icon, this.palette);

 @override
 Widget build(BuildContext context) {
   return Row(
     mainAxisAlignment: MainAxisAlignment.end,
     children: [
       Text(
         title,
         style: TextStyle(
           color:      palette.textPrimary,
           fontSize:   20,
           fontWeight: FontWeight.w600,
         ),
       ),
       const SizedBox(width: 8),
       Icon(icon, color: palette.accentPrimary, size: 22),
     ],
   );
 }
}

class _SourceBadge extends StatelessWidget {
 final String  label;
 final dynamic palette;

 const _SourceBadge(this.label, this.palette);

 @override
 Widget build(BuildContext context) {
   return Container(
     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
     decoration: BoxDecoration(
       color: palette.accentPrimary.withOpacity(0.12),
       borderRadius: BorderRadius.circular(8),
       border: Border.all(color: palette.accentPrimary.withOpacity(0.3)),
     ),
     child: Row(
       mainAxisSize: MainAxisSize.min,
       children: [
         Text(
           label,
           style: TextStyle(
             color:      palette.accentPrimary,
             fontSize:   12,
             fontWeight: FontWeight.w500,
           ),
         ),
         const SizedBox(width: 4),
         Icon(Icons.verified, size: 12, color: palette.accentPrimary),
       ],
     ),
   );
 }
}