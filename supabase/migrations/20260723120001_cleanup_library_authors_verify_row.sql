-- إزالة صفّ التحقق الاصطناعي (islamhouse_author_id = 999999999) الذي أنشأه
-- استدعاء تحقّقي لـupsert_harvested_author أثناء التأكد من أن الدالة تعمل
-- فعلياً بعد نشر هجرة add_library_authors - ليس مؤلفاً حقيقياً من
-- IslamHouse ولا ينبغي أن يظهر في شاشة المؤلفين.

DELETE FROM public.library_authors
WHERE islamhouse_author_id = 999999999;
