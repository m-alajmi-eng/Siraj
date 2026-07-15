// اختبار Widget لشاشتي الختمة: يقود التدفق الفعلي "إنشاء خطة" عبر
// KhatmahCreateScreen (اختيار مدة عبر preset + اسم مخصص + زر الإنشاء)
// ثم يتحقق من ظهور البطاقة في KhatmahListScreen بالحسابات الصحيحة
// (الوِرد اليومي، نسبة التقدّم، رقم اليوم، حالة التقدّم).

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:siraj/features/khatmah/presentation/screens/khatmah_create_screen.dart';
import 'package:siraj/features/khatmah/presentation/screens/khatmah_list_screen.dart';
import 'package:siraj/l10n/app_localizations.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    tempDir = await Directory.systemTemp.createTemp('khatmah_widget_test');
    Hive.init(tempDir.path);
    await Hive.openBox('settings');
  });

  tearDown(() async {
    await Hive.box('settings').clear();
  });

  tearDownAll(() async {
    await Hive.close();
    if (await tempDir.exists()) await tempDir.delete(recursive: true);
  });

  Widget buildApp() {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(path: '/', builder: (_, _) => const KhatmahListScreen()),
        GoRoute(
            path: '/khatmah/create',
            builder: (_, _) => const KhatmahCreateScreen()),
      ],
    );
    return ProviderScope(
      child: MaterialApp.router(
        routerConfig: router,
        locale: const Locale('ar'),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }

  testWidgets('إنشاء خطة ختمة يعرض بطاقة بالحسابات الصحيحة في القائمة',
      (tester) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    // القائمة فارغة قبل أي إنشاء
    expect(find.text('لا توجد ختمات بعد. ابدأ ختمتك الأولى!'), findsOneWidget);

    // فتح شاشة الإنشاء عبر زر الإضافة
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(KhatmahCreateScreen), findsOneWidget);

    // اختيار المدة الأسبوعية (7 أيام) عبر preset chip
    await tester.tap(find.text('أسبوعية (7 أيام)'));
    await tester.pump();

    // الوِرد اليومي يُحسب فوراً: ceil(604/7) = 87
    expect(find.text('الوِرد اليومي (صفحات): 87'), findsOneWidget);

    // اسم مخصص للخطة
    await tester.enterText(find.byType(TextField), 'ختمتي التجريبية');

    // إنشاء الخطة: onPressed يحفظ عبر Hive بعملية I/O حقيقية (منفذة عبر
    // isolate helper داخلي)، فيجب أن يبدأ الـtap ذاته والانتظار الحقيقي
    // معاً داخل runAsync واحد (بدء الـFuture خارج runAsync يجمّده أبدياً
    // في الزمن المُصطنع لـ flutter test)، ثم pumpAndSettle خارجها لعرض
    // التنقّل الناتج.
    await tester.runAsync(() async {
      await tester.tap(find.widgetWithText(ElevatedButton, 'إنشاء الختمة'));
      await Future<void>.delayed(const Duration(milliseconds: 300));
    });
    await tester.pumpAndSettle();

    // عاد للقائمة، والبطاقة الجديدة ظاهرة
    expect(find.byType(KhatmahCreateScreen), findsNothing);
    expect(find.text('ختمتي التجريبية'), findsOneWidget);

    // خطة بيوم أول ولم تُقرأ أي صفحة بعد: 0% تقدّم، اليوم 1 من 7، حالة متأخر
    expect(find.text('0% · اليوم 1 من 7'), findsOneWidget);
    expect(find.text('متأخر'), findsOneWidget);
  });
}
