#!/usr/bin/env python3
"""
يبني SQL لتحديث عمود hadiths."references" من ملف JSONL الناتج عن
fetch_references.py (سطر واحد لكل حديث ناجح: {"id":..,"references":[...]}).
كل عنصر بالمصفوفة نسخ حرفي كامل لعنصر <li> واحد من قسم "المراجع"
المُصيَّر فعلياً بالصفحة - لا تقسيم آلي مُخمَّن، الحدود يحددها الموقع
نفسه ببنية HTML صريحة (`<ol id="references"><li>`).

الاستخدام:
    python3 apply_references.py --in batch1.jsonl --sql-out batch1_update.sql
    # ثم يدوياً:
    supabase db query --linked --file batch1_update.sql -o json > result.json
"""
import argparse
import json


def esc(s):
    return s.replace("'", "''")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--in", dest="infile", required=True)
    ap.add_argument("--sql-out", required=True)
    args = ap.parse_args()

    rows = []
    seen_ids = set()
    with open(args.infile) as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            row = json.loads(line)
            if row.get("references") is None:
                continue
            if row["id"] in seen_ids:
                continue
            seen_ids.add(row["id"])
            rows.append(row)

    print(f"{len(rows)} rows with references to write")

    values = ",\n".join(
        f"({r['id']}, '{esc(json.dumps(r['references'], ensure_ascii=False))}'::jsonb)"
        for r in rows
    )
    sql = f"""
UPDATE public.hadiths h
SET "references" = v.refs
FROM (VALUES
{values}
) AS v(id, refs)
WHERE h.id = v.id
RETURNING h.id;
"""
    with open(args.sql_out, "w") as f:
        f.write(sql)
    print(f"SQL written to {args.sql_out}")


if __name__ == "__main__":
    main()
