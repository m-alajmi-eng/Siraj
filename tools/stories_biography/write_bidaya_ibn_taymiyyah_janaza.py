#!/usr/bin/env python3
"""إضافة رواية جنازة شيخ الإسلام ابن تيمية (شهود عيان، نقلاً عن علم الدين البرزالي، من سنة 728هـ)
كصف تكميلي - بموافقة محمد الصريحة رغم وجود ترجمة سابقة له (id=1287) من مصدر تذكرة الحفاظ،
لاختلاف زاوية النص كلياً (سيرة ذاتية علمية مقابل رواية شهود عيان ليوم الجنازة)."""
from __future__ import annotations
import json
import sys
import urllib.error
import urllib.request
import urllib.parse

SUPABASE_URL = "https://pzcnkzsicyxlzqwjznvh.supabase.co"
ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6Y25renNpY3l4bHpxd2p6bnZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIyMDY2NjQsImV4cCI6MjA5Nzc4MjY2NH0.W2z_NZKyc1HD9CifqKvupIVcSrW1MinDAYsfpZ6ewm8"

CONTENT_FILE = "/tmp/claude-1000/-home-user-projects-siraj/a69de163-8c92-4c1e-a5b0-6caf4012500a/scratchpad/bidaya14/final_ibn_taymiyyah_janaza.txt"
AUTHOR = "ابن كثير"
SOURCE_BOOK = "البداية والنهاية"
PAGE_TITLE = "البداية والنهاية/الجزء الرابع عشر/ثم دخلت سنة ثمان وعشرين وسبعمائة"


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
    content = open(CONTENT_FILE, encoding="utf-8").read().strip()
    src_url = "https://ar.wikisource.org/wiki/" + urllib.parse.quote(PAGE_TITLE.replace(" ", "_"))
    body = {
        "p_id": None,
        "p_category": "ulama",
        "p_title_ar": "ابن تيمية - رواية جنازته (نقلاً عن علم الدين البرزالي)",
        "p_content_ar": content,
        "p_person_name": "ابن تيمية",
        "p_order_index": 851,
        "p_source_book": SOURCE_BOOK,
        "p_author": AUTHOR,
        "p_source_url": src_url,
    }
    try:
        result = supabase_rpc(body)
        new_id = result
        if isinstance(result, list) and len(result) == 1:
            new_id = result[0] if not isinstance(result[0], dict) else next(iter(result[0].values()))
        print(f"OK id={new_id} idx=851 len={len(content)}", file=sys.stderr)
    except urllib.error.HTTPError as e:
        err_body = e.read().decode("utf-8", "replace")
        print(f"FAIL: HTTP {e.code}: {err_body}", file=sys.stderr)


if __name__ == "__main__":
    main()
