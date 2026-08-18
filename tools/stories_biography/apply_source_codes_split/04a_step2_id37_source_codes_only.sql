-- الخطوة 2أ (id=37، معزولة استباقياً - نفس نمط id=35): source_codes
-- فقط - تحديث صغير وآمن، يثبّت تقدماً جزئياً دائماً بغض النظر عمّا يحدث
-- لاحقاً مع content_ar. شرط "source_codes IS NULL" الأصلي أُبقي كحارس.

SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 37;

BEGIN;

UPDATE public.stories
SET source_codes = 'ب د ع'
WHERE id = 37
  AND content_ar LIKE '(ب د ع) علي بن أبي ط%'
  AND source_codes IS NULL
RETURNING id, source_codes;

COMMIT;

-- تحقق فوري - شغّله بلا مغادرة النافذة
SELECT id, source_codes FROM public.stories WHERE id = 37;
