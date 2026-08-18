-- استعلامات تصدير للتحقق الفعلي (TASK 2, TASK 3) - قراءة فقط، بلا أثر.
-- شغّلها في SQL Editor بمشروع Supabase، ثم "Export to CSV" (أو انسخ
-- النتائج كنص) وأرسلها لي - سأقارن content_ar حرفياً كلمة بكلمة، لا
-- أفترض تطابقاً من تشابه العنوان أو order_index فقط.

-- ============================================================
-- TASK 2 — تحقق تكرار 162-170 مقابل 152-160 (9 أزواج)
-- ============================================================
SELECT id, category, order_index, title_ar, person_name,
       source_book, author, source_volume, source_page, source_url,
       content_ar
FROM public.stories
WHERE id IN (152,153,154,155,156,157,158,159,160, 162,163,164,165,166,167,168,169,170)
ORDER BY order_index, id;

-- ============================================================
-- TASK 3 — تحقيق تصادم ids 8-12 مقابل 34-38 (كل الأعمدة المتاحة)
-- ملاحظة: لا عمود created_at في الجدول (تحققتُ من المخطط) - لا يمكن
-- معرفة تاريخ إدخال 8-12 من القاعدة نفسها، فقط من محتواها واستشهادها.
-- ============================================================
SELECT id, category, order_index, title_ar, person_name, period,
       source_book, author, source_volume, source_page, source_url,
       is_published, reviewed_by, reviewed_at,
       content_ar
FROM public.stories
WHERE id IN (8,9,10,11,12, 34,35,36,37,38)
ORDER BY order_index, id;
