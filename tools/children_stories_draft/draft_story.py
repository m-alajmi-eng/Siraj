#!/usr/bin/env python3
"""أداة مساعدة لصياغة مسودات قصص الأطفال من مكتبتنا الموثوقة (ابن كثير/القرآن/
الحديث) - يقصّها المالك يدوياً من مصدر النص الأصلي، لا حصاد آلي ولا مصدر خارجي.

**السياسة الثابتة (لا استثناء مهما بدت الصياغة "مجرد تلخيص"):**
كل مخرج من هذه الأداة مسودة أولى فقط (reviewed=false دائماً في القاعدة إن
كُتبت لاحقاً) تخضع لمراجعة بشرية كاملة من مالك المشروع لكل قصة على حدة قبل أي
نشر. هذا الإصدار من الأداة (generate فقط) **لا يكتب على القاعدة إطلاقاً** -
يطبع المسودة على الشاشة فقط لمراجعة المالك.

الاستخدام:
    export ANTHROPIC_API_KEY=...
    python3 draft_story.py generate --source-file src.txt --title "أصحاب الكهف"
"""

from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

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

    print("─" * 60)
    print(f"العنوان المستهدف: {args.title}")
    print(f"زمن القراءة المقدَّر: {parsed['reading_time_minutes']} دقيقة")
    print("─" * 60)
    print(parsed["simplified_text"])
    print("─" * 60)
    print(
        "هذه مسودة ذكاء اصطناعي - راجعها/عدّلها يدوياً بالكامل. "
        "لم تُكتب في أي مكان - هذا الإصدار من الأداة يطبع على الشاشة فقط."
    )


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = parser.add_subparsers(dest="command", required=True)

    gen = sub.add_parser("generate", help="يستدعي Anthropic API ويطبع المسودة على الشاشة فقط")
    gen.add_argument("--source-file", help="ملف النص المصدر الأصلي (وإلا يُقرأ من stdin)")
    gen.add_argument("--title", required=True, help="عنوان القصة المستهدفة من التسعة الموجودة")
    gen.add_argument("--lang", default="ar", help="لغة النص المصدر (افتراضي: ar)")
    gen.set_defaults(func=cmd_generate)

    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
