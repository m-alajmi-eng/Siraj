#!/usr/bin/env python3
"""كتابة الدفعة الثالثة (42 اسماً، الطبقة التاسعة) من تذكرة الحفاظ للذهبي عبر upsert_story_draft بمفتاح anon."""
from __future__ import annotations
import json
import sys
import urllib.error
import urllib.request
import urllib.parse

SUPABASE_URL = "https://pzcnkzsicyxlzqwjznvh.supabase.co"
ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6Y25renNpY3l4bHpxd2p6bnZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIyMDY2NjQsImV4cCI6MjA5Nzc4MjY2NH0.W2z_NZKyc1HD9CifqKvupIVcSrW1MinDAYsfpZ6ewm8"

SCRATCH = "/tmp/claude-1000/-home-user-projects-siraj/5b3301c6-b957-4875-a5a0-f28d2e514459/scratchpad/batch3_tadhkira"
AUTHOR = "الذهبي"
SOURCE_BOOK = "تذكرة الحفاظ"
SRC_URL = "https://ar.wikisource.org/wiki/" + urllib.parse.quote("تذكرة الحفاظ/الطبقة التاسعة".replace(" ", "_"))

# (filename, title override or None to derive from filename)
entries = [
    ("00_الذهلي.txt", None),
    ("01_محمد بن أسلم بن سالم بن يزيد.txt", None),
    ("01b_عبد بن حميد.txt", None),
    ("02_الدارمي.txt", "الدارمي (عبد الله بن عبد الرحمن)"),
    ("03_عبد الملك بن حبيب.txt", None),
    ("04_علي بن نصر بن علي بن نصر بن علي بن .txt", "علي بن نصر بن علي الجهضمي"),
    ("05_رجاء بن مرجى.txt", None),
    ("06_سلمة بن شبيب.txt", None),
    ("07_أحمد بن الفرات.txt", None),
    ("08_أحمد بن الأزهر بن منيع بن سليط.txt", "أحمد بن الأزهر"),
    ("09_أحمد بن سعيد بن صخر.txt", "أحمد بن سعيد الدارمي السرخسي"),
    ("10_حجاج بن الشاعر.txt", None),
    ("11_صاعقة.txt", None),
    ("12_الرخامي.txt", None),
    ("13_ابن البرقي.txt", None),
    ("14_الأثرم.txt", None),
    ("15_الصاغائي.txt", None),
    ("16_ابن وارة.txt", None),
    ("17_يعقوب بن شيبة بن الصلت بن عصفور.txt", "يعقوب بن شيبة"),
    ("18_محمد بن سنجر.txt", None),
    ("19_أبو قلابة.txt", "أبو قلابة الرقاشي"),
    ("20_محمد بن عوف بن سفيان.txt", "محمد بن عوف الطائي"),
    ("21_الفسوي.txt", None),
    ("22_مسلم بن الحجاج.txt", None),
    ("23_حمدان.txt", None),
    ("24_ابن أبي غرزة.txt", None),
    ("25_أحمد بن أبي خيثمة زهير بن حرب.txt", "أحمد بن أبي خيثمة"),
    ("26_البرتي.txt", None),
    ("27_أحمد بن مهدي بن رستم.txt", None),
    ("28_أبو أحمد الفراء.txt", None),
    ("29_فضلك الصائغ.txt", None),
    ("30_الطرسوسي.txt", None),
    ("31_الديرعاقولي.txt", None),
    ("32_أبو الأحوص.txt", "أبو الأحوص محمد بن الهيثم"),
    ("33_أبو معين.txt", None),
    ("34_كيلجة.txt", None),
    ("35_هلال بن العلاء بن هلال بن عمر بن بل.txt", "هلال بن العلاء الباهلي"),
    ("36_حيكان.txt", None),
    ("37_الكديمي.txt", None),
    ("38_الحارث بن محمد بن أبي أسامة.txt", "الحارث بن أبي أسامة"),
    ("39_الدارمي.txt", "الدارمي (عثمان بن سعيد)"),
    ("40_علي بن عبد العزيز بن المرزبان بن سا.txt", "علي بن عبد العزيز البغوي"),
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
    next_idx = 369
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
