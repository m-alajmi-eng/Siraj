---
name: islamic-content-review
description: >-
  Apply before creating, editing, verifying, importing, or reviewing any
  Islamic content in this repo — Quran text/translations, hadith,
  tafsir, fiqh, aqeedah, asbab al-nuzul, hadith-verse relations,
  citation_type/reviewed flags, or any `verse_hadith_relations`-style
  table row. Also apply when writing migrations or data-import scripts
  that touch these tables. Full governance doc: docs/adr/ADR-008.
---

# Islamic Content Review — Human Escalation Boundary

Practical summary of ADR-008 Part 1 (Editorial Board), for immediate
application on every task touching Islamic content. Part 2 of ADR-008
(Canonical Knowledge Architecture) is long-term direction for future
migrations — not required reading for day-to-day content work.

## The one rule everything else follows from

**No AI role in this project is a religious authority.** An AI agent
verifying AI-extracted content is not independent verification — it's
the same failure mode checking itself. On 2026-07-14, an automated
classifier for this exact project misclassified 81% of "israiliyyat"
citations before a human caught it by manually reading the samples.

**Current reality:** Mohammed is the sole human reviewer. There is no
staffed scholarly reviewer. Every escalation below routes through him
explicitly. Never assume a "Scholarly Reviewer" step is satisfied just
because it's named in a workflow doc.

## You (the AI) MAY

- Flag inconsistencies and surface missing citations
- Compare extracted text against known reference patterns
- Prepare material, cross-references, and source links for human review
- Draft a grading suggestion (Sahih/Hasan/Da'if/etc.), **always labeled
  explicitly as a DRAFT SUGGESTION, never as a final grading**

## You (the AI) MUST NEVER

- Set any `reviewed` flag to `true`. It stays `false` until a human
  explicitly sets it. This applies to every table with this pattern
  (e.g. `verse_hadith_relations.reviewed`), not just the ones named here.
- Resolve scholarly disagreement (ikhtilaf) on your own authority
- Present a hadith authenticity grade as final without citing the
  specific human-authored reference it came from
- Publish anything to users without an explicit human sign-off event
- Modify, paraphrase, auto-correct, or regenerate Quranic Arabic text,
  or original hadith texts, for any reason

## Per-content-type checks (condensed from the Editorial Board roles)

- **Quran quotes:** verify surah, ayah, Arabic text against Uthmani
  script, translation source. No missing words, no paraphrasing.
- **Hadith:** must include original source, book, chapter, hadith
  number, and grade (Sahih/Hasan/Da'if/Fabricated/Unknown) when
  available. Never present a weak narration as authentic.
- **Tafsir:** identify the source; distinguish direct tafsir /
  scholarly opinion / historical narration / linguistic explanation /
  personal interpretation. Never mix them, never present interpretation
  as revelation.
- **Fiqh:** identify school of thought (if relevant), consensus (ijma)
  vs disagreement (ikhtilaf). Never claim consensus where disagreement
  exists.
- **Translations:** must preserve meaning, context, tone, religious
  terminology — never shift theological meaning.
- **Historical material:** separate verified history / popular
  narration / weak reports / legends / later interpretation. Never
  merge historical certainty with speculation.
- **Citations generally:** every statement traceable, prefer primary
  sources, never invent a citation or scholarly opinion, never remove
  attribution.

## Before queuing anything for human review, confirm

- [ ] Every citation is traceable to a specific source
- [ ] Every verse is accurate against the Uthmani text
- [ ] Every hadith is referenced with book/chapter/number
- [ ] Any authenticity status is labeled DRAFT SUGGESTION, not final
- [ ] Scholarly disagreements are represented fairly, not flattened
- [ ] Nothing speculative is presented as fact
- [ ] The `reviewed` flag (or equivalent) is still `false`

If any box is unchecked, fix it before the content enters the review
queue — don't hand Mohammed something that still needs work a linter
could have caught.
