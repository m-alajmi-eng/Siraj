# Siraj — Verified Project Audit

**Scope:** This is an evidence-only second pass against `docs/reviews/MASTER_PROJECT_REVIEW.md`. It validates the repository state, not deployed Supabase, Apple/Google console settings, production credentials, legal rights, or physical-device behavior.

**Validation performed:** `flutter analyze` (0 errors; 10 info/warning findings) and `flutter test` (56/56 passed). No application files were modified during the audit.

## 1. Confirmed Issues

### C-01 — A public `SECURITY DEFINER` RPC can write public author metadata

- **Status:** Confirmed
- **Confidence:** High
- **Severity:** Critical
- **Evidence:** `supabase/migrations/20260723120000_add_library_authors.sql:59-113` defines `public.upsert_harvested_author(...)` as `SECURITY DEFINER`; lines `121-123` grant `EXECUTE` to `anon`, `authenticated`, and `service_role`. The function inserts or updates `library_authors` at lines `79-112`. `lib/features/gateway/data/datasources/islamhouse_remote_datasource.dart:184` invokes this RPC from the client path.
- **Explanation:** Possession of the public Supabase key permits calling this trusted function with arbitrary author ID, language, title, description, count, and category. It has no JWT-role check, ownership check, trusted-source verification, allowlist, request signature, or server-side fetch from IslamHouse.
- **Impact:** An attacker can inject or alter publicly displayed author metadata and undermine source trust. Because the table exposes `reviewed=true` rows (`CREATE POLICY` at lines `43-46`), poisoned content can appear credible.
- **Recommendation:** Remove anonymous execution. Perform harvesting in a trusted server-side job/Edge Function that fetches and validates IslamHouse itself, or strictly authorize a dedicated internal role and validate every input.

### C-02 — Translation reports are an unrestricted anonymous write surface

- **Status:** Confirmed
- **Confidence:** High
- **Severity:** High
- **Evidence:** `supabase/migrations/20260715140615_add_translation_reports.sql:10-16` accepts free-text fields without length limits; lines `21-26` enable RLS and create `FOR INSERT WITH CHECK (true)`. `lib/features/qke/presentation/widgets/translation_report_dialog.dart:62-73` writes directly from the client.
- **Explanation:** RLS correctly blocks reads/updates/deletes for public users, but it authorizes every anonymous insert and performs no rate limiting, challenge, authentication, deduplication, or content-size validation.
- **Impact:** Database spam, moderation burden, possible cost growth, and potentially harmful content stored in operational systems.
- **Recommendation:** Route submissions through an abuse-protected server endpoint/Edge Function; enforce rate limits, field length/schema rules, deduplication, telemetry, moderation state, and an explicit retention policy.

### C-03 — Android release artifacts are debug-signed

- **Status:** Confirmed
- **Confidence:** High
- **Severity:** Critical
- **Evidence:** `android/app/build.gradle.kts:29-35` configures the `release` build type with `signingConfigs.getByName("debug")`.
- **Explanation:** A distributable Play artifact must be signed by the app’s release/upload key, not the standard debug key.
- **Impact:** The present release configuration is not acceptable for a production Play release and cannot establish a durable app-signing identity.
- **Recommendation:** Establish a protected release/upload key, CI secret handling, key-loss recovery procedure, and a separately verifiable signed AAB release workflow.

### C-04 — Authentication/account completion paths target an unregistered route

- **Status:** Confirmed
- **Confidence:** High
- **Severity:** High
- **Evidence:** The router declares `/language`, `/onboarding`, `/auth`, `/account`, and `/home` at `lib/core/router/app_router.dart:52-92`; no `GoRoute(path: '/')` exists. Auth success uses `context.go('/')` at `lib/features/auth/presentation/screens/auth_screen.dart:55-76`; account deletion/sign-out use it at `lib/features/auth/presentation/screens/account_screen.dart:39-46` and `106-112`.
- **Explanation:** GoRouter has no matching configured location for `/` in the inspected route tree.
- **Impact:** OAuth/anonymous completion, sign-out, and deletion may show routing failure or leave the user in a broken state.
- **Recommendation:** Define a deliberate root redirect or route every completion path to a declared destination such as `/home`; add route-level widget/integration tests.

