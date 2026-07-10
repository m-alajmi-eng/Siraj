import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import '../../../../core/locale/locale_provider.dart';
import '../../../../core/theme/design_tokens.dart';

/// شاشة اختيار اللغة عند أول تشغيل - أول ما يراه المستخدم، قبل حتى
/// Onboarding، لأن كل نص بعدها (بما فيه تسجيل الدخول) يعتمد عليها.
class LanguageSelectScreen extends ConsumerWidget {
  const LanguageSelectScreen({super.key});

  // كود -> (الاسم بلغته الأصلية، RTL؟)
  static const List<(String, String, bool)> _languages = [
    ('ar', 'العربية', true),
    ('en', 'English', false),
    ('ur', 'اردو', true),
    ('fa', 'فارسی', true),
    ('id', 'Bahasa Indonesia', false),
    ('tr', 'Türkçe', false),
    ('fr', 'Français', false),
    ('bn', 'বাংলা', false),
    ('ms', 'Bahasa Melayu', false),
    ('ha', 'Hausa', false),
    ('sw', 'Kiswahili', false),
    ('de', 'Deutsch', false),
    ('ru', 'Русский', false),
    ('zh', '中文', false),
    ('es', 'Español', false),
  ];

  void _select(BuildContext context, WidgetRef ref, String code) {
    ref.read(localeProvider.notifier).setLocale(code);
    // نسجّل أن المستخدم اختار صراحة (لا نعتمد على الافتراضي الصامت)
    try {
      Hive.box('settings').put('locale_chosen', true);
    } catch (_) {}
    final isDone =
        Hive.box('settings').get('onboarding_done', defaultValue: false);
    context.go(isDone ? '/home' : '/onboarding');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1A24),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(SirajSpacing.s5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: SirajSpacing.s8),
              const Icon(Icons.language, size: 48, color: Color(0xFFD4AF37)),
              const SizedBox(height: SirajSpacing.s4),
              const Text(
                'اختر لغتك — Choose your language',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: SirajSpacing.s6),
              Expanded(
                child: ListView.separated(
                  itemCount: _languages.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: SirajSpacing.s2),
                  itemBuilder: (context, i) {
                    final (code, name, isRtl) = _languages[i];
                    return Directionality(
                      textDirection:
                          isRtl ? TextDirection.rtl : TextDirection.ltr,
                      child: Material(
                        color: Colors.white.withValues(alpha: 0.06),
                        borderRadius:
                            BorderRadius.circular(SirajRadiusFull.md),
                        child: InkWell(
                          borderRadius:
                              BorderRadius.circular(SirajRadiusFull.md),
                          onTap: () => _select(context, ref, code),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: SirajSpacing.s4,
                                vertical: SirajSpacing.s4),
                            child: Text(
                              name,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
