#!/usr/bin/env python3
"""مقارنة آلية مرجعية بين ترجمات سراج المحلية ومرجع مستقل (Quran.com).

مهم جداً - اقرأ قبل الاستخدام:
هذا السكربت **لا** يفهم المعنى الديني للنصوص ولا "يراجع" الترجمات كناطق
أصلي أو كمتخصص شرعي. كل ما يفعله: حساب تشابه محتوى إحصائي (تداخل مجموعة الكلمات - Jaccard) بين
نص سراج ونص مرجع مستقل لكل آية، ثم يُبرز الآيات ذات التشابه الأدنى
إحصائياً ضمن كل لغة كـ"مرشحة لمراجعة بشرية" - لا أكثر. أي اختلاف
مُبرَز هنا **قد يكون فرقاً أسلوبياً طبيعياً بين مترجمَين مستقلَّين**،
وليس بالضرورة خطأً. القرار النهائي دائماً لمراجع بشري مختص.

الاستخدام:
    python3 compare_translations.py [--lang en] [--no-cache]

المخرجات:
    reports/translation_review/{lang}.md  (تقرير لكل لغة)
    reports/translation_review/README.md  (ملخص شامل)
"""

from __future__ import annotations

import argparse
import json
import re
import statistics
import time
import urllib.error
import urllib.request
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
TOOLS_DIR = Path(__file__).resolve().parent
REPORTS_DIR = REPO_ROOT / "reports" / "translation_review"
CACHE_DIR = TOOLS_DIR / ".raw_cache"  # غير مرفوع لـgit (انظر .gitignore)
SIRAJ_TRANSLATIONS = REPO_ROOT / "assets" / "data" / "quran_translations.json"
EDITIONS_MAP = TOOLS_DIR / "reference_editions.json"

API_BASE = "https://api.quran.com/api/v4/quran/translations"
TOTAL_SURAHS = 114
REQUEST_DELAY_SECONDS = 0.25  # لطف مع الـAPI العام
FLAG_PERCENTILE = 1.0  # أدنى 1% تشابهاً لكل لغة تُبرز كمرشحة للمراجعة

_HTML_TAG_RE = re.compile(r"<[^>]+>")
_PUNCT_RE = re.compile(r"[^\w\s]", re.UNICODE)
_WS_RE = re.compile(r"\s+")


def clean_text(text: str) -> str:
    text = _HTML_TAG_RE.sub(" ", text)
    text = _PUNCT_RE.sub(" ", text)
    text = _WS_RE.sub(" ", text).strip().lower()
    return text


def similarity(a: str, b: str) -> float:
    """تشابه محتوى (Jaccard على مجموعة الكلمات) - أقل حساسية لإعادة
    ترتيب الجملة/الأسلوب من مطابقة التسلسل الحرفي، فيبرز اختلاف
    المفردات/المحتوى الفعلي بدل اختلاف الصياغة الطبيعي بين مترجمَين."""
    ca, cb = clean_text(a), clean_text(b)
    if not ca or not cb:
        return 0.0
    wa, wb = set(ca.split()), set(cb.split())
    if not wa or not wb:
        return 0.0
    return len(wa & wb) / len(wa | wb)


def fetch_chapter_translation(resource_id: int, chapter: int, use_cache: bool) -> list[str]:
    CACHE_DIR.mkdir(parents=True, exist_ok=True)
    cache_file = CACHE_DIR / f"{resource_id}_{chapter}.json"
    if use_cache and cache_file.exists():
        return json.loads(cache_file.read_text(encoding="utf-8"))

    url = f"{API_BASE}/{resource_id}?chapter_number={chapter}"
    last_err = None
    for attempt in range(3):
        try:
            req = urllib.request.Request(url, headers={"User-Agent": "siraj-translation-review/1.0"})
            with urllib.request.urlopen(req, timeout=20) as resp:
                data = json.loads(resp.read().decode("utf-8"))
            texts = [t["text"] for t in data["translations"]]
            cache_file.write_text(json.dumps(texts, ensure_ascii=False), encoding="utf-8")
            time.sleep(REQUEST_DELAY_SECONDS)
            return texts
        except (urllib.error.URLError, urllib.error.HTTPError, TimeoutError,
                OSError, KeyError, json.JSONDecodeError) as e:
            last_err = e
            time.sleep(1.5 * (attempt + 1))
    raise RuntimeError(f"فشل جلب سورة {chapter} للمصدر {resource_id}: {last_err}")


