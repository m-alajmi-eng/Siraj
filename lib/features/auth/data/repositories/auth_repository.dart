import 'package:supabase_flutter/supabase_flutter.dart';

/// طبقة موحّدة لكل عمليات المصادقة عبر Supabase Auth.
/// تدعم: رابط سحري بالبريد، Google، Apple، ضيف (مجهول)، وحذف الحساب.
class AuthRepository {
  final SupabaseClient _client = Supabase.instance.client;

  /// المستخدم الحالي، أو null إن لم يُسجَّل الدخول.
  User? get currentUser => _client.auth.currentUser;

  /// تدفّق حالة المصادقة (يُستخدم لمراقبة تسجيل الدخول/الخروج فورياً).
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  /// هل المستخدم الحالي "ضيف" (تسجيل مجهول، لا بريد حقيقي)؟
  bool get isGuest => currentUser != null && currentUser!.isAnonymous;

  /// يرسل رابط دخول سحرياً إلى البريد المُدخَل. المستخدم يكمل الدخول
  /// بالضغط على الرابط في بريده (لا كلمة مرور مطلوبة إطلاقاً).
  Future<void> sendMagicLink(String email) async {
    await _client.auth.signInWithOtp(
      email: email,
      emailRedirectTo: 'app.siraj.siraj://auth-callback',
    );
  }

  /// تسجيل الدخول عبر Google (يفتح نافذة OAuth عبر المتصفح/النظام).
  Future<bool> signInWithGoogle() async {
    return _client.auth.signInWithOAuth(OAuthProvider.google);
  }

  /// تسجيل الدخول عبر Apple (إلزامي لتطبيقات iOS التي توفر Google).
  Future<bool> signInWithApple() async {
    return _client.auth.signInWithOAuth(OAuthProvider.apple);
  }

  /// دخول كضيف: حساب مؤقت مجهول بلا بريد، يتيح استخدام كل ميزات
  /// التطبيق فوراً بلا أي تسجيل. يمكن ربطه ببريد لاحقاً (ترقية).
  Future<void> signInAsGuest() async {
    await _client.auth.signInAnonymously();
  }

  /// تسجيل الخروج (يعمل لكل أنواع الحسابات، بما فيها الضيف).
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  /// حذف الحساب نهائياً. يتطلب دالة قاعدة بيانات (RPC) في Supabase
  /// باسم delete_user (تُنشأ في لوحة تحكم Supabase، تُنفَّذ بصلاحيات
  /// خادم لحذف المستخدم فعلياً من auth.users - لا يمكن حذف حساب
  /// المستخدم لنفسه مباشرة من العميل لأسباب أمنية في Supabase).
  Future<void> deleteAccount() async {
    await _client.rpc('delete_user');
    await signOut();
  }
}
