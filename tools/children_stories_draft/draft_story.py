#!/usr/bin/env python3
"""أداة مساعدة لصياغة مسودات قصص الأطفال من مكتبتنا الموثوقة (ابن كثير/القرآن/
الحديث) - يقصّها المالك يدوياً من مصدر النص الأصلي، لا حصاد آلي ولا مصدر خارجي.

**السياسة الثابتة (لا استثناء مهما بدت الصياغة "مجرد تلخيص"):**
كل مخرج من هذه الأداة مسودة أولى فقط (reviewed=false دائماً في القاعدة) تخضع
لمراجعة بشرية كاملة من مالك المشروع لكل قصة على حدة قبل أي نشر. لا مسار في هذا
السكربت يقدر يُعيّن reviewed=true - ذلك فقط عبر تحديث SQL مباشر يدوي موثَّق في
docs/reviews/CHILDREN_STORIES_DRAFTS_REVIEW_GUIDE.md.

**تصميم بخطوتين منفصلتين عمداً - لا مسار آلي واحد يولّد وينشر معاً:**
    1) generate  - يستدعي Anthropic API، يطبع المسودة على الشاشة، ويحفظها في
                   ملف JSON محلي (tools/children_stories_draft/drafts/*.json،
                   غير مرفوع لـgit) للمراجعة/التعديل اليدوي.
    2) commit    - يقرأ ملف المسودة (بعد أي تعديل يدوي عليه من المالك)، يطبع
                   محتواه الكامل للمراجعة الأخيرة، يطلب تأكيداً تفاعلياً صريحاً
                   بكتابة "نعم" حرفياً، ثم يستدعي upsert_draft_story عبر واجهة
                   Supabase REST (بمفتاح anon العام - نفس صلاحية العميل تماماً،
                   لا مفتاح خدمة).

**تنبيه معماري مهم (اقرأه قبل commit):**
upsert_draft_story يُدرج صفاً *جديداً* دوماً عند source=NULL,NULL (القيد
UNIQUE(source_author_id, source_item_id) لا يتعارض بين NULL,NULL وNULL,NULL في
PostgreSQL - انظر دليل المراجعة). هذا يعني أن commit **لا يملأ** صفّ القصة
المخطَّط لها مسبقاً بنفس العنوان (الذي يحمل legacy_emoji/legacy_color/
legacy_category الحقيقية) - بل يُنشئ صفاً موازياً جديداً بلا هوية بصرية مخصَّصة
(سيظهر في الشبكة بإيموجي/لون افتراضيَين حتى يدمجه المالك يدوياً لاحقاً بتحديث
مباشر بـid، كما هو موثَّق في دليل المراجعة). هذا سلوك متعمَّد حسب توجيه المالك
لهذه الأداة تحديداً - لا حل تلقائي له هنا.

الاستخدام:
    export ANTHROPIC_API_KEY=...
    export SUPABASE_URL=...
    export SUPABASE_ANON_KEY=...

    python3 draft_story.py generate --source-file src.txt --title "أصحاب الكهف"
    # راجع/عدّل tools/children_stories_draft/drafts/<...>.json يدوياً إن أردت
    python3 draft_story.py commit --draft-file tools/children_stories_draft/drafts/<...>.json
"""

from __future__ import annotations

import argparse
import json
import os
import sys
import urllib.error
import urllib.request
from datetime import datetime, timezone
from pathlib import Path

TOOL_DIR = Path(__file__).resolve().parent
DRAFTS_DIR = TOOL_DIR / "drafts"

MODEL = "claude-opus-4-8"