def load_siraj_translations() -> dict:
    data = json.loads(SIRAJ_TRANSLATIONS.read_text(encoding="utf-8"))
    return data["translations"]


def percentile_threshold(scores: list[float], pct: float) -> float:
    if not scores:
        return 0.0
    ordered = sorted(scores)
    idx = max(0, int(len(ordered) * pct / 100.0) - 1)
    return ordered[idx]


def compare_language(lang_code: str, edition: dict, siraj_data: dict, use_cache: bool) -> dict:
    resource_id = edition["reference_resource_id"]
    lang_siraj = siraj_data.get(lang_code, {})

    rows = []  # (surah, ayah, siraj_text, ref_text, score, word_ratio)
    for surah in range(1, TOTAL_SURAHS + 1):
        siraj_ayahs = lang_siraj.get(str(surah))
        if not siraj_ayahs:
            continue
        ref_texts = fetch_chapter_translation(resource_id, surah, use_cache)
        siraj_by_n = {a["n"]: a["text"] for a in siraj_ayahs}
        for i, ref_text in enumerate(ref_texts, start=1):
            siraj_text = siraj_by_n.get(i)
            if siraj_text is None:
                continue
            score = similarity(siraj_text, ref_text)
            sw = len(clean_text(siraj_text).split())
            rw = len(clean_text(ref_text).split())
            word_ratio = (sw / rw) if rw else 0.0
            rows.append((surah, i, siraj_text, ref_text, score, word_ratio))

    scores = [r[4] for r in rows]
    threshold = percentile_threshold(scores, FLAG_PERCENTILE)
    flagged_similarity = [r for r in rows if r[4] <= threshold]
    flagged_length = [r for r in rows if r[5] and (r[5] < 0.3 or r[5] > 3.0)]

    return {
        "lang_code": lang_code,
        "edition": edition,
        "total_compared": len(rows),
        "mean_score": statistics.mean(scores) if scores else 0.0,
        "stdev_score": statistics.pstdev(scores) if len(scores) > 1 else 0.0,
        "threshold": threshold,
        "flagged_similarity": flagged_similarity,
        "flagged_length": flagged_length,
    }


LANG_NAMES_AR = {
    "en": "الإنجليزية", "ur": "الأردية", "fa": "الفارسية", "id": "الإندونيسية",
    "tr": "التركية", "fr": "الفرنسية", "bn": "البنغالية", "ms": "الملايوية",
    "ha": "الهوساوية", "sw": "السواحيلية", "de": "الألمانية", "ru": "الروسية",
    "zh": "الصينية", "es": "الإسبانية",
}