### C-05 — Checked-in local Auth configuration contradicts advertised anonymous and social login

- **Status:** Partially Confirmed
- **Confidence:** High for local configuration; cannot verify production configuration
- **Severity:** High
- **Evidence:** `supabase/config.toml:176-180` sets `enable_anonymous_sign_ins = false`; its Apple provider is disabled at lines `319-329`, and no enabled Google provider is present. The app exposes `signInAnonymously`, Google OAuth, and Apple OAuth in `lib/features/auth/data/repositories/auth_repository.dart:19-39`, and presents all three at `lib/features/auth/presentation/screens/auth_screen.dart:143-192`.
- **Explanation:** The local Supabase project would reject anonymous sign-in and has no configured social provider. The repository cannot establish whether the hosted production project differs.
- **Impact:** If production matches the checked-in configuration, three advertised login paths fail.
- **Recommendation:** Treat provider setup as a versioned release prerequisite. Verify production Auth settings, redirect allowlist, native deep links, Apple configuration, and end-to-end flows in release builds.

### C-06 — Magic-link mobile completion is not configured in repository code

- **Status:** Partially Confirmed
- **Confidence:** Medium
- **Severity:** High
- **Evidence:** `AuthRepository.sendMagicLink` calls only `_client.auth.signInWithOtp(email: email)` in `lib/features/auth/data/repositories/auth_repository.dart:17-18`. `supabase/config.toml:160-163` contains only local-loopback redirect settings. No platform URL scheme/deep-link configuration or auth callback handler was found in `android/app/src/main/AndroidManifest.xml` or `ios/Runner/Info.plist`.
- **Explanation:** The client code does not provide a mobile `emailRedirectTo`, and the checked-in local redirect allowlist does not represent mobile production routing.
- **Impact:** Email authentication may fail to return a mobile user into the application or complete unreliably.
- **Recommendation:** Define and test one supported mobile callback design per platform, register exact allowed redirect URLs in production, and add an end-to-end test script.

### C-07 — Broad public grants and dangerous default privileges are present in the schema baseline

- **Status:** Confirmed
- **Confidence:** High
- **Severity:** High
- **Evidence:** `supabase/migrations/00000000000000_baseline.sql:911-1057` grants `ALL` on content tables and sequences to `anon` and `authenticated`; lines `1067-1090` set default `ALL` privileges on every future sequence, function, and table for those roles. `kg_edges` repeats public `ALL` grants at `20260716102020_kg_edges_unify_hadith_relations.sql:73-78`.
- **Explanation:** Current RLS policies constrain most current table actions, but authorization depends on every present and future object having RLS and safe policies. Default `ALL` privileges increase the blast radius of any missed RLS/policy configuration.
- **Impact:** A future migration or an operationally-created object can be unintentionally exposed for modification/execution. The pattern is difficult to audit and easy to regress.
- **Recommendation:** Revoke broad defaults, grant only required privileges by object and operation, and add migration tests that execute as `anon` and `authenticated`.

### C-08 — The RLS auto-enable function is present, but no `CREATE EVENT TRIGGER` is versioned

- **Status:** Confirmed
- **Confidence:** High for the repository; cannot verify remote database state
- **Severity:** High
- **Evidence:** `supabase/migrations/00000000000000_baseline.sql:64-88` defines `public.rls_auto_enable()` returning `event_trigger`; repository-wide search finds no `CREATE EVENT TRIGGER`. The function is itself granted to public roles at lines `890-892`.
- **Explanation:** A function is not an active database event trigger. The migration history does not prove automatic RLS enablement for future tables.
- **Impact:** The project’s documented assumption that new tables are automatically protected is not reproducible from migrations alone.
- **Recommendation:** Make the intended safeguard explicit, reproducible, and tested—or remove the assumption and require explicit `ENABLE ROW LEVEL SECURITY` plus policies in every table migration.

