#!/usr/bin/env python3
"""كتابة دفعة 7 (78 صفاً) عبر upsert_story_draft بمفتاح anon فقط - سير أعلام النبلاء."""
from __future__ import annotations
import json
import sys
import urllib.error
import urllib.request
import urllib.parse

SUPABASE_URL = "https://pzcnkzsicyxlzqwjznvh.supabase.co"
ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InB6Y25renNpY3l4bHpxd2p6bnZoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIyMDY2NjQsImV4cCI6MjA5Nzc4MjY2NH0.W2z_NZKyc1HD9CifqKvupIVcSrW1MinDAYsfpZ6ewm8"

recs = {}
for line in open("/tmp/claude-1000/-home-user-projects-siraj/c7bf5dd8-46f6-4932-8864-a47b69c60a73/scratchpad/batch7_cleaned.jsonl", encoding="utf-8"):
    r = json.loads(line)
    recs[r["requested_title"]] = r

final = [
("كريب ابن أبي مسلم","tabieen",None,"كريب بن أبي مسلم"),
("كهمس","tabieen",None,"كهمس بن الحسن"),
("ليث بن أبي سليم","tabieen",None,"ليث بن أبي سليم"),
("مالك بن أوس","tabieen",None,"مالك بن أوس بن الحدثان"),
("مبارك بن فضالة","tabieen",None,"مبارك بن فضالة"),
("مجالد بن سعيد","tabieen",None,"مجالد بن سعيد"),
("محارب بن دثار","tabieen",None,"محارب بن دثار"),
("محمد بن إبراهيم التيمي","tabieen",None,"محمد بن إبراهيم التيمي"),
("محمد بن سعد بن أبي وقاص","tabieen",None,"محمد بن سعد بن أبي وقاص"),
("محمد بن عبد الله بن عمرو","tabieen",None,"محمد بن عبد الله بن عمرو بن العاص"),
("محمد بن علي بن الحسين","tabieen",None,"محمد بن علي بن الحسين (الباقر)"),
("محمد بن مسلم بن تدرس","tabieen",None,"محمد بن مسلم بن تدرس (أبو الزبير المكي)"),
("مسروق","tabieen",None,"مسروق بن الأجدع"),
("مسلم بن يسار","tabieen",None,"مسلم بن يسار البصري"),
("مطر الوراق","tabieen",None,"مطر الوراق"),
("مطرف بن طريف","tabieen",None,"مطرف بن طريف"),
("معاذة بنت عبد الله","tabieen",None,"معاذة بنت عبد الله العدوية"),
("معاوية بن قرة","tabieen",None,"معاوية بن قرة المزني"),
("معبد بن عبد الله بن عويمر","tabieen",None,"معبد الجهني"),
("مغيرة بن مقسم","tabieen",None,"مغيرة بن مقسم الضبي"),
("مكحول الأزدي","tabieen",None,"مكحول الأزدي البصري"),
("ممطور الحبشي","tabieen",None,"أبو سلام ممطور الحبشي"),
("منصور بن زاذان","tabieen",None,"منصور بن زاذان"),
("مورق العجلي","tabieen",None,"مورق العجلي"),
("موسى بن طلحة بن عبيد الله","tabieen",None,"موسى بن طلحة بن عبيد الله"),
("موسى بن عقبة","tabieen",None,"موسى بن عقبة"),
("مالك بن إسماعيل بن درهم","ulama",None,"مالك بن إسماعيل بن درهم (أبو غسان)"),
("مالك بن مغول","ulama",None,"مالك بن مغول"),
("مؤمل بن إسماعيل","ulama",None,"مؤمل بن إسماعيل"),
("محمد بن أبي حفصة","ulama",None,"محمد بن أبي حفصة"),
("محمد بن الحسن بن فرقد","ulama",None,"محمد بن الحسن الشيباني"),
("محمد بن الصباح الدولابي","ulama",None,"محمد بن الصباح الدولابي"),
("محمد بن المنهال","ulama",None,"محمد بن المنهال البصري"),
("محمد بن بشر بن الفرافصة","ulama",None,"محمد بن بشر بن الفرافصة"),
("محمد بن بن أبي أمية","ulama","محمد بن عبيد بن أبي أمية","محمد بن عبيد بن أبي أمية الطنافسي"),
("محمد بن جحادة","ulama",None,"محمد بن جحادة"),
("محمد بن جعفر الصادق","ulama",None,"محمد بن جعفر الصادق (الديباج)"),
("محمد بن حرب","ulama",None,"محمد بن حرب الخولاني"),
("محمد بن حمير","ulama",None,"محمد بن حمير"),
("محمد بن راشد","ulama",None,"محمد بن راشد المكحولي"),
("محمد بن سعد","ulama",None,"محمد بن سعد صاحب الطبقات"),
("محمد بن سلام","ulama",None,"محمد بن سلام البيكندي"),
("محمد بن سلام بن عبيد الله","ulama",None,"محمد بن سلام الجمحي"),
("محمد بن شعيب بن شابور","ulama",None,"محمد بن شعيب بن شابور"),
("محمد بن طلحة","ulama",None,"محمد بن طلحة بن مصرف"),
("محمد بن عبد الله بن الزبير بن عمر","ulama","محمد بن عبد الله بن الزبير (أبو أحمد الزبيري)","أبو أحمد الزبيري"),
("محمد بن عبد الله بن المثنى","ulama","محمد بن عبد الله بن المثنى (الأنصاري)","الأنصاري (محمد بن عبد الله بن المثنى)"),
("محمد بن عجلان","ulama",None,"محمد بن عجلان"),
("محمد بن عمرو بن علقمة","ulama",None,"محمد بن عمرو بن علقمة"),
("محمد بن فضيل بن غزوان","ulama",None,"محمد بن فضيل بن غزوان"),
("محمد بن كثير العبدي","ulama",None,"محمد بن كثير العبدي"),
("محمد بن كثير بن أبي عطاء","ulama",None,"محمد بن كثير بن أبي عطاء"),
("محمد بن مطرف","ulama",None,"محمد بن مطرف"),
("محمد بن وهب","ulama",None,"محمد بن وهب بن عطية"),
("مرحوم بن عبد العزيز","ulama",None,"مرحوم بن عبد العزيز"),
("مروان بن محمد بن حسان","ulama",None,"مروان بن محمد الطاطري"),
("مروان بن معاوية بن الحارث","ulama",None,"مروان بن معاوية الفزاري"),
("مسدد بن مسرهد","ulama",None,"مسدد بن مسرهد"),
("مسلم بن إبراهيم","ulama",None,"مسلم بن إبراهيم الفراهيدي"),
("مصعب","ulama",None,"مصعب بن ثابت"),
("مظفر بن مدرك","ulama",None,"مظفر بن مدرك (أبو كامل)"),
("معاذ بن معاذ بن نصر","ulama",None,"معاذ بن معاذ العنبري"),
("معاذ بن هاشم","ulama",None,"معاذ بن هاشم"),
("معاوية بن صالح","ulama",None,"معاوية بن صالح الحضرمي"),
("معاوية بن عبيد الله بن يسار","ulama",None,"معاوية بن عبيد الله بن يسار"),
("معاوية بن عمرو بن المهلب","ulama",None,"معاوية بن عمرو بن المهلب"),
("معلى بن منصور","ulama",None,"معلى بن منصور الرازي"),
("معن بن عيسى","ulama",None,"معن بن عيسى القزاز"),
("مفضل بن فضالة","ulama",None,"مفضل بن فضالة"),
("مقاتل","ulama","مقاتل بن سليمان","مقاتل بن سليمان البلخي"),
("مقاتل بن حيان","ulama",None,"مقاتل بن حيان"),
("مكي","ulama","مكي بن إبراهيم","مكي بن إبراهيم البلخي"),
("منصور بن سلمة","ulama",None,"منصور بن سلمة الخزاعي"),
("منصور بن عمار","ulama",None,"منصور بن عمار الواعظ"),
("موسى الكاظم","ulama",None,"موسى الكاظم"),
("موسى بن داود","ulama",None,"موسى بن داود الضبي"),
("مسعر","ulama",None,"مسعر بن كدام"),
("معمر بن راشد","ulama",None,"معمر بن راشد"),
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
    next_tabieen = 172
    next_ulama = 208
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

    with open("/tmp/claude-1000/-home-user-projects-siraj/c7bf5dd8-46f6-4932-8864-a47b69c60a73/scratchpad/batch7_write_results.json", "w", encoding="utf-8") as f:
        json.dump(results, f, ensure_ascii=False, indent=2)

    n_ok = sum(1 for r in results if r["error"] is None)
    print(f"\nDONE: {n_ok}/{len(results)} succeeded", file=sys.stderr)


if __name__ == "__main__":
    main()
