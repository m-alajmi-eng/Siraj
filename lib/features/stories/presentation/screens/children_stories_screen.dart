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
      body: Stack(
        children: [
          // توهّج دافئ خفيف خلف الشبكة - زخرفي بحت، لا يمس أي منطق.
          const Positioned.fill(child: _WarmGlow()),
          FutureBuilder<List<Map>>(
            future: _fetchStories(),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(color: palette.accentPrimary));
              }
              final items = snap.data ?? [];
              if (items.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(SirajSpacing.s6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.auto_stories,
                          size: 56, color: palette.accentPrimary.withValues(alpha: 0.5)),
                        const SizedBox(height: SirajSpacing.s3),
                        Text(t.stories_comingSoonMsg, textAlign: TextAlign.center,
                          style: AppText.body.copyWith(color: palette.textSecondary)),
                      ],
                    ),
                  ),
                );
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
                  return _StoryCard(
                    index:      i,
                    color:      color,
                    emoji:      s['emoji'] ?? '',
                    titleAr:    s['title_ar'] ?? '',
                    moralAr:    s['moral_ar'] ?? '',
                    comingSoon: t.stories_comingSoon,
                    palette:    palette,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

// ─── توهّج دافئ خلفي ───────────────────────────────────────
// دائرتان ذهبيتان ضبابيتان ثابتتان (لا حركة، لا Random) خلف الشبكة فقط
// لإضفاء دفء بصري - زخرفة بحتة بلا أي أثر وظيفي.
class _WarmGlow extends StatelessWidget {
  const _WarmGlow();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -60, right: -40,
            child: _blurCircle(220, SirajGold.subtle),
          ),
          Positioned(
            bottom: -80, left: -60,
            child: _blurCircle(260, SirajGold.faint),
          ),
        ],
      ),
    );
  }

  Widget _blurCircle(double size, Color color) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

// ─── بطاقة قصة واحدة ────────────────────────────────────────
// دخول متدرّج (fade + scale) حسب ترتيب البطاقة + "تنفّس" خفيف مستمر
// للإيموجي - حركة لطيفة تناسب شاشة أطفال، بلا أي تغيير على المحتوى أو
// منطق الإتاحة.
class _StoryCard extends StatefulWidget {
  final int index;
  final Color color;
  final String emoji;
  final String titleAr;
  final String moralAr;
  final String comingSoon;
  final dynamic palette;

  const _StoryCard({
    required this.index,
    required this.color,
    required this.emoji,
    required this.titleAr,
    required this.moralAr,
    required this.comingSoon,
    required this.palette,
  });

  @override
  State<_StoryCard> createState() => _StoryCardState();
}

class _StoryCardState extends State<_StoryCard> with TickerProviderStateMixin {
  late final AnimationController _entrance;
  late final Animation<double> _curvedEntrance;
  late final AnimationController _breathe;

  @override
  void initState() {
    super.initState();
    _entrance = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 420));
    _curvedEntrance = CurvedAnimation(parent: _entrance, curve: Curves.easeOutBack);
    _breathe = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 2400))..repeat(reverse: true);

    final delay = Duration(milliseconds: 60 * (widget.index % 8));
    Future.delayed(delay, () {
      if (mounted) _entrance.forward();
    });
  }

  @override
  void dispose() {
    _entrance.dispose();
    _breathe.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color;
    return AnimatedBuilder(
      animation: _entrance,
      builder: (context, child) {
        return Opacity(
          opacity: _entrance.value.clamp(0.0, 1.0),
          child: Transform.scale(scale: 0.85 + 0.15 * _curvedEntrance.value, child: child),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end:   Alignment.bottomCenter,
            colors: [color.withValues(alpha: 0.24), color.withValues(alpha: 0.09)],
          ),
          borderRadius: BorderRadius.circular(SirajRadiusFull.xl),
          border: Border.all(color: color.withValues(alpha: 0.35)),
          boxShadow: [
            BoxShadow(color: color.withValues(alpha: 0.18), blurRadius: 16, offset: const Offset(0, 6)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _breathe,
              builder: (context, child) {
                final scale = 1.0 + 0.06 * _breathe.value;
                return Transform.scale(scale: scale, child: child);
              },
              child: Container(
                width: 68, height: 68,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: 0.18),
                ),
                child: Center(
                  child: Text(widget.emoji, style: const TextStyle(fontSize: 40)),
                ),
              ),
            ),
            const SizedBox(height: SirajSpacing.s3),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s2),
              child: Text(widget.titleAr,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: AppText.body.copyWith(
                  color: widget.palette.textPrimary, fontWeight: FontWeight.bold)),
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
              child: Text(widget.moralAr,
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
                style: AppText.caption.copyWith(color: color, fontSize: SirajSizes.sSm)),
            ),
            const SizedBox(height: SirajSpacing.s2),
            Text(widget.comingSoon, style: AppText.caption.copyWith(
              color: widget.palette.textSecondary, fontSize: SirajSizes.sSm)),
          ],
        ),
      ),
    );
  }
}