### C-09 — Core offline guarantee is incomplete for surah metadata

- **Status:** Confirmed
- **Confidence:** High
- **Severity:** Medium
- **Evidence:** `assets/data/surah_names.json` exists, but `QuranRemoteDataSource.getSurahs()` at `lib/features/quran/data/datasources/quran_remote_datasource.dart:77-114` uses Hive then `https://api.alquran.cloud/v1/surah`; it does not load that asset. Quran text, translations, and tafsir do use local assets at lines `17-40` and `120+`.
- **Explanation:** On first launch without cache/network, the Quran index cannot load even though a local source file exists.
- **Impact:** First-use offline availability does not match the stated local-core-content promise.
- **Recommendation:** Establish one tested local source of truth for all required reading entry data, including surah metadata; preserve network only as an optional update path.

### C-10 — Large local JSON files are decoded and permanently retained on the UI isolate

- **Status:** Confirmed
- **Confidence:** High
- **Severity:** High
- **Evidence:** `QuranRemoteDataSource` calls `rootBundle.loadString` and `jsonDecode` for Quran, translations, and tafsir at `lib/features/quran/data/datasources/quran_remote_datasource.dart:17-40`, then stores maps in static caches. File sizes: `assets/data/quran_translations.json` 17,949,394 bytes; `hafs_smart_v8.json` 4,192,442; `quran_tajweed.json` 3,413,314; `quran_tafsir.json` 2,645,921; `quran_uthmani.json` 1,646,209.
- **Explanation:** `jsonDecode` runs synchronously after the asset read completes; static maps prevent reclamation for the process lifetime. Parsed object graphs occupy substantially more memory than raw JSON.
- **Impact:** First-use jank and memory pressure are credible on low-end phones; exact impact requires profiling.
- **Recommendation:** Profile release builds on representative low-RAM devices; then use lazy per-surah data, a structured local database, or background-isolate parsing with bounded caches based on measured results.

### C-11 — Local fallback Quran search scans all loaded Quran entries synchronously

- **Status:** Confirmed
- **Confidence:** High
- **Severity:** Medium
- **Evidence:** `searchLocalAyahs` loops every local surah and ayah until a limit at `lib/features/quran/data/datasources/quran_remote_datasource.dart:280-300`. It is used after RPC failure at `lib/features/search/presentation/providers/search_provider.dart:149-154`.
- **Explanation:** This is an O(number of loaded ayahs) substring scan on the isolate executing the notifier.
- **Impact:** Offline search may stutter, particularly after the large cache has been loaded.
- **Recommendation:** Measure typing/frame impact, then use normalized indexed local search or isolate work. Do not optimize blindly.

### C-12 — Verse Portal executes several serial backend operations

- **Status:** Confirmed
- **Confidence:** High
- **Severity:** Medium
- **Evidence:** `QkeRepository.getPortal` makes initial ayah, tafsir, and word queries sequentially at `lib/features/qke/data/qke_repository.dart:153-202`; then optional asbab, graph-edge, TOC, next-TOC, and page queries at lines `204-302`.
- **Explanation:** Independent requests are awaited one after another, increasing latency; broad `catch (_) {}` masks failures.
- **Impact:** Slow portal opening on mobile networks and weak operational visibility when scholarly content is absent.
- **Recommendation:** Set latency and error budgets, consolidate/read-model queries where justified, and preserve typed partial-failure information for the UI and telemetry.

### C-13 — Time themes use clock hours rather than calculated prayer times

