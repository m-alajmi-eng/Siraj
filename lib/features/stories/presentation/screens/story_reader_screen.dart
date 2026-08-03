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

/// أقصى نسبة من ارتفاع الصفحة تُخصَّص للصورة - الباقي للنص دائماً.
const _kImageHeightFraction = 0.46;

/// أقصى نسبة من عرض الصفحة يُسمح لارتفاع الصورة أن يبلغها - يمنع الصورة
/// من أن تصبح طويلة عمودياً بشكل غير متناسب مع عرضها الفعلي على شاشة
/// جوال ضيقة (~390px)، حتى لو كانت نسبة الارتفاع وحدها (فوق) تسمح
/// بارتفاع أكبر. القيد الفعلي في كل صفحة هو الأصغر بين القيدين.
const _kImageMaxWidthAspect = 0.75;

/// يقسّم نص القصة (فقرات مفصولة بسطرين فارغين \n\n) إلى فقرات مفردة -
/// كل فقرة تُعرض في صفحتها الخاصة كاملة، بلا دمج فقرتين أو أكثر في صفحة
/// واحدة مهما كان عدد الصور المرفقة.
List<String> splitStoryParagraphs(String text) {
  final paragraphs =
      text.split('\n\n').map((p) => p.trim()).where((p) => p.isNotEmpty).toList();
  return paragraphs.isEmpty ? [text.trim()] : paragraphs;
}

