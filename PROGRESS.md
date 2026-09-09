# Siraj — Development Progress Report

## Project Overview
Siraj is an elite Islamic Knowledge & Guidance Platform built with Flutter + Supabase.
Solo developer leading all architecture, decisions, and testing. Claude used as a coding assistant.

## Tech Stack
- Flutter 3.44.2 + Riverpod 3.x + GoRouter
- Supabase (PostgreSQL) — primary database
- Firebase Auth
- just_audio family (just_audio + just_audio_background + just_audio_media_kit)
  behind a `SirajAudioController` abstraction layer + Hive (offline cache).
  `audioplayers` fully migrated off (ADR-001) — package removed from
  `pubspec.yaml` only after the Platform Validation Checklist passes on
  real Android/iOS devices.
- Ubuntu 22.04 / Target: Android

## Phase 1 — COMPLETED ✅

### Core Infrastructure
- Clean Architecture (features/core/data/presentation)
- 8 dynamic prayer-time themes (Fajr → Night)
- Offline-first with Hive cache
- 15-language localization (l10n): ar, en, ur, fa, id, tr, fr, bn, ms,
  ha, sw, de, ru, zh, es
- AppMode (Lite/Full) via feature flags
- Onboarding screen
- Settings screen

### Islamic Features
- Prayer times (Adhan package, calc method + madhab both wired into
  calculation AND scheduled notifications from one shared resolver)
- Azan: real `zonedSchedule` notifications (8 voices) with a channel
  per sound + real raw-resource sound, not the instant `.show()` burst
  from earlier sessions
- Qibla direction — real tilt-compensated compass via `sensors_plus`
  (accelerometer + magnetometer), with a clearly labeled static
  fallback on platforms/devices without a magnetometer
- Islamic calendar + upcoming events (dual Hijri/Gregorian day cells +
  manual ±2 day Hijri correction)
- Athkar (morning/evening/sleep)
- Radio (50+ Quran stations)
- Nearby mosques (Overpass API)
- Share cards (6 platforms)

### Quran
- Full Quran (114 surahs, 6236 ayahs) from alquran.cloud
- Audio recitation (23 reciters)
- Search by text
- Long press ayah → options menu
- Copy ayah to clipboard
- Save last surah position

### QKE — Quran Knowledge Engine (Signature Feature)
- 6,236 ayahs with clean Uthmani text
- 49,888 tafsir entries (8 sources):
  - Tabari, Ibn Kathir, Baghawi, Saadi
  - Muyassar (King Fahd), Mukhtasar (AR/EN/BN)
- 77,432 word meanings with morphology + word text
- 201 asbab al-nuzul entries
- Citation Engine (CitationBadge, tafsirSourcesMap)

### Verse Portal (Book Experience)
- Opens from long press on any ayah
- Horizontal index with page chips
- One page per scholar/tafsir source
- Linguistic page (word in Quran font + meaning + morphology)
- Asbab al-nuzul page
- Hadiths page (coming soon)
- Stories & Sira page (coming soon)
- Ayah counter (e.g. 4/286)
- Language auto-detection (AR/EN/BN)
- Share button

### Hadith
- 34,153 hadiths imported (6 books):
  - Bukhari: 7,580
  - Muslim: 7,360
  - Tirmidhi: 3,924
  - Abu Dawud: 5,272
  - Nasai: 5,679
  - Ibn Majah: 4,338
- Clean text (tashkeel removed for search)
- Browseable by book in Hadith screen

### Unified Search Engine
- Searches: Quran ayahs + Tafsir + Word meanings + Hadiths
- Results open Verse Portal (for Quran results)
- Color-coded result types
- Citation badges on results

### Home Screen
- Hijri date + day name
- Next prayer card (dynamic gradient)
- Upcoming Islamic event
- Quick access grid (6 buttons)
- Smart Quran button ("Continue Reading" if last surah saved)
- Daily Ayah (7 rotating ayahs)

## Supabase Schema
- surahs (114 rows)
- ayahs (6,236 rows)
- tafsir (49,888 rows)
- tafsir_sources (8 rows)
- word_meanings (77,432 rows)
- asbab_al_nuzul (201 rows)
- hadith_books (6 rows)
- hadiths (34,153 rows)

