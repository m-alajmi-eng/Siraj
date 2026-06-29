import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';

class ChildrenStoriesScreen extends ConsumerWidget {
  const ChildrenStoriesScreen({super.key});

  Future<List<Map>> _fetchStories() async {
    final res = await Supabase.instance.client
        .from('children_stories')
        .select('id, title_ar, moral_ar, emoji, color, category')
        .order('order_index');
    return List<Map>.from(res);
  }

  Color _parseColor(String hex) {
    try {
      return Color(int.parse(hex.replaceFirst('#', '0xFF')));
    } catch (_) {
      return const Color(0xFF4A90E2);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t       = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(
        backgroundColor: palette.surface,
        title: Text(t.children_title,
          style: AppText.headline.copyWith(color: palette.textPrimary)),
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
              child: Text(t.stories_comingSoonMsg, textAlign: TextAlign.center,
                style: AppText.body.copyWith(color: palette.textSecondary)));
          }
          return GridView.builder(
            padding: const EdgeInsets.all(SirajSpacing.s4),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:   2,
              crossAxisSpacing: SirajSpacing.s3,
              mainAxisSpacing:  SirajSpacing.s3,
              childAspectRatio: 0.85,
            ),
            itemCount: items.length,
            itemBuilder: (_, i) {
              final s = items[i];
              final color = _parseColor(s['color'] ?? '#4A90E2');
              return Container(
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(SirajRadiusFull.xl),
                  border: Border.all(color: color.withValues(alpha: 0.3)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(s['emoji'] ?? '', style: const TextStyle(fontSize: 48)),
                    const SizedBox(height: SirajSpacing.s3),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s2),
                      child: Text(s['title_ar'] ?? '',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: AppText.body.copyWith(
                          color: palette.textPrimary, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: SirajSpacing.s2),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: SirajSpacing.s3),
                      padding: const EdgeInsets.symmetric(
                        horizontal: SirajSpacing.s2, vertical: SirajSpacing.s1),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(SirajRadiusFull.sm),
                      ),
                      child: Text(s['moral_ar'] ?? '',
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: AppText.caption.copyWith(color: color, fontSize: SirajSizes.sSm)),
                    ),
                    const SizedBox(height: SirajSpacing.s2),
                    Text(t.stories_comingSoon, style: AppText.caption.copyWith(
                      color: palette.textSecondary, fontSize: SirajSizes.sSm)),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
