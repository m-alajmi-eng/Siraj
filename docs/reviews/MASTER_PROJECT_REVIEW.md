# Siraj Engineering Advisory Report

No files were changed during the audit. Validation: `flutter test` passed 56/56; `flutter analyze` found 0 errors and 10 warnings/info findings.

## 1. Executive summary

Siraj has unusually strong product intent, religious-content seriousness, offline ambition, and internal decision-making for a solo project. The core architecture is viable.

However, it is not launch-ready. The biggest blockers are authentication configuration/flows, public backend write surfaces, release signing, legal provenance, privacy-policy accuracy, documentation drift, and real-device accessibility/performance validation.

- Product maturity: advanced prototype / pre-alpha
- Engineering maturity: medium
- Launch readiness: low
- Long-term potential: high, if scope is controlled
- Overall score: **5.5/10 today; 8/10 potential**

## 2. Architecture review

Strengths:

- Flutter + Riverpod + GoRouter is an appropriate low-operations stack.
- Feature-first organization is generally clear.
- Local Quran, tafsir, translations, tajweed, athkar, and fonts support the central offline-first promise.
- Supabase/Postgres is appropriate for structured scholarly content and search.
- Arabic FTS + GIN indexes are a good scalability decision.
- Audio is sensibly hidden behind `SirajAudioController`.

Weaknesses and risks:

- “Clean Architecture” is inconsistently applied: screens, providers, remote data sources, Supabase calls, assets, Hive, and HTTP are often tightly coupled.
- State management mixes `Notifier`, `FutureProvider`, direct static service calls, stateful widgets, and `dynamic` UI values without a consistent boundary.
- No formal repository interfaces, dependency injection boundary, error model, or typed result model.
- “Offline-first” is excellent for core reading, but not uniformly expressed: surah metadata, portal content, library, radio, mosque discovery, and search have materially different resilience behavior.
- No synchronization architecture exists yet for future user data. Add it only after explicit conflict, ownership, encryption, retention, and deletion rules are designed.

## 3. Flutter review

Strengths:

- Sensible feature grouping and shared scaffolding/tokens.
- Riverpod is used for several mutable user-facing domains.
- Local Quran data fallback is tested.
- Good use of page-independent prayer calculation and audio abstraction.

Issues:

- Several high-complexity screens are very large, notably reader, portal, settings, home, calendar, and onboarding. They will become difficult to test and redesign.
- `context.go('/')` appears in auth/account flows, but no `/` route exists. Successful sign-in, sign-out, or deletion may route to an unmatched location rather than home.
- Auth UI advertises Google, Apple, magic link, and anonymous sign-in, while the checked-in local Supabase configuration has anonymous sign-in and external providers disabled. Production configuration must be verified independently.
- Magic-link mobile return/deep-link handling is not visible; `signInWithOtp` has no redirect URL.
- `getSurahs()` still depends on alquran.cloud when no cache exists, despite the local `surah_names.json`.
- Asset JSON is decoded on the UI isolate and retained in static memory. `quran_translations.json` alone is ~18 MB.
- `ConcatenatingAudioSource` is deprecated.
- `audioplayers`, Firebase Core, and Firebase Auth remain dependencies without active app use.
- Static analysis has 10 findings, including deprecated API use and `BuildContext` across async gaps.

## 4. Backend review

Strengths:

- PostgreSQL schema has useful uniqueness constraints and foreign keys.
- RLS is enabled for the principal content tables.
- Full-text Arabic search is thoughtfully normalized and indexed.
- Translation reports are write-only to the public, which is directionally correct.

Critical concerns:

- `upsert_harvested_author` is `SECURITY DEFINER` and executable by `anon`. Any client with the public key can create or alter harvested-author records through the RPC. It is not safely restricted to a trusted server-side harvester.
- Public translation-report insertion is unrestricted: no rate limiting, CAPTCHA, length constraints, abuse prevention, moderation workflow, or attribution.
- `kg_edges` grants `ALL` to `anon` and `authenticated`. RLS currently prevents writes without policies, but privileges should be least-privilege rather than relying on absence of policies.
- The baseline grants `ALL` broadly to public roles and sets dangerous default privileges for new tables/functions/sequences. This is high drift risk.
- The baseline defines an RLS event-trigger function but does not create the event trigger in the migration. Do not assume it protects future tables.
- Migrations are not a full operational backend: no seeds, deployment environments, schema verification, backup/restore drills, monitoring, or production policy tests are present.
- Supabase Auth is used, while Firebase dependencies/config remain, creating unnecessary ambiguity.

