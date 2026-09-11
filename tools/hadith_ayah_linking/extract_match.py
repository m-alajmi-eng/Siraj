#!/usr/bin/env python3
"""
Ayah<->hadith citation extraction+matching for the Ibn Kathir tafsir linking
project (see PROGRESS.md, "ربط حديث↔آية"). Pulls raw quotes attributed to the
Prophet from tafsir.text (source_id='ibn-kathir-ar'), matches them against
public.hadiths via the search_hadiths RPC + longest-common-substring scoring,
dedupes, and flags matches near authenticity warning words for manual review.

Usage:
  python3 extract_match.py --after-surah 57 --after-ayah 6 --target-quotes 650 \
      --out report.json

Then read report.json ("flagged" list) by hand, decide inclusion/exclusion,
and pass the result to insert_kg_edges.py.
"""
import argparse
import json
import re
import sys
import time
from difflib import SequenceMatcher

import requests

SUPABASE_URL = "https://pzcnkzsicyxlzqwjznvh.supabase.co"
SUPABASE_KEY = "sb_publishable_No_no5hRjIZU9dIBuqFcbQ_9I8IxWu9"
HEADERS = {"apikey": SUPABASE_KEY, "Authorization": f"Bearer {SUPABASE_KEY}"}

TASHKEEL = re.compile(r'[ً-ْٰـۖ-ۭ]')
PBUH = "صلى الله عليه وسلم"
DASH_PATTERN = re.compile(r'-?\s*' + PBUH + r'\s*-?')
QUOTE_LOOKAHEAD = 80
WARNING_WORDS = ["منكر", "مجهول", "مرسل", "موقوف", "أشبه", "غريب", "ضعيف",
                 "لم يثبت", "لا يصح", "منقطع"]
WAH_STANDALONE = re.compile(r'(?<![؀-ۿ])واه(?![؀-ۿ])')


def strip_tashkeel(s):
    return TASHKEEL.sub('', s)


def fetch_all(table, params, page_size=1000):
    rows = []
    offset = 0
    while True:
        h = dict(HEADERS)
        h["Range-Unit"] = "items"
        h["Range"] = f"{offset}-{offset + page_size - 1}"
        r = requests.get(f"{SUPABASE_URL}/rest/v1/{table}", headers=h, params=params)
        r.raise_for_status()
        batch = r.json()
        rows.extend(batch)
        if len(batch) < page_size:
            break
        offset += page_size
    return rows


def fetch_tafsir():
    params = {
        "select": "ayah_id,text,ayahs(surah_id,ayah_number)",
        "source_id": "eq.ibn-kathir-ar",
    }
    return fetch_all("tafsir", params)


def sort_key(r):
    a = r["ayahs"]
    return (a["surah_id"], a["ayah_number"])


def extract_quotes(rows, after_surah, after_ayah, window):
    rows = sorted(rows, key=sort_key)
    cutoff = (after_surah, after_ayah)
    subset = [r for r in rows if sort_key(r) > cutoff][:window]
    quotes = []
    for r in subset:
        a = r["ayahs"]
        stripped = strip_tashkeel(r["text"])
        for m in DASH_PATTERN.finditer(stripped):
            tail = stripped[m.end():m.end() + QUOTE_LOOKAHEAD]
            qm = re.search(r'"', tail)
            if not qm:
                continue
            start_idx = m.end() + qm.end()
            end_idx = stripped.find('"', start_idx)
            if end_idx == -1:
                continue
            quote_text = stripped[start_idx:end_idx].strip()
            if len(quote_text) < 15:
                continue
            quotes.append({
                "surah_id": a["surah_id"],
                "ayah_number": a["ayah_number"],
                "ayah_id": r["ayah_id"],
                "quote": quote_text,
            })
    return subset, quotes


def search_hadiths(query, limit=8):
    r = requests.post(
        f"{SUPABASE_URL}/rest/v1/rpc/search_hadiths",
        headers={**HEADERS, "Content-Type": "application/json"},
        json={"search_query": query, "match_limit": limit},
    )
    r.raise_for_status()
    return r.json()


