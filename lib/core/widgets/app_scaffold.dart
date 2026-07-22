import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../theme/design_tokens.dart';
import '../theme/app_text.dart';
import '../theme/time_theme_provider.dart';

// ═══════════════════════════════════════════════════════
// AppScaffold — هيكل الصفحة الموحّد
// كل شاشة جديدة تستخدمه. يضمن:
//  - خلفية موحّدة من الثيم
//  - عنوان + عنوان فرعي اختياري
//  - زر رجوع تلقائي (يتكيّف مع RTL/LTR)
//  - padding موحّد
//  - حركة دخول ناعمة
// الاستخدام:
//   AppScaffold(title: t.hadith_title, child: ...)
// ═══════════════════════════════════════════════════════
class AppScaffold extends ConsumerWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final bool showBack;
  final List<Widget>? actions;
  final bool scrollable;
  final EdgeInsetsGeometry? padding;
  final Widget? floatingActionButton;
  /// يستبدل عمود العنوان الافتراضي (Text(title) + العنوان الفرعي) بودجت
  /// مخصّص — لشاشات هيدرها ليس عنواناً نصياً بل عنصر تفاعلي (حقل بحث
  /// مثلاً). زر الرجوع والإجراءات الجانبية (actions) يبقيان كما هما.
  /// [title] يبقى مطلوباً حتى مع هذا لأغراض القراءة الصوتية/التتبّع.
  final Widget? titleWidget;

  const AppScaffold({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.showBack = true,
    this.actions,
    this.scrollable = false,
    this.padding,
    this.floatingActionButton,
    this.titleWidget,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(timeThemeProvider);
    final canPop  = context.canPop();

    final pad = padding ??
        const EdgeInsets.symmetric(horizontal: SirajLayout.pagePadding);

    Widget body = child;
    if (scrollable) {
      body = SingleChildScrollView(child: body);
    }

    return Scaffold(
      backgroundColor: palette.background,
      floatingActionButton: floatingActionButton,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ─── Header ───
            Padding(
              padding: const EdgeInsets.fromLTRB(
                SirajLayout.pagePadding, SirajSpacing.s4,
                SirajLayout.pagePadding, SirajSpacing.s4),
              child: Row(
                children: [
                  if (showBack && canPop)
                    _BackButton(palette: palette),
                  if (showBack && canPop)
                    const SizedBox(width: SirajSpacing.s3),
                  Expanded(
                    child: titleWidget ?? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppText.title.copyWith(
                          color: palette.textPrimary)),
                        if (subtitle != null)
                          Text(subtitle!, style: AppText.caption.copyWith(
                            color: palette.textSecondary)),
                      ],
                    ),
                  ),
                  if (actions != null) ...actions!,
                ],
              ),
            ),
            // ─── Content ───
            Expanded(
              child: Padding(padding: pad, child: body),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  final dynamic palette;
  const _BackButton({required this.palette});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: AppLocalizations.of(context).common_back,
      child: GestureDetector(
        onTap: () => context.pop(),
        child: Container(
          width: 40, height: 40,
          decoration: BoxDecoration(
            color: SirajWhite.w7,
            shape: BoxShape.circle,
            border: Border.all(color: SirajWhite.w10),
          ),
          // الأيقونة تنعكس تلقائياً مع الاتجاه
          child: const Icon(Icons.arrow_back, color: SirajWhite.w70, size: 18),
        ),
      ),
    );
  }
}
