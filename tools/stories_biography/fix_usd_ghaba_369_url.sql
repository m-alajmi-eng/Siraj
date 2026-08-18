BEGIN;

-- إصلاح رابط source_url خاطئ لـ id=369 "معمر بن الحارث الجمحي" (أسد الغابة)
-- كان يحيل لصفحة "معقل" (شخص مختلف تماماً) بدل "معمر" - تحقَّقت أن الصفحة الجديدة
-- تحوي فعلياً نص الترجمة المطابق لـ content_ar حرفياً (بداية ونهاية متطابقتان تماماً).

UPDATE public.stories SET source_url = 'https://ar.wikisource.org/wiki/%D8%A3%D8%B3%D8%AF_%D8%A7%D9%84%D8%BA%D8%A7%D8%A8%D8%A9_%28%D8%B7._%D8%A7%D9%84%D9%88%D9%87%D8%A8%D9%8A%D8%A9%29/%D8%AD%D8%B1%D9%81_%D8%A7%D9%84%D9%85%D9%8A%D9%85/%D8%A8%D8%A7%D8%A8_%D8%A7%D9%84%D9%85%D9%8A%D9%85_%D9%88%D8%A7%D9%84%D8%B9%D9%8A%D9%86/%D9%85%D8%B9%D9%85%D8%B1' WHERE id = 369;

-- تحقق قبل الإتمام
SELECT id, source_url FROM public.stories WHERE id = 369;

COMMIT;
