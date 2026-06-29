import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../providers/search_provider.dart';
import '../../../qke/presentation/screens/verse_portal_screen.dart';

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
    final t           = AppLocalizations.of(context);
    final palette     = ref.watch(timeThemeProvider);
    final searchState = ref.watch(searchProvider);

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Column(
          children: [
            // ─── Header + Search Bar ───
            Padding(
              padding: const EdgeInsets.all(SirajSpacing.s4),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: palette.textPrimary),
                    onPressed: () {
                      ref.read(searchProvider.notifier).clear();
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: palette.surface,
                        borderRadius: BorderRadius.circular(SirajRadiusFull.md),
                      ),
                      child: TextField(
                        controller: _controller,
                        autofocus: true,
                        style: AppText.body.copyWith(color: palette.textPrimary),
                        decoration: InputDecoration(
                          hintText: t.search_hint,
                          hintStyle: AppText.bodySmall.copyWith(
                            color: palette.textSecondary),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: SirajSpacing.s4, vertical: SirajSpacing.s2),
                          suffixIcon: searchState.query.isNotEmpty
                              ? IconButton(
                                  icon: Icon(Icons.clear,
                                    color: palette.textSecondary, size: 18),
                                  onPressed: () {
                                    _controller.clear();
                                    ref.read(searchProvider.notifier).clear();
                                  },
                                )
                              : Icon(Icons.search, color: palette.textSecondary),
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

            if (searchState.isLoading)
              LinearProgressIndicator(
                color: palette.accentPrimary,
                backgroundColor: palette.surface,
              ),

            Expanded(
              child: searchState.query.isEmpty
                  ? _EmptyState(palette: palette, t: t)
                  : searchState.isLoading
                      ? const SizedBox.shrink()
                      : searchState.error != null
                          ? _ErrorState(error: searchState.error!, palette: palette)
                          : searchState.results.isEmpty
                              ? _NoResults(query: searchState.query, palette: palette, t: t)
                              : _ResultsList(
                                  results: searchState.results, palette: palette, t: t),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final dynamic palette;
  final AppLocalizations t;
  const _EmptyState({required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search, size: 64,
            color: palette.textSecondary.withValues(alpha: 0.3)),
          const SizedBox(height: SirajSpacing.s4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s8),
            child: Text(t.search_empty, textAlign: TextAlign.center,
              style: AppText.body.copyWith(color: palette.textSecondary, height: 1.6)),
          ),
        ],
      ),
    );
  }
}

class _NoResults extends StatelessWidget {
  final String query;
  final dynamic palette;
  final AppLocalizations t;
  const _NoResults({required this.query, required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off, size: 48, color: palette.textSecondary),
          const SizedBox(height: SirajSpacing.s3),
          Text(t.search_noResults(query), textAlign: TextAlign.center,
            style: AppText.body.copyWith(color: palette.textPrimary)),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String error;
  final dynamic palette;
  const _ErrorState({required this.error, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SirajSpacing.s5),
        child: Text(error, textAlign: TextAlign.center,
          style: AppText.bodySmall.copyWith(color: palette.textSecondary)),
      ),
    );
  }
}

class _ResultsList extends StatelessWidget {
  final List<SearchResult> results;
  final dynamic palette;
  final AppLocalizations t;

  const _ResultsList({
    required this.results,
    required this.palette,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s4),
      itemCount: results.length,
      itemBuilder: (_, i) {
        final r = results[i];
        return GestureDetector(
          onTap: () {
            if (r.surahId > 0 && r.ayahNumber > 0) {
              Navigator.push(context, MaterialPageRoute(
                builder: (_) => VersePortalScreen(
                  surahId: r.surahId,
                  ayahNumber: r.ayahNumber,
                ),
              ));
            }
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: SirajSpacing.s3),
            padding: const EdgeInsets.all(SirajSpacing.s4),
            decoration: BoxDecoration(
              color: palette.surface,
              borderRadius: BorderRadius.circular(SirajRadiusFull.md),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: SirajSpacing.s2, vertical: 2),
                      decoration: BoxDecoration(
                        color: _typeColor(r.type).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(SirajRadiusFull.xs),
                      ),
                      child: Text(_typeLabel(t, r.type), style: AppText.caption.copyWith(
                        color: _typeColor(r.type), fontSize: 10)),
                    ),
                    Text('${r.surahName} · ${r.ayahNumber}',
                      style: AppText.caption.copyWith(color: palette.accentPrimary)),
                  ],
                ),
                const SizedBox(height: SirajSpacing.s2),
                Text(
                  r.text.length > 200 ? '${r.text.substring(0, 200)}...' : r.text,
                  textAlign: TextAlign.right,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    color: palette.textPrimary,
                    fontSize: r.type == 'ayah' ? 18 : 14,
                    fontFamily: r.type == 'ayah' ? 'QuranFont' : null,
                    height: 1.7,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _typeLabel(AppLocalizations t, String type) {
    switch (type) {
      case 'ayah':   return t.search_typeAyah;
      case 'tafsir': return t.search_typeTafsir;
      case 'word':   return t.search_typeWord;
      case 'hadith': return t.search_typeHadith;
      default:       return type;
    }
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'ayah':   return const Color(0xFF6EB4D0);
      case 'tafsir': return const Color(0xFF50B478);
      case 'word':   return const Color(0xFFE0A458);
      case 'hadith': return const Color(0xFF4DB6AC);
      default:       return SirajWhite.w40;
    }
  }
}