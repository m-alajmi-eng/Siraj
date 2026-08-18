-- الخطوة 2أ (id=35، معزولة): source_codes فقط - تحديث صغير جداً وآمن،
-- يثبّت تقدماً جزئياً دائماً بغض النظر عمّا يحدث لاحقاً مع content_ar.
-- شرط "source_codes IS NULL" الأصلي أُبقي هنا كحارس - يجعل إعادة
-- التشغيل آمنة (لن يُطبَّق مرتين).

SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 35;

BEGIN;

UPDATE public.stories
SET source_codes = 'ب د ع'
WHERE id = 35
  AND content_ar LIKE '(ب د ع) عمر بن الخطا%'
  AND source_codes IS NULL
RETURNING id, source_codes;

COMMIT;

-- تحقق فوري - شغّله بلا مغادرة النافذة
SELECT id, source_codes FROM public.stories WHERE id = 35;
