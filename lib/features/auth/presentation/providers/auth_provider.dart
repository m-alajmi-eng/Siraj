import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) => AuthRepository());

/// حالة المصادقة الحالية (تُحدَّث تلقائياً عبر Stream عند أي تغيير:
/// دخول، خروج، أو تحديث جلسة).
final authStateProvider = StreamProvider<AuthState>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return repo.authStateChanges;
});

/// المستخدم الحالي مباشرة (مختصر مريح للاستخدام في الواجهات).
final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.value?.session?.user ??
      ref.watch(authRepositoryProvider).currentUser;
});

/// هل يوجد مستخدم مسجَّل دخول حالياً (بأي طريقة، بما فيها الضيف)؟
final isSignedInProvider = Provider<bool>((ref) {
  return ref.watch(currentUserProvider) != null;
});
