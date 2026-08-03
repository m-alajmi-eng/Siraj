#!/usr/bin/env python3
"""Backfill لمرة واحدة: فصل بيانات الاستشهاد عن content_ar للصفوف العشرة
الأولى من دفعة الصحابة (ids 34-43، العشرة المبشرون بالجنة) بعد مهجرة
20260803200313_add_story_source_columns.sql.

يعتمد على tools/stories_biography/drafts/companions/*.json كمصدر الحقيقة
لأن حقل "content" هناك هو بالضبط النص الحرفي قبل إلحاق سطر الاستشهاد
(تم التحقق برمجياً أن drafts.content + السطر الملحق == ready.content_ar
المحفوظ فعلياً في القاعدة، لكل الصفوف العشرة - راجع نقاش الجلسة).

مصفوفة ID_MAP ثابتة يدوياً (نتيجة عمليات upsert_story_draft السابقة في
نفس الجلسة) - لا اكتشاف تلقائي، لأن anon لا يقدر يقرأ صفوف is_published
=false أصلاً (RLS)، فلا طريقة "لاكتشاف" الصفوف المطلوب تحديثها من القاعدة
نفسها.

الاستخدام:
    export SUPABASE_URL=... SUPABASE_ANON_KEY=...
    python3 backfill_source_columns.py            # عرض فقط (dry-run)
    python3 backfill_source_columns.py --apply     # تنفيذ فعلي
"""

from __future__ import annotations

import argparse
import json
import os
import urllib.error
import urllib.request
from pathlib import Path

DRAFTS_DIR = Path(__file__).parent / "drafts" / "companions"

ID_MAP = {
    1: 34,   # أبو بكر الصديق
    2: 35,   # عمر بن الخطاب
    3: 36,   # عثمان بن عفان
    4: 37,   # علي بن أبي طالب
    5: 38,   # طلحة بن عبيد الله
    6: 39,   # الزبير بن العوام
    7: 40,   # عبد الرحمن بن عوف
    8: 41,   # سعد بن أبي وقاص
    9: 42,   # سعيد بن زيد
    10: 43,  # أبو عبيدة بن الجراح
}


def _rpc(supabase_url: str, anon_key: str, body: dict) -> object:
    url = f"{supabase_url.rstrip('/')}/rest/v1/rpc/upsert_story_draft"
    req = urllib.request.Request(
        url,
        data=json.dumps(body).encode("utf-8"),
        method="POST",
        headers={
            "apikey": anon_key,
            "Authorization": f"Bearer {anon_key}",
            "Content-Type": "application/json",
        },
    )
    try:
        with urllib.request.urlopen(req) as resp:
            raw = resp.read()
            return json.loads(raw) if raw else None
    except urllib.error.HTTPError as e:
        raise SystemExit(f"فشل RPC: HTTP {e.code} - {e.read().decode('utf-8', 'replace')}")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--apply", action="store_true", help="تنفيذ فعلي - بدونه عرض فقط (dry-run)")
    args = parser.parse_args()

    draft_files = sorted(DRAFTS_DIR.glob("*.json"))
    if len(draft_files) != len(ID_MAP):
        raise SystemExit(f"عدد ملفات drafts ({len(draft_files)}) لا يطابق ID_MAP ({len(ID_MAP)})")

    rows = []
    for path in draft_files:
        order_index = int(path.name.split("_", 1)[0])
        story_id = ID_MAP[order_index]
        data = json.loads(path.read_text(encoding="utf-8"))
        rows.append((story_id, order_index, path.name, data))

    print("─" * 70)
    for story_id, order_index, fname, data in sorted(rows):
        print(f"id={story_id} (order_index={order_index}) <- {fname}")
        print(f"  source_book: {data['source_book']}")
        print(f"  author:      {data['author']}")
        print(f"  source_url:  {data['source_url']}")
        print(f"  content_ar الجديد ({len(data['content'])} حرف) يبدأ بـ:")
        print(f"    {data['content'][:120]}...")
        print(f"  content_ar الجديد ينتهي بـ:")
        print(f"    ...{data['content'][-120:]}")
        print("─" * 70)

    if not args.apply:
        print("dry-run فقط - لم يُنفَّذ أي تحديث. أعد التشغيل مع --apply للتنفيذ الفعلي.")
        return

    supabase_url = os.environ.get("SUPABASE_URL")
    anon_key = os.environ.get("SUPABASE_ANON_KEY")
    if not supabase_url or not anon_key:
        raise SystemExit("لازم SUPABASE_URL وSUPABASE_ANON_KEY في البيئة.")

    for story_id, order_index, fname, data in sorted(rows):
        body = {
            "p_id": story_id,
            "p_content_ar": data["content"],
            "p_source_book": data["source_book"],
            "p_author": data["author"],
            "p_source_volume": data.get("volume"),
            "p_source_page": data.get("page"),
            "p_source_url": data["source_url"],
        }
        result = _rpc(supabase_url, anon_key, body)
        print(f"id={story_id}: تم التحديث، الرد: {result}")

    print("انتهى Backfill لجميع الصفوف العشرة.")


if __name__ == "__main__":
    main()
