#!/usr/bin/env python3
"""كتابة دفعة 8 (62 صفاً) عبر upsert_story_draft بمفتاح anon فقط - سير أعلام النبلاء."""
from __future__ import annotations
import json
import sys
import urllib.error
import urllib.request
import urllib.parse

SUPABASE_URL = "https://pzcnkzsicyxlzqwjznvh.supabase.co"
ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6Y25renNpY3l4bHpxd2p6bnZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIyMDY2NjQsImV4cCI6MjA5Nzc4MjY2NH0.W2z_NZKyc1HD9CifqKvupIVcSrW1MinDAYsfpZ6ewm8"

recs = {}
for line in open("/tmp/claude-1000/-home-user-projects-siraj/c7bf5dd8-46f6-4932-8864-a47b69c60a73/scratchpad/batch8_cleaned.jsonl", encoding="utf-8"):
    r = json.loads(line)
    recs[r["requested_title"]] = r

final = [
("نافع","tabieen",None,"نافع مولى ابن عمر"),
("نافع بن جبير","tabieen",None,"نافع بن جبير بن مطعم"),
("هارون بن رئاب","tabieen",None,"هارون بن رئاب"),
("هرم بن حيان","tabieen",None,"هرم بن حيان العبدي"),
("همام بن منبه","tabieen",None,"همام بن منبه"),
("يحيى البكاء","tabieen",None,"يحيى البكاء"),
("يحيى بن الحارث","tabieen",None,"يحيى بن الحارث الذماري"),
("يحيى بن وثاب","tabieen",None,"يحيى بن وثاب"),
("يحيى بن يعمر","tabieen",None,"يحيى بن يعمر"),
("يزيد بن أبي مالك","tabieen",None,"يزيد بن أبي مالك"),
("يزيد بن عبد الله بن أسامة","tabieen",None,"يزيد بن عبد الله بن أسامة بن الهاد"),
("يونس بن إبي إسحاق","tabieen","يونس بن أبي إسحاق","يونس بن أبي إسحاق السبيعي"),
("هشام بن عروة","tabieen",None,"هشام بن عروة بن الزبير"),
("وهب بن منبه","tabieen",None,"وهب بن منبه"),
("موسى بن علي بن رباح","ulama",None,"موسى بن علي بن رباح"),
("موسى بن مسعود","ulama",None,"موسى بن مسعود (أبو حذيفة)"),
("نافع بن أبي نعيم","ulama",None,"نافع بن أبي نعيم (القارئ)"),
("نافع بن عمر","ulama",None,"نافع بن عمر الجمحي"),
("هاشم بن القاسم الليثي","ulama","أبو النضر هاشم بن القاسم","أبو النضر هاشم بن القاسم الليثي"),
("هشام الدستوائي","ulama",None,"هشام بن أبي عبد الله الدستوائي"),
("هشام بن الغاز","ulama",None,"هشام بن الغاز"),
("هشام بن سعد","ulama",None,"هشام بن سعد"),
("هشام بن عبيد الله الرازي","ulama",None,"هشام بن عبيد الله الرازي"),
("هشام بن يوسف الصنعاني","ulama",None,"هشام بن يوسف الصنعاني"),
("همام بن يحيى","ulama",None,"همام بن يحيى العوذي"),
("هوذة بن خليفة","ulama",None,"هوذة بن خليفة"),
("ورش","ulama",None,"ورش (عثمان بن سعيد)"),
("ورقاء بن عمر","ulama",None,"ورقاء بن عمر اليشكري"),
("وهب بن جرير","ulama",None,"وهب بن جرير بن حازم"),
("وهيب","ulama",None,"وهيب بن خالد"),
("يحيى بن آدم","ulama",None,"يحيى بن آدم"),
("يحيى بن أبي بكير","ulama",None,"يحيى بن أبي بكير"),
("يحيى بن إسحاق السيلحيني","ulama",None,"يحيى بن إسحاق السيلحيني"),
("يحيى بن الضريس","ulama",None,"يحيى بن الضريس"),
("يحيى بن أيوب","ulama",None,"يحيى بن أيوب الغافقي"),
("يحيى بن حسان","ulama",None,"يحيى بن حسان التنيسي"),
("يحيى بن حماد","ulama",None,"يحيى بن حماد الشيباني"),
("يحيى بن حمزة","ulama",None,"يحيى بن حمزة الحضرمي"),
("يحيى بن زكريا بن أبي زائدة","ulama",None,"يحيى بن زكريا بن أبي زائدة"),
("يحيى بن سعيد بن أبان","ulama",None,"يحيى بن سعيد بن أبان الأموي"),
("يحيى بن عبد الله بن بكير","ulama",None,"يحيى بن عبد الله بن بكير"),
("يحيى بن هاشم","ulama",None,"يحيى بن هاشم الغساني"),
("يحيى بن يحيى","ulama",None,"يحيى بن يحيى النيسابوري"),
("يحيى بن يحيى بن كثير","ulama",None,"يحيى بن يحيى الليثي (فقيه الأندلس)"),
("يحيى بن يمان","ulama",None,"يحيى بن يمان العجلي"),
("يزيد بن إبراهيم التستري","ulama",None,"يزيد بن إبراهيم التستري"),
("يزيد بن زريع","ulama",None,"يزيد بن زريع"),
("يزيد بن يزيد بن جابر","ulama",None,"يزيد بن يزيد بن جابر الأزدي"),
("يعقوب بن إبراهيم بن سعد","ulama",None,"يعقوب بن إبراهيم بن سعد الزهري"),
("يعقوب بن إسحاق بن زيد","ulama","يعقوب الحضرمي","يعقوب بن إسحاق الحضرمي (أحد القراء العشرة)"),
("يعلى بن الأشدق العقيلي","ulama",None,"يعلى بن الأشدق العقيلي"),
("يعلى بن عبيد","ulama",None,"يعلى بن عبيد الطنافسي"),
("يوسف بن أسباط","ulama",None,"يوسف بن أسباط"),
("يوسف بن الماجشون","ulama",None,"يوسف بن يعقوب الماجشون"),
("يوسف بن عدي","ulama",None,"يوسف بن عدي"),
("يونس بن بكير","ulama",None,"يونس بن بكير"),
("يونس بن محمد المؤدب","ulama",None,"يونس بن محمد المؤدب"),
("يونس بن يزيد","ulama",None,"يونس بن يزيد الأيلي"),
("نعيم بن حماد بن معاوية","ulama",None,"نعيم بن حماد الخزاعي"),
("هشام بن حسان","ulama",None,"هشام بن حسان القردوسي"),
("يحيى القطان","ulama","يحيى بن سعيد القطان","يحيى بن سعيد القطان"),
("يحيى بن عبد الحميد بن عبد الرحمن","ulama","يحيى بن عبد الحميد الحماني","يحيى بن عبد الحميد الحماني"),
]