- **Status:** Confirmed
- **Confidence:** High
- **Severity:** Medium
- **Evidence:** `lib/core/theme/time_theme_provider.dart:4-14` only reads `DateTime.now().hour`; it neither watches prayer state nor receives prayer-time data.
- **Explanation:** Clock-hour intervals are not prayer times and vary materially by season and location.
- **Impact:** The implementation does not deliver the documented dynamic-prayer-time theme concept and may feel incorrect to users.
- **Recommendation:** Either describe it honestly as time-of-day theming or calculate phase from the same prayer-time source used by prayer/notification features.

### C-14 — Privacy policy conflicts with implementation on location precision and Sentry configuration

- **Status:** Confirmed
- **Confidence:** High
- **Severity:** High
- **Evidence:** `docs/legal/PRIVACY_POLICY.md:22-31` says location is approximate and used only locally for prayer/qibla. `lib/features/mosques/presentation/providers/mosques_provider.dart:59-80` requests `LocationAccuracy.high` and transmits latitude/longitude to Overpass endpoints. Policy lines `49-54` claim `sendDefaultPii` is explicitly disabled; `lib/main.dart:51-56` sets only DSN and `tracesSampleRate`, with no `sendDefaultPii` setting or scrubbing configuration.
- **Explanation:** The policy’s location-use and “explicitly configured” Sentry statements are contradicted by checked-in code.
- **Impact:** Misleading disclosures create compliance and user-trust risk.
- **Recommendation:** Align product behavior and legal disclosure after privacy counsel review. Explicitly configure and test Sentry PII/event scrubbing rather than relying on undocumented defaults.

### C-15 — Hive persists precise location and user activity state without application-level encryption

- **Status:** Confirmed
- **Confidence:** High
- **Severity:** Medium
- **Evidence:** `lib/core/storage/cache_service.dart:8-12` initializes ordinary Hive boxes. Precise `last_lat`/`last_lng` are persisted at lines `55-69`; reading context and Khatmah identifiers/plans are persisted at lines `75-139`. No encryption cipher, secure key storage, or encrypted-box configuration is present.
- **Explanation:** The application persists sensitive contextual data in standard local storage. OS device protection is beneficial but is not application-level encryption.
- **Impact:** Risk is primarily for compromised, rooted, jailbroken, or shared/unlocked devices; it is not evidence of remote disclosure.
- **Recommendation:** Perform data classification first. Encrypt only data that warrants it using a platform-protected key, define local-data deletion behavior, and update the privacy policy accurately.

### C-16 — Deprecated audio API remains in use

- **Status:** Confirmed
- **Confidence:** High
- **Severity:** Low
- **Evidence:** Analyzer reports deprecated member use; `lib/core/audio/impl/just_audio_controller.dart:139` calls `ConcatenatingAudioSource`.
- **Explanation:** The current just_audio API marks this construct deprecated.
- **Impact:** Future dependency upgrades may break playback code; no demonstrated current malfunction.
- **Recommendation:** Migrate using the supported player source API under a dedicated regression test for basmala, ayah sequence, pause/resume, and background media controls.

### C-17 — Several declared direct dependencies have no executable imports

- **Status:** Confirmed
- **Confidence:** High
- **Severity:** Low
- **Evidence:** `pubspec.yaml:16-23` declares `firebase_core`, `firebase_auth`, `riverpod_annotation`, and `audioplayers`. Repository search found no `package:firebase_core/`, `package:firebase_auth/`, `package:riverpod_annotation/`, or `package:audioplayers/` imports under `lib`, `test`, Android, or iOS. The only `audioplayers` match is a comment in `lib/features/radio/presentation/providers/radio_provider.dart:134`. `font_awesome_flutter` is used in `lib/features/sharing/presentation/screens/share_card_screen.dart`; `media_kit_libs_linux` is plausibly a platform runtime dependency and is not classified as unused merely because it has no Dart import.
- **Explanation:** The first four add transitive packages/build surface without source usage.
- **Impact:** Larger dependency graph, avoidable upgrades/security advisories, and confusion over Auth architecture.
- **Recommendation:** Confirm platform/plugin requirements with a clean release build, then remove genuinely unused direct dependencies in a controlled change.

