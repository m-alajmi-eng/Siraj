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

### PHASE B — نظام الإشعارات ✅ مكتمل (commit 19aef67، مدفوع)
- `NotificationService` (core/notifications/notification_service.dart): instance
  مشترك للأذان+الإقامة+الختمة، `requestNotificationsPermission` وقت التشغيل،
  fallback exact→inexact عند غياب SCHEDULE_EXACT_ALARM.
- `AdhanService.schedulePrayerNotifications`: `zonedSchedule` فعلي لأسبوع
  متجدد (بدل `.show()` الفوري القديم الذي كان يُفجّر حتى 10 إشعارات دفعة
  واحدة). قنوات Android مُصدَّرة (`adhan_<sound>_v1`) بصوت خام حقيقي من
  `android/app/src/main/res/raw/adhan_*.mp3` (نُسخت من `assets/audio/adhan/`
  — مضاعفة ~6MB في حجم APK على أندرويد، ضرورية لأن قناة الإشعار لا يمكنها
  الإشارة لأصل Flutter مباشرة). قناة اهتزاز صامتة بديلة عند تفعيل `vibration`.
  تنبيه إقامة منفصل (معرّفات 4000-4069).
- **قيد iOS موثَّق (لا حل مُختلَق):** أصوات الأذان المخصَّصة (mp3) **لا تعمل
  كصوت إشعار على iOS** — Apple تشترط aiff/wav/caf فقط لـ`UNNotificationSound`
  المُرفَق بالحزمة. `DarwinNotificationDetails` الحالي بلا `sound:` مخصَّص،
  فسيستخدم iOS الصوت الافتراضي للنظام بدل صوت الأذان المختار (لا يزال
  الإشعار يصل وينبّه، فقط بصوت مختلف). يحتاج تحويل صيغة الملفات الصوتية
  (ffmpeg mp3→caf) قبل أي عمل مستقبلي على هذا — خارج نطاق ما يمكن التحقق أو
  التنفيذ منه على جهاز Linux بلا macOS/Xcode أصلاً.
- الجدولة انتقلت من `MaterialApp.builder` (حارس bool عام هشّ) إلى مستمعات
  Riverpod (`ref.listen`) في `MainShell` — تُعاد الجدولة تلقائياً عند فتح
  التطبيق (انتقال `locationProvider` من loading→data)، تغيّر الموقع >10كم،
  أو تغيّر أي من: calc_method/madhab/adhan_enabled/adhan_sound/vibration/
  iqama_alert.
- `KhatmahReminderService` يشارك الآن نفس `NotificationService.plugin` (كان
  ينشئ نسخة `FlutterLocalNotificationsPlugin` منفصلة) ونفس منطق
  exact/inexact الآمن.

### PHASE C — دقة الصلاة + كل الإعدادات التسعة ✅ مكتمل (commits 19aef67 و8f6b855، مدفوعان)
- **C1/C2 الموقع:** `locationProvider` أصبح `AsyncNotifier<LocationState>` حيّاً
  (حقل `hasRealFix`)، يُعيد بناء حالته فعلياً عند تحرّك المستخدم >10كم (كان
  يُرجع آخر موقع محفوظ للأبد بلا تحديث). السقوط الاحتياطي أصبح إحداثيات
  الكعبة (21.4225, 39.8262 — محايدة عالمياً) بدل الرياض المثبَّتة، مع شارة
  "مكة المكرمة (افتراضي)" ظاهرة في شاشتي الصلاة والقبلة (كانتا صامتتين).
- **C3 المذهب:** `prayer_calc_resolver.dart` مصدر حقيقة واحد (calc method +
  madhab) يستهلكه `prayer_local_datasource.dart` (العرض) و`adhan_service.dart`
  (الإشعارات) معاً — كانا يحسبان بـ`Madhab.shafi` مثبَّتاً في الاثنين رغم أن
  الإعداد يُحفَظ فعلياً؛ الآن عبر `madhabProvider` جديد.
- **C4 التدويل:** `prayer_screen.dart` كان يحوي كل نصوصه بالعربية مباشرة
  (أسماء الصلوات، "جارٍ تحديد موقعك..."، تنسيق العدّ التنازلي) رغم وجود
  مفاتيح l10n جاهزة وغير مستهلَكة لكل هذه النصوص بالضبط — وُصلت. حُذفت
  getters ميتة في `PrayerTimesEntity` (كانت تكرّر نفس الأسماء المثبَّتة بلا
  مستهلك بعد هذا الإصلاح): `nextPrayerName`, `nextPrayerNameAr`,
  `nextPrayerNameEn`, `nextPrayerTimeStr`. حُذف أيضاً `nextPrayerProvider`/
  `countdownProvider` من `prayer_provider.dart` (dead code، صفر مستهلك في
  كل المستودع حتى قبل هذه الجلسة).
- **C5 الإعدادات التسعة:** كل التسعة موصولة الآن عبر Notifier providers
  تُقرأ في نقطة الاستهلاك (ADR-011):
  - `adhan_enabled/adhan_sound/vibration/iqama_alert` → providers جديدة في
    `core/notifications/adhan_settings_provider.dart`. **اكتُشف عيب دقيق:**
    الافتراضي المحفوظ لـ`adhan_sound` كان `'مكي (الحرم المكي)'` (نص عربي)
    لا يطابق أي مفتاح فعلي في `AdhanService.adhanSounds` (المفاتيح:
    `makkah/madinah/...`) — يفشل صامتاً في مطابقة صوت القناة حتى يختار
    المستخدم يدوياً. الافتراضي الصحيح الآن `'makkah'`.
  - `madhab/calc_method` → كانا موصولين جزئياً (State محلي مزدوج مع Hive
    مباشرة)، بُسِّطا لقراءة/كتابة عبر الـprovider فقط.
  - `quran_font/font_size` → `readerFontProvider` جديد. **اكتُشف عيب ثانٍ:**
    القارئ كان يستخدم عائلة خط `'QuranFont'` العامة دائماً بصرف النظر عن
    اختيار المستخدم uthmani/hafs، رغم أن عائلتي `UthmanTNB`/`HafsSmart`
    المطلوبتين فعلياً مرفقتان كأصول في `pubspec.yaml` ولم تُستخدَما قط.
    حجم الخط (كان 24/26/28 مثبَّتة في 3 سياقات مختلفة) يُشتقّ الآن من قيمة
    واحدة قابلة للتعديل بنفس الفروق النسبية.
  - `app_mode` → **مكتمل مسبقاً فعلياً** (تحقّق مباشر من الكود؛ يخالف ما ورد
    في SIRAJ_Architecture_Review.md §3 القائل إنه لا يُحفَظ من Onboarding
    إطلاقاً). `onboarding_screen.dart:_finish()` يستدعي
    `appModeProvider.notifier.setMode()` الذي يكتب فعلياً لمفتاح `app_mode`
    في Hive ويُقرَأ صحيحاً عند الإقلاع. **PHASE D لا حاجة لعمل إضافي فيه.**

### PHASE E — طبقة التجريد الصوتي (قيد التنفيذ الآن)
_(سيُحدَّث هنا)_

---

## 2) مؤجَّل بانتظار جهاز فعلي

_(يُملأ عند الوصول لـPHASE E7 وPHASE F حسب تعليمات المستخدم — لا حذف audioplayers ولا اعتماد القبلة "مكتملة التحقق" بلا جهاز حقيقي)_

---

## 3) مشاكل/تعارضات واجهتها

_(تُسجَّل فور حدوثها؛ العمل يتابع للمهمة المستقلة التالية إلا إن كان الفشل يمنع أي عمل لاحق منطقياً)_
