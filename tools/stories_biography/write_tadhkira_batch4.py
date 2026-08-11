#!/usr/bin/env python3
"""كتابة الدفعة الرابعة (55 اسماً، الطبقة العاشرة) من تذكرة الحفاظ للذهبي عبر upsert_story_draft بمفتاح anon."""
from __future__ import annotations
import json
import sys
import urllib.error
import urllib.request
import urllib.parse

SUPABASE_URL = "https://pzcnkzsicyxlzqwjznvh.supabase.co"
ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6Y25renNpY3l4bHpxd2p6bnZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIyMDY2NjQsImV4cCI6MjA5Nzc4MjY2NH0.W2z_NZKyc1HD9CifqKvupIVcSrW1MinDAYsfpZ6ewm8"

SCRATCH = "/tmp/claude-1000/-home-user-projects-siraj/5b3301c6-b957-4875-a5a0-f28d2e514459/scratchpad/batch4_tadhkira"
AUTHOR = "الذهبي"
SOURCE_BOOK = "تذكرة الحفاظ"
SRC_URL = "https://ar.wikisource.org/wiki/" + urllib.parse.quote("تذكرة الحفاظ/الطبقة العاشرة".replace(" ", "_"))

entries = [
    ("00_الترمذي.txt", None),
    ("01_ابن ماجة.txt", None),
    ("02_أحمد بن سلمة.txt", None),
    ("03_الأبار.txt", None),
    ("04_ابن أبي عاصم.txt", None),
    ("05_جزرة.txt", None),
    ("06_أحمد بن النضر بن عبد الوهاب.txt", None),
    ("07_محمد بن وضاح بن بزيع.txt", "محمد بن وضاح القرطبي"),
    ("08_قاسم بن محمد بن قاسم بن محمد بن سيا.txt", "قاسم بن محمد بن سيار"),
    ("08b_الخشني.txt", None),
    ("09_زكريا بن يحيى بن إياس السجزي.txt", "زكريا بن يحيى السجزي"),
    ("10_محمد بن نصر.txt", "محمد بن نصر المروزي"),
    ("11_البزار.txt", None),
    ("12_عبد الله بن أبي الخوارزمي.txt", "عبد الله بن أبي الخوارزمي"),
    ("13_محمد بن عثمان بن أبي شيبة.txt", None),
    ("14_المروزي.txt", "أحمد بن علي المروزي"),
    ("15_بحشل.txt", None),
    ("16_عبد الله بن أحمد بن محمد بن حنبل.txt", "عبد الله بن أحمد بن حنبل"),
    ("17_المعمري.txt", None),
    ("18_أبو بكر الجارودي.txt", None),
    ("19_نصرك.txt", None),
    ("20_ابن أبي الدنيا.txt", None),
    ("21_القباني.txt", None),
    ("22_عبد الله بن محمد بن علي.txt", "عبد الله بن محمد البلخي"),
    ("23_أبو سعد الهروي.txt", None),
    ("24_الفريابي.txt", None),
    ("25_ابن ناجية.txt", None),
    ("26_السامي.txt", None),
    ("27_النسائي.txt", None),
    ("28_الحصيري.txt", None),
    ("29_الحسن بن سفيان بن عامر.txt", "الحسن بن سفيان"),
    ("30_ابن شيرويه.txt", None),
    ("31_أبو يعلى الموصلي.txt", None),
    ("32_الساجي.txt", None),
    ("33_الطبري.txt", "ابن جرير الطبري"),
    ("34_الفرهياني.txt", None),
    ("35_المطرز.txt", None),
    ("36_السعدي.txt", None),
    ("37_البجيري.txt", None),
    ("38_ابن خزيمة.txt", None),
    ("39_البغوي.txt", "عبد الله بن محمد البغوي"),
    ("40_محمد بن أبي بكر أحمد بن أبي خيثمة ز.txt", "محمد بن أحمد بن أبي خيثمة"),
    ("41_البرذعي.txt", None),
    ("42_البرديجي.txt", None),
    ("43_ابن الأخرم.txt", "ابن الأخرم الأصبهاني"),
    ("44_علي بن سعيد بن بشير بن مهران.txt", "علي بن سعيد الرازي"),
    ("45_جعفرك.txt", None),
    ("46_الروياني.txt", None),
    ("47_علي بن سراج.txt", None),
    ("48_الحيري.txt", None),
    ("49_ابن قتيبة.txt", "ابن قتيبة العسقلاني"),
    ("50_أبو قريش.txt", None),
    ("51_عبدوس بن أحمد بن عباد الثقفي الهمذا.txt", "عبدوس بن أحمد الهمذاني"),
    ("52_أبو عروبة.txt", None),
    ("53_يحيى بن محمد بن صاعد بن كاتب.txt", "ابن صاعد"),
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
    next_idx = 411
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
