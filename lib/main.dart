import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'core/router/app_router.dart';
import 'core/theme/time_theme_provider.dart';
import 'core/storage/cache_service.dart';
import 'core/notifications/adhan_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://pzcnkzsicyxlzqwjznvh.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6Y25renNpY3l4bHpxd2p6bnZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIyMDY2NjQsImV4cCI6MjA5Nzc4MjY2NH0.W2z_NZKyc1HD9CifqKvupIVcSrW1MinDAYsfpZ6ewm8',
  );

  await CacheService.init();

  // تفعيل الأذان (Android/iOS فقط)
  if (Platform.isAndroid || Platform.isIOS) {
    await AdhanService.init();
    await AdhanService.schedulePrayerNotifications(
      latitude:  24.7136,
      longitude: 46.6753,
    );
  }

  runApp(const ProviderScope(child: SirajApp()));
}

class SirajApp extends ConsumerWidget {
  const SirajApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final palette = ref.watch(timeThemeProvider);
    final router  = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title:                      'Siraj',
      debugShowCheckedModeBanner: false,
      routerConfig:               router,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,

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
    );
  }
}