-- TASK A — نشر فئة prophets. يُنفَّذ يدوياً فقط من محمد عبر SQL Editor
-- في Supabase (لا مسار آلي - نفس قيد is_published الموثَّق في
-- 20260803000000_secure_stories_table.sql: "لا مسار آلي يقدر يكتب true").
--
-- تحققتُ فعلياً (لا افتراضاً): محاولة UPDATE فعلية بمفتاح anon على
-- stories رجعت "permission denied for table stories" (anon يملك SELECT
-- فقط على هذا الجدول). لذا لا أقدر أنفّذ حتى التحديث المبسّط الذي
-- طلبتَه بنفسي - ينتظر تنفيذك المباشر.
--
-- ⚠ تحذير قبل التنفيذ: النص الحرفي الذي أرسلتَه
--   UPDATE public.stories SET is_published=true, ...
--   WHERE category='prophets' AND id NOT IN (13);
-- قد يُعيد بالضبط نفس مشكلة ids 8-12 الموثَّقة في PUBLISH_INDEX.md
-- (صفوف companions فارغة تماماً من المحتوى، بلا content_ar ولا مصدر،
-- تصادمت في order_index مع صفوف 34-38 الحقيقية). لم أتحقق من محتوى
-- بقية صفوف prophets (لا أملك قراءة إلا للصف المنشور id=13 عبر anon -
-- RLS تمنع قراءة أي مسودة غير منشورة بهذا المفتاح) - **من المحتمل أن
-- تكون بعض ids 1-7 أو 14-19+ في فئة prophets صفوفاً فارغة/بقايا من نفس
-- المرحلة القديمة غير الموثَّقة** (بالضبط كما حدث مع 8-12). نشرها بلا
-- تحقق يعرض صفحات فارغة للمستخدمين.
--
-- لذلك: نفّذ القسم 1 أولاً وراجع النتيجة بعينك (خصوصاً عمود content_ar
-- وطوله) قبل تنفيذ القسم 2.

-- ============================================================
-- القسم 1 — تحقق قبل النشر (SELECT فقط، بلا أثر)
-- ============================================================
SELECT id, order_index, title_ar, is_published,
       length(content_ar) AS content_len,
       source_book, author
FROM public.stories
WHERE category = 'prophets'
ORDER BY order_index, id;

-- ============================================================
-- القسم 2 — النشر (نفّذ فقط بعد مراجعة القسم 1 يدوياً؛ يستثني تلقائياً
-- أي صف فارغ من المحتوى، لا فقط id=13 كما في نصّك الأصلي - إضافة
-- احترازية بعد اكتشاف نمط 8-12 المطابق تماماً في companions)
-- ============================================================
UPDATE public.stories
SET is_published = true,
    reviewed_by   = 'محمد',
    reviewed_at   = now()
WHERE category = 'prophets'
  AND is_published = false
  AND content_ar IS NOT NULL
  AND length(trim(content_ar)) > 0;

-- تحقق نهائي
SELECT id, order_index, title_ar, is_published, length(content_ar) AS content_len
FROM public.stories
WHERE category = 'prophets'
ORDER BY order_index, id;
