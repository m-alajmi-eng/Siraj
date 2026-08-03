#!/usr/bin/env python3
"""أداة استيراد قصة سيرة واحدة (نبي/صحابي/عالم) إلى جدول public.stories عبر
دالة upsert_story_draft (المهجرة 20260803000000_secure_stories_table.sql) -
بنفس روح tools/children_stories_draft/draft_story.py (بوابة موافقة يدوية
صريحة قبل أي كتابة، مفتاح anon العام فقط - لا مفتاح خدمة، لأن الدالة
SECURITY DEFINER مصمَّمة أصلاً للعمل بصلاحية anon العادية).

**السياسة الثابتة:** كل مخرج من هذه الأداة صف جديد بـis_published=false
دائماً - upsert_story_draft لا تملك أصلاً معامل p_is_published في توقيعها،
فلا مسار يقدر يكتبه true. النشر الفعلي (is_published=true) تحديث SQL مباشر
يدوي فقط من مالك المشروع بعد قراءة كاملة للقصة.

الاستخدام:
    export SUPABASE_URL=...
    export SUPABASE_ANON_KEY=...
    python3 upsert_story.py path/to/story.json
"""

from __future__ import annotations

import argparse
import json
import os
import urllib.error
import urllib.request
from pathlib import Path

REQUIRED_FIELDS = ("category", "title_ar")
OPTIONAL_FIELDS = (
    "title_en",
    "summary_ar",
    "content_ar",
    "person_name",
    "period",
    "lessons",
    "tags",
    "order_index",
    "source_book",
    "author",
    "source_volume",
    "source_page",
    "source_url",
)


def _supabase_request(
    method: str,
    path: str,
    supabase_url: str,
    anon_key: str,
    body: dict | None = None,
) -> object:
    url = f"{supabase_url.rstrip('/')}{path}"
    data = json.dumps(body).encode("utf-8") if body is not None else None
    req = urllib.request.Request(
        url,
        data=data,
        method=method,
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
        raise SystemExit(
            f"فشل الطلب {method} {path}: HTTP {e.code} - "
            f"{e.read().decode('utf-8', 'replace')}"
        )


def main() -> None:
    parser = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
    )
    parser.add_argument(
        "story_file", help="ملف JSON لقصة واحدة (category وtitle_ar إلزاميان)"
    )
    args = parser.parse_args()

    supabase_url = os.environ.get("SUPABASE_URL")
    anon_key = os.environ.get("SUPABASE_ANON_KEY")
    if not supabase_url or not anon_key:
        raise SystemExit("لازم تضبط SUPABASE_URL وSUPABASE_ANON_KEY في البيئة أولاً.")

    story_path = Path(args.story_file)
    story = json.loads(story_path.read_text(encoding="utf-8"))

    for field in REQUIRED_FIELDS:
        if not story.get(field):
            raise SystemExit(f"الحقل '{field}' إلزامي وغير موجود في {story_path}")

    print("─" * 60)
    print(f"ملف المصدر: {story_path}")
    print(f"التصنيف (category): {story.get('category')}")
    print(f"العنوان العربي: {story.get('title_ar')}")
    print(f"العنوان الإنجليزي: {story.get('title_en', '(بلا)')}")
    print(f"اسم الشخصية: {story.get('person_name', '(بلا)')}")
    print(f"الفترة: {story.get('period', '(بلا)')}")
    print(f"ترتيب العرض: {story.get('order_index', '(بلا)')}")
    print(f"الوسوم: {story.get('tags', [])}")
    print("─" * 60)
    print(f"الكتاب المصدر (source_book): {story.get('source_book', '(بلا)')}")
    print(f"المؤلف (author): {story.get('author', '(بلا)')}")
    print(f"الجزء (source_volume): {story.get('source_volume', '(بلا)')}")
    print(f"الصفحة (source_page): {story.get('source_page', '(بلا)')}")
    print(f"رابط المصدر (source_url): {story.get('source_url', '(بلا)')}")
    print("─" * 60)
    print("الملخص (summary_ar):")
    print(story.get("summary_ar", "(بلا)"))
    print("─" * 60)
    print("النص الكامل (content_ar):")
    print(story.get("content_ar", "(بلا)"))
    print("─" * 60)
    print("العبر (lessons):")
    for lesson in story.get("lessons", []):
        print(f"  - {lesson}")
    print("─" * 60)
    print(
        "تذكير: upsert_story_draft تكتب is_published=false دائماً - لا معامل "
        "p_is_published في توقيعها أصلاً، فلا مسار يقدر يكتبه true. p_id "
        "سيُمرَّر NULL (صف جديد، لا تحديث)."
    )
    print(
        "هذا استيراد جديد إلى القاعدة الحية - لا يُنشَر بلا قراءتك الفعلية "
        "الكاملة لكل كلمة أعلاه."
    )

    answer = input(
        "\nاكتب 'نعم' حرفياً لتأكيد كتابة هذه القصة كمسودة (is_published=false): "
    )
    if answer.strip() != "نعم":
        raise SystemExit("أُلغيت العملية - لم تُكتب أي مسودة.")

    params: dict = {"p_id": None}
    for field in REQUIRED_FIELDS + OPTIONAL_FIELDS:
        if field in story:
            params[f"p_{field}"] = story[field]

    result = _supabase_request(
        "POST",
        "/rest/v1/rpc/upsert_story_draft",
        supabase_url,
        anon_key,
        body=params,
    )

    new_id = result
    if isinstance(result, list) and len(result) == 1:
        new_id = result[0] if not isinstance(result[0], dict) else next(iter(result[0].values()))

    print(f"\nتمت الكتابة بنجاح. id الصف الجديد: {new_id}")

    verify_path = f"/rest/v1/stories?id=eq.{new_id}&select=id,title_ar,is_published"
    verify = _supabase_request("GET", verify_path, supabase_url, anon_key)

    print("─" * 60)
    print("تحقّق مزدوج - استعلام مباشر بمفتاح anon على id الناتج:")
    print(json.dumps(verify, ensure_ascii=False, indent=2))
    print("─" * 60)
    if verify == []:
        print(
            "✓ النتيجة صفر صفوف - هذا هو المتوقَّع تماماً: سياسة RLS "
            "\"Public read access\" تسمح بقراءة anon فقط حين is_published=true، "
            "فاختفاء الصف الجديد عن قراءة anon يؤكد بصدق أن is_published=false "
            "(لو كان true لظهر الصف هنا)."
        )
    else:
        print(
            "⚠ تحذير غير متوقَّع: الصف ظهر لقراءة anon - هذا يعني is_published="
            "true فعلياً، ما يخالف الضمانة المفترَضة في upsert_story_draft. "
            "راجع فوراً ولا تفترض أن هذا سلوك سليم."
        )


if __name__ == "__main__":
    main()