SYSTEM_PROMPT_TEMPLATE = """أنت أداة تلخيص حرفي فقط - لا صياغة إبداعية ولا سرد قصصي حر ولا اجتهاد.

المهمة الوحيدة: لخّص النص المصدر المرفق أدناه بلغة عربية مبسّطة تناسب أطفالاً
بعمر 6-12 سنة، مع الالتزام الصارم بما يلي بلا أي استثناء:

1. ممنوع إضافة أي حدث أو حوار أو شخصية أو تفصيل غير موجود صراحةً في النص
   المصدر المرفق. لا تخترع حواراً منطوقاً، ولا تُضف تفاصيل مشهدية (طقس/ألوان/
   مشاعر داخلية) لم يذكرها النص حرفياً.
2. ممنوع أي اجتهاد فقهي أو عقدي من عندك - لا تُضف حكماً شرعياً، ولا تفسيراً
   عقدياً، ولا استنباطاً لم يرد صراحة في النص المصدر.
3. إن كان النص المصدر ناقصاً أو غامضاً في جزء ما، لا تُكمله من عندك - لخّص فقط
   ما هو مذكور صراحة، واترك الغامض غامضاً بدل اختلاق تفصيل يسدّ الفراغ.
4. القصة المستهدفة (من كتالوج تسع قصص مخطَّط لها مسبقاً): "{target_title}"
   استخدم هذا العنوان كسياق لفهم أي قصة يُفترض أن يتحدث عنها النص فقط، لكن لا
   تُعِد صياغة العنوان نفسه، ولا تفترض تفاصيل من القصة المشهورة إن لم يذكرها
   النص المصدر حرفياً.
5. أخرِج حصراً: (أ) النص المبسَّط الكامل، (ب) تقدير زمن قراءة بالدقائق لطفل في
   هذه الفئة العمرية (عدد صحيح).

هذا النص مسودة أولى فقط (reviewed=false) تخضع لمراجعة بشرية كاملة من مالك
المشروع قبل أي نشر - مهمتك تلخيص محافظ حرفي، لا إبداع ولا إضافة."""

DRAFT_SCHEMA = {
    "type": "object",
    "properties": {
        "simplified_text": {"type": "string"},
        "reading_time_minutes": {"type": "integer"},
    },
    "required": ["simplified_text", "reading_time_minutes"],
    "additionalProperties": False,
}


def _read_source_text(args: argparse.Namespace) -> str:
    if args.source_file:
        return Path(args.source_file).read_text(encoding="utf-8").strip()
    text = sys.stdin.read().strip()
    if not text:
        raise SystemExit("لا نص مصدر: مرّر --source-file أو مرّر النص عبر stdin.")
    return text


