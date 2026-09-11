# ربط حديث↔آية (Ibn Kathir tafsir citation extraction)

Extracts hadith quotes attributed to the Prophet from Ibn Kathir's tafsir
(`tafsir` table, `source_id='ibn-kathir-ar'`), matches them against
`public.hadiths`, and links confirmed matches into `public.kg_edges`
(`edge_type='authentic_hadith_citation'`, always `reviewed=false`). Full batch
history is narrated in root `PROGRESS.md` (search "ربط حديث↔آية").

There is no persisted "candidate ayah list" — each batch continues from
wherever `kg_edges` actually leaves off (see below), not a fixed index. An
earlier undocumented "1,667 candidate ayahs" scheme from batches 1-4 could not
be reconstructed (see PROGRESS.md, batch 5 entry) — this tool intentionally
does not try to reproduce it.

## Find the frontier (last-linked ayah)

```sql
SELECT a.surah_id, a.ayah_number
FROM kg_edges k JOIN ayahs a ON a.id = k.src_id
WHERE k.edge_type = 'authentic_hadith_citation'
  AND k.dst_type = 'hadith' AND k.dst_id IS NOT NULL
ORDER BY a.surah_id DESC, a.ayah_number DESC
LIMIT 1;
```

Run via `supabase db query --linked "<sql above>"`.

## Stage 1: extract + match + flag

```bash
python3 extract_match.py --after-surah 57 --after-ayah 6 \
    --window 900 --out /tmp/batch6_report.json
```

`--window` is a count of **raw consecutive ayahs**, not pre-filtered
candidates — citation density varies a lot across the mushaf (dense in early
legislative surahs, sparse in narrative/short surahs), so tune it to land
around 500-650 raw quotes per batch (print output shows the count; rerun with
a different `--window` if needed).

Read `report.json["candidates"]`, specifically entries with a non-empty
`flags` list (`wide_context` has ~450 chars around the match). For each, judge
per the project's standing rule: exclude ONLY if Ibn Kathir himself expresses
genuine doubt the quote is actually *marfu'* (raised to the Prophet) vs
mawquf/a Companion's own words — a weak isnad alone, or a Tirmidhi "حسن غريب"
classification, is never exclusion grounds. Watch for warning words that are
just substrings of an unrelated word nearby (e.g. "واه" inside "رواه") or that
belong to a different, adjacent hadith in the same tafsir paragraph.

Write decided exclusions to a JSON file:

```json
[{"surah_id": 37, "ayah_number": 182, "quote": "سبحان ربك رب العزة..."}]
```

## Stage 2: resolve real hadiths.id (never guessed)

```bash
python3 insert_kg_edges.py --report /tmp/batch6_report.json \
    --exclude /tmp/batch6_excluded.json --sql-out /tmp/batch6_resolve.sql
supabase db query --linked --file /tmp/batch6_resolve.sql -o json \
    > /tmp/batch6_resolved.json
```

## Stage 3: build + run the insert

```bash
python3 insert_kg_edges.py --report /tmp/batch6_report.json \
    --exclude /tmp/batch6_excluded.json --resolved /tmp/batch6_resolved.json \
    --sql-out /tmp/batch6_insert.sql --finalize
# sanity-check for overlap with existing kg_edges pairs before running this
supabase db query --linked --file /tmp/batch6_insert.sql -o json \
    > /tmp/batch6_result.json
```

Then verify anon can't read the new ids (`reviewed=false` should hide them),
and document the batch in `PROGRESS.md` with a separate commit.
