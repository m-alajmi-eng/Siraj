# Siraj — Design Brief for Figma

## App Overview
Siraj is an elite Islamic Knowledge & Guidance Platform.
Philosophy: Spiritual Minimalism — every pixel must justify its existence.

---

## Navigation Structure

### Bottom Navigation (5 tabs)
1. الرئيسية (Home)
2. القرآن (Quran)
3. الأذكار (Athkar)
4. الحديث (Hadith)
5. المزيد (More)

### FAB (Floating Action Button)
- Global search button (bottom left, all screens)

---

## Screens (16 total)

### 1. Onboarding
- Welcome screen
- Language selection
- App mode selection (Lite / Full)
- One-time shown

### 2. Home Screen
- Hijri date + day name (top right)
- Next prayer card (dynamic gradient based on prayer time)
- Upcoming Islamic event card
- Quick access grid (6 buttons):
  - القرآن / أكمل القراءة (smart — shows last opened surah)
  - الأذكار
  - الحديث
  - القبلة
  - الراديو
  - التقويم
  - القصص والسير
  - قصص الأطفال
- Daily Ayah section (bottom)

### 3. Quran Home
- List of 114 surahs
- Search bar
- Each surah card: name (Arabic + transliteration) + ayah count + revelation type

### 4. Surah Reader
- Full screen reading
- Uthmani Arabic text
- Long press on ayah → options menu:
  - بوابة الآية (opens Verse Portal)
  - عرض التفسير (quick tafsir sheet)
  - نسخ الآية
  - مشاركة الآية
- Audio mini player (bottom)
- 23 reciters available

### 5. Verse Portal (Signature Feature)
Book-style experience with horizontal page index.

#### Pages (in order):
1. **التفسير الميسّر** — Quick understanding (Muyassar, King Fahd)
2. **الشرح اللغوي** — Word-by-word linguistic analysis
   - Each word shown in Quran font (large, colored)
   - Below it: meaning + morphology in a colored box
3. **التفسير بالعربية** — All Arabic tafsirs in one page
   - Scrollable list of scholars:
     - الطبري
     - ابن كثير
     - البغوي
     - السعدي
     - مركز تفسير (مختصر)
   - Each scholar in expandable card with citation badge
4. **التفسير بلغات أخرى** — Translations & tafsir in other languages
   - Search bar to filter languages
   - Languages available:
     - English (Saheeh International, Pickthall, Yusuf Ali)
     - বাংলা (Muhiuddin Khan)
     - اردو (Jalandhry, Maududi)
     - Français (Hamidullah)
     - Indonesia (Kemenag RI)
     - Türkçe (Diyanet)
     - Русский (Kuliev)
     - Deutsch (Bubenheim)
     - Español (García)
     - 中文 (Ma Jian)
5. **أحاديث** — Related hadiths (linked manually)
6. **قصص وسير** — Stories & Sira (coming soon)

#### Header (always visible):
- Back button (×)
- Share button
- Surah name (right)
- Ayah counter e.g. 4/286 (right, below name)
- Revelation type: مكية / مدنية

### 6. Athkar Screen
- Categories: صباح / مساء / نوم / صلاة / أدعية
- Each athkar card: text + repetition count + source
- Counter feature (tap to count repetitions)

### 7. Hadith Screen
- 6 books listed:
  - البخاري (7,580)
  - مسلم (7,360)
  - الترمذي (3,924)
  - أبو داود (5,272)
  - النسائي (5,679)
  - ابن ماجه (4,338)
- Search within books
- Each hadith: text + book name + hadith number

### 8. Prayer Times Screen
- Today's prayer times (5 prayers)
- Next prayer highlighted
- Countdown timer to next prayer
- Location-based (GPS)
- Manual city selection

### 9. Search Screen (Global)
- Universal search bar
- Results categorized:
  - آية (blue) → opens Verse Portal
  - تفسير (green) → opens Verse Portal
  - كلمة (orange) → opens Verse Portal
  - حديث (teal) → opens Hadith detail
- Citation badges on results

### 10. Qibla Screen
- Compass pointing to Mecca
- Degree display
- Distance to Mecca

### 11. Radio Screen
- 50+ Quran radio stations
- Mini player
- Station categories

### 12. Mosques Screen
- Nearby mosques (map + list)
- Distance indicator
- Based on GPS

### 13. Islamic Calendar Screen
- Hijri calendar
- Upcoming Islamic events list
- Days remaining to each event

### 14. Share Screen
- Share Ayah / Hadith as card
- 6 platforms: WhatsApp, Twitter, Instagram, Telegram, Copy, Save
- Custom card design with app branding

### 15. Statistics Screen
- Personal reading stats
- (Community stats coming in Phase 5)

### 16. Settings Screen
- Language
- Calculation method (prayer times)
- Theme (auto / manual)
- App mode (Lite / Full)
- Notifications

### 17. Stories Screen
- Tabs: الأنبياء / الصحابة / العلماء
- Each story card: title + period + person name
- "Coming soon" state (content being added)

### 18. Children Stories Screen
- Grid layout (2 columns)
- Each card: emoji + title + moral lesson + color
- Fun, colorful design
- Categories: أنبياء / صحابة / قيم / قصص قرآنية

---

## Design System Requirements

### Color System
8 dynamic themes based on prayer time:
- Fajr: deep blue/purple
- Morning: soft gold
- Sunrise: warm orange
- Dhuhr: clean white/light
- Asr: warm amber
- Maghrib: deep orange/red
- Isha: dark purple
- Night: deep navy

Each theme: Light + Dark + Accessible contrast

### Typography
- Arabic UI: Amiri or Noto Naskh Arabic
- Quran text: UthmanTNB / KFGQPC Hafs
- English: Inter
- Arabic line height: 1.8–2.0

### Key Components Needed
- AyahCard
- TafsirCard (with CitationBadge)
- HadithCard
- PrayerCard
- QuickTile (home grid)
- SearchResult (4 types)
- PortalPageChip (horizontal index)
- WordCard (linguistic page)
- StoryCard
- ChildrenStoryCard
- MiniAudioPlayer
- CitationBadge

### RTL Support
- Full RTL (Arabic, Urdu)
- Full LTR (English, French, etc.)
- Auto-detection

### Platform
- Primary: Android
- Secondary: iOS
- Flutter implementation

---

## Data Summary
- 114 surahs
- 6,236 ayahs
- 49,888 tafsir entries (8 sources)
- 77,432 word meanings
- 201 asbab al-nuzul
- 34,153 hadiths (6 books)
- 10+ translation languages

---

## App Modes
**Lite Mode:** Home + Quran + Athkar + Prayer times
**Full Mode:** All features unlocked
