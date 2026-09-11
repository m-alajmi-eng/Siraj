#!/usr/bin/env python3
"""
فرز الـ518 استشهاداً بلا حديث مطابَق (kg_edges, edge_type=
'authentic_hadith_citation', dst_type='citation', dst_id=NULL) - كلها من
"أضواء البيان" للشنقيطي. يطابق citation_text مقابل hadiths.text_ar عبر
RPC search_hadiths + تسجيل LCS (نفس منهجية tools/hadith_ayah_linking/
extract_match.py المُثبتة سابقاً)، بلا أي تحديث فعلي - تقرير فرز فقط.
"""
import json
import re
import sys
from difflib import SequenceMatcher

import requests

SUPABASE_URL = "https://pzcnkzsicyxlzqwjznvh.supabase.co"
SUPABASE_KEY = "sb_publishable_No_no5hRjIZU9dIBuqFcbQ_9I8IxWu9"
HEADERS = {"apikey": SUPABASE_KEY, "Authorization": f"Bearer {SUPABASE_KEY}"}

TASHKEEL = re.compile(r'[ً-ْٰـۖ-ۭ]')
QUOTE_CHARS = str.maketrans('', '', '«»"“”')

BOOK_HINTS = {
    'البخاري': 'bukhari', 'بخاري': 'bukhari',
    'مسلم': 'muslim',
    'الشيخان': 'bukhari+muslim', 'صحيحيهما': 'bukhari+muslim', 'متفق عليه': 'bukhari+muslim',
    'الترمذي': 'tirmidhi',
    'أبو داود': 'abudawud', 'أبي داود': 'abudawud',
    'النسائي': 'nasai',
    'ابن ماجه': 'ibnmajah',
    'أحمد': 'ahmad(غير موجود بقاعدتنا)',
}


def strip_tashkeel(s):
    return TASHKEEL.sub('', s)


def clean_quote(s):
    return s.translate(QUOTE_CHARS).strip()


def guess_book(citation_text, source_reference):
    hay = citation_text + ' ' + source_reference
    found = []
    for k, v in BOOK_HINTS.items():
        if k in hay:
            found.append(v)
    return found


def search_hadiths(query, limit=8):
    r = requests.post(
        f"{SUPABASE_URL}/rest/v1/rpc/search_hadiths",
        headers={**HEADERS, "Content-Type": "application/json"},
        json={"search_query": query, "match_limit": limit},
    )
    r.raise_for_status()
    return r.json()


def lcs_ratio(a, b):
    sm = SequenceMatcher(None, a, b, autojunk=False)
    m = sm.find_longest_match(0, len(a), 0, len(b))
    return m.size / max(1, len(a)), m.size


def main():
    with open('/tmp/citations_raw.json') as f:
        content = f.read()
    start = content.find('{'); end = content.rfind('}') + 1
    rows = json.loads(content[start:end])['rows']

    min_len = 15
    candidates = [r for r in rows if len(clean_quote(r['citation_text'])) >= min_len]
    print(f"إجمالي: {len(rows)} - بعد فلتر الطول (>={min_len} حرفاً): "
          f"{len(candidates)} - مستبعَد لقِصر الاقتباس: {len(rows) - len(candidates)}",
          file=sys.stderr)

    results = []
    for i, r in enumerate(candidates):
        q = strip_tashkeel(clean_quote(r['citation_text']))
        try:
            cands = search_hadiths(q)
        except Exception as e:
            print(f"error at id={r['id']}: {e}", file=sys.stderr)
            cands = []
        best = None
        for c in cands:
            cand_text = strip_tashkeel(c['text_ar'])
            ratio, matchlen = lcs_ratio(q, cand_text)
            if best is None or ratio > best['ratio']:
                # ملاحظة: search_hadiths RPC لا يرجع id - يُحَل لاحقاً فقط
                # للمرشَّحين المؤكَّدين عبر مطابقة نصية حرفية تامة بجدول hadiths
                # (نفس منهجية مشروع ربط حديث↔آية سابقاً).
                best = {'ratio': ratio, 'matchlen': matchlen,
                        'hadith_number': c.get('hadith_number'),
                        'book_name': c.get('book_name'), 'text_ar': c['text_ar']}
        results.append({
            'id': r['id'], 'citation_text': r['citation_text'],
            'source_reference': r['source_reference'],
            'book_guess': guess_book(r['citation_text'], r['source_reference']),
            'best': best,
        })
        if (i + 1) % 50 == 0:
            print(f"progress {i+1}/{len(candidates)}", file=sys.stderr)

    with open('/tmp/citation_match_report.json', 'w') as f:
        json.dump(results, f, ensure_ascii=False, indent=1)

    high = [r for r in results if r['best'] and r['best']['ratio'] >= 0.85 and r['best']['matchlen'] >= 15]
    print(f"إجمالي مُرشَّح (بعد فلتر الطول): {len(candidates)}", file=sys.stderr)
    print(f"مطابقة عالية الثقة (ratio>=0.85, matchlen>=15): {len(high)}", file=sys.stderr)


if __name__ == '__main__':
    main()