### C-18 — Localization coverage is incomplete and contains English fallback text

- **Status:** Confirmed
- **Confidence:** High
- **Severity:** Medium
- **Evidence:** `lib/l10n/app_de.arb` has 437 application keys versus 444 in the Arabic template; missing keys are `home_continueReading`, `home_greetingAsr`, `home_greetingEvening`, `home_greetingLateNight`, `home_nextPrayer`, `home_qiblaDirection`, and `home_welcome`. It also contains English auth/section values at lines `478-522`. Equivalent English fallback strings occur in multiple non-Arabic ARB files.
- **Explanation:** The project supports these locales in the generated localization delegate, but some delivered interface text is missing or English.
- **Impact:** A multilingual user can receive inconsistent mixed-language UI, contrary to the stated international-quality position.
- **Recommendation:** Add CI completeness checks against the template and use qualified human review for each supported locale before representing it as production-ready.

### C-19 — “Coming soon” UI remains in source, although some tabs may be conditionally hidden

- **Status:** Partially Confirmed
- **Confidence:** Medium
- **Severity:** Medium
- **Evidence:** `_ComingSoonPage` at `lib/features/qke/presentation/screens/verse_portal_screen.dart:603-635` renders Arabic “coming soon” text. Recent git history and comments indicate some empty portal tabs were hidden, but this audit did not exhaustively execute all data/feature-flag combinations.
- **Explanation:** The component is compiled and has a user-facing state; reachability depends on upstream screen logic and content.
- **Impact:** If reachable in release, incomplete functionality can reduce trust and store-review readiness.
- **Recommendation:** Add route/content-state tests that prove unfinished screens are not reachable in the target v1 configuration, or complete them before release.

### C-20 — CI intentionally passes static-analysis warnings and publishes a debug-signed “release” APK

- **Status:** Confirmed
- **Confidence:** High
- **Severity:** Medium
- **Evidence:** `.github/workflows/ci.yml:29-39` fails only when output contains `error •`; lines `44-51` build and upload a release APK. The Android release configuration is debug-signed (`android/app/build.gradle.kts:29-35`).
- **Explanation:** CI does not enforce the team’s lint-quality target and its published artifact is not production signing evidence.
- **Impact:** Quality regressions can merge, and CI output can be mistaken for a store-ready release.
- **Recommendation:** Split developer artifact builds from protected release builds; make quality gates intentional and use signing/provenance checks for distributable artifacts.

### C-21 — Documentation contains verified stale and corrupted content

- **Status:** Confirmed
- **Confidence:** High
- **Severity:** Medium
- **Evidence:**
  - `README.md:1-17` is the untouched Flutter template, conflicting with the actual product in `pubspec.yaml:1-40` and `lib/`.
  - `docs/CONTENT_SOURCES.md:11-28` says `quran_library` 4.2.1 is currently used; `pubspec.yaml:9-40` has no such dependency and reader code uses local data.
  - `docs/adr/ADR-003-offline-first-caching.md:16-17,32-34` says tafsir/translations remain cloud-only and Quran local migration is unimplemented; `QuranRemoteDataSource` uses bundled text/translations/tafsir at `lib/features/quran/data/datasources/quran_remote_datasource.dart:17-40,302-305`.
  - `docs/ROADMAP.md:391` contains a terminal escape/paste fragment (`...cd ~/projects/siraj && cat >>...`).
- **Explanation:** These are direct, reproducible conflicts rather than subjective documentation-quality concerns.
- **Impact:** New maintainers can make incorrect architecture, licensing, offline, and release decisions.
- **Recommendation:** Establish a documentation owner and review gate; reconcile each ADR/status claim against code and migrations before release.

### C-22 — Architecture boundaries are inconsistent in concrete places

