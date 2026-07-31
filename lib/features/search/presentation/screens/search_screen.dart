import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
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

    // العنوان هنا حقل بحث تفاعلي لا نص ثابت — titleWidget يستبدل عمود
    // العنوان الافتراضي في AppScaffold بينما يبقى زر الرجوع الموحّد كما هو.
    return AppScaffold(
      title: t.common_search,
      padding: EdgeInsets.zero,
      titleWidget: Container(
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
                    tooltip: t.common_clearSearch,
                    onPressed: () {
                      _controller.clear();
                      ref.read(searchProvider.notifier).clear();
                    },
                  )
                : Icon(Icons.search, color: palette.textSecondary),
          ),
          onChanged: (q) => ref.read(searchProvider.notifier).search(q),
        ),
      ),
      child: Column(
        children: [
          if (searchState.isLoading)
            LinearProgressIndicator(
              color: palette.accentPrimary,
              backgroundColor: palette.surface,
            ),
          if (searchState.results.isNotEmpty)
            _TypeFilterBar(state: searchState, palette: palette, t: t),
          if (searchState.failedTypes.isNotEmpty)
            _PartialFailureBanner(palette: palette, t: t),
          Expanded(
            child: searchState.query.isEmpty
                ? _EmptyState(palette: palette, t: t)
                : searchState.isLoading
                    ? const SizedBox.shrink()
                    : searchState.error != null
                        ? _ErrorState(error: searchState.error!, palette: palette, t: t)
                        : searchState.filteredResults.isEmpty
                            ? _NoResults(query: searchState.query, palette: palette, t: t)
                            : _ResultsList(
                                results: searchState.filteredResults,
                                query: searchState.query,
                                palette: palette, t: t),
          ),
        ],
      ),
    );
  }
}

/// شريط فلاتر حسب النوع (PHASE L2) — يظهر فقط إن وُجدت نتائج فعلية.
class _TypeFilterBar extends StatelessWidget {
  final SearchState state;
  final dynamic palette;
  final AppLocalizations t;
  const _TypeFilterBar({required this.state, required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    final types = state.results.map((r) => r.type).toSet().toList();
    if (types.length <= 1) return const SizedBox.shrink();

    return Consumer(builder: (context, ref, _) {
      return SizedBox(
        height: 36,
        child: ListView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s4, vertical: 4),
          children: [
            _FilterChip(
              label: t.common_search,
              selected: state.typeFilter == null,
              palette: palette,
              onTap: () => ref.read(searchProvider.notifier).setTypeFilter(null),
            ),
            const SizedBox(width: SirajSpacing.s2),
            for (final type in types) ...[
              _FilterChip(
                label: _typeLabelFor(t, type),
                selected: state.typeFilter == type,
                palette: palette,
                onTap: () => ref.read(searchProvider.notifier).setTypeFilter(type),
              ),
              const SizedBox(width: SirajSpacing.s2),
            ],
          ],
        ),
      );
    });
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final dynamic palette;
  final VoidCallback onTap;
  const _FilterChip({
    required this.label, required this.selected,
    required this.palette, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s3, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? palette.accentPrimary : palette.surface,
          borderRadius: BorderRadius.circular(SirajRadiusFull.pill),
        ),
        child: Text(label, style: AppText.caption.copyWith(
          color: selected ? palette.background : palette.textPrimary)),
      ),
    );
  }
}

class _PartialFailureBanner extends StatelessWidget {
  final dynamic palette;
  final AppLocalizations t;
  const _PartialFailureBanner({required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: SirajSpacing.s4, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s3, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(SirajRadiusFull.sm),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, size: 14, color: Colors.amber),
          const SizedBox(width: SirajSpacing.s2),
          Expanded(
            child: Text(t.search_partialResults,
              style: AppText.caption.copyWith(color: palette.textSecondary)),
          ),
        ],
      ),
    );
  }
}

String _typeLabelFor(AppLocalizations t, String type) {
  switch (type) {
    case 'ayah':   return t.search_typeAyah;
    case 'tafsir': return t.search_typeTafsir;
    case 'word':   return t.search_typeWord;
    case 'hadith': return t.search_typeHadith;
    case 'athkar': return t.search_typeAthkar;
    default:       return type;
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
  final AppLocalizations t;
  const _ErrorState({required this.error, required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SirajSpacing.s5),
        child: Text('${t.common_error}: $error', textAlign: TextAlign.center,
          style: AppText.bodySmall.copyWith(color: palette.textSecondary)),
      ),
    );
  }
}

/// ترتيب الأقسام الثابت عند التجميع - يطابق ترتيب مصادر البحث في
/// search_provider.dart (آيات ثم تفسير ثم كلمات ثم أحاديث ثم أذكار).
const _kSectionOrder = ['ayah', 'tafsir', 'word', 'hadith', 'athkar'];

