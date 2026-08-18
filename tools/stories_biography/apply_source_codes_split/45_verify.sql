-- تحقق نهائي - شغّلها بعد كل الملفات السابقة
SELECT count(*) AS total_with_source_codes FROM public.stories WHERE source_codes IS NOT NULL;

SELECT id, title_ar, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id IN (204, 215) ORDER BY id;

SELECT id, title_ar, source_book, author, source_url
FROM public.stories WHERE id = 13;

SELECT id, title_ar, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories
WHERE category = 'companions' AND source_codes IS NOT NULL AND id NOT IN (204, 215)
ORDER BY random() LIMIT 5;
