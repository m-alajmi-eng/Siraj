#!/usr/bin/env python3
"""كتابة الدفعة الأولى (20 اسماً، طبقات 1-7) من تذكرة الحفاظ للذهبي عبر upsert_story_draft بمفتاح anon."""
from __future__ import annotations
import json
import sys
import urllib.error
import urllib.request
import urllib.parse

SUPABASE_URL = "https://pzcnkzsicyxlzqwjznvh.supabase.co"
ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6Y25renNpY3l4bHpxd2p6bnZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIyMDY2NjQsImV4cCI6MjA5Nzc4MjY2NH0.W2z_NZKyc1HD9CifqKvupIVcSrW1MinDAYsfpZ6ewm8"

SCRATCH = "/tmp/claude-1000/-home-user-projects-siraj/5b3301c6-b957-4875-a5a0-f28d2e514459/scratchpad/batch1_tadhkira"
AUTHOR = "الذهبي"
SOURCE_BOOK = "تذكرة الحفاظ"

def src_url(tabaqa):
    title = f"تذكرة الحفاظ/{tabaqa}"
    return "https://ar.wikisource.org/wiki/" + urllib.parse.quote(title.replace(" ", "_"))

# (filename, category, tabaqa)
entries = [
    ("00_أبو ذر الغفاري.txt", "companions", "الطبقة الأولى"),
    ("01_أبو الدرداء.txt", "companions", "الطبقة الأولى"),
    ("02_عبد الله بن سلام بن الحارث.txt", "companions", "الطبقة الأولى"),
    ("03_أبو هريرة.txt", "companions", "الطبقة الأولى"),
    ("04_عبد الله بن عباس بن عبد المطلب.txt", "companions", "الطبقة الأولى"),
    ("05_أنس بن مالك بن النضر بن ضمضم.txt", "companions", "الطبقة الأولى"),
    ("06_أبو قلابة.txt", "tabieen", "الطبقة الثالثة"),
    ("07_أبو رجاء العطاردي.txt", "tabieen", "الطبقة الثانية"),
    ("08_ابن جريج.txt", "ulama", "الطبقة الخامسة"),
    ("09_شيبان بن عبد الرحمن.txt", "ulama", "الطبقة الخامسة"),
    ("10_أبو معشر.txt", "ulama", "الطبقة الخامسة"),
    ("11_أبو عوانة.txt", "ulama", "الطبقة الخامسة"),
    ("12_بكر بن مضر.txt", "ulama", "الطبقة الخامسة"),
    ("13_حميد الطويل.txt", "tabieen", "الطبقة الرابعة"),
    ("14_أبو الوليد الطيالسي.txt", "ulama", "الطبقة السابعة"),
    ("15_ابن الطباع.txt", "ulama", "الطبقة السابعة"),
    ("16_الهقل بن زياد.txt", "ulama", "الطبقة السادسة"),
    ("17_الهيثم بن حميد.txt", "ulama", "الطبقة السادسة"),
    ("18_السيناني.txt", "ulama", "الطبقة السادسة"),
    ("20_النضر بن شميل.txt", "ulama", "الطبقة السادسة"),
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
    next_idx = {"companions": 252, "tabieen": 212, "ulama": 315}
    results = []
    for fname, category, tabaqa in entries:
        content = open(f"{SCRATCH}/{fname}", encoding="utf-8").read().strip()
        person_name = fname.split("_", 1)[1].replace(".txt", "")
        order_index = next_idx[category]
        next_idx[category] += 1
        body = {
            "p_id": None,
            "p_category": category,
            "p_title_ar": person_name,
            "p_content_ar": content,
            "p_person_name": person_name,
            "p_order_index": order_index,
            "p_source_book": SOURCE_BOOK,
            "p_author": AUTHOR,
            "p_source_url": src_url(tabaqa),
        }
        try:
            result = supabase_rpc(body)
            new_id = result
            if isinstance(result, list) and len(result) == 1:
                new_id = result[0] if not isinstance(result[0], dict) else next(iter(result[0].values()))
            results.append({
                "person_name": person_name, "category": category, "tabaqa": tabaqa,
                "order_index": order_index, "id": new_id, "content_len": len(content), "error": None,
            })
            print(f"OK id={new_id} cat={category} idx={order_index} title={person_name} len={len(content)}", file=sys.stderr)
        except urllib.error.HTTPError as e:
            err_body = e.read().decode("utf-8", "replace")
            results.append({
                "person_name": person_name, "category": category, "tabaqa": tabaqa,
                "order_index": order_index, "id": None, "content_len": len(content),
                "error": f"HTTP {e.code}: {err_body}",
            })
            print(f"FAIL {person_name}: HTTP {e.code}: {err_body}", file=sys.stderr)

    with open(f"{SCRATCH}/write_results.json", "w", encoding="utf-8") as f:
        json.dump(results, f, ensure_ascii=False, indent=2)

    n_ok = sum(1 for r in results if r["error"] is None)
    print(f"\nDONE: {n_ok}/{len(results)} succeeded", file=sys.stderr)


if __name__ == "__main__":
    main()
