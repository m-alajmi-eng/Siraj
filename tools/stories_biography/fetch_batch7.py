#!/usr/bin/env python3
"""جلب دفعة أسماء من سير أعلام النبلاء (ويكي مصدر) - دفعة سابعة.

يعيد استخدام منطق fetch_wikisource_entry.py (fetch_page_html + html_to_clean_text)
حرفياً بدون تعديل، مع حلقة دفعية فوقها:
- إعادة محاولة تصاعدية عند HTTP 429 (تراجع تصاعدي: ×1.7 حتى سقف 8.0 ثانية)
- **تراجع فعلي للتأخير**: بعد 5 نجاحات متتالية بلا 429، delay يتراجع ×0.7
  (الدرس المُوثَّق من دفعة 6 الذي حسَّن السرعة كثيراً عن دفعة 5)
- لا استعلامات أخرى بالتوازي (قيد صارم موثَّق من درس دفعة 5)

يحفظ نتيجة كل صفحة (عنوان مطلوب، عنوان فعلي بعد أي تحويل، نص نظيف، عدد
كلمات) كسجل JSON واحد بالسطر (JSON Lines) في ملف الخرج، لتيسير المعالجة
اللاحقة دون إعادة الجلب.
"""

from __future__ import annotations

import json
import sys
import time
import urllib.error

sys.path.insert(0, "/home/user/projects/siraj/tools/stories_biography")
from fetch_wikisource_entry import fetch_page_html, html_to_clean_text  # noqa: E402

NAMES_FILE = sys.argv[1] if len(sys.argv) > 1 else "/tmp/claude-1000/-home-user-projects-siraj/c7bf5dd8-46f6-4932-8864-a47b69c60a73/scratchpad/batch7_names.txt"
OUT_FILE = sys.argv[2] if len(sys.argv) > 2 else "/tmp/claude-1000/-home-user-projects-siraj/c7bf5dd8-46f6-4932-8864-a47b69c60a73/scratchpad/batch7_fetched.jsonl"

MAX_DELAY = 8.0
MIN_DELAY = 0.8


def main() -> None:
    with open(NAMES_FILE, encoding="utf-8") as f:
        names = [line.strip() for line in f if line.strip()]

    print(f"سيُجلب {len(names)} اسماً من {NAMES_FILE} -> {OUT_FILE}", file=sys.stderr)

    delay = 1.4
    consecutive_success = 0
    results = []

    with open(OUT_FILE, "w", encoding="utf-8") as out:
        for i, name in enumerate(names, 1):
            attempt = 0
            ok = False
            while not ok:
                attempt += 1
                try:
                    real_title, html = fetch_page_html(name)
                    text = html_to_clean_text(html)
                    record = {
                        "requested_title": name,
                        "real_title": real_title,
                        "text": text,
                        "word_count": len(text.split()),
                        "char_count": len(text),
                        "error": None,
                    }
                    ok = True
                    consecutive_success += 1
                    if consecutive_success >= 5 and delay > MIN_DELAY:
                        delay = max(MIN_DELAY, delay * 0.7)
                        consecutive_success = 0
                except urllib.error.HTTPError as e:
                    if e.code == 429:
                        consecutive_success = 0
                        delay = min(delay * 1.7, MAX_DELAY)
                        print(f"[{i}/{len(names)}] 429 على '{name}' - إعادة محاولة #{attempt} بعد {delay:.1f}s", file=sys.stderr)
                        time.sleep(delay)
                        continue
                    else:
                        record = {
                            "requested_title": name,
                            "real_title": None,
                            "text": None,
                            "word_count": 0,
                            "char_count": 0,
                            "error": f"HTTPError {e.code}",
                        }
                        ok = True
                except SystemExit as e:
                    record = {
                        "requested_title": name,
                        "real_title": None,
                        "text": None,
                        "word_count": 0,
                        "char_count": 0,
                        "error": str(e),
                    }
                    ok = True
                except Exception as e:  # noqa: BLE001
                    record = {
                        "requested_title": name,
                        "real_title": None,
                        "text": None,
                        "word_count": 0,
                        "char_count": 0,
                        "error": f"{type(e).__name__}: {e}",
                    }
                    ok = True

            out.write(json.dumps(record, ensure_ascii=False) + "\n")
            out.flush()
            results.append(record)
            status = "OK" if record["error"] is None else f"FAIL({record['error']})"
            print(f"[{i}/{len(names)}] {name} -> {status} ({record['word_count']} كلمة) delay={delay:.2f}", file=sys.stderr)
            time.sleep(delay)

    n_ok = sum(1 for r in results if r["error"] is None)
    n_fail = len(results) - n_ok
    print(f"\nانتهى الجلب: {n_ok} نجاح، {n_fail} فشل من أصل {len(results)}", file=sys.stderr)
    if n_fail:
        print("الفاشلة:", [r["requested_title"] for r in results if r["error"]], file=sys.stderr)


if __name__ == "__main__":
    main()
