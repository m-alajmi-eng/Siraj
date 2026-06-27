# SIRAJ — Islamic Knowledge App | Progress Report

> A comprehensive smart Islamic application
> Last updated: June 2026

---

## 🏗️ Tech Stack

| Component | Technology |
|-----------|-----------|
| Frontend | Flutter 3.44.2 + Riverpod 3.x + GoRouter |
| Backend | Supabase (PostgreSQL) |
| Auth | Firebase Auth |
| Audio | audioplayers |
| Cache | Hive (offline-first) |
| Package ID | app.islamx.siraj |
| GitHub | github.com/m-alajmi-eng/Siraj |

---

## ✅ Completed Milestones

### Core Architecture
- Clean Architecture (data/domain/presentation)
- 8 time-based themes that change with prayer times
- AppMode (Lite/Full) + Feature Flags
- Offline-first with Hive Cache
- Onboarding + Settings
- l10n ready (30 languages)

### MVP Features
- ✅ Prayer times (adhan + geolocator)
- ✅ Qibla direction
- ✅ Adhan audio (8 voices from islamcan.com)
- ✅ Quran reader (Uthmani font)
- ✅ Audio recitation (23 reciters)
- ✅ Athkar (6 categories)
- ✅ Hadith (6 books via jsdelivr)
- ✅ Islamic calendar (Hijri)
- ✅ User statistics
- ✅ Share cards (6 platforms)
- ✅ Quran radio (50+ stations)
- ✅ Nearby mosques (Overpass API)

### QKE — Quranic Knowledge Engine
- ✅ 114 surahs + 6,236 ayahs (clean Uthmani text)
- ✅ 49,888 tafsir entries (8 verified sources)
- ✅ 77,432 word meanings + morphology
- ✅ 201 asbab al-nuzul (reasons of revelation)
- ✅ VersePortalScreen — 4 knowledge layers:
 - Quick understanding (Muyassar)
 - Word explorer
 - Reasons of revelation
 - Full tafsir (8 scholars)
- ✅ Navigation buttons between layers

### Citation Engine
- ✅ CitationBadge — verified source badge on every text
- ✅ 8 sources: Tabari, Ibn Kathir, Baghawi, Saadi, Muyassar, Mukhtasar (AR/EN/BN)
- ✅ Scholar name + book title + death year

### Home Screen
- ✅ Hijri date display
- ✅ Next prayer card
- ✅ Upcoming Islamic event
- ✅ Quick access grid (6 buttons)
- ✅ Verse of the day

### Unified Search Engine
- ✅ Search in Quran ayahs
- ✅ Search in tafsir (Muyassar)
- ✅ Search in word meanings
- ✅ Global search FAB on all screens

---

## 🗄️ Supabase Schema

| Table | Content |
|-------|---------|
| surahs | 114 surahs |
| ayahs | 6,236 ayahs |
| tafsir_sources | 8 verified sources |
| tafsir | 49,888 cleaned tafsir entries |
| word_meanings | 77,432 word meanings |
| asbab_al_nuzul | 201 reasons of revelation |
| hadith_books | 6 hadith books |
| hadiths | ~34,000 hadiths (importing) |

---

## ⏳ In Progress

- 🔄 Importing hadiths (~34,000 entries)
- ⬜ Android device testing
- ⬜ UI/UX redesign (Figma)
- ⬜ Hadith search integration
- ⬜ ARB translations (30 languages)

---

## 🗺️ Roadmap

### Phase 2 — Content Quality
- Import verified hadiths with source references
- Stories of Prophets and Companions
- Quran translations

### Phase 3 — User Experience
- Professional UI/UX design (Figma)
- Complete visual identity
- Smart adhan notifications

### Phase 4 — Intelligence
- pgvector — semantic search
- Knowledge Journey feature
- Claude Haiku + RAG integration

### Phase 5 — Infrastructure
- Redis/Upstash caching
- Meilisearch
- Cloudflare Pro
- pg_dump + S3 backup

### Phase 6 — Launch
- Android + iOS production build
- Beta testing (50-100 users)
- Official launch

---

## 📝 Key Architecture Decisions

- **Riverpod 3.x**: No StateProvider, no ProviderScope.parent
- **audioplayers**: Chosen over just_audio (no Linux support)
- **ilike search**: Used instead of textSearch (FTS not enabled)
- **FutureBuilder**: Used for tafsir bottom sheet (Consumer+Map family caused infinite loop)
- **RLS disabled**: On all Supabase tables (anon key reads freely)
- **Search**: ilike on text_uthmani + tafsir.text + word_meanings.meaning_ar

---

## 👨‍💻 Development

Built by a solo developer with AI assistance (Claude by Anthropic).
Every architectural decision, test, and bug fix was driven by the developer.
Claude served as a coding assistant throughout the development process.

*Lenovo tablet — Ubuntu 22.04 — 7.4GB RAM*
*Development environment: Flutter + Cursor IDE*