-- تنظيف الصفوف المكرَّرة/المتصادمة + نشر companions/tabieen/ulama
-- يُنفَّذ يدوياً فقط من محمد عبر SQL Editor في Supabase (لا مسار آلي).
-- السياق الكامل: tools/stories_biography/NEEDS_REVIEW.md §6-7،
-- PUBLISH_INDEX.md، progress_log.md.
--
-- لماذا يدوي وليس عبر service_role الوكيل: عمود is_published معلَّق
-- عليه صراحة في مهجرة 20260803000000_secure_stories_table.sql:
-- "لا مسار آلي (بما فيه upsert_story_draft) يقدر يكتب true. فقط تحديث
-- مباشر يدوي من مالك المشروع بعد قراءة فعلية للقصة." هذا الملف يجهّز
-- الأوامر فقط - التنفيذ الفعلي قرارك وحدك.

-- ============================================================
-- القسم 1 — تحقق قبل أي حذف (SELECT فقط، بلا أثر). راجع النتائج
-- يدوياً قبل المتابعة للقسم 2.
-- ============================================================

-- 1أ) تكرار 162-170: يجب أن يطابق كل صف نظيره الأصلي (152↔162 ... 160↔170)
--     حرفياً في title_ar/order_index (وcontent_ar لو رغبت بمراجعة أعمق)
SELECT id, category, order_index, title_ar, left(content_ar, 60) AS content_preview
FROM public.stories
WHERE id IN (152,153,154,155,156,157,158,159,160, 162,163,164,165,166,167,168,169,170)
ORDER BY order_index, id;

-- 1ب) تصادم order_index بين 8-12 (دفعة قديمة غير موثَّقة) و34-38 (هذه الجلسة)
SELECT id, category, order_index, title_ar
FROM public.stories
WHERE id IN (8,9,10,11,12, 34,35,36,37,38)
ORDER BY order_index, id;

-- ============================================================
-- القسم 2 — الحذف (نفّذ فقط بعد التأكد يدوياً من نتائج القسم 1)
-- ============================================================

DELETE FROM public.stories WHERE id IN (162,163,164,165,166,167,168,169,170);
DELETE FROM public.stories WHERE id IN (8,9,10,11,12);

-- ============================================================
-- القسم 3 — التحقق: العدد الكلي النهائي لكل فئة بعد الحذف
-- ============================================================

SELECT category, count(*) AS total
FROM public.stories
WHERE category IN ('companions','tabieen','ulama')
GROUP BY category
ORDER BY category;

-- ============================================================
-- القسم 4 — النشر: is_published = true لكل الصفوف المتبقية في الفئات
-- الثلاث، شاملة الصفوف المُعلَّمة 🚩 (بموافقتك الصريحة على نشرها كما
-- هي - نقل تاريخي أمين، بلا تصرف). عدّل '<اسمك>' قبل التنفيذ.
-- ============================================================

UPDATE public.stories
SET is_published = true,
    reviewed_by   = '<اسمك>',
    reviewed_at   = now()
WHERE category IN ('companions','tabieen','ulama');

-- تحقق نهائي بعد النشر
SELECT category,
       count(*) FILTER (WHERE is_published) AS published,
       count(*) AS total
FROM public.stories
WHERE category IN ('companions','tabieen','ulama')
GROUP BY category
ORDER BY category;
