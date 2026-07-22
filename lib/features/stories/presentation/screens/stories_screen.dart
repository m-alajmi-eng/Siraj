import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';

class StoriesScreen extends ConsumerStatefulWidget {
  const StoriesScreen({super.key});
  @override
  ConsumerState<StoriesScreen> createState() => _StoriesScreenState();
}

class _StoriesScreenState extends ConsumerState<StoriesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<List<Map>> _fetchStories(String category) async {
    final res = await Supabase.instance.client
        .from('stories')
        .select('id, title_ar, person_name, period, summary_ar')
        .eq('category', category)
        .order('order_index');
    return List<Map>.from(res);
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
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            labelColor: palette.accentPrimary,
            unselectedLabelColor: palette.textSecondary,
            indicatorColor: palette.accentPrimary,
            tabs: [
              Tab(text: t.stories_prophets),
              Tab(text: t.stories_companions),
              Tab(text: t.stories_scholars),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _StoriesList(category: 'prophets', palette: palette, fetch: _fetchStories, t: t),
                _StoriesList(category: 'companions', palette: palette, fetch: _fetchStories, t: t),
                _StoriesList(category: 'scholars', palette: palette, fetch: _fetchStories, t: t),
              ],
            ),
          ),
        ],
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
        final items = snap.data ?? [];
        if (items.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_stories, size: 64, color: palette.textSecondary),
                const SizedBox(height: SirajSpacing.s4),
                Text(t.stories_comingSoonMsg, textAlign: TextAlign.center,
                  style: AppText.body.copyWith(color: palette.textSecondary)),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(SirajSpacing.s4),
          itemCount: items.length,
          itemBuilder: (_, i) {
            final s = items[i];
            return Container(
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
                  const SizedBox(width: SirajSpacing.s2),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: SirajSpacing.s2, vertical: SirajSpacing.s1),
                    decoration: BoxDecoration(
                      color: palette.accentPrimary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(SirajRadiusFull.sm),
                    ),
                    child: Text(t.stories_comingSoon, style: AppText.caption.copyWith(
                      color: palette.accentPrimary, fontSize: SirajSizes.sSm)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
