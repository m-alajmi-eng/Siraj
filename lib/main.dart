import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'core/router/app_router.dart';
import 'core/theme/time_theme_provider.dart';
import 'core/storage/cache_service.dart';
import 'core/locale/locale_provider.dart';
import 'core/notifications/adhan_service.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:just_audio_media_kit/just_audio_media_kit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // backend سطح المكتب (Linux/Windows) لـ just_audio — اختياري للتطوير
  if (Platform.isLinux || Platform.isWindows) {
    try {
      JustAudioMediaKit.ensureInitialized();
    } catch (_) {
      // libmpv غير مثبّت — الصوت يعمل على الجوال
    }
  }

  // تهيئة التشغيل الخلفي للصوت (قرآن + راديو)
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.siraj.audio',
    androidNotificationChannelName: 'سراج — الصوتيات',
    androidNotificationOngoing: true,
  );

  await Supabase.initialize(
    url: 'https://pzcnkzsicyxlzqwjznvh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6Y25renNpY3l4bHpxd2p6bnZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIyMDY2NjQsImV4cCI6MjA5Nzc4MjY2NH0.W2z_NZKyc1HD9CifqKvupIVcSrW1MinDAYsfpZ6ewm8',
  );

  await CacheService.init();

  // تفعيل الأذان (Android/iOS فقط)
  if (Platform.isAndroid || Platform.isIOS) {
    await AdhanService.init();
  }

  runApp(const ProviderScope(child: SirajApp()));
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
        dividerColor: palette.accentPrimary.withOpacity(0.2),
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
                  ? palette.accentPrimary.withOpacity(0.4)
                  : palette.surface),
        ),
      ),
    builder: (context, child) {
      // جدولة إشعارات الصلاة المترجمة - مرة واحدة فقط بعد توفر context
      if (Platform.isAndroid || Platform.isIOS) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!_prayerNotificationsScheduled) {
            _prayerNotificationsScheduled = true;
            AdhanService.schedulePrayerNotifications(
              latitude: 24.7136,
              longitude: 46.6753,
              t: AppLocalizations.of(context),
            );
          }
        });
      }
      return child!;
    },
    );
  }
}

bool _prayerNotificationsScheduled = false;

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
