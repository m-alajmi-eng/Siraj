import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/app_text.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';

/// شاشة قراءة قصة طفل واحدة من children_stories_drafts. الاستعلام يحترم
/// RLS (reviewed=true فقط) تلقائياً - لو لم تُراجَع القصة بعد (كل شيء
/// حالياً)، يرجع صفراً صفوف بلا أي خطأ، فتُعرض حالة "قريباً" صادقة بدل
/// شاشة مكسورة أو فارغة مربكة.
class StoryReaderScreen extends ConsumerWidget {
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

  Future<Map<String, dynamic>?> _fetchStory() async {
    final res = await Supabase.instance.client
        .from('children_stories_drafts')
        .select('id, localized')
        .eq('id', storyId)
        .maybeSingle();
    return res;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t       = AppLocalizations.of(context);
    final palette = ref.watch(timeThemeProvider);
    final lang    = ref.watch(localeProvider).languageCode;

    return AppScaffold(
      title: titleAr,
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
                    Text(emoji, style: const TextStyle(fontSize: 56)),
                    const SizedBox(height: SirajSpacing.s3),
                    Text(t.stories_comingSoonMsg, textAlign: TextAlign.center,
                      style: AppText.body.copyWith(color: palette.textSecondary)),
                  ],
                ),
              ),
            );
          }

          final title = (entry?['title'] as String?) ?? titleAr;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(SirajSpacing.s5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(child: Text(emoji, style: const TextStyle(fontSize: 56))),
                const SizedBox(height: SirajSpacing.s3),
                Text(title,
                  textAlign: TextAlign.center,
                  style: AppText.title.copyWith(color: palette.textPrimary)),
                const SizedBox(height: SirajSpacing.s5),
                Text(text,
                  style: AppText.body.copyWith(color: palette.textPrimary, height: 1.8)),
              ],
            ),
          );
        },
      ),
    );
  }
}