## Phase 2 — IN PROGRESS 🔄
- Figma design system (full UI/UX redesign)
- Stories & Sira content
- Hadith linked to ayahs in Verse Portal
- Prophet stories + Companions biographies

Note: the printed King Fahd Mushaf page-by-page reader (`quran_library`
package) was built, then deliberately removed (ADR-005) once the
portal-style `SurahReaderScreen` covered the same reading need without
duplicating the Khatmah/reading-position data model. `MushafPageMap`
converts old page-based reading positions to the surah/ayah reader
transparently, no user data migration needed.

## Phase 3 — PLANNED
- Smart azan notifications
- Full Figma design implementation
- Visual identity

## Phase 4 — PLANNED (AI)
- pgvector semantic search
- Claude Haiku integration
- RAG knowledge journeys

## Phase 5 — PLANNED (Infrastructure)
- Community analytics (most read/searched ayahs)
- Redis/Upstash caching
- Meilisearch
- Umami/Grafana dashboards

## Phase 6 — PLANNED (Launch)
- Android + iOS build
- Beta (50-100 users)
- Official launch

## Key Architecture Decisions
- No AI generation in Phase 1 — internal search only
- Religious content never auto-translated
- Themes change automatically by prayer time
- King Fahd Mushaf pages deferred to Figma phase
- Community stats deferred to Phase 5 (needs real server data)

## Development Notes
The developer led every architectural decision, feature prioritization, debugging session,
and quality review throughout Phase 1. Claude served as a coding assistant for implementation.
All product decisions, Islamic content standards, and release criteria were defined by the developer.

## آخر تحديث — جلسة 2 (29 يونيو 2026)

### مكتمل ✅
- Design Tokens من Figma (lib/core/theme/design_tokens.dart)
  - SirajGold, SirajCanvas, SirajWhite, SirajSky, SirajFonts
  - SirajSizes, SirajSpacing, SirajRadius, SirajMotion
  - SkyPhase enum + gradients للـ 7 phases
- Home Screen جديدة بتصميم Dark/Glass/Gold
  - Glass morphism components
  - Dynamic sky background
  - Floating search bar
  - Continue Reading card
  - Daily Ayah card
  - Quick Actions grid (8 أزرار)
- Stories + Children Stories screens
- Verse Portal: 7 صفحات (ميسّر + لغوي + عربي + لغات أخرى + أحاديث + قصص)
- ترجمات القرآن (13 لغة) من alquran.cloud
- Design Brief (DESIGN_BRIEF.md) للـ Figma
- Figma React code في ~/projects/DesignSIRAJHomeScreen

### معلّق ⚠️ (كما وردت أصلاً — كلاهما مُنجَز الآن، انظر تحديث 2026-07-22 أدناه)
- ~~Home Screen الجديدة تعطي شاشة حمراء~~ — أُصلح
- ~~Audio Hub الموحّد (just_audio + audio_service)~~ — مكتمل عبر
  `SirajAudioController` (ADR-001)

### القواعد الثابتة
- flutter clean يعلّق الجهاز — ممنوع
- RAM 7.4GB، r للـ hot reload، R للـ restart
- Supabase: https://pzcnkzsicyxlzqwjznvh.supabase.co
- GitHub: git@github.com:m-alajmi-eng/Siraj.git
- التعديلات عبر python3 أو Cursor مباشرة

## آخر تحديث — جلسة تنفيذ ADR المجمَّد (2026-07-22)

نُفِّذت خطة SIRAJ_Master_Implementation_Roadmap.md كاملة (PHASE A→L) في
جلسة واحدة طويلة عبر Claude Code، محكومة بـSIRAJ_ADR.md v1.1 المعتمد.
التفاصيل الكاملة (ملفاً بملف، مع أي تعارض بين وثيقتين مجمَّدتين اكتُشف
أثناء التنفيذ) موثَّقة في `SESSION_STATUS.md`. ملخّص:

- **الإشعارات:** أُعيد بناؤها بالكامل — `zonedSchedule` حقيقي بدل
  `.show()` الفوري، يحترم كل الإعدادات التسعة المحفوظة سابقاً بلا أثر.
- **الصوت:** طبقة تجريد `SirajAudioController` جديدة توحّد القرآن/
  الراديو/معاينة الأذان على محرّك واحد (just_audio) خلف عقد مجرّد؛
  `audioplayers` غير مستخدَم في الكود (`grep` = صفر) لكن لم يُحذَف من
  `pubspec.yaml` بعد — بانتظار Platform Validation Checklist على جهاز
  حقيقي.
