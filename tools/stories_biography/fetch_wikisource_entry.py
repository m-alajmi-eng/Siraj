#!/usr/bin/env python3
"""أداة استخراج نص مفرغ حرفياً لصفحة واحدة من ويكي مصدر العربية عبر واجهة
MediaWiki API مباشرة (action=parse&prop=text) - بدون أي وسيط يلخّص أو
يعيد صياغة المحتوى، لأن متطلب المشروع نسخ حرفي 100% (لا إعادة صياغة).

الاستخدام:
    python3 fetch_wikisource_entry.py "أسد الغابة (ط. الوهبية)/حرف العين/باب العين والميم/عمر بن الخطاب" \
        -o out.txt
"""

from __future__ import annotations

import argparse
import json
import re
import sys
import urllib.parse
import urllib.request
from html.parser import HTMLParser

API_URL = "https://ar.wikisource.org/w/api.php"

SKIP_TAGS = {"style", "script", "sup"}
SKIP_CLASS_MARKERS = ("reference", "mw-editsection", "noprint", "ws-noexport")


class _TextExtractor(HTMLParser):
    def __init__(self) -> None:
        super().__init__()
        self.parts: list[str] = []
        self.skip_stack: list[bool] = []

    def _should_skip(self, tag: str, attrs_d: dict) -> bool:
        if tag in SKIP_TAGS:
            return True
        cls = attrs_d.get("class", "")
        if any(marker in cls for marker in SKIP_CLASS_MARKERS):
            return True
        if attrs_d.get("id") == "headertemplate":
            return True
        return False

    def handle_starttag(self, tag: str, attrs: list[tuple[str, str | None]]) -> None:
        attrs_d = {k: (v or "") for k, v in attrs}
        skip = self._should_skip(tag, attrs_d)
        parent_skip = self.skip_stack[-1] if self.skip_stack else False
        self.skip_stack.append(skip or parent_skip)
        if tag == "br":
            self.parts.append("\n")

    def handle_startendtag(self, tag: str, attrs) -> None:
        if tag == "br":
            self.parts.append("\n")

    def handle_endtag(self, tag: str) -> None:
        if self.skip_stack:
            self.skip_stack.pop()

    def handle_data(self, data: str) -> None:
        if not (self.skip_stack and self.skip_stack[-1]):
            self.parts.append(data)


def fetch_page_html(title: str) -> tuple[str, str]:
    """يرجع (العنوان الفعلي بعد أي تحويل، نص HTML للمحتوى المُصيَّر)."""
    params = {
        "action": "parse",
        "page": title,
        "format": "json",
        "formatversion": "2",
        "prop": "text|displaytitle",
        "redirects": "1",
    }
    url = f"{API_URL}?{urllib.parse.urlencode(params)}"
    req = urllib.request.Request(url, headers={"User-Agent": "siraj-stories-extractor/1.0"})
    with urllib.request.urlopen(req, timeout=30) as resp:
        data = json.loads(resp.read())
    if "error" in data:
        raise SystemExit(f"خطأ من واجهة ويكي مصدر: {data['error']}")
    parse = data["parse"]
    return parse["title"], parse["text"]


def html_to_clean_text(html: str) -> str:
    p = _TextExtractor()
    p.feed(html)
    text = "".join(p.parts)
    text = re.sub(r"[ \t]+", " ", text)
    text = re.sub(r"\n[ \t]+", "\n", text)
    text = re.sub(r"\n{3,}", "\n\n", text)
    return text.strip()


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("title", help="عنوان صفحة ويكي مصدر (بدون ترميز URL)")
    parser.add_argument("-o", "--output", help="ملف الحفظ (نص عادي). افتراضياً stdout")
    args = parser.parse_args()

    real_title, html = fetch_page_html(args.title)
    text = html_to_clean_text(html)

    if args.output:
        with open(args.output, "w", encoding="utf-8") as f:
            f.write(text)
        print(f"العنوان الفعلي: {real_title}", file=sys.stderr)
        print(f"تم الحفظ في: {args.output} ({len(text)} حرف، {len(text.split())} كلمة)", file=sys.stderr)
    else:
        print(f"# {real_title}\n")
        print(text)


if __name__ == "__main__":
    main()
