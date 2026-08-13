#!/usr/bin/env python3
"""كتابة الدفعة الثلاثين من لسان الميزان لابن حجر العسقلاني (6 أسماء من الجزء الأول)
عبر upsert_story_draft بمفتاح anon. is_published=false."""
from __future__ import annotations
import json
import sys
import urllib.error
import urllib.request
import urllib.parse

SUPABASE_URL = "https://pzcnkzsicyxlzqwjznvh.supabase.co"
ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6Y25renNpY3l4bHpxd2p6bnZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIyMDY2NjQsImV4cCI6MjA5Nzc4MjY2NH0.W2z_NZKyc1HD9CifqKvupIVcSrW1MinDAYsfpZ6ewm8"

SCRATCH = "/tmp/claude-1000/-home-user-projects-siraj/ea146cfc-9eff-42e4-8dd6-150828943957/scratchpad/lisan_mizan/batch30"
AUTHOR = "ابن حجر العسقلاني"
SOURCE_BOOK = "لسان الميزان"
PAGE_TITLE = "لسان الميزان/الجزء الأول"

entries = [
    ("ahmad_muhammad_umar_munkadiri.txt", "أحمد بن محمد بن عمر أبو بكر المنكدري الخراساني"),
    ("idris_jafar_attar.txt", "إدريس بن جعفر العطار"),
    ("ahmad_muhammad_bakr_hazzani.txt", "أحمد بن محمد بن بكر أبو روق الهزاني"),
    ("aws_abdullah_buraida.txt", "أوس بن عبد الله بن بريدة المروزي"),
    ("ahmad_muhammad_isa_sakuni.txt", "أحمد بن محمد بن عيسى السكوني"),
    ("ahnaf_hakim_asbahani.txt", "الأحنف بن حكيم بن عمران الأصبهاني"),
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
    next_idx = 1030
    results = []
    src_url = "https://ar.wikisource.org/wiki/" + urllib.parse.quote(PAGE_TITLE.replace(" ", "_"))
    for fname, person_name in entries:
        content = open(f"{SCRATCH}/{fname}", encoding="utf-8").read().strip()
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
            "p_source_url": src_url,
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
