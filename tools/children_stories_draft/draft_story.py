#!/usr/bin/env python3
"""أداة مساعدة لصياغة مسودات قصص الأطفال من مكتبتنا الموثوقة (ابن كثير/القرآن/
الحديث) - يقصّها المالك يدوياً من مصدر النص الأصلي، لا حصاد آلي ولا مصدر خارجي.

**السياسة الثابتة (لا استثناء مهما بدت الصياغة "مجرد تلخيص"):**
كل مخرج من هذه الأداة مسودة أولى فقط (reviewed=false دائماً في القاعدة) تخضع
لمراجعة بشرية كاملة من مالك المشروع لكل قصة على حدة قبل أي نشر. لا مسار في هذا
السكربت يقدر يُعيّن reviewed=true - ذلك فقط عبر تحديث SQL مباشر يدوي موثَّق في
docs/reviews/CHILDREN_STORIES_DRAFTS_REVIEW_GUIDE.md.

**تصميم بخطوتين منفصلتين عمداً - لا مسار آلي واحد يولّد وينشر معاً:**
    1) generate     - يستدعي Anthropic API، يطبع المسودة على الشاشة، ويحفظها
                       في ملف JSON محلي (tools/children_stories_draft/drafts/
                       *.json، غير مرفوع لـgit) للمراجعة/التعديل اليدوي.
    2) commit        - يقرأ ملف المسودة (بعد أي تعديل يدوي عليه من المالك)،
                       يجلب الصفّ الحالي بـ--story-id (1-9) عبر get_children_
                       stories_catalog للمراجعة، يطبع كل شيء للمراجعة
                       الأخيرة، يطلب تأكيداً تفاعلياً صريحاً بكتابة "نعم"
                       حرفياً، ثم يستدعي update_draft_story_by_id (المهجرة
                       20260801150000) عبر واجهة Supabase REST بمفتاح anon
                       العام - نفس صلاحية العميل تماماً، لا مفتاح خدمة.
    3) upload-final  - يرفع صوراً + نصوصاً معاً دفعة واحدة لكل قصة من التسع.
                       يحتاج مفتاح service_role (متغير بيئة محلي فقط - انظر
                       تحذير الأمان أدناه) لرفع الصور فقط (bucket القراءة
                       العامة لا يسمح بكتابة anon/authenticated إطلاقاً -
                       المهجرة 20260802000000). الكتابة في القاعدة (نص+صور)
                       تبقى عبر anon key كالمعتاد (update_draft_story_by_id +
                       set_draft_story_images، كلتاهما SECURITY DEFINER
                       ضيّقتا الغرض).

**ملاحظة معمارية (commit/upload-final):** كلاهما يستهدف صفاً *موجوداً*
بمعرّفه (--story-id) - لا يُدرج صفاً جديداً. upsert_draft_story (مصدر
NULL,NULL يُدرج صفاً جديداً دوماً، لا يُحدّث - انظر دليل المراجعة القسم 3) لا
تُستخدَم هنا إطلاقاً؛ update_draft_story_by_id وset_draft_story_images ترفضان
صراحة أي id خارج التسع القصص الأصلية أو أي صف reviewed=true بالفعل - ضمانتان
داخل الدالتين نفسهما، لا تعتمدان على انضباط هذا السكربت.

**تحذير أمني (مفتاح service_role):** لا يُكتَب مطلقاً في هذا الملف ولا في أي
ملف مُرفَع لـgit - قيمته تُقرأ حصراً من متغير بيئة محلي (SUPABASE_SERVICE_ROLE_
KEY) وقت التشغيل. لا تشاركه، ولا تضعه في أي ملف مسودة/سجل/commit.

الاستخدام:
    export ANTHROPIC_API_KEY=...
    export SUPABASE_URL=...
    export SUPABASE_ANON_KEY=...

    python3 draft_story.py generate --source-file src.txt --title "أصحاب الكهف"
    # راجع/عدّل tools/children_stories_draft/drafts/<...>.json يدوياً إن أردت
    python3 draft_story.py commit --draft-file tools/children_stories_draft/drafts/<...>.json --story-id 9

    export SUPABASE_SERVICE_ROLE_KEY=...   # لرفع الصور فقط - محلي دائماً
    python3 draft_story.py upload-final --images-dir /path/to/images --texts-dir /path/to/texts
"""