## 5. UI / UX review

The visual direction—spiritual minimalism, dark canvas, gold, glass, dynamic sky—is distinctive and potentially premium. The home experience, content depth, and Verse Portal concept are differentiated.

Main concerns:

- Navigation has five persistent tabs plus a large “More” surface, Lite/Full configuration, portal pages, library depth, and several partly implemented experiences. This is too much cognitive load for a first release.
- Features marked “coming soon” or backed by empty data remain a store-review and trust risk.
- Dynamic themes are based on clock-hour bands, not actual calculated prayer times, so the stated prayer-time theme concept is not fulfilled.
- The dark/glass visual system risks low contrast, glare, weak affordance, and legibility issues, especially outdoors and for older users.
- Arabic content is premium; many non-Arabic UI translations are visibly English placeholders.
- There is no evidence of user testing with Saudi users, elderly users, new Muslims, screen-reader users, or low-end Android devices.
- Mosques, radio streams, prayer alerts, qibla, global search, and account features need clear permission/error/offline states tested in the actual app.

## 6. Design system review

Strengths:

- Central token files for colors, spacing, radius, typography, motion, and semantic colors.
- Quran typography is treated separately from UI typography.
- Reusable primitives exist (`AppScaffold`, `GlassCard`, section labels).

Issues:

- Two partly overlapping systems exist: `SirajSky`/design tokens and `SirajColors`/time palettes.
- Tokens do not guarantee adoption; many screens still define local styling.
- `AppText` uses a single Arabic family for all UI languages, with Latin font declared separately but not consistently selected by locale.
- No documented component inventory, states, sizing rules, contrast matrix, responsive breakpoints, or RTL/LTR component behavior.
- No design-source-of-truth connection to Figma is present in this repository.

## 7. Product review

The strongest strategic insight is the combination of reliable core worship tools, serious Quran study, local-first content, Arabic-first quality, and optional non-Muslim educational material.

Risks:

- The MVP is too broad: Quran, tafsir, hadith, library, prayer, adhan, qibla, calendar, radio, mosque discovery, Khatmah, children, gateway, sharing, stats, and auth.
- “Elite knowledge platform” should not be launched before content governance and provenance are operationally complete.
- Monetization is intentionally absent. That is viable for a charitable product, but hosting, Sentry, Supabase, audio bandwidth, editorial review, legal work, and support still require a sustainability model.
- Saudi readiness is promising—Arabic, local prayer methods, Saudi content sources—but requires Saudi user testing, reviewed legal text, accurate store disclosures, and licensed radio/content use.
- Global readiness is not yet credible because localization quality, multilingual support processes, app metadata, legal contacts, and support operations are incomplete.

## 8. Code quality review

Positive:

- Comments are unusually candid and useful.
- Tests cover Quran asset counts, Khatmah math, cache fallback, prayer resolver, and notification IDs.
- The repository has CI and Dependabot.

Gaps:

- 56 tests are narrow relative to the feature surface.
- No integration tests, golden tests, accessibility tests, backend policy tests, end-to-end auth tests, or platform tests.
- Error handling is inconsistent and frequently swallows exceptions.
- Large presentation files mix UI, navigation, data shaping, and behavior.
- Documentation contains stale statements, duplicated material, and even an apparent pasted shell-command fragment in `ROADMAP.md`.
- README remains the default Flutter template and gives no useful onboarding, architecture, privacy, build, or release information.

## 9. Security and privacy review

Critical:

1. Public `SECURITY DEFINER` author-upsert RPC can be abused to poison public author metadata.
2. Public report insertion can be spammed indefinitely.
3. Release builds use Android debug signing.
4. The checked-in Supabase public key and Sentry DSN are expected client values, but key rotation, environment separation, and release injection are not operationally complete.

