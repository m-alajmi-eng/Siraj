# SIRAJ — Session Status (تنفيذ ليلي تلقائي)
**بدأ:** 2026-07-22 · **الفرع:** fix/audio-service-mainactivity-engine-binding
**المرجع:** SIRAJ_ADR.md v1.1 + CLAUDE_CODE_EXECUTION_PROMPT.md v2.0 + SIRAJ_Master_Implementation_Roadmap.md

> ملاحظة: هذا الملف كان يُستخدَم سابقاً لتوثيق جلسة "المرحلة الثانية من QKE" (يوليو 2026، 3 بنود، PR #32/#33/#34 — كلها مكتملة ومدفوعة). ذاك المحتوى محفوظ بالكامل في تاريخ git (`git show 881a0fa:SESSION_STATUS.md` أو ما قبلها). هذا الملف يُعاد استخدامه الآن لجلسة تنفيذ ADR المُجمَّدة الحالية، غير مرتبطة ببنود QKE.

قيود الجهاز هذه الجلسة: عملية ثقيلة واحدة فقط في كل مرة؛ `flutter analyze` مفضّل على `flutter build`؛ `build` فقط في نهاية كل PHASE.

---

## 0) فحص الحالة عند بدء الجلسة (قبل أي تعديل)

- `git status`: نظيف على فرع العمل، لا تغييرات غير مُلتزَمة سوى ملف واحد untracked: `docs/DESIGN_MIGRATION_PLAN.md` (تاريخ تعديل 2026-07-16، **أقدم** من تاريخ التجميد 2026-07-22؛ محتوى كامل غير منقوص — ينتهي بخاتمة سليمة؛ مستند تخطيطي منفصل تماماً عن خطة ADR الحالية — لم يُلمَس، تُرك كما هو).
- الفرع كان متقدّماً عن `origin/fix/audio-service-mainactivity-engine-binding` بـ3 commits غير مدفوعة عند البدء.
- **PHASE A مكتمل فعلياً ومؤكَّد بالفحص المباشر للملفات** (نُفِّذ في جلسة سابقة قبل التجمّد):
  - A1 `network_security_config.xml`: 4 نطاقات فقط (live.mp3quran.net, server03.quran.com.kw, live.radiorodja.com, live.radioislam.org.za) ✅ يطابق ADR-002.
  - A2 `MainActivity.kt`: يرث `AudioServiceActivity` ✅.
  - A3 iOS `Info.plist`: `UIBackgroundModes(audio)` + `NSLocationWhenInUseUsageDescription` + `NSExceptionDomains` لنفس الأربعة نطاقات ✅.
  - A4 `main.dart`: `FlutterTimezone.getLocalTimezone()` + `tz.setLocalLocation` مع fallback صامت آمن لـUTC عند الفشل ✅.
  - لا كتابة منقوصة في أي من الملفات الأربعة — كلها متماسكة ومكتملة.
- `flutter analyze` (خط أساس قبل أي تعديل هذه الجلسة): **17 مشكلة**، كلها `info`/`warning` موجودة مسبقاً (لا علاقة لها بـPHASE A)، صفر أخطاء `error`. مسجَّلة كخط أساس للمقارنة.
- الحزم المطلوبة مُضافة مسبقاً في `pubspec.yaml`: `flutter_timezone: ^4.1.1`, `sensors_plus: ^7.0.0`. `audioplayers: ^6.8.1` لا يزال موجوداً (يُحذف في نهاية PHASE E فقط، بعد التحقق).

**القرار:** المتابعة من PHASE B مباشرة — لا حاجة لإعادة أي عمل من PHASE A.

---

## 1) سجل التقدّم (يُحدَّث تباعاً أثناء التنفيذ)

_(قيد التحديث الحي — سيُملأ بند بند مع تقدّم PHASE B فصاعداً)_

---

## 2) مؤجَّل بانتظار جهاز فعلي

_(يُملأ عند الوصول لـPHASE E7 وPHASE F حسب تعليمات المستخدم — لا حذف audioplayers ولا اعتماد القبلة "مكتملة التحقق" بلا جهاز حقيقي)_

---

## 3) مشاكل/تعارضات واجهتها

_(تُسجَّل فور حدوثها؛ العمل يتابع للمهمة المستقلة التالية إلا إن كان الفشل يمنع أي عمل لاحق منطقياً)_
