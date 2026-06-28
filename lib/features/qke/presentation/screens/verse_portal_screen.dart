import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/citation_badge.dart';
import '../../data/qke_repository.dart';
import '../../../../core/constants/translations.dart';
import '../../data/translation_service.dart';

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

  // بناء قائمة الصفحات ديناميكياً
  List<_PageItem> _buildPageItems(PortalData portal) {
    final pages = <_PageItem>[];

    // الفهم السريع
    final muyassar = portal.tafsirs
        .where((t) => t.sourceId == 'muyassar-ar')
        .firstOrNull;
    pages.add(_PageItem(
      id:    'quick',
      icon:  Icons.lightbulb_outline,
      label: 'الفهم السريع',
    ));

    // كل مفسّر بصفحة مستقلة
    for (final t in portal.tafsirs) {
      if (t.sourceId == 'muyassar-ar') continue; // مدرج في الفهم السريع
      final src = tafsirSourcesMap[t.sourceId];
      pages.add(_PageItem(
        id:    t.sourceId,
        icon:  _iconForSource(t.sourceId),
        label: src?['scholar'] ?? t.scholar,
      ));
    }

    // الشرح اللغوي
    if (portal.words.isNotEmpty) {
      pages.add(_PageItem(
        id:    'words',
        icon:  Icons.translate,
        label: 'الشرح اللغوي',
      ));
    }

    // سبب النزول
    if (portal.asbabAlNuzul != null) {
      pages.add(_PageItem(
        id:    'asbab',
        icon:  Icons.history_edu,
        label: 'سبب النزول',
      ));
    }

    // الترجمات
    pages.add(_PageItem(
      id:    'translations',
      icon:  Icons.translate,
      label: 'ترجمات',
    ));

    // الأحاديث المتعلقة بالآية (قريباً)
    pages.add(_PageItem(
      id:    'hadiths',
      icon:  Icons.format_quote,
      label: 'أحاديث',
      comingSoon: true,
    ));

    // القصص والسير (قريباً)
    pages.add(_PageItem(
      id:    'stories',
      icon:  Icons.auto_stories,
      label: 'قصص وسير',
      comingSoon: true,
    ));

    return pages;
  }

  IconData _iconForSource(String sourceId) {
    switch (sourceId) {
      case 'tabari-ar':     return Icons.menu_book;
      case 'ibn-kathir-ar': return Icons.book;
      case 'baghawi-ar':    return Icons.library_books;
      case 'saadi-ar':      return Icons.bookmark;
      case 'mukhtasar-ar':  return Icons.article;
      case 'mukhtasar-en':  return Icons.language;
      case 'mukhtasar-bn':  return Icons.translate;
      default:              return Icons.menu_book;
    }
  }

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
          child: CircularProgressIndicator(color: palette.accentPrimary)),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: palette.textSecondary, size: 48),
              const SizedBox(height: 16),
              Text('تعذّر فتح البوابة',
                style: TextStyle(color: palette.textPrimary, fontSize: 16)),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('رجوع',
                  style: TextStyle(color: palette.accentPrimary)),
              ),
            ],
          ),
        ),
        data: (portal) {
          final pages = _buildPageItems(portal);
          return SafeArea(
            child: Column(
              children: [

                // ─── Header ────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: palette.textPrimary),
                        onPressed: () => Navigator.pop(context),
                      ),
                      IconButton(
                        icon: Icon(Icons.share_outlined,
                          color: palette.accentPrimary),
                        onPressed: () => context.push('/more/share', extra: {
                          'title':    'آية كريمة',
                          'subtitle': '${portal.surahName} · آية ${portal.ayahNumber}',
                          'content':  portal.textUthmani,
                          'type':     'quran',
                        }),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(portal.surahName,
                              style: TextStyle(
                                color:      palette.textPrimary,
                                fontSize:   17,
                                fontWeight: FontWeight.w500,
                              )),
                            Text(
                              'آية ${portal.ayahNumber}/${portal.ayahCount} · ${portal.revelationType == "Meccan" ? "مكية" : "مدنية"}',
                              style: TextStyle(
                                color:    palette.accentPrimary,
                                fontSize: 12,
                              )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ─── الآية ─────────────────────────────
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxHeight: 160),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: palette.accentPrimary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: palette.accentPrimary.withOpacity(0.2)),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      portal.textUthmani,
                      textAlign:     TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color:      palette.textPrimary,
                        fontSize:   22,
                        height:     2.0,
                        fontFamily: 'QuranFont',
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // ─── فهرس الصفحات (أفقي) ───────────────
                SizedBox(
                  height: 56,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: pages.length,
                    itemBuilder: (_, i) {
                      final active = i == _currentPage;
                      final page   = pages[i];
                      return GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(i,
                            duration: const Duration(milliseconds: 300),
                            curve:    Curves.easeInOut);
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 6),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: active
                                ? palette.accentPrimary
                                : palette.surface,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: active
                                  ? palette.accentPrimary
                                  : palette.accentPrimary.withOpacity(0.2)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                page.comingSoon
                                    ? Icons.lock_outline
                                    : page.icon,
                                size:  14,
                                color: active
                                    ? Colors.white
                                    : palette.textSecondary,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                page.label,
                                style: TextStyle(
                                  color: active
                                      ? Colors.white
                                      : palette.textSecondary,
                                  fontSize:   12,
                                  fontWeight: active
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                // ─── محتوى الصفحات ──────────────────────
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (i) => setState(() => _currentPage = i),
                    itemCount: pages.length,
                    itemBuilder: (_, i) {
                      final page = pages[i];

                if (page.id == 'translations') {
                  return _TranslationsPage(
                    palette:    palette,
                    surahId:    widget.surahId,
                    ayahNumber: widget.ayahNumber,
                  );
                }
                      if (page.comingSoon) {
                        if (page.id == 'hadiths') {
                          return _HadithsPage(
                            palette: palette,
                            hadiths: portal.relatedHadiths,
                          );
                        }
                        return _ComingSoonPage(
                          palette: palette,
                          title:   page.label,
                        );
                      }

                      if (page.id == 'quick') {
                        final muyassar = portal.tafsirs
                            .where((t) => t.sourceId == 'muyassar-ar')
                            .firstOrNull;
                        return _TafsirPage(
                          title:    'الفهم السريع',
                          text:     muyassar?.text ?? 'لا يتوفر تفسير ميسّر.',
                          sourceId: 'muyassar-ar',
                          palette:  palette,
                        );
                      }

                      if (page.id == 'words') {
                        return _WordsPage(
                          words:   portal.words,
                          palette: palette,
                        );
                      }

                      if (page.id == 'asbab') {
                        return _AsbabPage(
                          text:    portal.asbabAlNuzul!,
                          palette: palette,
                        );
                      }

                      // صفحة مفسّر
                      final tafsir = portal.tafsirs
                          .where((t) => t.sourceId == page.id)
                          .firstOrNull;
                      if (tafsir == null) {
                        return _EmptyPage(
                          message: 'لا يتوفر هذا التفسير للآية',
                          palette: palette,
                        );
                      }
                      return _TafsirPage(
                        title:    page.label,
                        text:     tafsir.text,
                        sourceId: tafsir.sourceId,
                        palette:  palette,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// نموذج صفحة الفهرس
// ═══════════════════════════════════════════════════════════
class _PageItem {
  final String   id;
  final IconData icon;
  final String   label;
  final bool     comingSoon;

  _PageItem({
    required this.id,
    required this.icon,
    required this.label,
    this.comingSoon = false,
  });
}

// ═══════════════════════════════════════════════════════════
// صفحة تفسير
// ═══════════════════════════════════════════════════════════
class _TafsirPage extends StatelessWidget {
  final String  title;
  final String  text;
  final String  sourceId;
  final dynamic palette;

  const _TafsirPage({
    required this.title,
    required this.text,
    required this.sourceId,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    final src = tafsirSourcesMap[sourceId];
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Citation
          CitationBadge(
            scholar:   src?['scholar'] ?? title,
            bookTitle: src?['bookTitle'] ?? '',
            palette:   palette,
          ),
          const SizedBox(height: 16),
          // النص — اكتشاف اللغة تلقائياً
          Builder(builder: (context) {
            final isArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(text);
            return Text(
              text,
              textAlign:     isArabic ? TextAlign.right : TextAlign.left,
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              style: TextStyle(
                color:    palette.textPrimary,
                fontSize: 16,
                height:   1.9,
                fontFamily: isArabic ? null : 'sans-serif',
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// صفحة الشرح اللغوي
// ═══════════════════════════════════════════════════════════
class _WordsPage extends StatelessWidget {
  final List<WordMeaning> words;
  final dynamic           palette;

  const _WordsPage({required this.words, required this.palette});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CitationBadge(
            scholar:   'مركز تفسير',
            bookTitle: 'Tafsir MCP — 77,432 كلمة',
            palette:   palette,
            compact:   true,
          ),
          const SizedBox(height: 16),
          ...words.map((w) => Container(
            margin:  const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color:        palette.surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: palette.accentPrimary.withOpacity(0.15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // الكلمة بخط قرآني ولون مميز
                if (w.wordText.isNotEmpty) ...[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: palette.accentPrimary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      w.wordText,
                      textAlign:     TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color:      palette.accentPrimary,
                        fontSize:   22,
                        fontFamily: 'QuranFont',
                        height:     1.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                // المعنى
                Text(w.meaningAr,
                  textAlign:     TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color:    palette.textPrimary,
                    fontSize: 15,
                    height:   1.7,
                  )),
                if (w.morphology.isNotEmpty) ...[
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: palette.accentPrimary.withOpacity(0.06),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(w.morphology,
                      textAlign:     TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color:    palette.textSecondary,
                        fontSize: 12,
                      )),
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
// صفحة سبب النزول
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
          CitationBadge(
            scholar:   'مركز تفسير',
            bookTitle: 'Tafsir MCP — أسباب النزول',
            palette:   palette,
            compact:   true,
          ),
          const SizedBox(height: 16),
          Text(text,
            textAlign:     TextAlign.right,
            textDirection: TextDirection.rtl,
            style: TextStyle(
              color:    palette.textPrimary,
              fontSize: 16,
              height:   1.9,
            )),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// صفحة قريباً
// ═══════════════════════════════════════════════════════════
class _ComingSoonPage extends StatelessWidget {
  final dynamic palette;
  final String  title;
  const _ComingSoonPage({required this.palette, this.title = 'قريباً'});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_stories,
            size:  64,
            color: palette.textSecondary.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(title,
            style: TextStyle(
              color:      palette.textPrimary,
              fontSize:   18,
              fontWeight: FontWeight.w500,
            )),
          const SizedBox(height: 8),
          Text('قريباً — بعد استيراد الأحاديث',
            style: TextStyle(
              color:    palette.textSecondary,
              fontSize: 14,
            )),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// صفحة فارغة
// ═══════════════════════════════════════════════════════════
class _EmptyPage extends StatelessWidget {
  final String  message;
  final dynamic palette;

  const _EmptyPage({required this.message, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(message,
        style: TextStyle(color: palette.textSecondary, fontSize: 15)),
    );
  }
}

// ─── Hadiths Page ─────────────────────────────────────────
class _HadithsPage extends StatelessWidget {
  final dynamic              palette;
  final List<RelatedHadith>  hadiths;
  const _HadithsPage({required this.palette, required this.hadiths});

  @override
  Widget build(BuildContext context) {
    if (hadiths.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.format_quote, size: 64, color: palette.textSecondary),
            const SizedBox(height: 16),
            Text('لا توجد أحاديث مرتبطة بهذه الآية حتى الآن',
              textAlign: TextAlign.center,
              style: TextStyle(color: palette.textSecondary, fontSize: 14)),
            const SizedBox(height: 8),
            Text('نعمل على إضافة المحتوى تدريجياً',
              style: TextStyle(color: palette.textSecondary, fontSize: 12)),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: hadiths.length,
      itemBuilder: (_, i) {
        final h = hadiths[i];
        return Container(
          margin:  const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:        palette.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: palette.accentPrimary.withOpacity(0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('حديث \${h.hadithNumber}',
                    style: TextStyle(color: palette.textSecondary, fontSize: 12)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color:        palette.accentPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(h.bookName,
                      style: TextStyle(color: palette.accentPrimary, fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(h.text,
                textAlign:     TextAlign.right,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color:    palette.textPrimary,
                  fontSize: 14,
                  height:   1.8,
                )),
            ],
          ),
        );
      },
    );
  }
}

// ─── Translations Page ────────────────────────────────────
class _TranslationsPage extends ConsumerWidget {
  final dynamic palette;
  final int     surahId;
  final int     ayahNumber;
  const _TranslationsPage({
    required this.palette,
    required this.surahId,
    required this.ayahNumber,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: quranTranslations.map((t) {
        final async = ref.watch(translationProvider((
          edition:    t['edition']!,
          surahId:    surahId,
          ayahNumber: ayahNumber,
        )));
        final isRtl = t['direction'] == 'rtl';
        return Container(
          margin:  const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:        palette.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: palette.accentPrimary.withOpacity(0.1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(t['author'] ?? '',
                    style: TextStyle(color: palette.textSecondary, fontSize: 11)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color:        palette.accentPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(t['language'] ?? '',
                      style: TextStyle(color: palette.accentPrimary, fontSize: 13,
                        fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              async.when(
                loading: () => Center(
                  child: SizedBox(height: 20, width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2, color: palette.accentPrimary))),
                error: (e, _) => Text('تعذّر التحميل',
                  style: TextStyle(color: palette.textSecondary, fontSize: 13)),
                data: (text) => Text(text,
                  textAlign:     isRtl ? TextAlign.right : TextAlign.left,
                  textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                  style: TextStyle(
                    color:    palette.textPrimary,
                    fontSize: 15,
                    height:   1.8,
                  )),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
