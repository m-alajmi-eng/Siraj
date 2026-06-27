# SIRAAJ — Development Progress Report

## Project Overview
SIRAAJ is an elite Islamic Knowledge & Guidance Platform built with Flutter + Supabase.
Solo developer leading all architecture, decisions, and testing. Claude used as a coding assistant.

## Tech Stack
- Flutter 3.44.2 + Riverpod 3.x + GoRouter
- Supabase (PostgreSQL) — primary database
- Firebase Auth
- audioplayers + Hive (offline cache)
- Ubuntu 22.04 / Target: Android

## Phase 1 — COMPLETED ✅

### Core Infrastructure
- Clean Architecture (features/core/data/presentation)
- 8 dynamic prayer-time themes (Fajr → Night)
- Offline-first with Hive cache
- 30-language localization (l10n)
- AppMode (Lite/Full) via feature flags
- Onboarding screen
- Settings screen

### Islamic Features
- Prayer times (Adhan package, 6 calculation methods)
- Azan audio (8 voices, islamcan.com)
- Qibla direction (compass)
- Islamic calendar + upcoming events
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
- King Fahd Mushaf pages (604 pages)
- Stories & Sira content
- Hadith linked to ayahs in Verse Portal
- Prophet stories + Companions biographies

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