class _ResultsList extends StatelessWidget {
  final List<SearchResult> results;
  final String query;
  final dynamic palette;
  final AppLocalizations t;

  const _ResultsList({
    required this.results,
    required this.query,
    required this.palette,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    final grouped = <String, List<SearchResult>>{};
    for (final r in results) {
      grouped.putIfAbsent(r.type, () => []).add(r);
    }
    final sections = _kSectionOrder.where(grouped.containsKey).toList();

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s4),
      children: [
        for (final type in sections) ...[
          _SectionHeader(
            label: _typeLabelFor(t, type),
            color: _typeColor(type),
            count: grouped[type]!.length,
            palette: palette,
          ),
          for (final r in grouped[type]!)
            _ResultCard(result: r, query: query, palette: palette, t: t),
          const SizedBox(height: SirajSpacing.s2),
        ],
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  final Color color;
  final int count;
  final dynamic palette;

  const _SectionHeader({
    required this.label,
    required this.color,
    required this.count,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: SirajSpacing.s2, top: SirajSpacing.s1),
      child: Row(
        children: [
          Container(width: 8, height: 8,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
          const SizedBox(width: SirajSpacing.s2),
          Text('$label ($count)', style: AppText.bodySmall.copyWith(
            color: palette.accentPrimary, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final SearchResult result;
  final String query;
  final dynamic palette;
  final AppLocalizations t;

  const _ResultCard({
    required this.result,
    required this.query,
    required this.palette,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    final r = result;
    final baseStyle = TextStyle(
      color: palette.textPrimary,
      fontSize: r.type == 'ayah' ? 18 : 14,
      fontFamily: r.type == 'ayah' ? 'QuranFont' : null,
      height: 1.7,
    );
    final highlightStyle = baseStyle.copyWith(
      color: palette.accentPrimary,
      fontWeight: FontWeight.w700,
      backgroundColor: palette.accentPrimary.withValues(alpha: 0.18),
    );

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
                  child: Text(_typeLabelFor(t, r.type), style: AppText.caption.copyWith(
                    color: _typeColor(r.type), fontSize: 10)),
                ),
                Text('${r.surahName} · ${r.ayahNumber}',
                  style: AppText.caption.copyWith(color: palette.accentPrimary)),
              ],
            ),
            const SizedBox(height: SirajSpacing.s2),
            RichText(
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              text: TextSpan(
                children: _highlightedSpans(r.text, query, baseStyle, highlightStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color _typeColor(String type) {
  switch (type) {
    case 'ayah':   return const Color(0xFF6EB4D0);
    case 'tafsir': return const Color(0xFF50B478);
    case 'word':   return const Color(0xFFE0A458);
    case 'hadith': return const Color(0xFF4DB6AC);
    case 'athkar': return const Color(0xFFB07CC6);
    default:       return SirajWhite.w40;
  }
}

/// يبني TextSpans مع تظليل أول تطابق حرفي للاستعلام (بلا حساسية لحالة
/// الأحرف). عند تجاوز النص 200 حرف، يقتصّ نافذة حول موضع التطابق نفسه (لا
/// أول 200 حرف ثابتة كما كان سابقاً) حتى لا يختفي التظليل خلف اقتصاص لا
/// علاقة له بموضع المطابقة الفعلي.
List<InlineSpan> _highlightedSpans(
    String text, String query, TextStyle baseStyle, TextStyle highlightStyle) {
  final trimmedQuery = query.trim();
  if (trimmedQuery.isEmpty) {
    return [TextSpan(text: _truncatePlain(text, 200), style: baseStyle)];
  }

  final idx = text.toLowerCase().indexOf(trimmedQuery.toLowerCase());
  if (idx < 0) {
    return [TextSpan(text: _truncatePlain(text, 200), style: baseStyle)];
  }

  var display = text;
  var matchStart = idx;
  var matchEnd = idx + trimmedQuery.length;

  const maxLen = 200;
  if (text.length > maxLen) {
    final windowStart = (idx - 60).clamp(0, text.length);
    final windowEnd = (matchEnd + 140).clamp(0, text.length);
    final prefix = windowStart > 0 ? '...' : '';
    final suffix = windowEnd < text.length ? '...' : '';
    display = '$prefix${text.substring(windowStart, windowEnd)}$suffix';
    matchStart = idx - windowStart + prefix.length;
    matchEnd = matchStart + trimmedQuery.length;
  }

  final spans = <InlineSpan>[];
  if (matchStart > 0) {
    spans.add(TextSpan(text: display.substring(0, matchStart), style: baseStyle));
  }
  spans.add(TextSpan(text: display.substring(matchStart, matchEnd), style: highlightStyle));
  if (matchEnd < display.length) {
    spans.add(TextSpan(text: display.substring(matchEnd), style: baseStyle));
  }
  return spans;
}

String _truncatePlain(String text, int maxLen) =>
    text.length > maxLen ? '${text.substring(0, maxLen)}...' : text;