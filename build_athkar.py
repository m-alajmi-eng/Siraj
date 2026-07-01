import json, urllib.request, time, re

def parse_repeat(v):
    m = re.search(r'\d+', str(v))
    return int(m.group()) if m else 1

def fetch(url):
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    with urllib.request.urlopen(req, timeout=30) as r:
        raw = r.read().decode('utf-8-sig')
    # تنظيف أحرف التحكّم غير الصالحة (تسبّب فشل JSON مثل باب 126)
    raw = re.sub(r'[\x00-\x08\x0b\x0c\x0e-\x1f\x7f]', ' ', raw)
    return json.loads(raw)

BASE = 'https://www.hisnmuslim.com/api'

print("جلب الفهرس...")
index = fetch(f'{BASE}/ar/husn_ar.json')
cats = index[list(index.keys())[0]]
print(f"عدد الأبواب: {len(cats)}")

categories = []
athkar = []
seen_ids = set()
ok, fail = 0, 0

for i, cat in enumerate(cats):
    cid = cat['ID']
    categories.append({'id': str(cid), 'name': cat['TITLE'].strip()})
    try:
        ar_data = fetch(f'{BASE}/ar/{cid}.json')
        en_data = fetch(f'{BASE}/en/{cid}.json')
        ar_items = ar_data[list(ar_data.keys())[0]]
        en_items = en_data[list(en_data.keys())[0]]
        en_map = {it['ID']: it.get('TRANSLATED_TEXT', '') for it in en_items}
        for it in ar_items:
            aid = it['ID']
            if aid in seen_ids:
                continue
            seen_ids.add(aid)
            athkar.append({
                'id': aid,
                'category': str(cid),
                'arabic': (it.get('ARABIC_TEXT') or '').strip(),
                'translations': {'en': (en_map.get(aid) or '').strip()},
                'count': parse_repeat(it.get('REPEAT', '1')),
                'audio': it.get('AUDIO', ''),
            })
        ok += 1
    except Exception as e:
        fail += 1
        print(f"  فشل باب {cid}: {e}")
    time.sleep(0.08)

out = {'categories': categories, 'athkar': athkar}
path = '/home/user/projects/siraj/assets/data/athkar_full.json'
with open(path, 'w', encoding='utf-8') as f:
    json.dump(out, f, ensure_ascii=False, indent=2)

print(f"\n✅ حُفظ: {path}")
print(f"أبواب نجحت: {ok} | فشلت: {fail}")
print(f"الفئات: {len(categories)} | الأذكار: {len(athkar)}")
en_count = sum(1 for a in athkar if a['translations'].get('en'))
print(f"مترجمة en: {en_count}/{len(athkar)}")