from __future__ import annotations

import argparse
import json
import mimetypes
import os
import sys
import urllib.error
import urllib.request
from datetime import datetime, timezone
from pathlib import Path

TOOL_DIR = Path(__file__).resolve().parent
DRAFTS_DIR = TOOL_DIR / "drafts"

MODEL = "claude-opus-4-8"

STORY_IDS = range(1, 10)
IMAGE_ROLES = ("opening", "climax", "closing")
IMAGE_BUCKET = "children-stories-images"
IMAGE_EXTENSIONS = (".jpg", ".jpeg", ".png", ".webp")

# عدد صور مختلف عمداً حسب فئة طول كل قصة (قرار منتجي مُتعمَّد، لا موحَّد على
# التسع): القصص القصيرة جداً (5،6،7) صورة افتتاحية واحدة فقط؛ القصص القصيرة
# (1،2،8) افتتاحية+ختامية بلا climax؛ القصص الأطول (3،4،9) الثلاث صور كاملة.
STORY_IMAGE_ROLES: dict[int, tuple[str, ...]] = {
    1: ("opening", "closing"),
    2: ("opening", "closing"),
    3: ("opening", "climax", "closing"),
    4: ("opening", "climax", "closing"),
    5: ("opening",),
    6: ("opening",),
    7: ("opening",),
    8: ("opening", "closing"),
    9: ("opening", "climax", "closing"),
}

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


def _fetch_catalog_row(lang: str, story_id: int) -> dict:
    rows = _supabase_rpc("get_children_stories_catalog", {"p_lang": lang})
    for row in rows:
        if row.get("id") == story_id:
            return row
    raise SystemExit(
        f"لا صفّ بهذا id ({story_id}) في get_children_stories_catalog - تحقّق من "
        "الرقم عبر استعلام القسم (1) في دليل المراجعة."
    )


def cmd_commit(args: argparse.Namespace) -> None:
    draft_path = Path(args.draft_file)
    draft = json.loads(draft_path.read_text(encoding="utf-8"))

    for field in ("lang", "simplified_text", "reading_time_minutes"):
        if field not in draft:
            raise SystemExit(f"ملف المسودة ناقص - الحقل '{field}' غير موجود.")

    current_row = _fetch_catalog_row(draft["lang"], args.story_id)

    print("─" * 60)
    print("مراجعة أخيرة قبل الكتابة في القاعدة (reviewed=false دائماً):")
    print("─" * 60)
    print(f"id المستهدف: {args.story_id}")
    print(f"العنوان الحالي في القاعدة: {current_row.get('title')}")
    print(f"التصنيف: {current_row.get('legacy_category')}  الإيموجي: {current_row.get('legacy_emoji')}")
    print(f"اللغة: {draft['lang']}")
    print(f"زمن القراءة الجديد: {draft['reading_time_minutes']} دقيقة")
    print("─" * 60)
    print(draft["simplified_text"])
    print("─" * 60)
    print(
        "تذكير: هذا سيُحدِّث صفاً موجوداً بـid أعلاه (العنوان يبقى كما هو ما لم "
        "تُعدِّله يدوياً في القاعدة لاحقاً) - لا يُنشئ صفاً جديداً."
    )
    print(
        "هذه مسودة ذكاء اصطناعي دائماً - لا تُنشَر بلا قراءتك الفعلية الكاملة "
        "لكل كلمة أعلاه."
    )

    answer = input("\nاكتب 'نعم' حرفياً لتأكيد كتابة هذه المسودة (reviewed=false): ")
    if answer.strip() != "نعم":
        raise SystemExit("أُلغيت العملية - لم تُكتب أي مسودة.")

    result = _supabase_rpc(
        "update_draft_story_by_id",
        {
            "p_id": args.story_id,
            "p_original_language": draft["lang"],
            "p_simplified_text": draft["simplified_text"],
            "p_reading_time_minutes": draft["reading_time_minutes"],
        },
    )
    print("تمت الكتابة بنجاح كمسودة (reviewed=false).", result if result else "")


