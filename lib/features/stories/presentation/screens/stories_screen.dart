import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import 'story_biography_reader_screen.dart';

class StoriesScreen extends ConsumerStatefulWidget {
  const StoriesScreen({super.key});
  @override
  ConsumerState<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends ConsumerState<StoriesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _searchCategory = 'all';
  Future<List<Map>>? _allStoriesFuture;

  static const List<String> _categories = ['prophets', 'companions', 'tabieen', 'ulama'];

  // TASK H-2: تصنيف فرعي للتابعين والعلماء، مقترَح نصياً لمحمد ووافق عليه
  // بالكامل قبل التنفيذ (2026-08-06) - كل مجموعة مسندة بنص صريح داخل
  // content_ar لكل id (راجع تقرير الاقتراح بالمحادثة)، لا تخمين. البقية
  // (غير المدرجة بأي مجموعة) تبقى أبجدية بلا تصنيف عقدي/فرقي إضافي.
  static const Set<int> _sevenFuqahaIds = {229, 237, 264, 228};
  static const Set<int> _ahlBaytIds = {250, 254, 256, 265};
  static const Set<int> _fourImamsIds = {267, 268, 283, 284};
  static const Set<int> _hanafiCompanionsIds = {285, 275};
  static const Set<int> _zuhhadIds = {282, 266, 272, 276, 269, 286, 273};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // الأنبياء وحدهم يُرتَّبون زمنياً (order_index، TASK L) - الفئات الثلاث
  // الأخرى أبجدياً دائماً وبلا خيار تبديل (TASK N).
  Future<List<Map>> _fetchStories(String category) async {
    final res = await Supabase.instance.client
        .from('stories')
        .select('id, title_ar, person_name, period, summary_ar, content_ar, group_slug')
        .eq('category', category)
        .order(category == 'prophets' ? 'order_index' : 'title_ar');
    return List<Map>.from(res);
  }

  Future<List<Map>> _fetchGroups() async {
    final res = await Supabase.instance.client
        .from('story_groups')
        .select('slug, title_ar')
        .order('id');
    return List<Map>.from(res);
  }

