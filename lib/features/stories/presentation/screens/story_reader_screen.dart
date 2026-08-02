import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';

/// ترتيب أدوار الصور داخل القصة: افتتاحية → ذروة (إن وُجدت) → ختامية.
const _kImageRoleOrder = {'opening': 0, 'climax': 1, 'closing': 2};

/// يقسّم فقرات النص (مفصولة بسطرين فارغين \n\n) إلى [pageCount] مجموعة
/// متتالية متوازنة قدر الإمكان، بحيث يطابق عدد المجموعات عدد الصور بالضبط.
/// المجموعات الأولى تأخذ الفقرة الزائدة عند القسمة غير المتساوية، فتبقى
/// فقرة "فكّر معي" الختامية ضمن آخر مجموعة دائماً.
List<String> paginateStoryText(String text, int pageCount) {
  final paragraphs =
      text.split('\n\n').map((p) => p.trim()).where((p) => p.isNotEmpty).toList();

  if (pageCount <= 1 || paragraphs.isEmpty) return [text.trim()];

  final effectivePages = math.min(pageCount, paragraphs.length);
  final base = paragraphs.length ~/ effectivePages;
  final remainder = paragraphs.length % effectivePages;

  final pages = <String>[];
  var idx = 0;
  for (var i = 0; i < effectivePages; i++) {
    final size = base + (i < remainder ? 1 : 0);
    pages.add(paragraphs.sublist(idx, idx + size).join('\n\n'));
    idx += size;
  }
  return pages;
}

/// شاشة قراءة قصة طفل واحدة من children_stories_drafts. الاستعلام يحترم
/// RLS (reviewed=true فقط) تلقائياً - لو لم تُراجَع القصة بعد، يرجع صفراً
/// صفوف بلا أي خطأ، فتُعرض حالة "قريباً" صادقة بدل شاشة مكسورة أو فارغة
/// مربكة. تجربة القراءة الفعلية PageView: صفحة واحدة لكل صورة (بترتيب
/// opening→climax→closing)، وفقراتها أسفلها.
class StoryReaderScreen extends ConsumerStatefulWidget {
  final int storyId;
  final String titleAr;
  final String emoji;
  final Color color;

  const StoryReaderScreen({
    super.key,
    required this.storyId,
    required this.titleAr,
    required this.emoji,
    required this.color,
  });

  @override
  ConsumerState<StoryReaderScreen> createState() => _StoryReaderScreenState();
}

class _StoryReaderScreenState extends ConsumerState<StoryReaderScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  Future<Map<String, dynamic>?> _fetchStory() async {
    final res = await Supabase.instance.client
        .from('children_stories_drafts')
        .select('id, localized, images')
        .eq('id', widget.storyId)
        .maybeSingle();
    return res;
  }

  List<String> _sortedImageUrls(List<dynamic> images) {
    final rows = images.map((e) => Map<String, dynamic>.from(e as Map)).toList()
      ..sort((a, b) => (_kImageRoleOrder[a['role']] ?? 99)
          .compareTo(_kImageRoleOrder[b['role']] ?? 99));
    return rows.map((e) => e['url'] as String).toList();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t       = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);
    final lang    = ref.watch(localeProvider).languageCode;

    return AppScaffold(
      title: widget.titleAr,
      showBack: true,
      child: FutureBuilder<Map<String, dynamic>?>(
        future: _fetchStory(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: palette.accentPrimary));
          }

          final localized = snap.data?['localized'] as Map<String, dynamic>?;
          final entry = (localized?[lang] ?? localized?['ar']) as Map<String, dynamic>?;
          final text = (entry?['simplified_text'] as String?)?.trim();

          if (text == null || text.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(SirajSpacing.s6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(widget.emoji, style: const TextStyle(fontSize: 56)),
                    const SizedBox(height: SirajSpacing.s3),
                    Text(t.stories_comingSoonMsg, textAlign: TextAlign.center,
                      style: AppText.body.copyWith(color: palette.textSecondary)),
                  ],
                ),
              ),
            );
          }

          final title = (entry?['title'] as String?) ?? widget.titleAr;
          final rawImages = (snap.data?['images'] as List?) ?? const [];
          final imageUrls = _sortedImageUrls(rawImages);
          final pageCount = imageUrls.isEmpty ? 1 : imageUrls.length;
          final pages = paginateStoryText(text, pageCount);

          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemBuilder: (context, i) {
                    final url = i < imageUrls.length ? imageUrls[i] : null;
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: SirajSpacing.s5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (i == 0) ...[
                            Center(child: Text(widget.emoji, style: const TextStyle(fontSize: 48))),
                            const SizedBox(height: SirajSpacing.s2),
                            Text(title,
                              textAlign: TextAlign.center,
                              style: AppText.title.copyWith(color: palette.textPrimary)),
                            const SizedBox(height: SirajSpacing.s4),
                          ],
                          if (url != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(SirajRadiusFull.lg),
                              child: AspectRatio(
                                aspectRatio: 4 / 3,
                                child: Image.network(
                                  url,
                                  fit: BoxFit.cover,
                                  loadingBuilder: (context, child, progress) {
                                    if (progress == null) return child;
                                    return Center(
                                      child: CircularProgressIndicator(color: palette.accentPrimary));
                                  },
                                  errorBuilder: (context, error, stack) => Container(
                                    color: widget.color.withValues(alpha: 0.12),
                                    child: Center(
                                      child: Text(widget.emoji, style: const TextStyle(fontSize: 48))),
                                  ),
                                ),
                              ),
                            ),
                          const SizedBox(height: SirajSpacing.s5),
                          Text(pages[i],
                            style: AppText.body.copyWith(color: palette.textPrimary, height: 1.8)),
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (pages.length > 1) ...[
                const SizedBox(height: SirajSpacing.s2),
                _PageDotsIndicator(
                  count: pages.length,
                  current: _currentPage,
                  color: widget.color,
                ),
                const SizedBox(height: SirajSpacing.s3),
              ],
            ],
          );
        },
      ),
    );
  }
}

/// مؤشر نقاط بسيط لصفحات PageView - النقطة الحالية أعرض ومصمتة، والبقية
/// دائرية خافتة. لا اعتماد على حزمة خارجية.
class _PageDotsIndicator extends StatelessWidget {
  final int count;
  final int current;
  final Color color;

  const _PageDotsIndicator({
    required this.count,
    required this.current,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: SirajMotion.fast,
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 20 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? color : color.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(SirajRadiusFull.pill),
          ),
        );
      }),
    );
  }
}
