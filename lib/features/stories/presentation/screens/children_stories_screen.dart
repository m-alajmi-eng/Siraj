import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import 'story_reader_screen.dart';

/// عنصر كتالوج قصة طفل واحدة - يُبنى حصراً من عمود عرض دالة
/// get_children_stories_catalog RPC (المهجرة 20260801130000)، لا استعلام
/// SELECT مباشر على children_stories_drafts لأن RLS (reviewed=true)
/// يُخفي كل الصفوف التسع حالياً. الدالة تُرجع فقط id/تصنيف/إيموجي/لون/
/// عنوان - لا simplified_text إطلاقاً عبر هذا المسار؛ نص القصة الفعلي
/// (إن وُجد لاحقاً) يُجلَب حياً وبصلاحياته الطبيعية في StoryReaderScreen.
class _CatalogStory {
  final int id;
  final String title;
  final String category;
  final String emoji;
  final Color color;

  const _CatalogStory({
    required this.id,
    required this.title,
    required this.category,
    required this.emoji,
    required this.color,
  });
}

Color _parseLegacyColor(String? hex) {
  const fallback = Color(0xFF4A90E2);
  if (hex == null || hex.isEmpty) return fallback;
  final cleaned = hex.replaceFirst('#', '');
  final value = int.tryParse('FF$cleaned', radix: 16);
  return value != null ? Color(value) : fallback;
}

_CatalogStory _rowToCatalogStory(Map<String, dynamic> row) {
  return _CatalogStory(
    id:       row['id'] as int,
    title:    (row['title'] as String?) ?? '',
    category: (row['legacy_category'] as String?) ?? '',
    emoji:    (row['legacy_emoji'] as String?) ?? '📖',
    color:    _parseLegacyColor(row['legacy_color'] as String?),
  );
}

Future<List<_CatalogStory>> _fetchCatalog(String lang) async {
  final rows = await Supabase.instance.client
      .rpc('get_children_stories_catalog', params: {'p_lang': lang});
  return (rows as List)
      .map((r) => _rowToCatalogStory(Map<String, dynamic>.from(r as Map)))
      .where((s) => s.title.isNotEmpty)
      .toList();
}

String _categoryLabel(AppLocalizations t, String category) {
  switch (category) {
    case 'prophets': return t.stories_prophets;
    case 'values':   return t.children_category_values;
    default:         return t.children_category_quran;
  }
}

class ChildrenStoriesScreen extends ConsumerWidget {
  const ChildrenStoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t       = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);
    final lang    = ref.watch(localeProvider).languageCode;

    return AppScaffold(
      title: t.children_title,
      padding: EdgeInsets.zero,
      child: Stack(
        children: [
          // توهّج دافئ خفيف خلف الشبكة - زخرفي بحت، لا يمس أي منطق.
          const Positioned.fill(child: _WarmGlow()),
          FutureBuilder<List<_CatalogStory>>(
            future: _fetchCatalog(lang),
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(color: palette.accentPrimary));
              }

              final stories = snap.data ?? const <_CatalogStory>[];
              if (stories.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(SirajSpacing.s6),
                    child: Text(t.stories_comingSoonMsg,
                      textAlign: TextAlign.center,
                      style: AppText.body.copyWith(color: palette.textSecondary)),
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
                itemCount: stories.length,
                itemBuilder: (_, i) {
                  final s = stories[i];
                  return _StoryCard(
                    index:         i,
                    color:         s.color,
                    emoji:         s.emoji,
                    titleAr:       s.title,
                    categoryLabel: _categoryLabel(t, s.category),
                    comingSoon:    t.stories_comingSoon,
                    palette:       palette,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => StoryReaderScreen(
                          storyId: s.id,
                          titleAr: s.title,
                          emoji:   s.emoji,
                          color:   s.color,
                        ),
                      ),
                    ),
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
// للإيموجي - حركة لطيفة تناسب شاشة أطفال. onTap يفتح شاشة قراءة فعلية
// (StoryReaderScreen) حتى لو النص غير موجود بعد - هي من تعرض "قريباً".
class _StoryCard extends StatefulWidget {
  final int index;
  final Color color;
  final String emoji;
  final String titleAr;
  final String categoryLabel;
  final String comingSoon;
  final dynamic palette;
  final VoidCallback onTap;

  const _StoryCard({
    required this.index,
    required this.color,
    required this.emoji,
    required this.titleAr,
    required this.categoryLabel,
    required this.comingSoon,
    required this.palette,
    required this.onTap,
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
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedBuilder(
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s2, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(SirajRadiusFull.xs),
                ),
                child: Text(widget.categoryLabel,
                  style: AppText.caption.copyWith(color: color, fontSize: 10)),
              ),
              const SizedBox(height: SirajSpacing.s2),
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
                  // العنوان يُجلَب مترجَماً حسب لغة الواجهة الفعلية (p_lang بـ
                  // get_children_stories_catalog RPC) - ليس عربياً دائماً، فلا
                  // اتجاه ثابت هنا؛ Directionality المحيطة تتبع لغة التطبيق.
                  textAlign: TextAlign.center,
                  style: AppText.body.copyWith(
                    color: widget.palette.textPrimary, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: SirajSpacing.s2),
              Text(widget.comingSoon, style: AppText.caption.copyWith(
                color: widget.palette.textSecondary, fontSize: SirajSizes.sSm)),
            ],
          ),
        ),
      ),
    );
  }
}
