#!/usr/bin/env python3
"""كتابة الدفعة الحادية والثلاثين (ستة أسماء، سنوات 698-712هـ، أول دفعة من الجزء 14) من البداية والنهاية لابن كثير عبر upsert_story_draft بمفتاح anon."""
from __future__ import annotations
import json
import sys
import urllib.error
import urllib.request
import urllib.parse

SUPABASE_URL = "https://pzcnkzsicyxlzqwjznvh.supabase.co"
ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6Y25renNpY3l4bHpxd2p6bnZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIyMDY2NjQsImV4cCI6MjA5Nzc4MjY2NH0.W2z_NZKyc1HD9CifqKvupIVcSrW1MinDAYsfpZ6ewm8"

SCRATCH = "/tmp/claude-1000/-home-user-projects-siraj/5b3301c6-b957-4875-a5a0-f28d2e514459/scratchpad/bidaya_wa_nihaya/batch31"
AUTHOR = "ابن كثير"
SOURCE_BOOK = "البداية والنهاية"

entries = [
    ("00_جمال_الدين_البلخي_المفسر.txt", "جمال الدين البلخي المفسر", "البداية والنهاية/الجزء الرابع عشر/ثم دخلت سنة ثمان وتسعين وستمائة"),
    ("01_زين_الدين_الفارقي.txt", "زين الدين الفارقي", "البداية والنهاية/الجزء الرابع عشر/ثم دخلت سنة ثلاث وسبعمائة"),
    ("02_فتح_الدين_ابن_القيسراني.txt", "فتح الدين ابن القيسراني", "البداية والنهاية/الجزء الرابع عشر/ثم دخلت سنة ثلاث وسبعمائة"),
    ("03_شرف_الدين_الفزاري.txt", "شرف الدين الفزاري", "البداية والنهاية/الجزء الرابع عشر/ثم دخلت سنة خمس وسبعمائة"),
    ("04_قاضي_القضاة_السروجي.txt", "قاضي القضاة شمس الدين السروجي", "البداية والنهاية/الجزء الرابع عشر/ثم دخلت سنة عشر وسبعمائة"),
    ("05_ابن_الرفعة.txt", "ابن الرفعة شارح التنبيه", "البداية والنهاية/الجزء الرابع عشر/ثم دخلت سنة عشر وسبعمائة"),
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
    next_idx = 827
    results = []
    for fname, person_name, page_title in entries:
        content = open(f"{SCRATCH}/{fname}", encoding="utf-8").read().strip()
        order_index = next_idx
        next_idx += 1
        src_url = "https://ar.wikisource.org/wiki/" + urllib.parse.quote(page_title.replace(" ", "_"))
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
