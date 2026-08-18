#!/usr/bin/env python3
"""TASK K — نقل رموز مصادر أسد الغابة من متن content_ar إلى عمود source_codes
منفصل (بعد مهجرة 20260805_add_story_source_codes.sql).

الرموز مثل "(ب د ع)" أو "(ب س)" في بداية الترجمة هي رموز مصادر ابن الأثير
الأصلية (تشير لمن ذكر الصحابي: البخاري في التاريخ، ابن منده، أبو نعيم،
ابن السكن...) - معلومة حقيقية تُنقَل لا تُحذَف.

النمط المستهدَف بدقة: بداية content_ar تماماً (الموضع صفر) بقوس يحوي
حرفاً عربياً واحداً أو أكثر مفصولة بمسافات فقط (لا أي كلمة كاملة داخل
القوس) ثم قوس إغلاق مباشرة. هذا يستبعد تلقائياً أي حالة يكون القوس فيها
جزءاً من ترويسة مختلفة (اسم كامل، تكملة نسب، إلخ) - راجع split_entries.py
لسوابق أنماط الترويسات المتعددة في هذا المصدر بالذات.

الاستخدام:
    export SUPABASE_URL=... SUPABASE_ANON_KEY=...
    python3 extract_source_codes.py --sample 10       # عرض عيّنة فقط
    python3 extract_source_codes.py --report          # تقرير كامل (كل الفئات)
    python3 extract_source_codes.py --apply --service-role-key=...  # تنفيذ فعلي (بعد الموافقة)
"""

from __future__ import annotations

import argparse
import json
import os
import re
import urllib.error
import urllib.request

SUPABASE_URL_DEFAULT = "https://pzcnkzsicyxlzqwjznvh.supabase.co"
CATEGORIES = ["prophets", "companions", "tabieen", "ulama"]

# قوس يحوي حرفاً عربياً واحداً أو أكثر مفصولة بمسافات فقط - لا كلمات كاملة
CODE_PATTERN = re.compile(r'^\(([؀-ۿ](?:\s[؀-ۿ])*)\)\s*')


def _get(url: str, key: str, path: str) -> list[dict]:
    req = urllib.request.Request(
        f"{url.rstrip('/')}/rest/v1/{path}",
        headers={"apikey": key, "Authorization": f"Bearer {key}"},
    )
    try:
        with urllib.request.urlopen(req) as resp:
            return json.loads(resp.read())
    except urllib.error.HTTPError as e:
        raise SystemExit(f"فشل GET {path}: HTTP {e.code} - {e.read().decode('utf-8', 'replace')}")


def fetch_all_rows(supabase_url: str, anon_key: str) -> list[dict]:
    rows = []
    for cat in CATEGORIES:
        rows.extend(_get(
            supabase_url, anon_key,
            f"stories?select=id,category,order_index,title_ar,content_ar,"
            f"source_book,author,source_url,source_volume,source_page"
            f"&category=eq.{cat}&order=order_index",
        ))
    return rows


def classify(rows: list[dict]) -> tuple[list[dict], list[dict]]:
    """يرجع (matched, ambiguous). matched: رموز نقية فقط قابلة للفصل الآلي.
    ambiguous: يبدأ القوس بحرف عربي لكن لا يطابق النمط النقي بالكامل
    (مثال: اسم مدموج داخل نفس القوس) - يحتاج قراراً يدوياً لكل حالة."""
    matched, ambiguous = [], []
    for r in rows:
        c = r.get("content_ar") or ""
        m = CODE_PATTERN.match(c)
        if m:
            codes = m.group(1)
            new_content = c[m.end():]
            matched.append({**r, "_codes": codes, "_new_content": new_content})
        elif c.startswith("("):
            ambiguous.append(r)
    return matched, ambiguous