High:

- Hive stores reading state, Khatmah plans, settings, and last location without application-layer encryption.
- The privacy policy says `sendDefaultPii` is disabled, but the Sentry initialization does not explicitly set it.
- The policy claims location is approximate, while mosque search requests high-accuracy location.
- Sentry can collect more than the policy’s narrow claims unless SDK defaults and event scrubbing are explicitly configured and verified.
- Authentication is not production-verified: provider configuration, redirect allowlist, Apple configuration, deletion behavior, and anonymous access must be checked against deployed Supabase—not inferred from code.

## 10. Performance review

The principal performance risk is startup/first-use memory pressure on 8 GB development hardware and lower-end target phones.

- Large bundled data is good for availability but currently loaded through whole-file `jsonDecode`.
- Quran translations (~18 MB), tajweed, tafsir, and Quran data can cause jank and memory retention.
- Local fallback Quran search scans all Quran content synchronously.
- QKE portal performs several sequential remote queries.
- Audio creates a complete playlist for the remaining surah.
- No startup, frame-time, memory, network, or database measurements are checked in.
- No asset-size budget or release-size measurement is present.

## 11. Apple App Store review

**Likely outcome today: rejection or a request for significant clarification.**

Likely issues:

- **Guideline 5.1.1:** account deletion appears implemented in UI, but must be fully functional and verified on production Auth.
- **Guideline 5.1.1:** privacy policy has no real contact email or hosted public URL.
- **Guideline 2.1:** nonfunctional auth choices, empty/coming-soon surfaces, broken `/` redirect, or radio failures could be treated as incomplete functionality.
- **Guideline 2.3:** metadata and screenshots are absent; claims must exactly match delivered functionality.
- **Guideline 5.2:** radio rebroadcast rights and content/font licensing remain unresolved.
- **Guideline 5.1.2:** location and Sentry data disclosures need exact, verified App Privacy answers.
- Apple Sign In must work if Google sign-in is offered.

## 12. Google Play review

**Not ready for submission.**

- Android release variant is debug-signed.
- Data Safety form and hosted privacy policy are missing.
- Account-deletion policy requires both in-app and web deletion access where accounts can be created.
- Notification, exact-alarm, foreground-service, location, and boot permissions need a policy-by-policy justification.
- Radio/media foreground behavior requires device validation.
- Unlicensed radio content is a material policy and copyright risk.
- Low-end-device ANR/performance risk is unmeasured.

## 13. Source and dependency review

Concerns:

- Unused or transitional direct dependencies: `firebase_core`, `firebase_auth`, `audioplayers`.
- `supabase_flutter` deprecates `anonKey` in favor of a publishable key.
- No SBOM, dependency-license inventory, vulnerability scan gate, or formal update policy.
- Content provenance is materially incomplete for radio, IslamHouse usage, tajweed, translations, tafsir, and some fonts.
- `licenses_screen.dart` is candid but does not resolve legal permission.

## 14. Documentation review

Good:

- ADRs, risk register, technical debt, release plan, compliance checklist, and content philosophy show excellent governance instincts.
- The project documents uncertainty rather than pretending certainty.

Needs correction:

- README is unusable.
- Multiple documents refer to removed packages/features (`quran_library`, audioplayers, Firebase, broken-build claims) as current.
- ADR-003 and ADR-006 are stale relative to actual local Quran/translation/tafsir assets.
- `CONTENT_SOURCES.md` describes `quran_library` as currently used even though code no longer depends on it.
- The roadmap contains duplicated entries and an apparent accidental terminal paste.
- Documents sometimes state completion based on prior sessions where the present code says otherwise.
- Legal documents contain placeholder contact details and should not be treated as publishable.

## 15. Collective advisory-board opinion

The board is impressed by the seriousness of the religious-content mission, the local-content direction, Arabic FTS work, documentation culture, and product differentiation of the Verse Portal.