def supabase_rpc(body):
    url = f"{SUPABASE_URL}/rest/v1/rpc/upsert_story_draft"
    data = json.dumps(body).encode("utf-8")
    req = urllib.request.Request(
        url, data=data, method="POST",
        headers={
            "apikey": ANON_KEY,
            "Authorization": f"Bearer {ANON_KEY}",
            "Content-Type": "application/json",
            "Prefer": "return=representation",
        },
    )
    with urllib.request.urlopen(req) as resp:
        raw = resp.read()
        return json.loads(raw) if raw else None


def main():
    next_tabieen = 198
    next_ulama = 260
    results = []
    for requested_title, category, title_override, person_name in final:
        r = recs[requested_title]
        title_ar = title_override or r["real_title"].split("سير أعلام النبلاء/")[-1]
        content = r["clean_text"]
        real_title = r["real_title"]
        source_url = "https://ar.wikisource.org/wiki/" + urllib.parse.quote(real_title.replace(" ", "_"))
        if category == "tabieen":
            order_index = next_tabieen
            next_tabieen += 1
        else:
            order_index = next_ulama
            next_ulama += 1
        body = {
            "p_id": None,
            "p_category": category,
            "p_title_ar": title_ar,
            "p_content_ar": content,
            "p_person_name": person_name,
            "p_order_index": order_index,
            "p_source_book": "سير أعلام النبلاء",
            "p_author": "الذهبي",
            "p_source_url": source_url,
        }
        try:
            result = supabase_rpc(body)
            new_id = result
            if isinstance(result, list) and len(result) == 1:
                new_id = result[0] if not isinstance(result[0], dict) else next(iter(result[0].values()))
            results.append({
                "requested_title": requested_title,
                "title_ar": title_ar,
                "category": category,
                "order_index": order_index,
                "id": new_id,
                "content_len": len(content),
                "error": None,
            })
            print(f"OK id={new_id} cat={category} idx={order_index} title={title_ar}", file=sys.stderr)
        except urllib.error.HTTPError as e:
            err_body = e.read().decode("utf-8", "replace")
            results.append({
                "requested_title": requested_title,
                "title_ar": title_ar,
                "category": category,
                "order_index": order_index,
                "id": None,
                "content_len": len(content),
                "error": f"HTTP {e.code}: {err_body}",
            })
            print(f"FAIL {requested_title}: HTTP {e.code}: {err_body}", file=sys.stderr)

    with open("/tmp/claude-1000/-home-user-projects-siraj/c7bf5dd8-46f6-4932-8864-a47b69c60a73/scratchpad/batch8_write_results.json", "w", encoding="utf-8") as f:
        json.dump(results, f, ensure_ascii=False, indent=2)

    n_ok = sum(1 for r in results if r["error"] is None)
    print(f"\nDONE: {n_ok}/{len(results)} succeeded", file=sys.stderr)


if __name__ == "__main__":
    main()
