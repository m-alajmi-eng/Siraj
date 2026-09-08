import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;
import 'l10n/app_localizations.dart';
import 'core/router/app_router.dart';
import 'core/theme/time_theme_provider.dart';
import 'core/storage/cache_service.dart';
import 'core/locale/locale_provider.dart';
import 'core/notifications/adhan_service.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:just_audio_media_kit/just_audio_media_kit.dart';

// أسرار قابلة للتخصيص عبر --dart-define وقت البناء (PHASE L3): المفتاح
// العلني (publishable key) عام بطبيعته في Supabase ولا يمثّل ثغرة أمنية
// بذاته، لكن فصله يُمكّن تدوير المفاتيح بلا تعديل الكود، ويطابق توصية
// docs/02_STORE_COMPLIANCE.md. القيم الافتراضية هنا هي قيم الإنتاج
// الحالية — البناء العادي بلا أي --dart-define يعمل تماماً كما كان.
//
// 2026-09-08: انتقال من anonKey (JWT قديم) إلى publishableKey (نظام
// مفاتيح Supabase الجديد sb_publishable_*) - المشروع لم يعد يملك صفحة
// "JWT Settings" بلوحة التحكم إطلاقاً (تحقَّق محمد بنفسه)، والمفتاح
// القديم مهجور رسمياً بحزمة supabase_flutter (anonKey will be removed
// in a future major version). المفتاح الفعلي جُلب مباشرة عبر
// `supabase projects api-keys --project-ref pzcnkzsicyxlzqwjznvh`
// (النوع "publishable"، لا "Legacy anon API key").
const String _supabaseUrl = String.fromEnvironment(
  'SUPABASE_URL',
  defaultValue: 'https://pzcnkzsicyxlzqwjznvh.supabase.co',
);
const String _supabasePublishableKey = String.fromEnvironment(
  'SUPABASE_PUBLISHABLE_KEY',
  defaultValue: 'sb_publishable_No_no5hRjIZU9dIBuqFcbQ_9I8IxWu9',
);
const String _sentryDsn = String.fromEnvironment(
  'SENTRY_DSN',
  defaultValue:
      'https://795e91c7bb4515d11239d0c5e3f4b0e6@o4511711586615296.ingest.de.sentry.io/4511711604310096',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initTimezone();

  // مراقبة الأعطال عبر Sentry (مجاني، مستقل عن Firebase تماماً) — يجب أن
  // تُهيَّأ قبل أي تهيئة أخرى قد تفشل (JustAudioMediaKit/JustAudioBackground/
  // Supabase/CacheService/AdhanService)، لذا انتقلت كلها إلى داخل appRunner
  // نفسه بدل أن تسبق SentryFlutter.init() — بلا أي تغيير في ترتيبها
  // النسبي أو منطقها الداخلي، فقط موضعها.
  await SentryFlutter.init(
    (options) {
      options.dsn = _sentryDsn;
      // نسبة تتبع الأداء منخفضة عمداً لمشروع خيري (توفير الحصة المجانية)
      options.tracesSampleRate = 0.1;
      // يطابق ادّعاء سياسة الخصوصية أن Sentry "مُعطَّل صراحة" لأي بيانات
      // تعريف شخصية (IP، اسم مستخدم، إلخ) - القيمة الافتراضية في SDK
      // بحد ذاتها false، لكن التصريح الصريح هنا يمنع أي تغيير مستقبلي
      // في الافتراضي من كسر هذا الالتزام بصمت.
      options.sendDefaultPii = false;
    },
    appRunner: () async {
      // Sentry يستدعي هذا داخلياً بنفسه بالفعل (أول تكامل لديه)، لكن
      // استدعاؤه هنا أيضاً آمن تماماً (يُرجع نفس الـbinding الموجود).
      WidgetsFlutterBinding.ensureInitialized();

      // backend سطح المكتب (Linux/Windows) لـ just_audio — اختياري للتطوير
      if (Platform.isLinux || Platform.isWindows) {
        try {
          JustAudioMediaKit.ensureInitialized();
        } catch (e, st) {
          // لا نغيّر السلوك (التطبيق يستمر بلا صوت سطح مكتب إن فشلت هذه
          // التهيئة، غالباً بسبب libmpv غير مثبّت) — لكن السبب كان يُبتلَع
          // بصمت تام سابقاً، ما يُخفي أي فشل صوت مستقبلي مشابه حتى لو
          // حدث يوماً على منصة أخرى. نسجّله الآن بدل تجاهله.
          if (kDebugMode) {
            debugPrint('JustAudioMediaKit.ensureInitialized فشلت: $e');
          }
          if (Sentry.isEnabled) {
            unawaited(Sentry.captureException(e, stackTrace: st));
          }
        }
      }

      // تهيئة التشغيل الخلفي للصوت (قرآن + راديو)
      await JustAudioBackground.init(
        androidNotificationChannelId: 'com.siraj.audio',
        androidNotificationChannelName: 'سراج — الصوتيات',
        androidNotificationOngoing: true,
      );

      await Supabase.initialize(
        url: _supabaseUrl,
        publishableKey: _supabasePublishableKey,
      );

      await CacheService.init();

      // تفعيل الأذان (Android/iOS فقط)
      if (Platform.isAndroid || Platform.isIOS) {
        await AdhanService.init();
      }

      runApp(const ProviderScope(child: SirajApp()));
    },
  );
}