def _print_expected_filenames_map() -> None:
    print("─" * 60)
    print(
        "الخريطة المتوقَّعة لأسماء ملفات الصور (راجعها قبل ربطها بملفاتك "
        "الفعلية في --images-dir):"
    )
    print(f"  الامتدادات المقبولة: {', '.join(IMAGE_EXTENSIONS)}")
    for story_id in STORY_IDS:
        names = [f"{story_id}_{role}.<ext>" for role in STORY_IMAGE_ROLES[story_id]]
        print(f"  story-id {story_id} ({len(STORY_IMAGE_ROLES[story_id])} صورة): {', '.join(names)}")
    print(
        "  النصوص المتوقَّعة في --texts-dir: <story-id>.json بنفس حقول ملف "
        "generate (lang, simplified_text, reading_time_minutes)."
    )
    print("─" * 60)


def _find_image_file(images_dir: Path, story_id: int, role: str) -> Path | None:
    for ext in IMAGE_EXTENSIONS:
        candidate = images_dir / f"{story_id}_{role}{ext}"
        if candidate.is_file():
            return candidate
    return None


def _read_text_file(texts_dir: Path, story_id: int) -> dict | None:
    path = texts_dir / f"{story_id}.json"
    if not path.is_file():
        return None
    data = json.loads(path.read_text(encoding="utf-8"))
    for field in ("lang", "simplified_text", "reading_time_minutes"):
        if field not in data:
            raise SystemExit(f"ملف النص {path} ناقص - الحقل '{field}' غير موجود.")
    return data


def _upload_storage_object(local_path: Path, object_path: str) -> str:
    supabase_url = os.environ.get("SUPABASE_URL")
    service_key = os.environ.get("SUPABASE_SERVICE_ROLE_KEY")
    if not supabase_url or not service_key:
        raise SystemExit(
            "لازم تضبط SUPABASE_URL وSUPABASE_SERVICE_ROLE_KEY (محلي فقط) في "
            "البيئة أولاً لرفع الصور."
        )

    content_type = mimetypes.guess_type(local_path.name)[0] or "application/octet-stream"
    url = f"{supabase_url.rstrip('/')}/storage/v1/object/{IMAGE_BUCKET}/{object_path}"
    req = urllib.request.Request(
        url,
        data=local_path.read_bytes(),
        method="POST",
        headers={
            "apikey": service_key,
            "Authorization": f"Bearer {service_key}",
            "Content-Type": content_type,
            "x-upsert": "true",
        },
    )
    try:
        with urllib.request.urlopen(req):
            pass
    except urllib.error.HTTPError as e:
        raise SystemExit(f"فشل رفع {local_path}: HTTP {e.code} - {e.read().decode('utf-8', 'replace')}")

    return f"{supabase_url.rstrip('/')}/storage/v1/object/public/{IMAGE_BUCKET}/{object_path}"