- **Status:** Confirmed
- **Confidence:** High
- **Severity:** Medium
- **Evidence:** `lib/features/stories/presentation/screens/stories_screen.dart:33-38` and `children_stories_screen.dart:14-18` call `Supabase.instance.client` directly from presentation. `lib/features/qke/data/qke_repository.dart:150-302` couples data orchestration to global `Supabase.instance.client`. `lib/features/quran/data/datasources/quran_remote_datasource.dart:1-8` combines HTTP, assets, Supabase, Hive, entity mapping, cache policy, and fallback behavior. `CacheService` is static/global (`lib/core/storage/cache_service.dart:3-140`).
- **Explanation:** The dependency direction is not consistently presentation → abstraction/domain → data implementation. It is a pragmatic mixed architecture, not uniformly clean architecture.
- **Impact:** Tests require real global services more often, providers/screens are harder to substitute, and future sync/multi-environment work will be more expensive.
- **Recommendation:** Define a target boundary for new work first: injected repositories/interfaces, separate local/remote data sources, typed domain failures, and no direct backend access from screens.

### C-23 — State-management styles are demonstrably mixed; no rebuild defect is proven

- **Status:** Partially Confirmed
- **Confidence:** High
- **Severity:** Low
- **Evidence:** Riverpod `Notifier` is used in `lib/core/mode/app_mode_provider.dart`; `AsyncNotifier` in `lib/features/mosques/presentation/providers/mosques_provider.dart`; `StreamProvider` in `lib/features/qibla/presentation/providers/qibla_heading_provider.dart`; `FutureProvider` in `lib/features/qke/data/qke_repository.dart`; and `ConsumerStatefulWidget` local state in `lib/features/auth/presentation/screens/auth_screen.dart`.
- **Explanation:** Multiple patterns are used. This is not inherently erroneous and source inspection alone cannot prove excessive rebuilds.
- **Impact:** Consistency and onboarding cost, but not a demonstrated performance defect.
- **Recommendation:** Document selection criteria and profile rebuilds before changing patterns.

## 2. False Positives or Downgraded Findings

### F-01 — “RLS is absent on the main content tables”

- **Status:** False Positive
- **Confidence:** High
- **Evidence:** Baseline enables RLS on `asbab_al_nuzul`, `ayah_hadiths`, `ayahs`, `children_stories`, `hadith_categories`, `hadith_category_links`, `hadiths`, `stories`, `tafsir`, `verse_hadith_relations`, and `word_meanings` at `00000000000000_baseline.sql:674-721`; migration `20260714030138_enable_rls_missing_tables.sql:9-16` enables it for `surahs`, `tafsir_sources`, and `hadith_books`; later migrations explicitly enable it for `translation_reports`, `translation_review_status`, `kg_edges`, and `library_authors`.
- **Explanation:** The important issue is broad grants/default privileges and lack of reproducible policy testing, not absence of RLS in the checked-in schema.
- **Recommendation:** Retain the hardening recommendation; do not characterize current migrated tables as simply “RLS disabled.”

### F-02 — “Public `ALL` grants on `kg_edges` immediately permit writes”

- **Status:** False Positive as a direct-write claim; confirmed as a least-privilege risk
- **Confidence:** High
- **Evidence:** `20260716102020_kg_edges_unify_hadith_relations.sql:65-71` enables RLS and creates only a `FOR SELECT` policy. No INSERT/UPDATE/DELETE policy is defined in repository migrations.
- **Explanation:** With RLS enabled, grants alone do not authorize non-owner writes absent matching RLS policies. The grant remains unsafe design debt.
- **Recommendation:** Revoke unnecessary privileges and test as public roles.

### F-03 — “All non-Arabic translations are English placeholders”

