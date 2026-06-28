import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/time_theme_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChildrenStoriesScreen extends ConsumerWidget {
  const ChildrenStoriesScreen({super.key});

  Future<List<Map>> _fetchStories() async {
    final res = await Supabase.instance.client
        .from('children_stories')
        .select('id, title_ar, moral_ar, emoji, color, category')
        .order('order_index');
    return List<Map>.from(res);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(timeThemeProvider);
    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        backgroundColor: palette.surface,
        title: Text('قصص الاطفال',
          style: TextStyle(color: palette.textPrimary, fontWeight: FontWeight.bold)),
        iconTheme: IconThemeData(color: palette.textPrimary),
      ),
      body: FutureBuilder<List<Map>>(
        future: _fetchStories(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: palette.accentPrimary));
          }
          final items = snap.data ?? [];
          if (items.isEmpty) {
            return Center(
              child: Text('قريبا',
                style: TextStyle(color: palette.textSecondary, fontSize: 15)));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:   2,
              crossAxisSpacing: 12,
              mainAxisSpacing:  12,
              childAspectRatio: 0.85,
            ),
            itemCount: items.length,
            itemBuilder: (_, i) {
              final s = items[i];
              final color = _parseColor(s['color'] ?? '#4A90E2');
              return Container(
                decoration: BoxDecoration(
                  color:        color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(s['emoji'] ?? '',
                      style: const TextStyle(fontSize: 48)),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Text(s['title_ar'] ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:      palette.textPrimary,
                          fontSize:   15,
                          fontWeight: FontWeight.bold,
                        )),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      margin:  const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color:        color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(s['moral_ar'] ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: color, fontSize: 11)),
                    ),
                    const SizedBox(height: 8),
                    Text('قريبا',
                      style: TextStyle(color: palette.textSecondary, fontSize: 11)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  Color _parseColor(String hex) {
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    } catch (_) {
      return const Color(0xFF4A90E2);
    }
  }
}