def cmd_upload_final(args: argparse.Namespace) -> None:
    images_dir = Path(args.images_dir)
    texts_dir = Path(args.texts_dir)

    if args.story_id is not None and args.story_id not in STORY_IMAGE_ROLES:
        raise SystemExit(f"--story-id يجب أن يكون بين 1 و9 - وصل {args.story_id}")

    story_ids = [args.story_id] if args.story_id is not None else list(STORY_IDS)

    _print_expected_filenames_map()

    completed: list[int] = []
    skipped: list[int] = []

    for story_id in story_ids:
        expected_roles = STORY_IMAGE_ROLES[story_id]
        image_paths = {}
        missing = []
        for role in expected_roles:
            found = _find_image_file(images_dir, story_id, role)
            if found is None:
                missing.append(role)
            else:
                image_paths[role] = found

        text_data = _read_text_file(texts_dir, story_id)

        if missing or text_data is None:
            reasons = []
            if missing:
                reasons.append(f"صور ناقصة: {', '.join(missing)}")
            if text_data is None:
                reasons.append(f"لا ملف نص {story_id}.json في --texts-dir")
            print(f"\n[تخطّي story-id {story_id}] {' | '.join(reasons)}")
            skipped.append(story_id)
            continue

        current_row = _fetch_catalog_row(text_data["lang"], story_id)

        print("─" * 60)
        print(f"مراجعة أخيرة - story-id {story_id} (نص + صور معاً):")
        print("─" * 60)
        print(f"العنوان الحالي في القاعدة: {current_row.get('title')}")
        print(f"التصنيف: {current_row.get('legacy_category')}  الإيموجي: {current_row.get('legacy_emoji')}")
        print(f"اللغة: {text_data['lang']}")
        print(f"زمن القراءة الجديد: {text_data['reading_time_minutes']} دقيقة")
        print("─" * 60)
        print(text_data["simplified_text"])
        print("─" * 60)
        for role in expected_roles:
            print(f"صورة {role}: {image_paths[role]}")
        print("─" * 60)
        print(
            "هذه مسودة نص (وربطها بصور) - لا تُنشَر بلا قراءتك الفعلية الكاملة "
            "لكل كلمة أعلاه ومراجعة الصور بنفسك."
        )

        answer = input(f"\nاكتب 'نعم' حرفياً لتأكيد كتابة story-id {story_id} (نص+صور، reviewed=false): ")
        if answer.strip() != "نعم":
            print(f"تم تخطّي story-id {story_id} - لم يُكتب شيء.")
            skipped.append(story_id)
            continue

        images_payload = []
        for role in expected_roles:
            local_path = image_paths[role]
            object_path = f"{story_id}/{role}{local_path.suffix.lower()}"
            url = _upload_storage_object(local_path, object_path)
            images_payload.append({"url": url, "role": role})

        _supabase_rpc("set_draft_story_images", {"p_id": story_id, "p_images": images_payload})
        _supabase_rpc(
            "update_draft_story_by_id",
            {
                "p_id": story_id,
                "p_original_language": text_data["lang"],
                "p_simplified_text": text_data["simplified_text"],
                "p_reading_time_minutes": text_data["reading_time_minutes"],
            },
        )
        print(f"تمت كتابة story-id {story_id} بنجاح (نص+صور، reviewed=false).")
        completed.append(story_id)

    print("─" * 60)
    print(f"اكتمل: {completed if completed else 'لا شيء'}")
    print(f"تُخطّي: {skipped if skipped else 'لا شيء'}")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = parser.add_subparsers(dest="command", required=True)

    gen = sub.add_parser("generate", help="يستدعي Anthropic API، يطبع المسودة على الشاشة، ويحفظها في ملف محلي")
    gen.add_argument("--source-file", help="ملف النص المصدر الأصلي (وإلا يُقرأ من stdin)")
    gen.add_argument("--title", required=True, help="عنوان القصة المستهدفة من التسعة الموجودة")
    gen.add_argument("--lang", default="ar", help="لغة النص المصدر (افتراضي: ar)")
    gen.add_argument("-o", "--output", help="مسار ملف المسودة الناتج (افتراضي: tools/children_stories_draft/drafts/)")
    gen.set_defaults(func=cmd_generate)

    commit = sub.add_parser("commit", help="يحدّث نص صفّ موجود بمعرّفه (بعد موافقة يدوية صريحة) عبر update_draft_story_by_id")
    commit.add_argument("--draft-file", required=True, help="ملف المسودة الناتج من generate (بعد أي تعديل يدوي)")
    commit.add_argument("--story-id", required=True, type=int, help="id الصف المستهدف من التسع القصص الأصلية (1-9)")
    commit.set_defaults(func=cmd_commit)

    upload_final = sub.add_parser(
        "upload-final",
        help="يرفع صوراً+نصوصاً معاً دفعة واحدة لكل قصة من التسع (يحتاج SUPABASE_SERVICE_ROLE_KEY محلياً لرفع الصور فقط)",
    )
    upload_final.add_argument("--images-dir", required=True, help="مجلد محلي فيه صور بأسماء <story-id>_<opening|climax|closing>.<ext>")
    upload_final.add_argument("--texts-dir", required=True, help="مجلد محلي فيه ملفات نص <story-id>.json (نفس حقول ملف generate)")
    upload_final.add_argument("--story-id", type=int, default=None, help="عالج قصة واحدة فقط بمعرّفها (1-9) بدل التسع كلها")
    upload_final.set_defaults(func=cmd_upload_final)

    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
