import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/time_theme_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    final palette = ref.watch(timeThemeProvider);
    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        backgroundColor: palette.surface,
        title: Text('القصص والسير',
          style: TextStyle(color: palette.textPrimary, fontWeight: FontWeight.bold)),
        iconTheme: IconThemeData(color: palette.textPrimary),
        bottom: TabBar(
          controller: _tabController,
          labelColor: palette.accentPrimary,
          unselectedLabelColor: palette.textSecondary,
          indicatorColor: palette.accentPrimary,
          tabs: const [
            Tab(text: 'الأنبياء'),
            Tab(text: 'الصحابة'),
            Tab(text: 'العلماء'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _StoriesList(category: 'prophets', palette: palette, fetch: _fetchStories),
          _StoriesList(category: 'companions', palette: palette, fetch: _fetchStories),
          _StoriesList(category: 'scholars', palette: palette, fetch: _fetchStories),
        ],
      ),
    );
  }
}

class _StoriesList extends StatelessWidget {
  final String category;
  final dynamic palette;
  final Future<List<Map>> Function(String) fetch;
  const _StoriesList({required this.category, required this.palette, required this.fetch});

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
                const SizedBox(height: 16),
                Text('قريباً — نعمل على إضافة المحتوى',
                  style: TextStyle(color: palette.textSecondary, fontSize: 15)),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: items.length,
          itemBuilder: (_, i) {
            final s = items[i];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: palette.surface,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: palette.accentPrimary.withOpacity(0.1)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(
                      color: palette.accentPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(Icons.person, color: palette.accentPrimary),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(s['title_ar'] ?? '',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: palette.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          )),
                        if (s['period'] != null) ...[
                          const SizedBox(height: 4),
                          Text(s['period'],
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: palette.textSecondary,
                              fontSize: 12,
                            )),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: palette.accentPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('قريباً',
                      style: TextStyle(
                        color: palette.accentPrimary,
                        fontSize: 11,
                      )),
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
