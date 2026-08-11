#!/usr/bin/env python3
"""كتابة الدفعة السابعة (42 اسماً، الطبقة الثالثة عشرة) من تذكرة الحفاظ للذهبي عبر upsert_story_draft بمفتاح anon."""
from __future__ import annotations
import json
import sys
import urllib.error
import urllib.request
import urllib.parse

SUPABASE_URL = "https://pzcnkzsicyxlzqwjznvh.supabase.co"
ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6Y25renNpY3l4bHpxd2p6bnZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIyMDY2NjQsImV4cCI6MjA5Nzc4MjY2NH0.W2z_NZKyc1HD9CifqKvupIVcSrW1MinDAYsfpZ6ewm8"

SCRATCH = "/tmp/claude-1000/-home-user-projects-siraj/5b3301c6-b957-4875-a5a0-f28d2e514459/scratchpad/batch7_tadhkira"
AUTHOR = "الذهبي"
SOURCE_BOOK = "تذكرة الحفاظ"
SRC_URL = "https://ar.wikisource.org/wiki/" + urllib.parse.quote("تذكرة الحفاظ/الطبقة الثالثة عشرة".replace(" ", "_"))

entries = [
    ("00_أبو زرعة الكشي.txt", None),
    ("01_ابن الباجي.txt", "عبد الله بن محمد الباجي"),
    ("02_ابن أبي ذهل.txt", None),
    ("03_ابن مفرج.txt", None),
    ("04_أحمد بن منصور بن ثابت.txt", None),
    ("05_المعافى بن زكريا بن يحيى بن حميد.txt", "المعافى بن زكريا"),
    ("06_الرقي.txt", None),
    ("07_ابن الفرات.txt", "ابن الفرات البغدادي"),
    ("08_الطوسي.txt", "نصر بن محمد الطوسي"),
    ("09_ابن حنزابة.txt", None),
    ("10_خلف بن القاسم بن سهل.txt", "خلف بن القاسم"),
    ("11_الكلاباذي.txt", None),
    ("12_البصير.txt", None),
    ("13_ابن منده.txt", None),
    ("14_الشيرازي.txt", "الحسن بن أحمد الشيرازي"),
    ("15_الحاكم.txt", None),
    ("16_عبد الغني بن سعيد بن علي بن سعيد بن.txt", "عبد الغني بن سعيد الأزدي"),
    ("17_ابن أبي الفوارس.txt", None),
    ("18_الجارودي.txt", None),
    ("19_تمام.txt", "تمام الرازي"),
    ("20_ابن الباجي.txt", "أحمد بن عبد الله الباجي"),
    ("21_النقاش.txt", "النقاش الأصبهاني"),
    ("22_ابن فطيس.txt", "عبد الرحمن بن فطيس"),
    ("23_الأسفراييني.txt", None),
    ("24_الشيرازي.txt", "أحمد بن عبد الرحمن الشيرازي"),
    ("25_خلف بن محمد بن علي بن حمدون الواسطي.txt", "خلف بن محمد الواسطي"),
    ("25b_أبو مسعود الدمشقي.txt", None),
    ("26_الماليني.txt", None),
    ("27_ابن الفرضي.txt", None),
    ("28_القابسي.txt", None),
    ("29_الوليد بن بكر بن مخلد.txt", "الوليد بن بكر"),
    ("30_البحيري.txt", None),
    ("31_عطية بن سعيد.txt", None),
    ("32_أبو نعيم.txt", None),
    ("33_الطلمنكي.txt", None),
    ("33b_القراب.txt", None),
    ("34_المستغفري.txt", None),
    ("35_أبو ذر الهروي.txt", None),
    ("36_الربعي.txt", None),
    ("37_الخلال.txt", None),
    ("38_ابن حمدان.txt", None),
    ("39_النعيمي.txt", None),
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
    next_idx = 541
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