def print_sample(matched: list[dict], n: int) -> None:
    print(f"عيّنة {min(n, len(matched))} من أصل {len(matched)} صفاً مطابقاً (كل الفئات):\n")
    for r in matched[:n]:
        print("─" * 70)
        print(f"id={r['id']}  category={r['category']}  order_index={r['order_index']}")
        print(f"title_ar: {r['title_ar']}")
        print(f"قبل  - content_ar[:100]: {r['content_ar'][:100]!r}")
        print(f"بعد  - source_codes: {r['_codes']!r}")
        print(f"بعد  - content_ar[:100]: {r['_new_content'][:100]!r}")
    print("─" * 70)


def print_report(rows: list[dict], matched: list[dict], ambiguous: list[dict]) -> None:
    by_cat = {}
    for r in matched:
        by_cat.setdefault(r["category"], []).append(r)
    print("=== تقرير وجود نمط رموز المصادر عبر الفئات الأربع ===\n")
    for cat in CATEGORIES:
        total_cat = sum(1 for r in rows if r["category"] == cat)
        n = len(by_cat.get(cat, []))
        print(f"{cat}: {n} / {total_cat} صفاً يطابق النمط النقي")
    print(f"\nإجمالي مطابق نقياً: {len(matched)}")
    print(f"إجمالي غامض (قوس + حرف عربي لكن لا يطابق تماماً): {len(ambiguous)}")
    if ambiguous:
        print("\nالحالات الغامضة (تحتاج قراراً يدوياً منفصلاً، لن تُعالَج تلقائياً):")
        for r in ambiguous:
            print(f"  id={r['id']} category={r['category']} title={r['title_ar']!r}")
            print(f"    content_ar[:90]: {r['content_ar'][:90]!r}")


def apply_updates(supabase_url: str, service_role_key: str, matched: list[dict]) -> None:
    for r in matched:
        url = f"{supabase_url.rstrip('/')}/rest/v1/stories?id=eq.{r['id']}"
        body = json.dumps({
            "source_codes": r["_codes"],
            "content_ar": r["_new_content"],
        }).encode("utf-8")
        req = urllib.request.Request(
            url, data=body, method="PATCH",
            headers={
                "apikey": service_role_key,
                "Authorization": f"Bearer {service_role_key}",
                "Content-Type": "application/json",
                "Prefer": "return=minimal",
            },
        )
        try:
            with urllib.request.urlopen(req) as resp:
                resp.read()
            print(f"id={r['id']}: تم التحديث")
        except urllib.error.HTTPError as e:
            print(f"id={r['id']}: فشل - HTTP {e.code} - {e.read().decode('utf-8', 'replace')}")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--sample", type=int, default=0, help="اعرض عيّنة بهذا العدد من الصفوف المطابقة")
    parser.add_argument("--report", action="store_true", help="اطبع تقرير النطاق عبر الفئات الأربع")
    parser.add_argument("--apply", action="store_true", help="تنفيذ فعلي (يتطلب --service-role-key)")
    parser.add_argument("--service-role-key", default=None)
    args = parser.parse_args()

    supabase_url = os.environ.get("SUPABASE_URL", SUPABASE_URL_DEFAULT)
    anon_key = os.environ.get("SUPABASE_ANON_KEY")
    if not anon_key:
        raise SystemExit("لازم SUPABASE_ANON_KEY في البيئة.")

    rows = fetch_all_rows(supabase_url, anon_key)
    matched, ambiguous = classify(rows)

    if args.sample:
        print_sample(matched, args.sample)
    if args.report or not (args.sample or args.apply):
        print_report(rows, matched, ambiguous)

    if args.apply:
        key = args.service_role_key or os.environ.get("SUPABASE_SERVICE_ROLE_KEY")
        if not key:
            raise SystemExit("التنفيذ الفعلي يتطلب --service-role-key أو SUPABASE_SERVICE_ROLE_KEY - لا يمكن لـanon كتابة content_ar بلا إلغاء النشر (نفس قيد upsert_story_draft).")
        print(f"\nسيُحدَّث {len(matched)} صفاً فعلياً عبر service_role. اضغط Enter للمتابعة أو Ctrl+C للإلغاء...")
        input()
        apply_updates(supabase_url, key, matched)


if __name__ == "__main__":
    main()
