-- الخطوة 3: كتابة مصدر id=13 فقط

BEGIN;

UPDATE public.stories SET source_book = 'قصص الأنبياء', author = 'ابن كثير' WHERE id = 13 AND source_book IS NULL AND author IS NULL;

COMMIT;
