#!/usr/bin/env python3
"""إصلاح تلوث id=1477 (أسلم الكوفي) بعنوان قسم فرعي زائد التصق بنهاية النص
("من اسمه إسماعيل") بسبب خلل في المحلل الآلي المستخدم بالدفعة التاسعة.
يمرر كل الحقول الأصلية كاملة مع p_id لتفادي أي تصفير جزئي."""
from __future__ import annotations
import json
import urllib.request

SUPABASE_URL = "https://pzcnkzsicyxlzqwjznvh.supabase.co"
ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6Y25renNpY3l4bHpxd2p6bnZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIyMDY2NjQsImV4cCI6MjA5Nzc4MjY2NH0.W2z_NZKyc1HD9CifqKvupIVcSrW1MinDAYsfpZ6ewm8"

with open("/tmp/claude-1000/-home-user-projects-siraj/ea146cfc-9eff-42e4-8dd6-150828943957/scratchpad/lisan_mizan/row_1477_before.json", encoding="utf-8") as f:
    row = json.load(f)[0]

content = row["content_ar"]
suffix = "\n\nمن اسمه إسماعيل"
assert content.endswith(suffix), "unexpected content tail, aborting"
cleaned = content[: -len(suffix)]

body = {
    "p_id": 1477,
    "p_category": row["category"],
    "p_title_ar": row["title_ar"],
    "p_content_ar": cleaned,
    "p_person_name": row["person_name"],
    "p_order_index": row["order_index"],
    "p_source_book": row["source_book"],
    "p_author": row["author"],
    "p_source_url": row["source_url"],
}

req = urllib.request.Request(
    f"{SUPABASE_URL}/rest/v1/rpc/upsert_story_draft",
    data=json.dumps(body).encode("utf-8"),
    method="POST",
    headers={
        "apikey": ANON_KEY,
        "Authorization": f"Bearer {ANON_KEY}",
        "Content-Type": "application/json",
        "Prefer": "return=representation",
    },
)
with urllib.request.urlopen(req) as resp:
    print(resp.read().decode())

print("old len:", len(content), "new len:", len(cleaned))
