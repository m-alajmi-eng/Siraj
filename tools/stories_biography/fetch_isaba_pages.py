#!/usr/bin/env python3
"""أداة استخراج صفحات "الإصابة في تمييز الصحابة" (ابن حجر العسقلاني) من
مجال Page: (صفحة:) على ويكي مصدر العربية - بخلاف أسد الغابة/البداية
والنهاية، هذا الكتاب لا يملك بنية مقالات فرعية مرتّبة (روابط "الجزء
الأول" إلخ بالصفحة الرئيسية ميتة، تحقَّق فعلياً 2026-08-10)، فالمصدر
الوحيد المتاح هو صفحات المسح الضوئي الخام (namespace=104) مرتَّبة رقمياً
داخل كل جزء (١-٨)، بجودة "pagequality level=1" (نص OCR غير مراجَع بشرياً
بعد - يحتاج فحصاً يدوياً أدق من المعتاد لأخطاء تباعد/دمج كلمات).

الاستخدام:
    # عدّ/سرد صفحات جزء معيّن
    python3 fetch_isaba_pages.py --list --volume 1

    # جلب نطاق صفحات من جزء معيّن (بترتيب رقمي صحيح، لا أبجدي)
    python3 fetch_isaba_pages.py --volume 1 --start 15 --end 60 -o out.txt

    # تقسيم الصفحات المجلوبة إلى تراجم مفردة عبر رقم الترجمة المضمَّن
    # بالنص نفسه (مثال: "٢١ ( أبيض) بن هني...")
    python3 fetch_isaba_pages.py --volume 1 --start 15 --end 60 --split --min-words 150
"""

from __future__ import annotations

import argparse
import json
import re
import sys
import time
import urllib.error
import urllib.parse
import urllib.request

API_URL = "https://ar.wikisource.org/w/api.php"
HEADERS = {"User-Agent": "siraj-stories-extractor/1.0 (research; siraj project)"}

# أرقام عربية-هندية → لاتينية، لاستخراج رقم الصفحة/الترجمة للفرز الصحيح
_AR_DIGITS = str.maketrans("٠١٢٣٤٥٦٧٨٩", "0123456789")

# فاصل عنوان الصفحة القياسي {{رص|...|...|...}} + pagequality - يُقصّ دائماً
_HEADER_RE = re.compile(r"<noinclude>.*?</noinclude>", re.DOTALL)
# رقم ترجمة جديدة: رقم عربي (أرقام هندية) يتبعه قوس يحوي اسماً
_ENTRY_START_RE = re.compile(r"([٠-٩]{1,5})\s*\(\s*([^)]{2,80})\)")


def api_get(params: dict, retries: int = 5) -> dict:
    url = API_URL + "?" + urllib.parse.urlencode(params)
    for attempt in range(retries):
        req = urllib.request.Request(url, headers=HEADERS)
        try:
            with urllib.request.urlopen(req, timeout=30) as resp:
                return json.loads(resp.read())
        except urllib.error.HTTPError as e:
            if e.code == 429:
                time.sleep(5 * (attempt + 1))
                continue
            raise
    raise SystemExit("فشل الطلب بعد عدة محاولات (rate limit مستمر)")


def page_num(title: str) -> int:
    m = re.search(r"/(\d+)$", title)
    return int(m.group(1)) if m else -1


def list_volume_pages(volume: int) -> list[str]:
    prefix = f"الإصابة في تمييز الصحابة{volume}.pdf"
    params = {
        "action": "query",
        "list": "allpages",
        "apprefix": prefix,
        "apnamespace": 104,
        "aplimit": 500,
        "format": "json",
    }
    titles: list[str] = []
    while True:
        d = api_get(params)
        titles.extend(p["title"] for p in d["query"]["allpages"])
        cont = d.get("continue", {}).get("apcontinue")
        if not cont:
            break
        params["apcontinue"] = cont
        time.sleep(1)
    return sorted(titles, key=page_num)


def fetch_pages_content(titles: list[str]) -> dict[str, str]:
    """يرجع {title: نص wikitext خام} - يستثني وسم <noinclude> (ترويسة/رقم صفحة)."""
    result: dict[str, str] = {}
    for i in range(0, len(titles), 20):
        batch = titles[i : i + 20]
        params = {
            "action": "query",
            "titles": "|".join(batch),
            "prop": "revisions",
            "rvprop": "content",
            "rvslots": "main",
            "format": "json",
        }
        d = api_get(params)
        for pg in d["query"]["pages"].values():
            title = pg.get("title")
            rev = pg.get("revisions", [{}])[0]
            content = rev.get("slots", {}).get("main", {}).get("*", "")
            content = _HEADER_RE.sub("", content).strip()
            result[title] = content
        time.sleep(2)
    return result


def split_entries(full_text: str) -> list[tuple[str, str]]:
    """يفصل النص المجمَّع (عدة صفحات متتالية) إلى (رقم الترجمة، النص) لكل
    ترجمة عبر نمط 'رقم ( اسم )' - لا يضمن دقة 100% (نص OCR، قد يفشل مع
    أرقام ملتبسة بأرقام صفحات مضمَّنة خطأً) - يحتاج مراجعة يدوية لكل نتيجة
    قبل أي استخدام، تماماً كبقية مصادر هذا المشروع."""
    matches = list(_ENTRY_START_RE.finditer(full_text))
    entries: list[tuple[str, str]] = []
    for idx, m in enumerate(matches):
        start = m.start()
        end = matches[idx + 1].start() if idx + 1 < len(matches) else len(full_text)
        entry_num = m.group(1).translate(_AR_DIGITS)
        entry_text = full_text[start:end].strip()
        entries.append((entry_num, entry_text))
    return entries


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--volume", type=int, required=True)
    ap.add_argument("--list", action="store_true", help="اطبع فقط قائمة الصفحات المرتَّبة رقمياً")
    ap.add_argument("--start", type=int)
    ap.add_argument("--end", type=int)
    ap.add_argument("--split", action="store_true", help="قسِّم النص المجموع إلى تراجم مفردة")
    ap.add_argument("--min-words", type=int, default=0, help="اطبع فقط التراجم بعدد كلمات >= هذا (مع --split)")
    ap.add_argument("-o", "--output", type=argparse.FileType("w", encoding="utf-8"), default=sys.stdout)
    args = ap.parse_args()

    titles = list_volume_pages(args.volume)

    if args.list:
        for t in titles:
            print(t, "->", page_num(t))
        print(f"إجمالي: {len(titles)} صفحة", file=sys.stderr)
        return

    if args.start is not None and args.end is not None:
        titles = [t for t in titles if args.start <= page_num(t) <= args.end]

    content_map = fetch_pages_content(titles)
    ordered = [content_map[t] for t in titles if t in content_map]
    full_text = "\n\n".join(ordered)

    if not args.split:
        args.output.write(full_text)
        return

    entries = split_entries(full_text)
    kept = 0
    for num, text in entries:
        words = len(text.split())
        if words < args.min_words:
            continue
        kept += 1
        args.output.write(f"===== ترجمة رقم {num} ({words} كلمة) =====\n")
        args.output.write(text)
        args.output.write("\n\n")
    print(f"إجمالي تراجم مُكتشَفة: {len(entries)} - اجتاز العتبة (>= {args.min_words} كلمة): {kept}", file=sys.stderr)


if __name__ == "__main__":
    main()
