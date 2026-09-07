-- ثلاث إصلاحات نصية طفيفة موثقة سابقاً بـprogress_log.md (خلل نسخ معزول
-- لكل حالة، لا يمس صحة الترجمة جوهرياً) - بإذن محمد الصريح المباشر
-- (جلسة 2026-09-07). كل UPDATE محصور بـid + شرط LIKE على النص القديم
-- بالضبط لضمان عدم تنفيذه إن تغيّر المحتوى منذ آخر فحص.

BEGIN;

-- id=91 "عاصم بن ثابت بن أبي الأقلح": مسافة مفقودة بين كلمتين
UPDATE public.stories
SET content_ar = replace(content_ar, 'بقبيحهاولحيان', 'بقبيحها ولحيان')
WHERE id = 91 AND content_ar LIKE '%بقبيحهاولحيان%';

-- id=215 "عمرو بن الحارث بن زهير الفهري": حلقة نسب مفقودة "بن أهيب"
UPDATE public.stories
SET content_ar = replace(content_ar, 'بن ربيعة بن هلال بن ضبة', 'بن ربيعة بن هلال بن أهيب بن ضبة')
WHERE id = 215 AND content_ar LIKE '%بن ربيعة بن هلال بن ضبة%';

-- id=367 "تميم بن يعار الخزرجي": كلمة تحريرية "(قلت)" مفقودة
UPDATE public.stories
SET content_ar = replace(content_ar, 'معجمة ومثله قال ابن ماكولا', 'معجمة (قلت) ومثله قال ابن ماكولا')
WHERE id = 367 AND content_ar LIKE '%معجمة ومثله قال ابن ماكولا%';

-- تحقق قبل COMMIT: يجب أن تُرجع كل حالة صفاً واحداً بالضبط بعدد الصفوف المتأثرة أعلاه = 1 لكل UPDATE.
SELECT id, person_name, right(content_ar, 60) AS tail FROM public.stories WHERE id IN (91, 215, 367);

COMMIT;
