#!/usr/bin/env python3
"""كتابة السبعة الجديدة من تقدمة الجرح والتعديل (ابن أبي حاتم الرازي) عبر upsert_story_draft بمفتاح anon فقط."""
from __future__ import annotations
import json
import sys
import urllib.error
import urllib.request
import urllib.parse

SUPABASE_URL = "https://pzcnkzsicyxlzqwjznvh.supabase.co"
ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6Y25renNpY3l4bHpxd2p6bnZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIyMDY2NjQsImV4cCI6MjA5Nzc4MjY2NH0.W2z_NZKyc1HD9CifqKvupIVcSrW1MinDAYsfpZ6ewm8"

SCRATCH = "/tmp/claude-1000/-home-user-projects-siraj/5b3301c6-b957-4875-a5a0-f28d2e514459/scratchpad"

SOURCE_URL = "https://ar.wikisource.org/wiki/" + urllib.parse.quote("الجرح والتعديل")
AUTHOR = "ابن أبي حاتم الرازي"
SOURCE_BOOK = "الجرح والتعديل (تقدمة المعرفة)"

entries = [
    ("seg_fizari.txt", "أبو إسحاق الفزاري"),
    ("seg_abumushir.txt", "أبو مسهر الدمشقي"),
    ("seg_yahya_main.txt", "يحيى بن معين"),
    ("seg_ali_madini.txt", "علي بن المديني"),
    ("seg_ibn_numayr.txt", "محمد بن عبد الله بن نمير"),
    ("seg_abu_zuraa.txt", "أبو زرعة الرازي"),
    ("seg_abu_hatim.txt", "أبو حاتم الرازي"),
]


def supabase_rpc(body):
    url = f"{SUPABASE_URL}/rest/v1/rpc/upsert_story_draft"
    data = json.dumps(body).encode("utf-8")
    req = urllib.request.Request(
        url, data=data, method="POST",
        headers={
            "apikey": ANON_KEY,
            "Authorization": f"Bearer {ANON_KEY}",
            "Content-Type": "application/json",
            "Prefer": "return=representation",
        },
    )
    with urllib.request.urlopen(req) as resp:
        raw = resp.read()
        return json.loads(raw) if raw else None


def main():
    next_ulama = 308
    results = []
    for fname, person_name in entries:
        content = open(f"{SCRATCH}/{fname}", encoding="utf-8").read().strip()
        order_index = next_ulama
        next_ulama += 1
        body = {
            "p_id": None,
            "p_category": "ulama",
            "p_title_ar": person_name,
            "p_content_ar": content,
            "p_person_name": person_name,
            "p_order_index": order_index,
            "p_source_book": SOURCE_BOOK,
            "p_author": AUTHOR,
            "p_source_url": SOURCE_URL,
        }
        try:
            result = supabase_rpc(body)
            new_id = result
            if isinstance(result, list) and len(result) == 1:
                new_id = result[0] if not isinstance(result[0], dict) else next(iter(result[0].values()))
            results.append({
                "person_name": person_name,
                "order_index": order_index,
                "id": new_id,
                "content_len": len(content),
                "error": None,
            })
            print(f"OK id={new_id} idx={order_index} title={person_name} len={len(content)}", file=sys.stderr)
        except urllib.error.HTTPError as e:
            err_body = e.read().decode("utf-8", "replace")
            results.append({
                "person_name": person_name,
                "order_index": order_index,
                "id": None,
                "content_len": len(content),
                "error": f"HTTP {e.code}: {err_body}",
            })
            print(f"FAIL {person_name}: HTTP {e.code}: {err_body}", file=sys.stderr)

    with open(f"{SCRATCH}/jarh_tadeel_write_results.json", "w", encoding="utf-8") as f:
        json.dump(results, f, ensure_ascii=False, indent=2)

    n_ok = sum(1 for r in results if r["error"] is None)
    print(f"\nDONE: {n_ok}/{len(results)} succeeded", file=sys.stderr)


if __name__ == "__main__":
    main()
