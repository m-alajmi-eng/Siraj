#!/usr/bin/env python3
"""كتابة الدفعة التاسعة (28 اسماً، الطبقة الخامسة عشرة) من تذكرة الحفاظ للذهبي عبر upsert_story_draft بمفتاح anon."""
from __future__ import annotations
import json
import sys
import urllib.error
import urllib.request
import urllib.parse

SUPABASE_URL = "https://pzcnkzsicyxlzqwjznvh.supabase.co"
ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6Y25renNpY3l4bHpxd2p6bnZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIyMDY2NjQsImV4cCI6MjA5Nzc4MjY2NH0.W2z_NZKyc1HD9CifqKvupIVcSrW1MinDAYsfpZ6ewm8"

SCRATCH = "/tmp/claude-1000/-home-user-projects-siraj/5b3301c6-b957-4875-a5a0-f28d2e514459/scratchpad/batch9_tadhkira"
AUTHOR = "الذهبي"
SOURCE_BOOK = "تذكرة الحفاظ"
SRC_URL = "https://ar.wikisource.org/wiki/" + urllib.parse.quote("تذكرة الحفاظ/الطبقة الخامسة عشرة".replace(" ", "_"))

entries = [
    ("00_ابن ماكولا.txt", None),
    ("01_بن خيرون.txt", None),
    ("02_الحسيني.txt", None),
    ("03_هبة الله بن عبد الوارث بن علي.txt", None),
    ("04_مسعود بن ناصر بن أبي زيد عبد الله ب.txt", "مسعود بن ناصر السجزي"),
    ("05_الحميدي.txt", "محمد بن أبي نصر الحميدي"),
    ("06_طاهر النيسابوري.txt", None),
    ("07_بن الخاضب.txt", "ابن الخاضبة"),
    ("08_الحرمي.txt", None),
    ("09_مكي بن عبد السلام بن الحسين.txt", None),
    ("10_السمرقندي.txt", "الحسن بن أحمد السمرقندي"),
    ("11_البرداني.txt", None),
    ("12_عمر بن علي بن أحمد بن الليث بن أحمد.txt", "أبو الفتيان الرواسي"),
    ("13_أبو الفتيان.txt", "أبو مسلم الليثي البخاري"),
    ("14_شجاع بن فارس بن حسين بن فارس بن الح.txt", "شجاع الذهلي"),
    ("15_حمد بن نصر.txt", None),
    ("16_بن منده.txt", "يحيى بن عبد الوهاب بن منده"),
    ("17_محمود بن الفضل بن محمود.txt", None),
    ("18_ابن سكرة.txt", "الحسين بن محمد الصدفي"),
    ("19_الدقاق.txt", "محمد بن عبد الواحد الدقاق"),
    ("20_شيرويه بن شهردار بن شيرويه بن فناخس.txt", "شيرويه بن شهردار الديلمي"),
    ("21_النرسي.txt", None),
    ("22_الحوزي.txt", None),
    ("23_بن الحداد.txt", "عبيد الله بن الحسن الحداد"),
    ("24_السمعاني.txt", "محمد بن أبي المظفر منصور السمعاني"),
    ("25_الغازي.txt", None),
    ("26_الأنماطي.txt", None),
    ("27_أبو سعد بن البغدادي.txt", None),
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
    next_idx = 599
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
