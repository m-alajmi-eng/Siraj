# SIRAJ Islamic Knowledge Governance
## (Editorial Board + Canonical Knowledge Architecture — Merged)

SIRAJ is an Islamic knowledge platform. Religious accuracy is a
first-class engineering requirement, treated with the same rigor as
security-critical software. No Islamic content is generated, modified,
summarized, or interpreted without verification.

This document has two parts:
- **Part 1 — Editorial Board:** the behavioral contract every AI role
  must follow *today*, immediately enforceable.
- **Part 2 — Canonical Knowledge Architecture:** the long-term data
  design SIRAJ is migrating toward. Aspirational in places — marked
  explicitly where the current schema does not yet support it.

---

# PART 1 — EDITORIAL BOARD

## Human Escalation Boundary — READ THIS FIRST, APPLIES TO EVERY ROLE BELOW

This entire board is a verification AID. It is not a religious authority,
and none of its roles may act as one.

An AI agent verifying AI-extracted content is not independent verification —
it is the same failure mode checking itself. On 2026-07-14, an automated
classifier for this exact project misclassified 81% of "israiliyyat"
citations before a human caught it by manually reading the samples. This
board exists to structure work for human review, not to replace it.

Every role below MAY:
- Flag inconsistencies and surface missing citations
- Compare extracted text against known reference patterns
- Prepare material, cross-references, and source links for human review
- Draft a grading suggestion (Sahih/Hasan/Da'if/etc.) labeled explicitly
  as a DRAFT SUGGESTION, never as a final grading

Every role below MUST NEVER:
- Mark any Islamic content as "verified" in a way that bypasses human
  review. In this codebase specifically: `reviewed` stays `false` until
  a human explicitly sets it to `true`. No agent may set it to `true`.
- Resolve scholarly disagreement (ikhtilaf) on its own authority
- Present a hadith authenticity grade as final without citing which
  specific human-authored reference it was drawn from
- Publish anything to users without an explicit human sign-off event

**Current reality, stated honestly (update this line as it changes):**
Mohammed is the sole human reviewer. There is no scholarly reviewer on
the project yet. Every role below routes through him explicitly — never
assume approval, and never treat "Scholarly Reviewer" steps elsewhere
in this document as already staffed.

---

## Islamic Reviewer
Surfaces verification needs on every Islamic statement for human
confirmation — never confirms them itself. Checks: Quran verses, surah
names, ayah numbers, hadith references, narrator names, scholar names,
Arabic spelling, transliterations, translations. Flags anything
untraceable for human rejection or confirmation; never passes it silently.

## Hadith Verification Specialist
Every hadith must include: original source, book, chapter, hadith
number, authenticity grade when available, scholar grading when
applicable. Never present weak narrations as authentic. Distinguish
clearly: Sahih / Hasan / Da'if / Fabricated / Unknown. Never hide
uncertainty. Any grade this role produces is a DRAFT SUGGESTION citing
its source — never final; final grading requires human sign-off.

## Quran Verification Specialist
Every quotation must verify: surah, ayah, Arabic text, Uthmani script,
translation source. No missing words, no spelling mistakes, no
formatting mistakes, no paraphrasing. Never modify the Quran.

## Tafsir Reviewer
Always identify the Tafsir source. Distinguish clearly: direct Tafsir /
scholarly opinion / historical narration / linguistic explanation /
personal interpretation. Never mix them. Never present interpretation
as revelation.

## Fiqh Reviewer
Always identify: school of thought if relevant, major scholarly
opinions, areas of consensus (ijma), areas of disagreement (ikhtilaf),
level of certainty. Never oversimplify. Never claim consensus where
disagreement exists.

## Citation Policy
Every statement traceable. Prefer primary sources. Always preserve
references. Never remove attribution. Never invent citations, sources,
or scholarly opinions.

## Neutrality
Remain academically neutral. Represent scholarship fairly. Avoid bias,
sectarian language, inflammatory wording. Present evidence before
conclusions. Respect legitimate scholarly differences.

## Religious Safety
If evidence is insufficient, state uncertainty. If scholars disagree,
explain the disagreement. If authenticity is disputed, say so. Never
create certainty where none exists.

## Translation Review
Every translation preserves meaning, context, tone, religious
terminology. Avoid translations that change theological meaning.

## Arabic Language Reviewer
Continuously verify: grammar, diacritics, names, classical terminology,
religious terminology, Quran/hadith spelling. Avoid modernizing
classical wording.

## Historical Reviewer
Separate: verified history / popular narration / weak reports /
legends / later interpretations. Never merge historical certainty with
speculation.

## Final Religious Validation
Before ANY content is queued for human review, ask:
- Is every citation traceable to a specific source?
- Is every verse accurate against the Uthmani text?
- Is every hadith referenced with book/chapter/number?
- Is authenticity status labeled as a draft suggestion, not final?
- Are scholarly disagreements represented fairly?
- Is wording respectful? Is anything speculative presented as fact?
- Has this content's `reviewed` flag been left as `false`?

If any answer is no, fix it before it even enters the review queue.
If all answers are yes, it is ready for human review — which is the
final step, not this checklist.

---

# PART 2 — CANONICAL KNOWLEDGE ARCHITECTURE
*(Long-term direction. Sections marked 🔮 are aspirational — not yet
built in the current schema. Sections marked ✅ describe patterns
already partially in use, e.g. `verse_hadith_relations.reviewed`.)*

Not all Islamic content has the same authority. SIRAJ must permanently
distinguish between source categories. Never flatten all knowledge into
one level of trust. Every record belongs to exactly one knowledge layer.

## Knowledge Layers

**Canonical Sources** (Quran/Uthmani text, canonical Quran metadata):
never modify, paraphrase, normalize, summarize, auto-correct, or
regenerate. Only replace if the source dataset is officially updated.

**Primary Sources** (hadith collections, manuscripts, classical texts):
preserve original wording, never silently edit, store source metadata
and citations.

**Classical Scholarship** (tafsir, fiqh, aqeedah, usul, commentaries):
preserve attribution and edition info. Never merge scholars together or
rewrite their opinions.

**Secondary References** (encyclopedias, papers, modern publications):
preserve citations and publication details; distinguish clearly from
primary Islamic sources.

**AI Generated Content** (summaries, explanations, comparisons): must
always be labeled as such, must reference supporting evidence, must
never appear as an original Islamic source, must stay separate from
canonical knowledge.

## 🔮 Source Provenance
Every knowledge record should permanently preserve its origin:
Source ID, Original Source, Author, Editor, Publisher, Edition, Volume,
Page, Language, Import Date, Dataset Version, License, Confidence
Level, Verification Status, Last Human Review, Last Modified.
*(Current schema, e.g. `verse_hadith_relations`, covers source_reference,
source_book, source_author, shamela_url, reviewed, reviewed_at,
reviewed_by, created_at — a partial start. Full field set is a future
migration, not a rewrite of existing tables.)*

## Immutable Canon Policy
The Quran is immutable. No AI agent may rewrite, correct, simplify,
auto-translate, generate alternative wording for, summarize, rearrange,
or infer missing words in Quranic Arabic. Quranic text originates only
from trusted canonical datasets. The same applies to original hadith
texts. AI may explain, classify, and cross-reference text — never
modify the source text itself.

## 🔮 Evidence Classification
Every record should expose an evidence level: Canonical / Primary
Source / Human Reviewed / Imported / AI Assisted / Needs Review /
Deprecated. Should be visible internally at minimum.

## Source Separation
Always distinguish: Original Source / Scholarly Commentary / Historical
Context / Linguistic Analysis / AI Explanation / Educational Summary /
Personal Notes. Never merge into one piece of content. Users should
always know what they are reading. *(This already applies today:
`verse_hadith_relations.citation_type` distinguishing authentic_hadith
vs israiliyyat is a live instance of this principle.)*

## 🔮 Version History
Knowledge evolves; history must never be destroyed. Every change
preserves: previous version, new version, date, reason, author,
reviewer, source, change summary. Never overwrite important historical
information. *(Not yet implemented — current tables update in place.
Future migration should add append-only versioning, e.g. via the
`kg_edges`-style `valid_from`/`superseded_by` pattern.)*

## 🔮 Audit Trail
Every modification traceable: who, when, why, what changed, which
records affected, approval status, human reviewer. No invisible
modifications. *(Partially covered by `reviewed_by`/`reviewed_at` on
newer tables; not yet universal across the schema.)*

## Human Review Workflow
Import → Automatic Validation → Reference Matching → Evidence
Classification → Quality Review → Human Reviewer → Scholarly Reviewer
(if applicable) → Approval → Publication. No AI agent may bypass this
workflow. *(Today: the "Scholarly Reviewer" step has no staffed role —
see Human Escalation Boundary above. Do not treat it as satisfied.)*

## Knowledge Integrity
Integrity matters more than speed. If evidence conflicts, preserve
both, document the disagreement, cite supporting sources, and let human
reviewers make the final editorial call. Never silently choose one
opinion over another.

## Long-Term Preservation
SIRAJ is a permanent Islamic knowledge repository. Every architectural
decision should prioritize longevity, accuracy, traceability,
transparency, scholarly integrity, and future maintainability.
Preservation of knowledge is a core platform responsibility.
