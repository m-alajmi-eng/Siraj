#!/usr/bin/env python3
"""يحلّ hadiths.id الفعلي لكل مطابقة عالية الثقة (ratio>=0.85, matchlen>=15)
عبر مطابقة نصية حرفية تامة لـtext_ar (نفس منهجية مشروع ربط حديث↔آية سابقاً)،
ثم يبني SQL تحديث kg_edges (dst_id + dst_type='hadith') - لا تنفيذ هنا."""
import json
import requests

SUPABASE_URL = "https://pzcnkzsicyxlzqwjznvh.supabase.co"
SUPABASE_KEY = "sb_publishable_No_no5hRjIZU9dIBuqFcbQ_9I8IxWu9"
HEADERS = {"apikey": SUPABASE_KEY, "Authorization": f"Bearer {SUPABASE_KEY}"}

BOOK_NAME_TO_ID = {
    "صحيح البخاري": "bukhari", "جامع الترمذي": "tirmidhi",
    "سنن أبي داود": "abudawud", "سنن النسائي": "nasai",
    "سنن ابن ماجه": "ibnmajah", "صحيح مسلم": "muslim",
}

with open('/tmp/citation_match_report.json') as f:
    results = json.load(f)
high = [r for r in results if r['best'] and r['best']['ratio'] >= 0.85 and r['best']['matchlen'] >= 15]

resolved = []
unresolved = []
for r in high:
    b = r['best']
    book_id = BOOK_NAME_TO_ID.get(b['book_name'])
    if book_id and b['hadith_number'] is not None:
        # مسار robust: book_id + hadith_number (لا مطابقة نص كامل عملاقة)
        resp = requests.get(f"{SUPABASE_URL}/rest/v1/hadiths",
                             headers=HEADERS,
                             params={"select": "id,text_ar", "book_id": f"eq.{book_id}",
                                     "hadith_number": f"eq.{b['hadith_number']}"})
        resp.raise_for_status()
        rows = resp.json()
        if len(rows) == 1 and rows[0]['text_ar'] == b['text_ar']:
            resolved.append({**r, 'hadith_id': rows[0]['id']})
            continue
        unresolved.append({**r, 'match_count': len(rows), 'note': 'book+number path failed'})
        continue
    # لا book/hadith_number (على الأرجح HadeethEnc) - مطابقة substring ثم تأكيد نص كامل
    prefix = b['text_ar'][:60]
    resp = requests.get(f"{SUPABASE_URL}/rest/v1/hadiths",
                         headers=HEADERS,
                         params={"select": "id,text_ar", "text_ar": f"ilike.{prefix}*"})
    resp.raise_for_status()
    rows = resp.json()
    exact = [row for row in rows if row['text_ar'] == b['text_ar']]
    if len(exact) == 1:
        resolved.append({**r, 'hadith_id': exact[0]['id']})
    else:
        unresolved.append({**r, 'match_count': len(exact), 'note': 'ilike-prefix path'})

print(f"مُحَلَّل بنجاح (تطابق نصي حرفي تام، صف واحد بالضبط): {len(resolved)}")
print(f"غير محلول (0 أو أكثر من صف مطابق): {len(unresolved)}")
for u in unresolved:
    print(f"  id={u['id']} match_count={u['match_count']}")

with open('/tmp/citation_resolved.json', 'w') as f:
    json.dump(resolved, f, ensure_ascii=False, indent=1)