- **Status:** False Positive
- **Confidence:** High
- **Evidence:** Comparison of ARB values shows French, German, Turkish, English, and Chinese mostly differ from Arabic; German includes extensive German translations at `lib/l10n/app_de.arb:444-477`. However, incomplete/mixed localization is confirmed in C-18.
- **Explanation:** The earlier wording overstated the problem; quality/coverage is uneven, not uniformly placeholder-only.
- **Recommendation:** Keep a locale-by-locale quality audit instead of a blanket claim.

### F-04 — “All pending/coming-soon experiences are reachable in release”

- **Status:** Cannot establish; downgraded to Partially Confirmed
- **Confidence:** Medium
- **Evidence:** The component exists (`verse_portal_screen.dart:603-635`), but static inspection did not execute every feature/data combination.
- **Explanation:** Existence does not prove route reachability in the target configuration.
- **Recommendation:** Verify by release-candidate route/content tests and manual exploration.

### F-05 — “Actual excessive rebuilds”

- **Status:** False Positive as a performance conclusion
- **Confidence:** High
- **Evidence:** Mixed state patterns are visible, but no DevTools trace, frame metrics, or rebuild counters are in the repository.
- **Explanation:** Source inspection supports a maintainability observation, not a measured rebuild defect.
- **Recommendation:** Profile before prioritizing rebuild changes.

### F-06 — “Supabase public key/DSN are secrets leaked in source”

- **Status:** False Positive
- **Confidence:** High
- **Evidence:** `lib/main.dart:22-40` explicitly contains a Supabase anonymous key and Sentry DSN, both normally client-distributed identifiers. No service-role key, private signing key, or OAuth secret was found in tracked source during this audit.
- **Explanation:** The concern is environment separation/rotation and hard-coded production defaults, not exposure of a server secret by itself.
- **Recommendation:** Keep keys configurable per environment and audit history/remote secrets separately.

## 3. Needs Manual Verification

### Production backend and security

| Item | Status | Confidence | Evidence / reason | Recommendation |
|---|---|---|---|---|
| Hosted Supabase schema, grants, policies, and function definitions match migrations | Cannot Verify | High that repository alone is insufficient | Migrations are local artifacts; no production connection/credential was used | Run authenticated production schema diff and policy tests under `anon`/`authenticated` roles. |
| Production Auth provider enablement, Apple/Google credentials, anonymous login, redirect allowlists | Cannot Verify | High | `supabase/config.toml` is local configuration only | Verify in Supabase dashboard and on signed Android/iOS builds. |
| `delete_user()` completes account/data deletion for real users | Partially Confirmed | Medium | `delete_user()` deletes `auth.users` where `id = auth.uid()` at baseline lines `48-57`; no evidence of deployed behavior or additional user-owned data | Execute an auditable production test with a disposable account and document scope. |
| Sentry actual PII collection and trace payload | Cannot Verify | High | Code lacks explicit PII/scrubbing configuration; SDK/runtime defaults are not repository evidence | Inspect Sentry project settings and test events in a non-production environment. |
| Storage bucket policies | Cannot Verify | High | `supabase/config.toml` enables storage, but no bucket policy migrations are present | Inventory hosted buckets, objects, and policies. |

### Performance, accessibility, and platform behavior

| Item | Status | Confidence | Evidence / reason | Recommendation |
|---|---|---|---|---|
| Startup time, memory, jank, ANR risk | Cannot Verify | High | Source identifies likely load paths but no release-device profiling exists | Profile cold/warm startup, reader, search, and portal on low-RAM Android and iPhone. |
| Prayer alarms, exact-alarm permission, boot persistence, radio lock-screen behavior | Cannot Verify | High | Code schedules notifications and declares permissions; device/OEM behavior is not provable statically | Execute real-device test matrix, including Xiaomi/Huawei-style battery restrictions. |
| Qibla accuracy | Cannot Verify | High | Sensor math exists; calibration and magnetometer behavior require physical hardware | Test against known bearings across device models. |
| TalkBack, VoiceOver, Dynamic Type, contrast, keyboard/focus, reduced motion | Cannot Verify | High | Some semantics exist, but no assistive-technology test evidence | Conduct structured accessibility QA and retain results. |
| Third-party library/radio rights and religious-content provenance | Cannot Verify | High | `licenses_screen.dart` and internal docs explicitly leave licenses pending | Obtain written licenses/terms and scholarly review records. |