The board is concerned that the project has accumulated a large surface area faster than its release controls, production verification, legal provenance, and UX validation. We would continue with this architecture, but only after a focused stabilization phase. We would not rebuild the app; we would narrow v1 sharply and harden its foundation.

We would invest in the mission and team discipline, conditional on resolving security, legal, release, and quality gates before feature expansion.

## 16. Recommendations backlog

### Critical

| Recommendation | Why | Impact | Difficulty |
|---|---|---:|---:|
| Restrict/replace public author-harvesting RPC | Prevent public metadata poisoning | Critical | Medium |
| Add abuse controls for translation reports | Prevent spam and operational abuse | High | Medium |
| Establish real release signing and secrets handling | Required for distribution trust | Critical | Medium |
| Verify production Auth end-to-end | Current UI/configuration mismatch may break sign-in | Critical | Medium |
| Fix invalid `/` auth redirects | Core auth/account flow reliability | High | Low |
| Resolve content/radio licenses before release | Copyright and store-blocking risk | Critical | High |
| Publish accurate privacy policy and deletion webpage | Store requirement | Critical | Medium |

### High

| Recommendation | Why | Impact | Difficulty |
|---|---|---:|---:|
| Define a narrow v1 and hide unfinished surfaces | Reduce store and UX risk | High | Low |
| Replace local whole-file JSON decoding strategy | Prevent jank/memory pressure | High | Medium |
| Add real-device test matrix | Required for qibla, audio, notifications, accessibility | High | Medium |
| Complete non-Arabic UI localization review | Global quality and trust | High | High |
| Rewrite README and reconcile all operational docs | Prevent maintenance mistakes | High | Medium |
| Remove unused dependencies | Reduce attack surface/build complexity | Medium | Low |
| Establish backend migration/policy CI tests | Prevent future RLS regressions | High | Medium |

### Medium

| Recommendation | Why | Impact | Difficulty |
|---|---|---:|---:|
| Introduce typed repositories/results and unified errors | Maintainability | Medium | Medium |
| Split oversized screens | Testability and redesign speed | Medium | Medium |
| Add golden, integration, accessibility, and route tests | Quality confidence | Medium | Medium |
| Make theme phases use calculated prayer times | Deliver stated product promise | Medium | Medium |
| Formalize content provenance register | Religious/legal governance | High | Medium |
| Add data-retention, moderation, and incident procedures | Operational readiness | Medium | Medium |

### Low

| Recommendation | Why | Impact | Difficulty |
|---|---|---:|---:|
| Resolve analyzer findings | Keep codebase clean | Low | Low |
| Replace `dynamic` palette types | Better static safety | Low | Low |
| Improve desktop/web metadata | Future platform quality | Low | Low |

### Future

- Account-backed sync only after conflict-resolution, encryption, export, retention, and deletion design.
- Semantic search only after a measured search need and moderation/content-governance model.
- Native-style Mushaf mode only after foundational v1 quality gates pass.
- Monetization or donor-sustainability model before infrastructure costs become material.

## 17. Improvement register

Master themes for all future work:

- Security: least-privilege grants, protected RPCs, abuse prevention, key rotation, environment separation, audit logging.
- Privacy: explicit Sentry configuration, accurate disclosures, encrypted sensitive local state, retention/deletion operations.
- Backend: schema-policy tests, deployment runbook, backups, restore drills, production observability.
- Flutter: bounded screen complexity, typed data layer, error taxonomy, isolate-based parsing, cached/retry policies.
- UX: simplify v1 navigation, eliminate unfinished entry points, conduct Saudi and multilingual usability studies.
- Accessibility: TalkBack/VoiceOver, large text, contrast, focus order, touch targets, reduced motion.
- Product: prioritize Quran reading, prayer, athkar, qibla, Khatmah, and trusted study before broader media/community scope.
- Content: source contracts, scholarly review workflow, versioned datasets, correction SLA, visible provenance.
- Documentation: one accurate source of truth, versioned ADR status, release checklist tied to evidence.
- Operations: signed release pipeline, crash triage, support contact, incident response, store-submission evidence pack.

The project can become world-class, but the next phase should be stabilization—not more feature creation.
