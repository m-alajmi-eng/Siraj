#!/usr/bin/env python3
"""يربط صفوف stories الموجودة بمجموعاتها المصدرية (group_slug) عبر
set_story_group.

**إصلاح 2026-08-05:** الإصدار الأول من هذا السكربت كان يعتمد على حقل
"saved_id" داخل ملفات ready/**/*.json - لكن upsert_story.py لا يكتب هذا
الحقل فعلياً في أي ملف من الـ253 (تحقَّق فعلياً: grep على كل الملفات لم
يجد "saved_id" ولا مرة واحدة). النتيجة: collect_from_ready_dir كانت
تُرجع قاموساً فارغاً دائماً، فالربط الفعلي كان يقتصر على LEGACY_ID_GROUPS
فقط (ids 34-100، وكلها كانت مصنَّفة "badr" خطأً - راجع أدناه). هذا
الإصدار يستبدل الاعتماد على "saved_id" بمطابقة (category, order_index)
مقابل قراءة مباشرة من القاعدة الحية (anon، الصفوف الثلاث - companions/
tabieen/ulama - منشورة بالكامل الآن فتُقرأ عبر anon بلا قيد RLS).

**تصحيح تصنيف ids 34-64 (طلب محمد الصريح 2026-08-05):** الإصدار الأول
كان يضع كل هذا المدى تحت "badr" لمجرد أن أغلب أفراده شهدوا بدراً أيضاً.
لكن كل دفعة من هذه لها موضوعها الخاص المُوثَّق في progress_log.md
ومطلوب صراحة كـslug مستقل: العشرة المبشرون (order_index 1-10)،
أمهات المؤمنين (11-21)، كتّاب الوحي (22-31) - راجع LEGACY_ORDER_GROUPS
أدناه. order_index 32-67 (دفعتا "أهل بدر" الصريحتان الأوليان) تبقى
badr كما كانت.

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

# دفعات سابقة سبقت وجود حقل intended_group في ملفات JSON (order_index
# 1-67 لفئة companions حصراً) - مربوطة يدوياً هنا حسب موضوع كل دفعة
# الموثَّق في progress_log.md، لا حسب "من شهد بدراً أيضاً".
LEGACY_ORDER_GROUPS: dict[tuple[str, int], str] = {
    **{("companions", i): "ashara_mubashara" for i in range(1, 11)},   # 1-10: العشرة المبشرون
    **{("companions", i): "ummahat_muminin" for i in range(11, 22)},   # 11-21: أمهات المؤمنين
    **{("companions", i): "kuttab_wahy" for i in range(22, 32)},       # 22-31: كتّاب الوحي
    **{("companions", i): "badr" for i in range(32, 68)},              # 32-67: أهل بدر (دفعتا١-٢)
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


def fetch_live_ids(supabase_url: str, anon_key: str) -> dict[tuple[str, int], int]:
    """يقرأ (category, order_index) -> id من القاعدة الحية عبر anon.
    يعمل فقط للصفوف المنشورة (is_published=true) - وهذا متحقَّق فعلاً
    لكل صفوف companions/tabieen/ulama حالياً (RLS تخفي غير ذلك أصلاً)."""
    url = (
        f"{supabase_url.rstrip('/')}/rest/v1/stories"
        "?select=id,category,order_index"
        "&category=in.(companions,tabieen,ulama)"
        "&limit=1000"
    )
    req = urllib.request.Request(
        url,
        headers={"apikey": anon_key, "Authorization": f"Bearer {anon_key}"},
    )
    with urllib.request.urlopen(req) as resp:
        rows = json.loads(resp.read())
    mapping: dict[tuple[str, int], int] = {}
    for r in rows:
        mapping[(r["category"], r["order_index"])] = r["id"]
    return mapping


def collect_from_ready_dir(ready_dir: Path) -> dict[tuple[str, int], str]:
    """يقرأ (category, order_index) -> intended_group من ملفات ready
    المحفوظة (order_index 68-191 لفئة companions، حيث حقل intended_group
    مكتوب فعلياً في كل ملف)."""
    mapping: dict[tuple[str, int], str] = {}
    for path in ready_dir.rglob("*.json"):
        data = json.loads(path.read_text(encoding="utf-8"))
        category = data.get("category")
        order_index = data.get("order_index")
        group = data.get("intended_group")
        if category and order_index is not None and group:
            mapping[(category, int(order_index))] = group
    return mapping


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--apply", action="store_true")
    args = parser.parse_args()

    supabase_url = os.environ.get("SUPABASE_URL")
    anon_key = os.environ.get("SUPABASE_ANON_KEY")
    if not supabase_url or not anon_key:
        raise SystemExit("لازم SUPABASE_URL وSUPABASE_ANON_KEY في البيئة.")

    ready_dir = Path(__file__).parent / "ready"
    key_groups: dict[tuple[str, int], str] = dict(LEGACY_ORDER_GROUPS)
    key_groups.update(collect_from_ready_dir(ready_dir))

    live_ids = fetch_live_ids(supabase_url, anon_key)

    id_groups: dict[int, str] = {}
    unmatched: list[tuple[str, int, str]] = []
    for (category, order_index), group in key_groups.items():
        story_id = live_ids.get((category, order_index))
        if story_id is None:
            unmatched.append((category, order_index, group))
            continue
        id_groups[story_id] = group

    print(f"إجمالي الربط المُجهَّز: {len(id_groups)} صفاً (من {len(key_groups)} مفتاحاً محلياً)")
    for story_id, group in sorted(id_groups.items()):
        print(f"  id={story_id} -> {group}")

    if unmatched:
        print(f"\n⚠ {len(unmatched)} مفتاحاً محلياً بلا id مطابق في القاعدة الحية (لم يُربَط):")
        for category, order_index, group in sorted(unmatched):
            print(f"  category={category} order_index={order_index} -> {group} (لا id مطابق)")

    if not args.apply:
        print("\ndry-run فقط - أعد التشغيل مع --apply للتنفيذ الفعلي.")
        return

    for story_id, group in sorted(id_groups.items()):
        result = _rpc(supabase_url, anon_key, {"p_id": story_id, "p_group_slug": group})
        print(f"id={story_id}: تم الربط بـ{group}، الرد: {result}")


if __name__ == "__main__":
    main()
