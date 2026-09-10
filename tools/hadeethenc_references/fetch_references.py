#!/usr/bin/env python3
"""
استخراج قائمة المراجع الحرفية لكل حديث من HadeethEnc.com، عبر قسم
"المراجع" المُصيَّر فعلياً بصفحة الحديث (`<ol id="references"><li>...`)
- كل `<li>` مرجع مستقل حقيقي بحدود واضحة يحددها الموقع نفسه، لا تخمين
تقسيم من نص مسطَّح. (محاولة أولى استخدمت حقل citation ضمن JSON-LD -
تبيَّن أنه **مبتور أحياناً** لقوائم طويلة، مثال فعلي: حديث id=2750
كان حقل citation ينتهي بـ"...العما..." بينما قسم <ol id="references">
الفعلي يحوي "لحمد بن ناصر العمار" كاملاً - لذا استُبعد استخدام
citation نهائياً).

hadiths.id يطابق مباشرة hadeethenc.com/ar/browse/hadith/[id] (تحقَّق
فعلياً على 19 عيّنة عشوائية قبل بناء هذا السكربت).

تأخير تكيّفي (نفس نمط fetch_batch.py المستخدَم سابقاً لويكي مصدر):
يبدأ بـ`--delay`، يتصاعد `delay = min(delay*1.7, 8.0)` عند أي فشل/خطأ
HTTP، ويتراجع `delay = max(delay*0.7, floor)` بعد 5 نجاحات متتالية.

الاستخدام:
    python3 fetch_references.py --ids-file ids.txt --out batch1.jsonl

كل سطر بملف out هو JSON واحد: {"id": <int>, "references": <list[str]|null>,
"http_status": <int>, "error": <str|null>}. عمل تراكمي آمن لإعادة
التشغيل: مرّر --skip-existing مع ملف out نفسه ليتجاوز أي id مُنجَز
مسبقاً بنفس الملف.
"""
import argparse
import html
import json
import re
import sys
import time
import urllib.error
import urllib.request
from html.parser import HTMLParser

BASE = "https://hadeethenc.com/ar/browse/hadith/{}"


class _RefsExtractor(HTMLParser):
    def __init__(self):
        super().__init__()
        self.in_refs_ol = False
        self.ol_depth = 0
        self.in_li = False
        self.li_depth = 0
        self.current = []
        self.refs = []

    def handle_starttag(self, tag, attrs):
        attrs_d = dict(attrs)
        if tag == "ol" and attrs_d.get("id") == "references":
            self.in_refs_ol = True
            self.ol_depth = 1
            return
        if self.in_refs_ol:
            if tag == "ol":
                self.ol_depth += 1
            if tag == "li" and not self.in_li:
                self.in_li = True
                self.li_depth = 1
                self.current = []
            elif self.in_li and tag == "li":
                self.li_depth += 1
            if tag == "br" and self.in_li:
                self.current.append("\n")

    def handle_endtag(self, tag):
        if self.in_refs_ol:
            if tag == "li" and self.in_li:
                self.li_depth -= 1
                if self.li_depth == 0:
                    self.in_li = False
                    text = "".join(self.current)
                    text = re.sub(r"[ \t]+", " ", text).strip()
                    if text:
                        self.refs.append(text)
            if tag == "ol":
                self.ol_depth -= 1
                if self.ol_depth == 0:
                    self.in_refs_ol = False

    def handle_data(self, data):
        if self.in_refs_ol and self.in_li:
            self.current.append(data)

    def handle_entityref(self, name):
        if self.in_refs_ol and self.in_li:
            self.current.append(html.unescape(f"&{name};"))

    def handle_charref(self, name):
        if self.in_refs_ol and self.in_li:
            self.current.append(html.unescape(f"&#{name};"))


def extract_references(page_html):
    p = _RefsExtractor()
    p.feed(page_html)
    return p.refs if p.refs else None


def fetch_one(hadith_id, timeout=20):
    req = urllib.request.Request(
        BASE.format(hadith_id),
        headers={"User-Agent": "siraj-hadeethenc-references/1.0"},
    )
    try:
        with urllib.request.urlopen(req, timeout=timeout) as resp:
            status = resp.status
            page_html = resp.read().decode("utf-8", errors="replace")
    except urllib.error.HTTPError as e:
        return {"id": hadith_id, "references": None, "http_status": e.code,
                "error": f"HTTPError {e.code}"}
    except Exception as e:
        return {"id": hadith_id, "references": None, "http_status": None,
                "error": str(e)}
    refs = extract_references(page_html)
    return {"id": hadith_id, "references": refs, "http_status": status,
            "error": None if refs is not None else "references list not found"}


def load_done_ids(out_path):
    done = set()
    try:
        with open(out_path) as f:
            for line in f:
                line = line.strip()
                if not line:
                    continue
                try:
                    row = json.loads(line)
                except Exception:
                    continue
                if row.get("references") is not None:
                    done.add(row["id"])
    except FileNotFoundError:
        pass
    return done


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--ids", help="comma-separated ids")
    ap.add_argument("--ids-file", help="one id per line")
    ap.add_argument("--out", required=True, help="JSONL output (appended to)")
    ap.add_argument("--delay", type=float, default=1.0)
    ap.add_argument("--min-delay", type=float, default=0.5)
    ap.add_argument("--max-delay", type=float, default=8.0)
    ap.add_argument("--skip-existing", action="store_true",
                     help="skip ids already successfully recorded in --out")
    ap.add_argument("--max-retries", type=int, default=4)
    args = ap.parse_args()

    if args.ids:
        ids = [int(x) for x in args.ids.split(",") if x.strip()]
    elif args.ids_file:
        with open(args.ids_file) as f:
            ids = [int(line.strip()) for line in f if line.strip()]
    else:
        raise SystemExit("need --ids or --ids-file")

    if args.skip_existing:
        done = load_done_ids(args.out)
        ids = [i for i in ids if i not in done]
        print(f"skipping {len(done)} already-done ids, {len(ids)} remaining", file=sys.stderr)

    delay = args.delay
    consecutive_ok = 0
    n_ok, n_fail = 0, 0

    with open(args.out, "a") as out_f:
        for i, hadith_id in enumerate(ids):
            result = None
            for attempt in range(args.max_retries):
                result = fetch_one(hadith_id)
                if result["references"] is not None:
                    break
                delay = min(delay * 1.7, args.max_delay)
                consecutive_ok = 0
                time.sleep(delay)
            if result["references"] is not None:
                n_ok += 1
                consecutive_ok += 1
                if consecutive_ok >= 5:
                    delay = max(delay * 0.7, args.min_delay)
                    consecutive_ok = 0
            else:
                n_fail += 1
                print(f"FAILED id={hadith_id}: {result['error']}", file=sys.stderr)

            out_f.write(json.dumps(result, ensure_ascii=False) + "\n")
            out_f.flush()

            if (i + 1) % 100 == 0:
                print(f"progress {i+1}/{len(ids)} (ok={n_ok} fail={n_fail} delay={delay:.2f}s)",
                      file=sys.stderr)

            time.sleep(delay)

    print(f"done: {n_ok} ok, {n_fail} failed, out of {len(ids)}", file=sys.stderr)


if __name__ == "__main__":
    main()
