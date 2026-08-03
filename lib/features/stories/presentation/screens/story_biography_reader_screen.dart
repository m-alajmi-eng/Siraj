import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';

/// شاشة قراءة أساسية لقصة نبي/صحابي/عالم من جدول stories - نسخة مبسّطة
/// عمداً عن story_reader_screen.dart (قصص الأطفال): لا PageView مقسَّم
/// لصفحات، ولا صور مرحلية مرتبطة بأدوار (opening/climax/closing)، لأن
/// content_ar هنا نص عربي خام واحد بلا localized متعدد اللغات، والجدول
/// لا يملك عمود صور أصلاً. تمرير عمودي واحد كافٍ لهذا المحتوى.
///
/// الاستعلام يحترم RLS (is_published=true فقط) تلقائياً - لو لم تُنشَر
/// القصة بعد، يرجع صفراً صفوف بلا خطأ، فتُعرض حالة "قريباً" صادقة بدل
/// شاشة مكسورة أو فارغة مربكة.
class StoryBiographyReaderScreen extends ConsumerStatefulWidget {
  final int storyId;
  final String titleAr;

  const StoryBiographyReaderScreen({
    super.key,
    required this.storyId,
    required this.titleAr,
  });

  @override
  ConsumerState<StoryBiographyReaderScreen> createState() =>
      _StoryBiographyReaderScreenState();
}

class _StoryBiographyReaderScreenState
    extends ConsumerState<StoryBiographyReaderScreen> {
  // يُخزَّن مرة واحدة في initState - استدعاء الجلب مباشرة داخل
  // FutureBuilder.future ضمن build() يُنشئ Future جديداً في كل rebuild
  // (بما فيها تغيّر ref.watch(timeThemeProvider) هنا)، فيُعيد جلباً شبكياً
  // بلا داعٍ في كل مرة.
  late final Future<Map<String, dynamic>?> _storyFuture;

  @override
  void initState() {
    super.initState();
    _storyFuture = _fetchStory();
  }

  Future<Map<String, dynamic>?> _fetchStory() async {
    final res = await Supabase.instance.client
        .from('stories')
        .select('title_ar, person_name, period, content_ar')
        .eq('id', widget.storyId)
        .maybeSingle();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);

    return AppScaffold(
      title: widget.titleAr,
      showBack: true,
      child: FutureBuilder<Map<String, dynamic>?>(
        future: _storyFuture,
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: palette.accentPrimary),
            );
          }

          final content = (snap.data?['content_ar'] as String?)?.trim();
          if (content == null || content.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(SirajSpacing.s6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.auto_stories,
                      size: 56,
                      color: palette.textSecondary,
                    ),
                    const SizedBox(height: SirajSpacing.s3),
                    Text(
                      t.stories_comingSoonMsg,
                      textAlign: TextAlign.center,
                      style: AppText.body.copyWith(
                        color: palette.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final title = (snap.data?['title_ar'] as String?) ?? widget.titleAr;
          final personName = snap.data?['person_name'] as String?;
          final period = snap.data?['period'] as String?;
          final subtitle = [
            personName,
            period,
          ].where((s) => s != null && s.isNotEmpty).join(' · ');
          final paragraphs = content
              .split('\n\n')
              .map((p) => p.trim())
              .where((p) => p.isNotEmpty)
              .toList();

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: SirajSpacing.s5,
              vertical: SirajSpacing.s4,
            ),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: AppText.headline.copyWith(
                      color: palette.textPrimary,
                    ),
                  ),
                  if (subtitle.isNotEmpty) ...[
                    const SizedBox(height: SirajSpacing.s1),
                    Text(
                      subtitle,
                      style: AppText.caption.copyWith(
                        color: palette.textSecondary,
                      ),
                    ),
                  ],
                  const SizedBox(height: SirajSpacing.s5),
                  for (final p in paragraphs) ...[
                    Text(
                      p,
                      textAlign: TextAlign.start,
                      style: AppText.body.copyWith(
                        color: palette.textPrimary,
                        fontSize: SirajSizes.sLg,
                        height: SirajLineHeights.relaxed,
                      ),
                    ),
                    const SizedBox(height: SirajSpacing.s4),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