def lcs_ratio(a, b):
    sm = SequenceMatcher(None, a, b, autojunk=False)
    match = sm.find_longest_match(0, len(a), 0, len(b))
    return match.size / max(1, len(a)), match.size


def match_quotes(quotes, ratio_threshold=0.85, min_matchlen=15):
    results = []
    for i, q in enumerate(quotes):
        try:
            cands = search_hadiths(q["quote"])
        except Exception as e:
            print(f"search_hadiths error at {i}: {e}", file=sys.stderr)
            cands = []
        best = None
        for c in cands:
            cand_text = strip_tashkeel(c["text_ar"])
            ratio, matchlen = lcs_ratio(q["quote"], cand_text)
            if best is None or ratio > best["ratio"]:
                best = {
                    "ratio": ratio, "matchlen": matchlen,
                    "hadith_number": c["hadith_number"],
                    "book_name": c["book_name"], "text_ar": c["text_ar"],
                }
        results.append({**q, "best": best})
        if i % 100 == 0:
            print(f"matching progress {i}/{len(quotes)}", file=sys.stderr)
    return [r for r in results
            if r["best"] and r["best"]["ratio"] >= ratio_threshold
            and r["best"]["matchlen"] >= min_matchlen]


def dedup_and_flag(high_conf, tafsir_rows):
    tafsir_by_ayah = {r["ayah_id"]: strip_tashkeel(r["text"]) for r in tafsir_rows}
    seen = set()
    deduped = []
    for d in high_conf:
        b = d["best"]
        if b["book_name"] and b["hadith_number"] is not None:
            key = (d["ayah_id"], b["book_name"], b["hadith_number"])
        else:
            key = (d["ayah_id"], b["text_ar"][:80])
        if key in seen:
            continue
        seen.add(key)
        deduped.append(d)

    for d in deduped:
        full_text = tafsir_by_ayah.get(d["ayah_id"], "")
        idx = full_text.find(d["quote"][:30])
        if idx == -1:
            idx = full_text.find(d["quote"][:15])
        start = max(0, idx - 30) if idx != -1 else 0
        end = min(len(full_text), idx + len(d["quote"]) + 400) if idx != -1 else 0
        wide_context = full_text[start:end]
        flags = [w for w in WARNING_WORDS if w in wide_context]
        if WAH_STANDALONE.search(wide_context):
            flags.append("واهٍ(كلمة مستقلة)")
        d["wide_context"] = wide_context
        d["flags"] = flags
    return deduped


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--after-surah", type=int, required=True)
    ap.add_argument("--after-ayah", type=int, required=True)
    ap.add_argument("--window", type=int, default=900,
                     help="raw consecutive ayahs to scan (not pre-filtered candidates)")
    ap.add_argument("--out", required=True)
    ap.add_argument("--tafsir-cache", default=None,
                     help="reuse a previously fetched tafsir_ibnkathir.json instead of refetching")
    args = ap.parse_args()

    if args.tafsir_cache:
        with open(args.tafsir_cache) as f:
            rows = json.load(f)
    else:
        rows = fetch_tafsir()

    subset, quotes = extract_quotes(rows, args.after_surah, args.after_ayah, args.window)
    print(f"raw ayah window: {subset[0]['ayahs']} .. {subset[-1]['ayahs']} "
          f"({len(subset)} ayahs) -> {len(quotes)} raw quotes", file=sys.stderr)

    high_conf = match_quotes(quotes)
    print(f"high-confidence matches: {len(high_conf)}", file=sys.stderr)

    deduped = dedup_and_flag(high_conf, rows)
    flagged = [d for d in deduped if d["flags"]]
    clean = [d for d in deduped if not d["flags"]]
    print(f"deduped: {len(deduped)} (flagged: {len(flagged)}, clean: {len(clean)})",
          file=sys.stderr)

    report = {
        "window_start": subset[0]["ayahs"],
        "window_end": subset[-1]["ayahs"],
        "raw_ayah_count": len(subset),
        "raw_quote_count": len(quotes),
        "high_conf_count": len(high_conf),
        "candidates": deduped,
    }
    with open(args.out, "w") as f:
        json.dump(report, f, ensure_ascii=False, indent=1)
    print(f"report written to {args.out}", file=sys.stderr)


if __name__ == "__main__":
    main()
