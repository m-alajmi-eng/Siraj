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
        .select('id, title_ar, person_name, period, summary_ar, content_ar, group_slug, order_index')
        .eq('category', category)
        .order(category == 'prophets' ? 'order_index' : 'title_ar', ascending: true);
    return List<Map>.from(res);
  }

  Future<List<Map>> _fetchGroups() async {
    final res = await Supabase.instance.client
        .from('story_groups')
        .select('slug, title_ar')
        .order('id', ascending: true);
    return List<Map>.from(res);
  }

  // البحث يُغطّي الفئات الأربع مجتمعة، لذا تُجلب كل الصفوف مرة واحدة عند
  // فتح البحث وتُفلتَر محلياً بلا رحلة شبكة لكل حرف - هذا ما يحقق
  // "فلترة فورية أثناء الكتابة" فعلياً.
  Future<List<Map>> _fetchAllForSearch() async {
    final res = await Supabase.instance.client
        .from('stories')
        .select('id, title_ar, category, person_name, period, summary_ar, content_ar')
        .order('title_ar', ascending: true);
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
              _ProphetsList(palette: palette, fetch: _fetchStories, t: t),
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
            textAlign: TextAlign.start,
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

// TASK O: بطاقة مجموعة موحَّدة (صحابة/تابعين/علماء) - نفس الشكل البصري
// لبطاقات hadith_categories_screen.dart (بلا حدود، خلافاً لـ_StoryCard)،
// النقر يفتح _GroupMembersScreen بقائمة أفراد المجموعة.
class _GroupCard extends StatelessWidget {
  final String label;
  final int count;
  final dynamic palette;
  final AppLocalizations t;
  final VoidCallback onTap;
  final String? countLabel;
  const _GroupCard({
    required this.label, required this.count,
    required this.palette, required this.t, required this.onTap,
    this.countLabel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: SirajSpacing.s3),
        padding: const EdgeInsets.all(SirajSpacing.s4),
        decoration: BoxDecoration(
          color: palette.surface,
          borderRadius: BorderRadius.circular(SirajRadiusFull.md),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.chevron_left, color: palette.textSecondary),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(label,
                    textAlign: TextAlign.start,
                    style: AppText.body.copyWith(
                      color: palette.textPrimary, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(countLabel ?? t.stories_groupCount(count),
                    textAlign: TextAlign.start,
                    style: AppText.caption.copyWith(color: palette.textSecondary)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// شاشة أفراد مجموعة واحدة (تُفتَح من _GroupCard) - القائمة مُجلَّبة مسبقاً
// بالذاكرة، لا رحلة شبكة إضافية عند الضغط.
class _GroupMembersScreen extends StatelessWidget {
  final String titleAr;
  final List<Map> items;
  final dynamic palette;
  final AppLocalizations t;
  const _GroupMembersScreen({
    required this.titleAr, required this.items,
    required this.palette, required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: titleAr,
      padding: EdgeInsets.zero,
      child: _StoryListView(
        items: items,
        palette: palette,
        emptyMessage: t.stories_comingSoonMsg,
        comingSoonLabel: t.stories_comingSoon,
      ),
    );
  }
}

// TASK Q: تبويب الأنبياء يفصل بين قصص الأنبياء الأفراد (order_index 1-21،
// بطاقات مباشرة كالسابق) وفصول السيرة النبوية (order_index 22-72، 51 فصلاً)
// التي تُجمَع خلف بطاقة واحدة "السيرة النبوية" تفتح _SeeraPhasesScreen
// بدل عرضها كقائمة مسطّحة من 51 عنصراً.
class _ProphetsList extends StatelessWidget {
  final dynamic palette;
  final Future<List<Map>> Function(String) fetch;
  final AppLocalizations t;
  const _ProphetsList({required this.palette, required this.fetch, required this.t});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map>>(
      future: fetch('prophets'),
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
        final seerahChapters = all.where((s) => (s['order_index'] as int) >= 22).toList()
          ..sort((a, b) => (a['order_index'] as int).compareTo(b['order_index'] as int));
        final individualProphets = all.where((s) => (s['order_index'] as int) < 22).toList();

        return ListView(
          padding: const EdgeInsets.all(SirajSpacing.s4),
          children: [
            if (seerahChapters.isNotEmpty)
              _GroupCard(
                label: t.stories_seerahEntry,
                count: seerahChapters.length,
                countLabel: t.stories_chapterCount(seerahChapters.length),
                palette: palette,
                t: t,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => _SeeraPhasesScreen(
                    chapters: seerahChapters, palette: palette, t: t,
                  ),
                )),
              ),
            for (final s in individualProphets)
              _StoryCard(story: s, palette: palette, comingSoonLabel: t.stories_comingSoon),
          ],
        );
      },
    );
  }
}

// TASK Q: 7 مراحل زمنية للسيرة النبوية الـ51 فصلاً، محدَّدة بنطاقات
// order_index مُتحقَّق منها مباشرة من القاعدة (لا حدس) - حادثة الإفك
// (order_index=47) تقع ضمن نطاق المرحلة الرابعة (45-50) بين غزوة بني
// المصطلق (46) وصلح الحديبية (48)، تماماً كما طلب محمد.
class _SeeraPhase {
  final String label;
  final int start;
  final int end;
  const _SeeraPhase({required this.label, required this.start, required this.end});
}

class _SeeraPhasesScreen extends StatelessWidget {
  final List<Map> chapters;
  final dynamic palette;
  final AppLocalizations t;
  const _SeeraPhasesScreen({required this.chapters, required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    final phases = [
      _SeeraPhase(label: t.stories_seerahPhase1, start: 22, end: 33),
      _SeeraPhase(label: t.stories_seerahPhase2, start: 34, end: 38),
      _SeeraPhase(label: t.stories_seerahPhase3, start: 39, end: 44),
      _SeeraPhase(label: t.stories_seerahPhase4, start: 45, end: 50),
      _SeeraPhase(label: t.stories_seerahPhase5, start: 51, end: 58),
      _SeeraPhase(label: t.stories_seerahPhase6, start: 59, end: 63),
      _SeeraPhase(label: t.stories_seerahPhase7, start: 64, end: 72),
    ];

    return AppScaffold(
      title: t.stories_seerahPhasesTitle,
      padding: EdgeInsets.zero,
      child: ListView(
        padding: const EdgeInsets.all(SirajSpacing.s4),
        children: [
          for (final phase in phases)
            _buildPhaseCard(context, phase),
        ],
      ),
    );
  }

  Widget _buildPhaseCard(BuildContext context, _SeeraPhase phase) {
    final items = chapters.where((c) {
      final idx = c['order_index'] as int;
      return idx >= phase.start && idx <= phase.end;
    }).toList();
    if (items.isEmpty) return const SizedBox.shrink();
    return _GroupCard(
      label: phase.label,
      count: items.length,
      countLabel: t.stories_chapterCount(items.length),
      palette: palette,
      t: t,
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => _GroupMembersScreen(
          titleAr: phase.label, items: items, palette: palette, t: t,
        ),
      )),
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
                    // content_ar/title_ar بجدول stories عربي خام بلا localized
                    // متعدد اللغات حالياً (نفس تبرير story_biography_reader_screen.dart)
                    textAlign: TextAlign.start,
                    textDirection: TextDirection.rtl,
                    style: AppText.body.copyWith(
                      color: palette.textPrimary, fontWeight: FontWeight.w600)),
                  if (s['period'] != null) ...[
                    const SizedBox(height: SirajSpacing.s1),
                    Text(s['period'],
                      textAlign: TextAlign.start,
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

// TASK O: الصحابة مصنَّفون ببطاقة لكل مجموعة مصدرية (story_groups) -
// النقر على بطاقة يفتح _GroupMembersScreen بأفرادها. group_slug=NULL
// (غير مصنَّف بعد) يظهر ببطاقة "صحابة آخرون" منفصلة إن وُجد أي صف كذلك
// فعلياً - لا افتراض مسبق. لا خيار "عرض الكل مدمجاً" - البحث يغطي هذا.
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

        return ListView(
          padding: const EdgeInsets.all(SirajSpacing.s4),
          children: [
            for (final g in relevantGroups)
              _GroupCard(
                label: g['title_ar'] as String,
                count: stories.where((s) => s['group_slug'] == g['slug']).length,
                palette: palette,
                t: t,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => _GroupMembersScreen(
                    titleAr: g['title_ar'] as String,
                    items: stories.where((s) => s['group_slug'] == g['slug']).toList(),
                    palette: palette, t: t,
                  ),
                )),
              ),
            if (hasOther)
              _GroupCard(
                label: t.stories_otherCompanions,
                count: stories.where((s) => s['group_slug'] == null).length,
                palette: palette,
                t: t,
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => _GroupMembersScreen(
                    titleAr: t.stories_otherCompanions,
                    items: stories.where((s) => s['group_slug'] == null).toList(),
                    palette: palette, t: t,
                  ),
                )),
              ),
          ],
        );
      },
    );
  }
}

