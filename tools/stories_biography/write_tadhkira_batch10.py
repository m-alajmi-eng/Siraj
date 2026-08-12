#!/usr/bin/env python3
"""كتابة الدفعة العاشرة (18 اسماً، الطبقة السادسة عشرة) من تذكرة الحفاظ للذهبي عبر upsert_story_draft بمفتاح anon."""
from __future__ import annotations
import json
import sys
import urllib.error
import urllib.request
import urllib.parse

SUPABASE_URL = "https://pzcnkzsicyxlzqwjznvh.supabase.co"
ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6Y25renNpY3l4bHpxd2p6bnZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIyMDY2NjQsImV4cCI6MjA5Nzc4MjY2NH0.W2z_NZKyc1HD9CifqKvupIVcSrW1MinDAYsfpZ6ewm8"

SCRATCH = "/tmp/claude-1000/-home-user-projects-siraj/5b3301c6-b957-4875-a5a0-f28d2e514459/scratchpad/batch10_tadhkira"
AUTHOR = "الذهبي"
SOURCE_BOOK = "تذكرة الحفاظ"
SRC_URL = "https://ar.wikisource.org/wiki/" + urllib.parse.quote("تذكرة الحفاظ/الطبقة السادسة عشرة".replace(" ", "_"))

entries = [
    ("00_محمد بن ناصر بن محمد بن علي بن عمر.txt", "محمد بن ناصر السلامي"),
    ("01_البطروجي.txt", None),
    ("02_ابن العربي.txt", "القاضي أبو بكر بن العربي"),
    ("03_السلفي.txt", None),
    ("04_عياض.txt", "القاضي عياض"),
    ("05_الرشاطي.txt", None),
    ("05b_الجوزقاني.txt", None),
    ("06_الفامي.txt", None),
    ("07_ابن الدباغ.txt", None),
    ("08_السبحي.txt", None),
    ("09_كوتاه.txt", None),
    ("10_السمعاني.txt", "أبو سعد السمعاني"),
    ("11_معمر بن عبد الواحد.txt", None),
    ("12_أبو الخير.txt", None),
    ("13_أبو العلاء الهمذاني.txt", None),
    ("14_ابن عساكر.txt", None),
    ("15_أبو موسى المديني.txt", None),
    ("16_الزاغولي.txt", None),
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
    next_idx = 627
    results = []
    for fname, title_override in entries:
        content = open(f"{SCRATCH}/{fname}", encoding="utf-8").read().strip()
        derived = fname.replace(".txt", "").split("_", 1)[1]
        person_name = title_override or derived
        order_index = next_idx
        next_idx += 1
        body = {
            "p_id": None,
            "p_category": "ulama",
            "p_title_ar": person_name,
            "p_content_ar": content,
            "p_person_name": person_name,
            "p_order_index": order_index,
            "p_source_book": SOURCE_BOOK,
            "p_author": AUTHOR,
            "p_source_url": SRC_URL,
        }
        try:
            result = supabase_rpc(body)
            new_id = result
            if isinstance(result, list) and len(result) == 1:
                new_id = result[0] if not isinstance(result[0], dict) else next(iter(result[0].values()))
            results.append({
                "person_name": person_name, "order_index": order_index,
                "id": new_id, "content_len": len(content), "error": None, "file": fname,
            })
            print(f"OK id={new_id} idx={order_index} title={person_name} len={len(content)}", file=sys.stderr)
        except urllib.error.HTTPError as e:
            err_body = e.read().decode("utf-8", "replace")
            results.append({
                "person_name": person_name, "order_index": order_index,
                "id": None, "content_len": len(content), "error": f"HTTP {e.code}: {err_body}", "file": fname,
            })
            print(f"FAIL {person_name}: HTTP {e.code}: {err_body}", file=sys.stderr)

    with open(f"{SCRATCH}/write_results.json", "w", encoding="utf-8") as f:
        json.dump(results, f, ensure_ascii=False, indent=2)

    n_ok = sum(1 for r in results if r["error"] is None)
    print(f"\nDONE: {n_ok}/{len(results)} succeeded", file=sys.stderr)


if __name__ == "__main__":
    main()
