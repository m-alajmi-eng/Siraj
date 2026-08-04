#!/usr/bin/env python3
"""يربط صفوف stories الموجودة بمجموعاتها المصدرية (group_slug) عبر
set_story_group، اعتماداً على حقل "intended_group" المُضاف محلياً في
ملفات tools/stories_biography/ready/**/*.json وقائمة يدوية لـids
الدفعات الأقدم (34-100) التي سبقت وجود هذا الحقل.

**لا تُشغِّل هذا قبل أن تُنفَّذ مهجرة 20260804013313_add_story_groups.sql
فعلياً على المشروع البعيد (db push) - راجع NEEDS_REVIEW.md أولاً.**

الاستخدام:
    export SUPABASE_URL=... SUPABASE_ANON_KEY=...
    python3 link_groups.py --apply     # تنفيذ فعلي، بدونه dry-run فقط
"""
from __future__ import annotations

import argparse
import json
import os
import urllib.error
import urllib.request
from pathlib import Path

# دفعات سابقة سبقت وجود حقل intended_group في ملفات JSON - ربط يدوي
# صريح هنا بدل تخمين آلي لاحق.
LEGACY_ID_GROUPS: dict[int, str] = {
    # 34-43: العشرة المبشرون بالجنة - كلهم شهدوا بدراً فعلياً (مؤكَّد
    # في badr_roster_source.txt) فينتمون لمجموعة badr أيضاً، رغم أن
    # الدفعة نفسها اختيرت بمعيار "العشرة" لا "بدر".
    **{i: "badr" for i in range(34, 44)},
    # 44-54: أمهات المؤمنين - لسن من "أهل بدر" (نساء)، لا مجموعة معركة
    # لهن حالياً في story_groups - تُترَك NULL عمداً.
    # 55-64: كتّاب الوحي - أبي بن كعب (56) والأرقم بن أبي الأرقم (64)
    # شهدا بدراً فعلياً (مؤكَّد سابقاً)؛ البقية لم يشهدوا بدراً.
    56: "badr",
    64: "badr",
    # 65-100: دفعتا "أهل بدر" الصريحتان - كلها badr.
    **{i: "badr" for i in range(65, 101)},
}


def _rpc(supabase_url: str, anon_key: str, body: dict) -> object:
    url = f"{supabase_url.rstrip('/')}/rest/v1/rpc/set_story_group"
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


def collect_from_ready_dir(ready_dir: Path) -> dict[int, str]:
    """يقرأ id/intended_group من ملفات ready المحفوظة إن وُجد سجل
    تعقّب id->ملف (upsert_story.py لا يكتب id الناتج داخل الملف نفسه -
    هذا يعتمد على أن الاستدعاء الفعلي أضاف id يدوياً لاحقاً في نسخة
    مؤرشفة، أو يُستخدَم فقط لدفعات مستقبلية تُدرِج id بعد الحفظ)."""
    mapping: dict[int, str] = {}
    for path in ready_dir.rglob("*.json"):
        data = json.loads(path.read_text(encoding="utf-8"))
        story_id = data.get("saved_id")
        group = data.get("intended_group")
        if story_id and group:
            mapping[int(story_id)] = group
    return mapping


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--apply", action="store_true")
    args = parser.parse_args()

    ready_dir = Path(__file__).parent / "ready"
    mapping = dict(LEGACY_ID_GROUPS)
    mapping.update(collect_from_ready_dir(ready_dir))

    print(f"إجمالي الربط المُجهَّز: {len(mapping)} صفاً")
    for story_id, group in sorted(mapping.items()):
        print(f"  id={story_id} -> {group}")

    if not args.apply:
        print("\ndry-run فقط - أعد التشغيل مع --apply للتنفيذ الفعلي.")
        return

    supabase_url = os.environ.get("SUPABASE_URL")
    anon_key = os.environ.get("SUPABASE_ANON_KEY")
    if not supabase_url or not anon_key:
        raise SystemExit("لازم SUPABASE_URL وSUPABASE_ANON_KEY في البيئة.")

    for story_id, group in sorted(mapping.items()):
        result = _rpc(supabase_url, anon_key, {"p_id": story_id, "p_group_slug": group})
        print(f"id={story_id}: تم الربط بـ{group}، الرد: {result}")


if __name__ == "__main__":
    main()