DISCLAIMER_HEADER = """> ⚠️ **تنويه إلزامي قبل قراءة أي شيء أدناه**
>
> هذا تقرير **مقارنة آلية نصّية** (text-similarity heuristic عبر
> تشابه Jaccard على الكلمات) بين ترجمة سراج المحلية ومرجع مستقل من Quran.com. **هذا
> ليس مراجعة دلالية أو شرعية**، ولا ادّعاءً بأن أي ذكاء اصطناعي "فهم"
> معنى الآيات أو راجعها كناطق أصلي أو كمتخصص. الأداة تقيس فقط تشابه
> النص السطحي، والآيات المُبرزة أدناه هي **أدنى 1% تشابهاً إحصائياً
> ضمن هذه اللغة فقط** - أي أنها مرشحة للمراجعة البشرية، لا أخطاء
> مؤكَّدة. اختلاف الأسلوب بين مترجمَين مستقلَّين لنفس الآية أمر طبيعي
> ومتوقَّع تماماً ولا يعني خطأً بحد ذاته. **لا يُتخذ أي قرار نهائي بشأن
> صحة أي ترجمة إلا بمراجعة بشرية مختصة فعلية.**
>
> **ملاحظة منهجية مهمة عن "نسبة الطول الشاذة":** هذا المؤشر يقيس عدد
> الكلمات (بالفراغات) لا المعنى، وهو **غير موثوق إحصائياً للغات
> الإلصاقية/التركيبية الغنية** (كالتركية والروسية والسواحيلية، وينعدم
> معناه كلياً للصينية التي لا تفصل كلماتها بفراغات أصلاً) - كلمة واحدة
> في هذه اللغات قد تقابل جملة كاملة بلغة أخرى بنيوياً، فتُبرَز أعداد
> كبيرة زائفة. اعتبر هذا القسم مؤشراً ضعيفاً لهذه اللغات تحديداً، لا
> إشارة خطأ حقيقية.
"""

MAX_TABLE_ROWS = 100  # سقف عرض لكل جدول - لغات إلصاقية قد تُبرز مئات الصفوف


def write_language_report(result: dict) -> None:
    lang = result["lang_code"]
    edition = result["edition"]
    lang_name = LANG_NAMES_AR.get(lang, lang)
    path = REPORTS_DIR / f"{lang}.md"

    lines = [f"# مقارنة مرجعية: {lang_name} ({lang})", "", DISCLAIMER_HEADER, ""]

    if edition.get("note"):
        icon = "🚫" if not edition.get("independent", True) else "⚠️"
        lines.append(f"> {icon} **ملاحظة استقلالية المصدر:** {edition['note']}")
        lines.append("")

    lines += [
        "## المصادر",
        f"- ترجمة سراج: {edition['siraj_source']}",
        f"- المرجع المستقل (Quran.com resource_id={edition['reference_resource_id']}): "
        f"{edition['reference_name']}",
        "",
        "## ملخص إحصائي",
        f"- عدد الآيات المقارنة: {result['total_compared']}",
        f"- متوسط التشابه النصّي: {result['mean_score']:.3f}",
        f"- الانحراف المعياري: {result['stdev_score']:.3f}",
        f"- عتبة أدنى 1% (نقطة القطع): {result['threshold']:.3f}",
        f"- آيات مُبرزة (تشابه منخفض إحصائياً): {len(result['flagged_similarity'])}",
        f"- آيات مُبرزة (نسبة طول شاذة، خارج [0.3x, 3.0x]): {len(result['flagged_length'])}",
        "",
        "## آيات مرشّحة للمراجعة البشرية (تشابه نصّي منخفض)",
        "",
        "| سورة:آية | نص سراج | النص المرجعي | تشابه |",
        "|---|---|---|---|",
    ]
    similarity_sorted = sorted(result["flagged_similarity"], key=lambda r: r[4])
    if len(similarity_sorted) > MAX_TABLE_ROWS:
        lines.append(f"_(عرض أدنى {MAX_TABLE_ROWS} من أصل {len(similarity_sorted)} إجمالاً)_")
        lines.append("")
    for surah, ayah, siraj_text, ref_text, score, _ in similarity_sorted[:MAX_TABLE_ROWS]:
        st = siraj_text.replace("|", "\\|").replace("\n", " ")
        rt = ref_text.replace("|", "\\|").replace("\n", " ")
        lines.append(f"| {surah}:{ayah} | {st} | {rt} | {score:.3f} |")

    if result["flagged_length"]:
        length_sorted = sorted(result["flagged_length"], key=lambda r: r[5])
        lines += ["", "## آيات ذات نسبة طول شاذة (مؤشر ضعيف - انظر التنويه أعلاه)", ""]
        if len(length_sorted) > MAX_TABLE_ROWS:
            lines.append(f"_(عرض أشذّ {MAX_TABLE_ROWS} من أصل {len(length_sorted)} إجمالاً)_")
            lines.append("")
        lines += ["| سورة:آية | نص سراج | النص المرجعي | نسبة الطول |", "|---|---|---|---|"]
        for surah, ayah, siraj_text, ref_text, _, wr in length_sorted[:MAX_TABLE_ROWS]:
            st = siraj_text.replace("|", "\\|").replace("\n", " ")
            rt = ref_text.replace("|", "\\|").replace("\n", " ")
            lines.append(f"| {surah}:{ayah} | {st} | {rt} | {wr:.2f}x |")

    path.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"  كُتب: {path.relative_to(REPO_ROOT)}")


