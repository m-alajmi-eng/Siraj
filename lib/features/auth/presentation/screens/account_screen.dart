import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/theme/time_theme_provider.dart';
import '../../../../core/widgets/app_scaffold.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/auth_provider.dart';

/// شاشة إعدادات الحساب: عرض حالة الدخول، تسجيل خروج، وحذف حساب
/// نهائي (المرحلة الأهم لبند P0 القانوني - حذف الحساب داخل التطبيق).
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  Future<void> _confirmDelete(
      BuildContext context, WidgetRef ref, AppLocalizations t) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(t.auth_delete_account),
        content: Text(t.auth_delete_account_confirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(t.common_cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(t.auth_delete_account),
          ),
        ],
      ),
    );

    if (confirmed != true) return;
    if (!context.mounted) return;

    try {
      await ref.read(authRepositoryProvider).deleteAccount();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.auth_delete_account_success)),
        );
        context.go('/');
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.auth_error_generic)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(timeThemeProvider);
    final t = AppLocalizations.of(context);
    final user = ref.watch(currentUserProvider);
    final repo = ref.read(authRepositoryProvider);
    final isGuest = repo.isGuest;

    return AppScaffold(
      title: t.auth_account_settings,
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (user != null) ...[
                Container(
                  padding: const EdgeInsets.all(SirajSpacing.s4),
                  decoration: BoxDecoration(
                    color: palette.surface,
                    borderRadius: BorderRadius.circular(SirajRadiusFull.md),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: palette.accentPrimary.withValues(alpha: 0.2),
                        child: Icon(
                          isGuest ? Icons.person_outline : Icons.person,
                          color: palette.accentPrimary,
                        ),
                      ),
                      const SizedBox(width: SirajSpacing.s3),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isGuest ? t.auth_guest_account : t.auth_signed_in_as,
                              style: TextStyle(color: palette.textSecondary, fontSize: 12),
                            ),
                            if (!isGuest)
                              Text(
                                user.email ?? '',
                                style: TextStyle(color: palette.textPrimary, fontWeight: FontWeight.w600),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: SirajSpacing.s5),
                ListTile(
                  leading: Icon(Icons.logout, color: palette.textPrimary),
                  title: Text(t.auth_sign_out, style: TextStyle(color: palette.textPrimary)),
                  onTap: () async {
                    await ref.read(authRepositoryProvider).signOut();
                    if (context.mounted) context.go('/');
                  },
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.delete_forever, color: Colors.red),
                  title: Text(t.auth_delete_account, style: const TextStyle(color: Colors.red)),
                  onTap: () => _confirmDelete(context, ref, t),
                ),
              ] else
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(SirajSpacing.s8),
                    child: FilledButton(
                      onPressed: () => context.push('/auth'),
                      child: Text(t.auth_welcome_title),
                    ),
                  ),
                ),
            ],
          ),
    );
  }
}