- **القبلة:** بوصلة حقيقية (كانت معطّلة بالكامل) — بانتظار اختبار الإبرة
  الفعلي على جهاز حقيقي.
- **المساجد:** إعادة كتابة كاملة (AsyncNotifier، 4 حالات خطأ، توسّع نصف
  قطر تلقائي، اتجاهات).
- **الملاحة:** 5 تبويبات في الشريط السفلي (كانت 3)، الحديث انتقل من
  فرع مستقل تحت "المزيد" ليصبح قسماً أول داخل المكتبة، AppScaffold على
  16 من 24 شاشة (8 مستثناة بقرار موثَّق — هويات بصرية مقصودة أو شاشات
  ستُعاد كتابتها لاحقاً).
- **المصحف المطبوع:** أُزيل بالكامل (`quran_library` + `page_reader_
  screen.dart`) بعد بناء `MushafPageMap` واختباره؛ الختمة لا تزال
  تعمل بالصفحات، القراءة تفتح القارئ الموحّد فقط.
- **التقويم:** خلايا مزدوجة هجري/ميلادي + تصحيح هجري يدوي ±2.
- **البحث:** موازٍ بدل تسلسلي، عزل كل مصدر، سقوط احتياطي محلي، فلاتر
  حسب النوع، الأذكار مصدر بحث جديد.
- **اللغة:** توحيد الاسم على "Siraj" (Android label كان "siraj" بحرف
  صغير، أُصلح).

## مراجعة خارطة الطريق مقابل الكود الفعلي (2026-09-09)

بطلب محمد: فحص مباشر للكود (لا افتراض من التوثيق) لكل بنود "الموجة
الأولى" الأصلية. **كل البنود الستة مؤكَّدة مكتملة فعلياً بالكود**:

- **أذان تلقائي**: `lib/core/notifications/adhan_service.dart` —
  `zonedSchedule` حقيقي (لا `.show()` فوري)، 8 أصوات قابلة للاختيار،
  إعداد `adhan_sound` محفوظ بـHive.
- **تقويم إسلامي**: `lib/features/calendar/.../calendar_screen.dart`
  — `_DayCell` تعرض الرقمين معاً فعلياً (هجري بارز + ميلادي صغير
  أسفله، تعليق بالكود يشير صراحة لـ"ADR PHASE L §I")، `_MonthGrid`
  كاملة مع أحداث إسلامية وتصحيح هجري ±يدوي.
- **بطاقات مشاركة**: `share_card_screen.dart` — **6 منصات** فعلية
  (إنستقرام، تويتر/X، واتساب، تيكتوك، فيسبوك، تيليغرام)، كل واحدة
  بأبعاد/نسبة مخصَّصة.
- **QKE MVP**: 7 ملفات فعلية (`qke_repository.dart`،
  `verse_portal_screen.dart`، `adwaa_bayan_reader_screen.dart`،
  خدمات ترجمة ومراجعة) — أبعد من MVP، ميزة ناضجة.
- **الراديو**: `radio_provider.dart` — **47 محطة** فعلية (`RadioStation(`
  × 47)، لا بيانات تجريبية.
- **المذاهب/طرق الحساب**: `settings_screen.dart` — 4 مذاهب
  (حنفي/مالكي/شافعي/حنبلي) عبر `madhabProvider`، وطريقة حساب منفصلة
  عبر `calcMethodProvider`، كلاهما مربوط فعلياً بشاشة الإعدادات
  وبمنطق حساب أوقات الصلاة في `prayer_local_datasource.dart`.

**الخلاصة**: توثيق `PROGRESS.md`/`ROADMAP.md` لهذه البنود الستة دقيق
وليس تفاؤلياً — لا فجوة بين الادّعاء والكود الفعلي. الفجوات الحقيقية
المتبقية (موثَّقة بالفعل بوضوح في `ROADMAP.md`) هي: ربط حديث↔آية
(بحث مفتوح عالمياً، لا حل جاهز)، تفعيل تبويب "أحاديث" داخل بوابة
الآية، ومشروع توحيد قراءة الختمة/الصفحات (لم يبدأ التنفيذ بعد بقرار
واعٍ).