// TASK H-2/O: مجموعة فرعية ثابتة بمعرّفات id صريحة (فقهاء سبعة/آل بيت/
// أئمة أربعة/أصحاب أبي حنيفة/زهّاد) - كل مجموعة تُعرض ببطاقة منفصلة إن
// وُجد فيها صف واحد على الأقل، بنفس ترتيب `sections`، ثم بطاقة "البقية"
// أخيراً (TASK N) تحت `restLabel` بلا أي تصنيف إضافي. النقر على أي
// بطاقة يفتح _GroupMembersScreen بأفرادها (TASK O).
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
        final cards = <Widget>[];
        for (final section in sections) {
          final items = all.where((s) => section.ids.contains(s['id'] as int)).toList();
          if (items.isEmpty) continue;
          claimed.addAll(section.ids);
          cards.add(_GroupCard(
            label: section.label, count: items.length, palette: palette, t: t,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => _GroupMembersScreen(
                titleAr: section.label, items: items, palette: palette, t: t,
              ),
            )),
          ));
        }
        final rest = all.where((s) => !claimed.contains(s['id'] as int)).toList();
        if (rest.isNotEmpty) {
          cards.add(_GroupCard(
            label: restLabel, count: rest.length, palette: palette, t: t,
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => _GroupMembersScreen(
                titleAr: restLabel, items: rest, palette: palette, t: t,
              ),
            )),
          ));
        }
        return ListView(padding: const EdgeInsets.all(SirajSpacing.s4), children: cards);
      },
    );
  }
}