def write_summary(results: list[dict], excluded: list[tuple[str, str]]) -> None:
    lines = ["# ملخص مقارنة الترجمات المرجعية", "", DISCLAIMER_HEADER, "",
             "## طريقة العمل",
             "1. لكل لغة، اختير مترجم **مستقل** عن مترجم سراج الحالي من Quran.com "
             "(انظر `tools/translation_review/reference_editions.json`).",
             "2. جُلبت ترجمة كل سورة كاملة عبر Quran.com API (114 سورة × كل لغة).",
             "3. حُسب تشابه محتوى (تداخل مجموعة الكلمات - Jaccard) بين نص سراج والنص المرجعي "
             "لكل آية بعد تنظيف بسيط (إزالة HTML/ترقيم، توحيد الحالة).",
             "4. أُبرزت أدنى 1% تشابهاً ضمن كل لغة على حدة كمرشحة للمراجعة البشرية.",
             "", "## جدول اللغات", "",
             "| اللغة | مترجم سراج | المرجع المستقل | مستقل فعلاً؟ | آيات مقارَنة | "
             "متوسط تشابه | مُبرَزة |",
             "|---|---|---|---|---|---|---|"]
    for r in results:
        e = r["edition"]
        if not e.get("independent", True):
            mark = "⚠️ لا"
        elif r["mean_score"] >= 0.75:
            mark = "⚠️ تشابه مرتفع جداً"
        else:
            mark = "✅"
        lines.append(
            f"| {r['lang_code']} | {e['siraj_source']} | {e['reference_name']} | "
            f"{mark} | {r['total_compared']} | "
            f"{r['mean_score']:.3f} | {len(r['flagged_similarity'])} |"
        )
    if excluded:
        lines += ["", "## لغات مستبعدة من المقارنة"]
        for lang, reason in excluded:
            lines.append(f"- **{lang}**: {reason}")

    lines += ["", "## التقارير التفصيلية"]
    for r in results:
        lines.append(f"- [{r['lang_code']}.md](./{r['lang_code']}.md)")

    (REPORTS_DIR / "README.md").write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"  كُتب: {(REPORTS_DIR / 'README.md').relative_to(REPO_ROOT)}")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--lang", action="append", help="لغة محددة فقط (يمكن تكرارها)")
    parser.add_argument("--no-cache", action="store_true")
    args = parser.parse_args()

    REPORTS_DIR.mkdir(parents=True, exist_ok=True)
    editions = json.loads(EDITIONS_MAP.read_text(encoding="utf-8"))["languages"]
    siraj_data = load_siraj_translations()

    target_langs = args.lang if args.lang else list(editions.keys())
    excluded = []
    results = []

    for lang in target_langs:
        edition = editions[lang]
        if not edition.get("independent", True) and lang == "ms":
            excluded.append((lang, edition["note"]))
            print(f"تخطّي {lang}: {edition['note']}")
            continue
        print(f"مقارنة {lang} ...")
        try:
            result = compare_language(lang, edition, siraj_data, use_cache=not args.no_cache)
        except RuntimeError as e:
            print(f"  فشل جلب {lang} (شبكة)، سيُعاد لاحقاً: {e}")
            continue
        results.append(result)
        write_language_report(result)

    write_summary(results, excluded)
    print("انتهى.")


if __name__ == "__main__":
    main()