### Apple App Store assessment

#### Confirmed repository risks

- **Guideline 2.1 — App Completeness:** C-04 proves broken completion redirects; C-19 proves a compiled unfinished UI state, though target reachability remains unverified.
- **Guideline 5.1.1 — Data Collection and Storage:** `docs/legal/PRIVACY_POLICY.md:106-109` contains a placeholder contact address; C-14 proves disclosure/code mismatch.
- **Guideline 5.2 — Intellectual Property:** content and radio permission status is explicitly pending in `lib/features/settings/presentation/screens/licenses_screen.dart` and `docs/02_STORE_COMPLIANCE.md`.

#### Possible risks

- **Guideline 5.1.1(v):** account deletion is coded but needs production validation, including any associated data.
- **Guideline 4.8:** Apple sign-in must be correctly configured if third-party social login is offered.
- **Guideline 2.3:** store metadata, screenshots, and feature claims are not in this repository.

#### Not enough evidence

- App Store Connect privacy nutrition labels, age rating, signing, reviewer notes/test account, final binary behavior, and hosted privacy-policy URL.

### Google Play assessment

#### Confirmed repository risks

- Debug signing is confirmed (C-03).
- Privacy policy lacks a final contact and conflicts with implementation (C-14).
- The repository declares notifications, exact alarms, location, boot completion, and foreground media-service permissions in `android/app/src/main/AndroidManifest.xml:2-38`; their policy declarations and runtime behavior are not evidenced.

#### Possible risks

- Account-deletion policy applicability depends on the production account-creation flow.
- Data Safety answers may be inaccurate unless Sentry, precise location sharing to Overpass, direct radio/library networking, and Auth are included.
- Foreground media-service behavior and exact-alarm justification require release-device validation.

#### Unknown

- Play Console declarations, app-access instructions, target-SDK compliance at submission date, signed AAB upload, policy enforcement outcome, and production ANR/vitals.

## 4. Final Risk Matrix

| Severity | Count |
|---|---:|
| Critical | 2 |
| High | 8 |
| Medium | 9 |
| Low | 3 |

Counts include only C-01 through C-23 confirmed/partially confirmed repository findings, with security and release-distribution impact weighted highest. Manual-verification items are excluded.

## 5. Recommended Execution Order

1. **Contain public backend write/privilege risk.** Restrict the author RPC, protect report submission, remove broad default grants, and prove policies with role-based tests.
2. **Establish release trust.** Create real signing, environment separation, reproducible backend deployment, backup/restore procedure, and production configuration audit.
3. **Make authentication reliable and compliant.** Fix route completion, configure/test each enabled provider and magic-link return path, then validate deletion end-to-end.
4. **Correct privacy and legal truth.** Reconcile exact location/Sentry behavior with disclosures, add contact/deletion web surfaces, and resolve radio/content/source permissions.
5. **Reduce v1 to verified, finished features.** Make all unfinished surfaces unreachable or remove them from v1; test every release route.
6. **Profile before performance redesign.** Measure real-device startup, memory, reader, search, portal, audio, alarms, and qibla; address the largest observed bottlenecks.
7. **Complete quality gates.** Add backend policy, route/auth, integration, golden, and accessibility tests; decide which analyzer findings should fail CI.
8. **Reconcile architecture and documentation.** Define the target repository/error/state boundaries for future work, then update ADRs, README, roadmap, content sources, and release checklists from verified facts.
9. **Finish localization and accessibility validation.** Do not market locales as complete until key completeness, human language review, and RTL/LTR assistive-technology testing pass.