/// شاشة قراءة قصة طفل واحدة من children_stories_drafts. الاستعلام يحترم
/// RLS (reviewed=true فقط) تلقائياً - لو لم تُراجَع القصة بعد، يرجع صفراً
/// صفوف بلا أي خطأ، فتُعرض حالة "قريباً" صادقة بدل شاشة مكسورة أو فارغة
/// مربكة.
///
/// تجربة القراءة الفعلية PageView: صفحة واحدة لكل فقرة (لا دمج فقرات)،
/// وكل صفحة نصية - بلا استثناء - تعرض صورة "المرحلة" الأقرب لها
/// (افتتاحية/ذروة/ختامية) بنسبة ارتفاع محدودة من الصفحة، لا تطغى على النص.
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
  // يُخزَّن مرة واحدة في initState - لو استُدعي _fetchStory() مباشرة داخل
  // FutureBuilder.future ضمن build()، كل setState (مثل onPageChanged عند
  // كل قلب صفحة) يُنشئ Future جديداً، فيعيد FutureBuilder حالة الانتظار
  // ويهدم PageView بأكملها؛ لأن _pageController نفسه يُعاد ربطه بشجرة
  // جديدة بلا موضع تمرير محفوظ، تقفز الصفحة فعلياً إلى البداية (0) بدل
  // الانتقال لحيث ضغط المستخدم - وهذا ما بدا وكأن "الصفحة لا تتغيّر".
  late final Future<Map<String, dynamic>?> _storyFuture;

  @override
  void initState() {
    super.initState();
    _storyFuture = _fetchStory();
  }

  Future<Map<String, dynamic>?> _fetchStory() async {
    final res = await Supabase.instance.client
        .from('children_stories_drafts')
        .select('id, localized, images')
        .eq('id', widget.storyId)
        .maybeSingle();
    return res;
  }

  List<Map<String, dynamic>> _sortedImageRows(List<dynamic> images) {
    return images.map((e) => Map<String, dynamic>.from(e as Map)).toList()
      ..sort((a, b) => (_kImageRoleOrder[a['role']] ?? 99)
          .compareTo(_kImageRoleOrder[b['role']] ?? 99));
  }

  /// يضمن صورة لكل صفحة نصية بلا استثناء: عدد الفقرات غالباً أكبر من عدد
  /// الصور (افتتاحية/ذروة/ختامية)، فكل صفحة تأخذ صورة "المرحلة" الأقرب
  /// لها حتى لو لم تملك صورة أصلية مطابقة - النصف الأول من الصفحات
  /// يعرض صورة الافتتاحية، الثلث الأوسط (إن وُجدت صورة ذروة) يعرض
  /// صورة الذروة، والباقي يعرض صورة الختامية.
  Map<int, String> _imagePageMap(
      List<Map<String, dynamic>> sortedRows, int pageCount) {
    String? opening, climax, closing;
    for (final row in sortedRows) {
      final url = row['url'] as String;
      switch (row['role']) {
        case 'opening': opening = url;
        case 'climax': climax = url;
        case 'closing': closing = url;
      }
    }

    final map = <int, String>{};
    for (var i = 0; i < pageCount; i++) {
      final url = _phaseImage(i, pageCount, opening, climax, closing);
      if (url != null) map[i] = url;
    }
    return map;
  }

  /// صورة المرحلة المناسبة لفهرس صفحة بعينها، مع رجوع لأقرب صورة متاحة
  /// إن كانت صورة المرحلة المتوقعة (افتتاحية/ذروة/ختامية) غير موجودة.
  String? _phaseImage(int index, int pageCount, String? opening,
      String? climax, String? closing) {
    if (climax != null && pageCount >= 3) {
      final third = pageCount / 3;
      if (index < third) return opening ?? climax;
      if (index < third * 2) return climax;
      return closing ?? climax;
    }
    final half = pageCount / 2;
    if (index < half) return opening ?? closing ?? climax;
    return closing ?? opening ?? climax;
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
    final isAr    = lang == 'ar';

    return AppScaffold(
      title: widget.titleAr,
      showBack: true,
      child: FutureBuilder<Map<String, dynamic>?>(
        future: _storyFuture,
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
          final imageRows = _sortedImageRows(rawImages);
          final pages = splitStoryParagraphs(text);
          final imageMap = _imagePageMap(imageRows, pages.length);

          return Column(
            children: [
              Expanded(
                // TODO(قبل بناء APK): تفعيل/اختبار التمرير باللمس (يمين/يسار)
                // بشكل حقيقي على جهاز محمول فعلي - الأزرار الحالية بديل مؤقت
                // للاختبار على سطح المكتب فقط. لا تحذف هذا التعليق حتى يُختبَر
                // فعلياً على جوال/آيباد حقيقي.
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: pages.length,
                  onPageChanged: (i) => setState(() => _currentPage = i),
                  itemBuilder: (context, i) {
                    return _StoryPage(
                      isFirst: i == 0,
                      title: title,
                      emoji: widget.emoji,
                      paragraph: pages[i],
                      imageUrl: imageMap[i],
                      accentColor: widget.color,
                      palette: palette,
                    );
                  },
                ),
              ),
              if (pages.length > 1) ...[
                const SizedBox(height: SirajSpacing.s3),
                Directionality(
                  textDirection: isAr ? TextDirection.rtl : TextDirection.ltr,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _NavArrowButton(
                        icon: Icons.arrow_back,
                        enabled: _currentPage > 0,
                        accentColor: widget.color,
                        semanticLabel: t.common_prevPage,
                        onTap: () => _pageController.previousPage(
                          duration: SirajMotion.normal,
                          curve: Curves.easeInOut,
                        ),
                      ),
                      const SizedBox(width: SirajSpacing.s5),
                      _PageDotsIndicator(
                        count: pages.length,
                        current: _currentPage,
                        color: widget.color,
                      ),
                      const SizedBox(width: SirajSpacing.s5),
                      _NavArrowButton(
                        icon: Icons.arrow_forward,
                        enabled: _currentPage < pages.length - 1,
                        accentColor: widget.color,
                        semanticLabel: t.common_nextPage,
                        onTap: () => _pageController.nextPage(
                          duration: SirajMotion.normal,
                          curve: Curves.easeInOut,
                        ),
                      ),
                    ],
                  ),
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

/// صفحة قصة واحدة: صورة بنسبة ارتفاع ثابتة (لا تتجاوز
/// [_kImageHeightFraction] من ارتفاع الصفحة) + فقرة واحدة كاملة أسفلها
/// بخط أكبر من نص القراءة العادي وتباعد أسطر مريح لعين طفل، بمحاذاة
/// تبدأ من جهة القراءة (يمين للعربية) لا توسيط.
class _StoryPage extends StatelessWidget {
  final bool isFirst;
  final String title;
  final String emoji;
  final String paragraph;
  final String? imageUrl;
  final Color accentColor;
  final dynamic palette;

  const _StoryPage({
    required this.isFirst,
    required this.title,
    required this.emoji,
    required this.paragraph,
    required this.imageUrl,
    required this.accentColor,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageHeight = imageUrl == null
            ? 0.0
            : math.min(
                constraints.maxHeight * _kImageHeightFraction,
                constraints.maxWidth * _kImageMaxWidthAspect,
              );

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: SirajSpacing.s3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (imageUrl != null)
                SizedBox(
                  height: imageHeight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(SirajRadiusFull.lg),
                    child: Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(color: palette.accentPrimary));
                      },
                      errorBuilder: (context, error, stack) => Container(
                        color: accentColor.withValues(alpha: 0.12),
                        child: Center(
                          child: Text(emoji, style: const TextStyle(fontSize: 48))),
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: SirajSpacing.s4),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (isFirst) ...[
                        Row(
                          children: [
                            Text(emoji, style: const TextStyle(fontSize: 30)),
                            const SizedBox(width: SirajSpacing.s2),
                            Expanded(
                              child: Text(title,
                                style: AppText.headline.copyWith(color: palette.textPrimary)),
                            ),
                          ],
                        ),
                        const SizedBox(height: SirajSpacing.s4),
                      ],
                      Text(paragraph,
                        textAlign: TextAlign.start,
                        style: AppText.body.copyWith(
                          color: palette.textPrimary,
                          fontSize: SirajSizes.s2xl,
                          fontWeight: FontWeight.w500,
                          height: SirajLineHeights.loose,
                          letterSpacing: 0.4,
                        )),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// زر سهم تنقّل صريح (تالٍ/سابق) بجانب مؤشر النقاط - يعمل إلى جانب
/// السحب باللمس، لا بديلاً عنه. يتعطَّل بصرياً ووظيفياً في طرفَي القصة.
class _NavArrowButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final Color accentColor;
  final String semanticLabel;
  final VoidCallback onTap;

  const _NavArrowButton({
    required this.icon,
    required this.enabled,
    required this.accentColor,
    required this.semanticLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.35,
        child: GestureDetector(
          onTap: enabled ? onTap : null,
          child: Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.14),
              shape: BoxShape.circle,
              border: Border.all(color: accentColor.withValues(alpha: 0.35)),
            ),
            child: Icon(icon, color: accentColor, size: 22),
          ),
        ),
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
    return Wrap(
      alignment: WrapAlignment.center,
      children: List.generate(count, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: SirajMotion.fast,
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
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