/// يهيّئ قاعدة بيانات المناطق الزمنية ويضبط منطقة الجهاز الفعلية،
/// بدلاً من الاعتماد على UTC الافتراضي (كان يسبب انزياح تذكيرات الختمة).
Future<void> _initTimezone() async {
  tz_data.initializeTimeZones();
  try {
    final name = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(name));
  } catch (_) {
    // تعذّر تحديد منطقة الجهاز — تبقى tz.local على UTC كحل احتياطي آمن.
  }
}

class SirajApp extends ConsumerWidget {
  const SirajApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(timeThemeProvider);
    final router  = ref.watch(appRouterProvider);
    final locale  = ref.watch(localeProvider);

    return MaterialApp.router(
      title:                      'Siraj',
      debugShowCheckedModeBanner: false,
      routerConfig:               router,
      locale:                     locale,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        _FallbackMaterialDelegate(),
        _FallbackCupertinoDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,

      // معالجة اللغات التي لا يدعمها Material أصلاً (مثل الهوسا)
      // نستخدم ترجماتنا، وأدوات Material تقع على fallback آمن
      localeResolutionCallback: (locale, supported) {
        if (locale == null) return const Locale('ar');
        for (final l in supported) {
          if (l.languageCode == locale.languageCode) return locale;
        }
        return const Locale('ar');
      },

      theme: ThemeData(
        brightness:              Brightness.dark,
        scaffoldBackgroundColor: palette.background,
        useMaterial3:            true,
        colorScheme: ColorScheme.dark(
          primary:   palette.accentPrimary,
          surface:   palette.surface,
          onPrimary: palette.textPrimary,
          onSurface: palette.textPrimary,
        ),
        textTheme: TextTheme(
          bodyLarge:   TextStyle(color: palette.textPrimary),
          bodyMedium:  TextStyle(color: palette.textPrimary),
          bodySmall:   TextStyle(color: palette.textSecondary),
          titleLarge:  TextStyle(color: palette.textPrimary),
          titleMedium: TextStyle(color: palette.textPrimary),
        ),
        iconTheme: IconThemeData(color: palette.textPrimary),
        dividerColor: palette.accentPrimary.withValues(alpha: 0.2),
        listTileTheme: ListTileThemeData(
          textColor: palette.textPrimary,
          iconColor: palette.textPrimary,
        ),
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith((states) =>
              states.contains(WidgetState.selected)
                  ? palette.accentPrimary
                  : palette.textSecondary),
          trackColor: WidgetStateProperty.resolveWith((states) =>
              states.contains(WidgetState.selected)
                  ? palette.accentPrimary.withValues(alpha: 0.4)
                  : palette.surface),
        ),
      ),
    );
  }
}

class _FallbackMaterialDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  const _FallbackMaterialDelegate();
  @override
  bool isSupported(Locale locale) => true;
  @override
  Future<MaterialLocalizations> load(Locale locale) =>
      GlobalMaterialLocalizations.delegate.load(const Locale('en'));
  @override
  bool shouldReload(_FallbackMaterialDelegate old) => false;
}

class _FallbackCupertinoDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const _FallbackCupertinoDelegate();
  @override
  bool isSupported(Locale locale) => true;
  @override
  Future<CupertinoLocalizations> load(Locale locale) =>
      GlobalCupertinoLocalizations.delegate.load(const Locale('en'));
  @override
  bool shouldReload(_FallbackCupertinoDelegate old) => false;
}