  // البحث يُغطّي الفئات الأربع مجتمعة، لذا تُجلب كل الصفوف مرة واحدة عند
  // فتح البحث وتُفلتَر محلياً بلا رحلة شبكة لكل حرف - هذا ما يحقق
  // "فلترة فورية أثناء الكتابة" فعلياً.
  Future<List<Map>> _fetchAllForSearch() async {
    final res = await Supabase.instance.client
        .from('stories')
        .select('id, title_ar, category, person_name, period, summary_ar, content_ar')
        .order('title_ar');
    return List<Map>.from(res);
  }

  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
      if (_isSearching) {
        _allStoriesFuture ??= _fetchAllForSearch();
      } else {
        _searchController.clear();
        _searchQuery = '';
        _searchCategory = 'all';
      }
    });
  }

  List<Map> _filterSearchResults(List<Map> all) {
    final query = _searchQuery.trim();
    return all.where((s) {
      if (_searchCategory != 'all' && s['category'] != _searchCategory) return false;
      if (query.isEmpty) return true;
      final title = (s['title_ar'] as String?) ?? '';
      return title.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final t       = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);

    // AppScaffold لا يوفّر مكان لـTabBar (لا "bottom" slot مثل AppBar) —
    // نضع الشريط داخل child نفسه بدل appBar.bottom، فنحافظ على زر الرجوع
    // الموحّد بلا فقدان وظيفة التبويبات الثلاثة.
    return AppScaffold(
      title: t.stories_title,
      padding: EdgeInsets.zero,
      actions: [
        IconButton(
          tooltip: t.stories_searchHint,
          icon: Icon(
            _isSearching ? Icons.close : Icons.search,
            color: _isSearching ? palette.accentPrimary : palette.textSecondary,
          ),
          onPressed: _toggleSearch,
        ),
      ],
      child: _isSearching ? _buildSearchView(palette, t) : _buildTabsView(palette, t),
    );
  }

  Widget _buildTabsView(dynamic palette, AppLocalizations t) {
    return Column(
      children: [
        TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: palette.accentPrimary,
          unselectedLabelColor: palette.textSecondary,
          indicatorColor: palette.accentPrimary,
          tabs: [
            Tab(text: t.stories_prophets),
            Tab(text: t.stories_companions),
            Tab(text: t.stories_tabieen),
            Tab(text: t.stories_scholars),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _StoriesList(category: 'prophets', palette: palette, fetch: _fetchStories, t: t),
              _CompanionsList(
                palette: palette, t: t,
                fetchStories: _fetchStories, fetchGroups: _fetchGroups,
              ),
              _SectionedList(
                palette: palette, t: t, category: 'tabieen', fetch: _fetchStories,
                restLabel: t.stories_otherTabieen,
                sections: [
                  _StorySection(label: t.stories_sevenFuqaha, ids: _sevenFuqahaIds),
                  _StorySection(label: t.stories_ahlBayt, ids: _ahlBaytIds),
                ],
              ),
              _SectionedList(
                palette: palette, t: t, category: 'ulama', fetch: _fetchStories,
                restLabel: t.stories_otherScholars,
                sections: [
                  _StorySection(label: t.stories_fourImams, ids: _fourImamsIds),
                  _StorySection(label: t.stories_hanafiCompanions, ids: _hanafiCompanionsIds),
                  _StorySection(label: t.stories_zuhhad, ids: _zuhhadIds),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchView(dynamic palette, AppLocalizations t) {
    final categoryLabel = <String, String>{
      'prophets': t.stories_prophets,
      'companions': t.stories_companions,
      'tabieen': t.stories_tabieen,
      'ulama': t.stories_scholars,
    };
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            SirajSpacing.s4, SirajSpacing.s3, SirajSpacing.s4, SirajSpacing.s2,
          ),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            textAlign: TextAlign.right,
            textDirection: TextDirection.rtl,
            style: AppText.body.copyWith(color: palette.textPrimary),
            decoration: InputDecoration(
              hintText: t.stories_searchHint,
              hintStyle: AppText.body.copyWith(color: palette.textSecondary),
              prefixIcon: Icon(Icons.search, color: palette.textSecondary),
              filled: true,
              fillColor: palette.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SirajRadiusFull.md),
                borderSide: BorderSide.none,
              ),
            ),
            onChanged: (value) => setState(() => _searchQuery = value),
          ),
        ),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s4),
            children: [
              _CategoryChip(
                label: t.stories_all,
                selected: _searchCategory == 'all',
                palette: palette,
                onTap: () => setState(() => _searchCategory = 'all'),
              ),
              for (final category in _categories)
                Padding(
                  padding: const EdgeInsets.only(right: SirajSpacing.s2),
                  child: _CategoryChip(
                    label: categoryLabel[category]!,
                    selected: _searchCategory == category,
                    palette: palette,
                    onTap: () => setState(() => _searchCategory = category),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: SirajSpacing.s2),
        Expanded(
          child: FutureBuilder<List<Map>>(
            future: _allStoriesFuture,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: palette.accentPrimary));
              }
              final results = _filterSearchResults(snap.data ?? []);
              return _StoryListView(
                items: results,
                palette: palette,
                emptyMessage: t.stories_noResults,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool selected;
  final dynamic palette;
  final VoidCallback onTap;
  const _CategoryChip({
    required this.label, required this.selected,
    required this.palette, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s3, vertical: 6),
        margin: const EdgeInsets.only(left: SirajSpacing.s2),
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

class _StoriesList extends StatelessWidget {
  final String category;
  final dynamic palette;
  final Future<List<Map>> Function(String) fetch;
  final AppLocalizations t;
  const _StoriesList({
    required this.category, required this.palette,
    required this.fetch, required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map>>(
      future: fetch(category),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: palette.accentPrimary));
        }
        return _StoryListView(
          items: snap.data ?? [],
          palette: palette,
          emptyMessage: t.stories_comingSoonMsg,
          comingSoonLabel: t.stories_comingSoon,
        );
      },
    );
  }
}

class _StoryListView extends StatelessWidget {
  final List<Map> items;
  final dynamic palette;
  final String emptyMessage;
  final String? comingSoonLabel;
  const _StoryListView({
    required this.items, required this.palette,
    required this.emptyMessage, this.comingSoonLabel,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.auto_stories, size: 64, color: palette.textSecondary),
            const SizedBox(height: SirajSpacing.s4),
            Text(emptyMessage, textAlign: TextAlign.center,
              style: AppText.body.copyWith(color: palette.textSecondary)),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(SirajSpacing.s4),
      itemCount: items.length,
      itemBuilder: (_, i) => _StoryCard(
        story: items[i], palette: palette, comingSoonLabel: comingSoonLabel,
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final Map story;
  final dynamic palette;
  final String? comingSoonLabel;
  const _StoryCard({required this.story, required this.palette, this.comingSoonLabel});

  @override
  Widget build(BuildContext context) {
    final s = story;
    final hasContent = (s['content_ar'] as String?)?.trim().isNotEmpty ?? false;
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => StoryBiographyReaderScreen(
            storyId: s['id'] as int,
            titleAr: s['title_ar'] ?? '',
          ),
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: SirajSpacing.s3),
        padding: const EdgeInsets.all(SirajSpacing.s4),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(SirajRadiusFull.md),
          border: Border.all(color: palette.accentPrimary.withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(
                color: palette.accentPrimary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(SirajRadiusFull.md),
              ),
              child: Icon(Icons.person, color: palette.accentPrimary),
            ),
            const SizedBox(width: SirajSpacing.s3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(s['title_ar'] ?? '',
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: AppText.body.copyWith(
                      color: palette.textPrimary, fontWeight: FontWeight.w600)),
                  if (s['period'] != null) ...[
                    const SizedBox(height: SirajSpacing.s1),
                    Text(s['period'],
                      textAlign: TextAlign.right,
                      textDirection: TextDirection.rtl,
                      style: AppText.caption.copyWith(color: palette.textSecondary)),
                  ],
                ],
              ),
            ),
            if (!hasContent && comingSoonLabel != null) ...[
              const SizedBox(width: SirajSpacing.s2),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: SirajSpacing.s2, vertical: SirajSpacing.s1),
                decoration: BoxDecoration(
                  color: palette.accentPrimary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(SirajRadiusFull.sm),
                ),
                child: Text(comingSoonLabel!, style: AppText.caption.copyWith(
                  color: palette.accentPrimary, fontSize: SirajSizes.sSm)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;
  final dynamic palette;
  const _SectionHeader({required this.label, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        SirajSpacing.s1, SirajSpacing.s2, SirajSpacing.s1, SirajSpacing.s2,
      ),
      child: Text(label,
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
        style: AppText.body.copyWith(color: palette.accentPrimary, fontWeight: FontWeight.bold)),
    );
  }
}

// TASK M-1: الصحابة مصنَّفون فرعياً بمجموعاتهم المصدرية (story_groups) -
// شريط رقاقات أفقي يفلتر القائمة الأبجدية (TASK N) دون تغيير ترتيبها.
// group_slug=NULL (غير مصنَّف بعد) يظهر تحت رقاقة "صحابة آخرون" منفصلة
// إن وُجد أي صف كذلك فعلياً - لا افتراض مسبق.
class _CompanionsList extends StatefulWidget {
  final dynamic palette;
  final AppLocalizations t;
  final Future<List<Map>> Function(String) fetchStories;
  final Future<List<Map>> Function() fetchGroups;
  const _CompanionsList({
    required this.palette, required this.t,
    required this.fetchStories, required this.fetchGroups,
  });

  @override
  State<_CompanionsList> createState() => _CompanionsListState();
}

class _CompanionsListState extends State<_CompanionsList> {
  late final Future<List<List<Map>>> _future;
  String _selectedGroup = 'all';

  @override
  void initState() {
    super.initState();
    _future = Future.wait([widget.fetchStories('companions'), widget.fetchGroups()]);
  }

  @override
  Widget build(BuildContext context) {
    final palette = widget.palette;
    final t = widget.t;
    return FutureBuilder<List<List<Map>>>(
      future: _future,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: palette.accentPrimary));
        }
        final stories = snap.data?[0] ?? [];
        final groups = snap.data?[1] ?? [];
        final presentSlugs = stories.map((s) => s['group_slug'] as String?).toSet();
        final hasOther = presentSlugs.contains(null);
        final relevantGroups = groups.where((g) => presentSlugs.contains(g['slug'] as String)).toList();

        final filtered = stories.where((s) {
          if (_selectedGroup == 'all') return true;
          if (_selectedGroup == 'other') return s['group_slug'] == null;
          return s['group_slug'] == _selectedGroup;
        }).toList();

        return Column(
          children: [
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: SirajSpacing.s4, vertical: SirajSpacing.s2),
                children: [
                  _CategoryChip(
                    label: t.stories_all,
                    selected: _selectedGroup == 'all',
                    palette: palette,
                    onTap: () => setState(() => _selectedGroup = 'all'),
                  ),
                  for (final g in relevantGroups)
                    Padding(
                      padding: const EdgeInsets.only(right: SirajSpacing.s2),
                      child: _CategoryChip(
                        label: g['title_ar'] as String,
                        selected: _selectedGroup == g['slug'],
                        palette: palette,
                        onTap: () => setState(() => _selectedGroup = g['slug'] as String),
                      ),
                    ),
                  if (hasOther)
                    Padding(
                      padding: const EdgeInsets.only(right: SirajSpacing.s2),
                      child: _CategoryChip(
                        label: t.stories_otherCompanions,
                        selected: _selectedGroup == 'other',
                        palette: palette,
                        onTap: () => setState(() => _selectedGroup = 'other'),
                      ),
                    ),
                ],
              ),
            ),
            Expanded(
              child: _StoryListView(
                items: filtered,
                palette: palette,
                emptyMessage: t.stories_comingSoonMsg,
                comingSoonLabel: t.stories_comingSoon,
              ),
            ),
          ],
        );
      },
    );
  }
}

