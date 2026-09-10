#!/usr/bin/env python3
"""
Second stage of the ayah<->hadith linking pipeline (see extract_match.py).
Takes a reviewed report.json (with an --exclude file marking which flagged
candidates a human/agent decided to drop after reading wide_context), resolves
each surviving candidate's hadiths.id by exact text_ar match (never guessed),
and inserts into public.kg_edges via `supabase db query --linked` (reviewed
always stays false; RLS blocks anon from writing this table at all).

Usage:
  python3 insert_kg_edges.py --report report.json --exclude excluded.json \
      --sql-out insert_batch.sql --resolve-out resolve.sql

  # then, from the repo root (needs the linked Supabase CLI session):
  supabase db query --linked --file resolve.sql -o json > resolved.json
  python3 insert_kg_edges.py --report report.json --exclude excluded.json \
      --resolved resolved.json --sql-out insert_batch.sql --finalize

  supabase db query --linked --file insert_batch.sql -o json > result.json
"""
import argparse
import json
import sys

CITATION_BOOK = "تفسير القرآن العظيم (ابن كثير)"


def esc(s):
    return s.replace("'", "''")


def load_excluded(path):
    if not path:
        return set()
    with open(path) as f:
        items = json.load(f)
    return {(it["surah_id"], it["ayah_number"], it["quote"]) for it in items}


def build_resolve_sql(candidates, out_path):
    texts = sorted({esc(d["best"]["text_ar"]) for d in candidates})
    values = ",\n".join(f"('{t}')" for t in texts)
    sql = f"""
SELECT h.id, h.text_ar
FROM hadiths h
JOIN (VALUES
{values}
) AS want(t) ON h.text_ar = want.t;
"""
    with open(out_path, "w") as f:
        f.write(sql)
    return len(texts)


def build_insert_sql(candidates, text_to_id, out_path):
    rows = []
    for d in candidates:
        b = d["best"]
        hid = text_to_id.get(b["text_ar"])
        if hid is None:
            raise SystemExit(f"UNRESOLVED hadith id for: surah {d['surah_id']}:"
                              f"{d['ayah_number']} quote={d['quote']!r}")
        book_part = b["book_name"] if b["book_name"] else "HadeethEnc"
        num_part = f" #{b['hadith_number']}" if b["hadith_number"] is not None else ""
        source_reference = (f"تفسير ابن كثير، سورة {d['surah_id']} آية "
                             f"{d['ayah_number']} - {book_part}{num_part}")
        rows.append((d["ayah_id"], hid, esc(d["quote"]), esc(source_reference)))

    seen = set()
    uniq = []
    for r in rows:
        key = (r[0], r[1])
        if key in seen:
            continue
        seen.add(key)
        uniq.append(r)

    values = ",\n".join(
        f"('ayah', {src_id}, 'hadith', {dst_id}, 'authentic_hadith_citation', "
        f"'{source_reference}', '{citation_text}', '{CITATION_BOOK}', false)"
        for src_id, dst_id, citation_text, source_reference in uniq
    )
    sql = f"""
INSERT INTO public.kg_edges
  (src_type, src_id, dst_type, dst_id, edge_type, source_reference, citation_text, citation_book, reviewed)
VALUES
{values}
RETURNING id;
"""
    with open(out_path, "w") as f:
        f.write(sql)
    return len(uniq)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--report", required=True)
    ap.add_argument("--exclude", default=None,
                     help='JSON list of {"surah_id","ayah_number","quote"} to drop')
    ap.add_argument("--resolve-out", default=None,
                     help="where to write the id-resolution SQL (stage 1)")
    ap.add_argument("--resolved", default=None,
                     help="JSON output of running resolve-out via supabase db query (stage 2 input)")
    ap.add_argument("--sql-out", required=True)
    ap.add_argument("--finalize", action="store_true",
                     help="build the final INSERT sql (requires --resolved)")
    args = ap.parse_args()

    with open(args.report) as f:
        report = json.load(f)
    excluded = load_excluded(args.exclude)
    candidates = [d for d in report["candidates"]
                  if (d["surah_id"], d["ayah_number"], d["quote"]) not in excluded]
    print(f"candidates after exclusions: {len(candidates)} / {len(report['candidates'])}",
          file=sys.stderr)

    if not args.finalize:
        n = build_resolve_sql(candidates, args.resolve_out or args.sql_out)
        print(f"resolve SQL written, {n} distinct hadith texts to resolve", file=sys.stderr)
        return

    with open(args.resolved) as f:
        resolved = json.load(f)
    text_to_id = {}
    for r in resolved["rows"]:
        text_to_id.setdefault(r["text_ar"], r["id"])

    n = build_insert_sql(candidates, text_to_id, args.sql_out)
    print(f"insert SQL written, {n} rows", file=sys.stderr)


if __name__ == "__main__":
    main()
