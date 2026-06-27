import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../providers/search_provider.dart';
import '../../../qke/presentation/screens/verse_portal_screen.dart';
import '../providers/search_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final palette     = ref.watch(timeThemeProvider);
    final searchState = ref.watch(searchProvider);

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Column(
          children: [

            // ─── Header + Search Bar ──────────────────
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back,
                      color: palette.textPrimary),
                    onPressed: () {
                      ref.read(searchProvider.notifier).clear();
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color:        palette.surface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller:    _controller,
                        textDirection: TextDirection.rtl,
                        autofocus:     true,
                        style: TextStyle(
                          color:    palette.textPrimary,
                          fontSize: 15,
                        ),
                        decoration: InputDecoration(
                          hintText:  'ابحث في القرآن والتفاسير...',
                          hintStyle: TextStyle(
                            color:    palette.textSecondary,
                            fontSize: 14,
                          ),
                          border:        InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                          suffixIcon: searchState.query.isNotEmpty
                              ? IconButton(
                                  icon: Icon(Icons.clear,
                                    color: palette.textSecondary,
                                    size: 18),
                                  onPressed: () {
                                    _controller.clear();
                                    ref.read(searchProvider.notifier).clear();
                                  },
                                )
                              : Icon(Icons.search,
                                  color: palette.textSecondary),
                        ),
                        onChanged: (q) {
                          if (q.length >= 2) {
                            ref.read(searchProvider.notifier).search(q);
                          } else if (q.isEmpty) {
                            ref.read(searchProvider.notifier).clear();
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ─── Loading ──────────────────────────────
            if (searchState.isLoading)
              LinearProgressIndicator(
                color:           palette.accentPrimary,
                backgroundColor: palette.surface,
              ),

            // ─── نتائج / حالات ────────────────────────
            Expanded(
              child: searchState.query.isEmpty
                  ? _EmptyState(palette: palette)
                  : searchState.isLoading
                      ? const SizedBox.shrink()
                      : searchState.error != null
                          ? _ErrorState(
                              error:   searchState.error!,
                              palette: palette)
                          : searchState.results.isEmpty
                              ? _NoResults(
                                  query:   searchState.query,
                                  palette: palette)
                              : _ResultsList(
                                  results: searchState.results,
                                  palette: palette),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Empty State ──────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  final dynamic palette;
  const _EmptyState({required this.palette});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search,
            size:  64,
            color: palette.textSecondary.withOpacity(0.3)),
          const SizedBox(height: 16),
          Text(
            'ابحث في القرآن الكريم\nوالتفاسير ومعاني الكلمات',
            textAlign: TextAlign.center,
            style: TextStyle(
              color:    palette.textSecondary,
              fontSize: 15,
              height:   1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── No Results ───────────────────────────────────────────
class _NoResults extends StatelessWidget {
  final String  query;
  final dynamic palette;
  const _NoResults({required this.query, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off,
            size:  48,
            color: palette.textSecondary),
          const SizedBox(height: 12),
          Text(
            'لا نتائج لـ "$query"',
            style: TextStyle(
              color:    palette.textPrimary,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Error State ──────────────────────────────────────────
class _ErrorState extends StatelessWidget {
  final String  error;
  final dynamic palette;
  const _ErrorState({required this.error, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        error,
        textAlign: TextAlign.center,
        style: TextStyle(color: palette.textSecondary, fontSize: 13),
      ),
    );
  }
}

// ─── Results List ─────────────────────────────────────────
class _ResultsList extends StatelessWidget {
  final List<SearchResult> results;
  final dynamic            palette;

  const _ResultsList({
    required this.results,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding:   const EdgeInsets.symmetric(horizontal: 16),
      itemCount: results.length,
      itemBuilder: (_, i) {
        final r = results[i];
        return GestureDetector(
          onTap: () {
            if (r.surahId > 0 && r.ayahNumber > 0) {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => VersePortalScreen(
                  surahId:    r.surahId,
                  ayahNumber: r.ayahNumber,
                ),
              ));
            }
          },
          child: Container(
          margin:  const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:        palette.surface,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [

              // نوع النتيجة + المصدر
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.verified,
                        size:  12,
                        color: Colors.green.shade600),
                      const SizedBox(width: 4),
                      Text(
                        r.source ?? _typeLabel(r.type),
                        style: TextStyle(
                          color:    Colors.green.shade600,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${r.surahName} · ${r.ayahNumber}',
                        style: TextStyle(
                          color:    palette.accentPrimary,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: _typeColor(r.type).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _typeLabel(r.type),
                          style: TextStyle(
                            color:    _typeColor(r.type),
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // النص
              Text(
                r.text.length > 200
                    ? '${r.text.substring(0, 200)}...'
                    : r.text,
                textAlign:     TextAlign.right,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  color:      palette.textPrimary,
                  fontSize:   r.type == 'ayah' ? 18 : 14,
                  fontFamily: r.type == 'ayah' ? 'QuranFont' : null,
                  height:     1.7,
                ),
              ),
            ],
          ),
          ),
        );
      },
    );
  }

  String _typeLabel(String type) {
    switch (type) {
      case 'ayah':   return 'آية';
      case 'tafsir': return 'تفسير';
      case 'word':   return 'كلمة';
      default:       return type;
    }
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'ayah':   return Colors.blue;
      case 'tafsir': return Colors.green;
      case 'word':   return Colors.orange;
      default:       return Colors.grey;
    }
  }
} 