// TASK H-2: مجموعة فرعية ثابتة بمعرّفات id صريحة (فقهاء سبعة/آل بيت/
// أئمة أربعة/أصحاب أبي حنيفة/زهّاد) - كل مجموعة تُعرض بعنوانها إن وُجد
// فيها صف واحد على الأقل، بنفس ترتيب `sections`، ثم البقية أبجدياً
// (TASK N) تحت `restLabel` بلا أي تصنيف إضافي.
class _StorySection {
  final String label;
  final Set<int> ids;
  const _StorySection({required this.label, required this.ids});
}

class _SectionedList extends StatelessWidget {
  final dynamic palette;
  final AppLocalizations t;
  final String category;
  final Future<List<Map>> Function(String) fetch;
  final List<_StorySection> sections;
  final String restLabel;
  const _SectionedList({
    required this.palette, required this.t, required this.category,
    required this.fetch, required this.sections, required this.restLabel,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map>>(
      future: fetch(category),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(color: palette.accentPrimary));
        }
        final all = snap.data ?? [];
        if (all.isEmpty) {
          return Center(
            child: Text(t.stories_comingSoonMsg, textAlign: TextAlign.center,
              style: AppText.body.copyWith(color: palette.textSecondary)),
          );
        }
        final claimed = <int>{};
        final blocks = <Widget>[];
        for (final section in sections) {
          final items = all.where((s) => section.ids.contains(s['id'] as int)).toList();
          if (items.isEmpty) continue;
          claimed.addAll(section.ids);
          blocks.add(_SectionHeader(label: section.label, palette: palette));
          blocks.addAll(items.map((s) => _StoryCard(story: s, palette: palette)));
          blocks.add(const SizedBox(height: SirajSpacing.s2));
        }
        final rest = all.where((s) => !claimed.contains(s['id'] as int)).toList();
        if (rest.isNotEmpty) {
          blocks.add(_SectionHeader(label: restLabel, palette: palette));
          blocks.addAll(rest.map((s) => _StoryCard(story: s, palette: palette)));
        }
        return ListView(padding: const EdgeInsets.all(SirajSpacing.s4), children: blocks);
      },
    );
  }
}
