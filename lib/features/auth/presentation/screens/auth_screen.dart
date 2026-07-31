import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';

/// شاشة تسجيل الدخول: رابط سحري بالبريد (الطريقة الوحيدة الظاهرة حالياً).
/// لا كلمات مرور - يتماشى مع معايير 2026 (passwordless).
///
/// أزرار Google/Apple والدخول كضيف مُخفاة (لا محذوفة) لأن إعدادات
/// Supabase الحية تُعطّلها فعلياً: enable_anonymous_sign_ins=false،
/// auth.external.apple.enabled=false، ولا قسم google في
/// supabase/config.toml. أعد "true" هنا حين تُفعَّل هذه الإعدادات فعلياً.
const bool _kEnableSocialSignIn = false;
const bool _kEnableGuestSignIn = false;

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  final _emailController = TextEditingController();
  bool _isLoading = false;
  bool _magicLinkSent = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
  }

  Future<void> _sendMagicLink() async {
    final email = _emailController.text.trim();
    final t = AppLocalizations.of(context);
    if (!_isValidEmail(email)) {
      setState(() => _errorMessage = t.auth_invalid_email);
      return;
    }
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await ref.read(authRepositoryProvider).sendMagicLink(email);
      if (mounted) setState(() => _magicLinkSent = true);
    } catch (_) {
      if (mounted) setState(() => _errorMessage = t.auth_error_generic);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithProvider(Future<bool> Function() action) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await action();
      if (mounted) context.go('/');
    } catch (_) {
      if (mounted) {
        setState(() => _errorMessage = AppLocalizations.of(context).auth_error_generic);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _continueAsGuest() async {
    setState(() => _isLoading = true);
    try {
      await ref.read(authRepositoryProvider).signInAsGuest();
      if (mounted) context.go('/');
    } catch (_) {
      if (mounted) {
        setState(() => _errorMessage = AppLocalizations.of(context).auth_error_generic);
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final palette = ref.watch(timeThemeProvider);
    final t = AppLocalizations.of(context);

    return Scaffold(
      backgroundColor: palette.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(SirajSpacing.s5),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(Icons.auto_stories_rounded,
                      size: 56, color: palette.accentPrimary),
                  const SizedBox(height: SirajSpacing.s4),
                  Text(t.auth_welcome_title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: palette.textPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: SirajSpacing.s2),
                  Text(t.auth_welcome_subtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: palette.textSecondary, fontSize: 14)),
                  const SizedBox(height: SirajSpacing.s8),
                  if (_magicLinkSent) ...[
                    Container(
                      padding: const EdgeInsets.all(SirajSpacing.s4),
                      decoration: BoxDecoration(
                        color: palette.accentPrimary.withValues(alpha: 0.12),
                        borderRadius:
                            BorderRadius.circular(SirajRadiusFull.md),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.mark_email_read_outlined,
                              color: palette.accentPrimary),
                          const SizedBox(width: SirajSpacing.s3),
                          Expanded(
                            child: Text(t.auth_magic_link_sent,
                                style:
                                    TextStyle(color: palette.textPrimary)),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: palette.textPrimary),
                      decoration: InputDecoration(
                        hintText: t.auth_email_hint,
                        hintStyle: TextStyle(color: palette.textSecondary),
                        filled: true,
                        fillColor: palette.surface,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(SirajRadiusFull.md),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(Icons.email_outlined,
                            color: palette.textSecondary),
                      ),
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: SirajSpacing.s2),
                      Text(_errorMessage!,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 13)),
                    ],
                    const SizedBox(height: SirajSpacing.s3),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _isLoading ? null : _sendMagicLink,
                        style: FilledButton.styleFrom(
                          backgroundColor: palette.accentPrimary,
                          padding: const EdgeInsets.symmetric(
                              vertical: SirajSpacing.s4),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white),
                              )
                            : Text(t.auth_send_magic_link),
                      ),
                    ),
                  ],
                  if (_kEnableSocialSignIn) ...[
                    const SizedBox(height: SirajSpacing.s5),
                    Row(
                      children: [
                        Expanded(child: Divider(color: palette.textSecondary.withValues(alpha: 0.3))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: SirajSpacing.s3),
                          child: Text(t.auth_or, style: TextStyle(color: palette.textSecondary)),
                        ),
                        Expanded(child: Divider(color: palette.textSecondary.withValues(alpha: 0.3))),
                      ],
                    ),
                    const SizedBox(height: SirajSpacing.s5),
                    _SocialButton(
                      icon: Icons.g_mobiledata,
                      label: t.auth_continue_google,
                      palette: palette,
                      onPressed: () => _signInWithProvider(
                          () => ref.read(authRepositoryProvider).signInWithGoogle()),
                    ),
                    const SizedBox(height: SirajSpacing.s3),
                    _SocialButton(
                      icon: Icons.apple,
                      label: t.auth_continue_apple,
                      palette: palette,
                      onPressed: () => _signInWithProvider(
                          () => ref.read(authRepositoryProvider).signInWithApple()),
                    ),
                  ],
                  if (_kEnableGuestSignIn) ...[
                    const SizedBox(height: SirajSpacing.s5),
                    TextButton(
                      onPressed: _isLoading ? null : _continueAsGuest,
                      child: Column(
                        children: [
                          Text(t.auth_continue_guest,
                              style: TextStyle(
                                  color: palette.accentPrimary,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(height: 2),
                          Text(t.auth_guest_note,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: palette.textSecondary, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final dynamic palette;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.palette,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: palette.textPrimary),
        label: Text(label, style: TextStyle(color: palette.textPrimary)),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: SirajSpacing.s4),
          side: BorderSide(color: palette.textSecondary.withValues(alpha: 0.3)),
        ),
      ),
    );
  }
}