def cmd_generate(args: argparse.Namespace) -> None:
    try:
        import anthropic
    except ImportError:
        raise SystemExit(
            "الحزمة anthropic غير مثبَّتة. ثبّتها أولاً: pip install anthropic"
        )

    source_text = _read_source_text(args)
    system_prompt = SYSTEM_PROMPT_TEMPLATE.format(target_title=args.title)

    client = anthropic.Anthropic()
    response = client.messages.create(
        model=MODEL,
        max_tokens=4096,
        thinking={"type": "adaptive"},
        system=system_prompt,
        output_config={
            "effort": "high",
            "format": {"type": "json_schema", "schema": DRAFT_SCHEMA},
        },
        messages=[
            {
                "role": "user",
                "content": f"النص المصدر (كما هو حرفياً، دون أي تعديل):\n\n{source_text}",
            }
        ],
    )

    if response.stop_reason == "refusal":
        raise SystemExit("رفض النموذج الطلب (stop_reason=refusal) - راجع النص المصدر.")

    text_block = next(b.text for b in response.content if b.type == "text")
    parsed = json.loads(text_block)

    draft = {
        "target_title": args.title,
        "lang": args.lang,
        "simplified_text": parsed["simplified_text"],
        "reading_time_minutes": parsed["reading_time_minutes"],
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "model": MODEL,
        "source_excerpt": source_text[:200],
    }

    print("─" * 60)
    print(f"العنوان المستهدف: {draft['target_title']}")
    print(f"زمن القراءة المقدَّر: {draft['reading_time_minutes']} دقيقة")
    print("─" * 60)
    print(draft["simplified_text"])
    print("─" * 60)

    DRAFTS_DIR.mkdir(parents=True, exist_ok=True)
    if args.output:
        out_path = Path(args.output)
    else:
        slug = "".join(c if c.isalnum() else "_" for c in args.title)[:40]
        stamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
        out_path = DRAFTS_DIR / f"{slug}_{stamp}.json"

    out_path.write_text(
        json.dumps(draft, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    print(f"\nحُفظت المسودة في: {out_path}")
    print(
        "هذه مسودة ذكاء اصطناعي - راجعها/عدّلها يدوياً بالكامل قبل commit. "
        "لا نشر آلي بأي حال."
    )


def _supabase_rpc(function_name: str, params: dict) -> dict:
    supabase_url = os.environ.get("SUPABASE_URL")
    anon_key = os.environ.get("SUPABASE_ANON_KEY")
    if not supabase_url or not anon_key:
        raise SystemExit("لازم تضبط SUPABASE_URL وSUPABASE_ANON_KEY في البيئة أولاً.")

    url = f"{supabase_url.rstrip('/')}/rest/v1/rpc/{function_name}"
    body = json.dumps(params).encode("utf-8")
    req = urllib.request.Request(
        url,
        data=body,
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
            return json.loads(raw) if raw else {}
    except urllib.error.HTTPError as e:
        raise SystemExit(f"فشل استدعاء {function_name}: HTTP {e.code} - {e.read().decode('utf-8', 'replace')}")


def cmd_commit(args: argparse.Namespace) -> None:
    draft_path = Path(args.draft_file)
    draft = json.loads(draft_path.read_text(encoding="utf-8"))

    for field in ("target_title", "lang", "simplified_text", "reading_time_minutes"):
        if field not in draft:
            raise SystemExit(f"ملف المسودة ناقص - الحقل '{field}' غير موجود.")

    print("─" * 60)
    print("مراجعة أخيرة قبل الكتابة في القاعدة (reviewed=false دائماً):")
    print("─" * 60)
    print(f"العنوان: {draft['target_title']}")
    print(f"اللغة: {draft['lang']}")
    print(f"زمن القراءة: {draft['reading_time_minutes']} دقيقة")
    print("─" * 60)
    print(draft["simplified_text"])
    print("─" * 60)
    print(
        "تذكير: upsert_draft_story يُدرج صفاً جديداً دوماً - لن يملأ صفّ القصة "
        "المخطَّط لها مسبقاً بنفس العنوان تلقائياً. راجع دليل المراجعة للدمج اليدوي."
    )
    print(
        "هذه مسودة ذكاء اصطناعي دائماً - لا تُنشَر بلا قراءتك الفعلية الكاملة "
        "لكل كلمة أعلاه."
    )

    answer = input("\nاكتب 'نعم' حرفياً لتأكيد كتابة هذه المسودة (reviewed=false): ")
    if answer.strip() != "نعم":
        raise SystemExit("أُلغيت العملية - لم تُكتب أي مسودة.")

    result = _supabase_rpc(
        "upsert_draft_story",
        {
            "p_source_author_id": None,
            "p_source_item_id": None,
            "p_original_language": draft["lang"],
            "p_title": draft["target_title"],
            "p_simplified_text": draft["simplified_text"],
            "p_reading_time_minutes": draft["reading_time_minutes"],
        },
    )
    print("تمت الكتابة بنجاح كمسودة (reviewed=false).", result if result else "")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = parser.add_subparsers(dest="command", required=True)

    gen = sub.add_parser("generate", help="يستدعي Anthropic API، يطبع المسودة على الشاشة، ويحفظها في ملف محلي")
    gen.add_argument("--source-file", help="ملف النص المصدر الأصلي (وإلا يُقرأ من stdin)")
    gen.add_argument("--title", required=True, help="عنوان القصة المستهدفة من التسعة الموجودة")
    gen.add_argument("--lang", default="ar", help="لغة النص المصدر (افتراضي: ar)")
    gen.add_argument("-o", "--output", help="مسار ملف المسودة الناتج (افتراضي: tools/children_stories_draft/drafts/)")
    gen.set_defaults(func=cmd_generate)

    commit = sub.add_parser("commit", help="يكتب مسودة (بعد موافقة يدوية صريحة) عبر upsert_draft_story")
    commit.add_argument("--draft-file", required=True, help="ملف المسودة الناتج من generate (بعد أي تعديل يدوي)")
    commit.set_defaults(func=cmd_commit)

    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
