-- فصل بيانات الاستشهاد (اسم الكتاب/المؤلف/الجزء/الصفحة/رابط المصدر) عن
-- content_ar في public.stories - كانت مدموجة كسطر نصي بعد فاصل "---" في
-- نهاية content_ar (انظر tools/stories_biography/upsert_story.py وTASK
-- الجلسة السابقة) لأن الجدول لم يملك أعمدة استشهاد مستقلة. هذه المهجرة
-- تضيف الأعمدة، ثم دالة upsert_story_draft تُحدَّث لتكتبها مباشرة بدل
-- الدمج النصي لأي إدخال قادم. Backfill الصفوف العشرة الحالية (ids
-- 34-43) في سكربت SQL منفصل بعد المراجعة اليدوية - ليس هنا، لأن هذه
-- مهجرة بنيوية (schema) لا بيانات.

ALTER TABLE public.stories
  ADD COLUMN source_book   text,
  ADD COLUMN author        text,
  ADD COLUMN source_volume text,
  ADD COLUMN source_page   text,
  ADD COLUMN source_url    text;

COMMENT ON COLUMN public.stories.source_book IS
  'اسم الكتاب المصدر (مثال: أسد الغابة في معرفة الصحابة) - نص حر، لا قيد.';
COMMENT ON COLUMN public.stories.author IS
  'اسم مؤلف الكتاب المصدر.';
COMMENT ON COLUMN public.stories.source_volume IS
  'رقم الجزء إن وجد - نص وليس رقماً لاحتمال قيم مثل "٢" أو "الثاني".';
COMMENT ON COLUMN public.stories.source_page IS
  'رقم الصفحة إن وجد - نص لنفس سبب source_volume.';
COMMENT ON COLUMN public.stories.source_url IS
  'رابط صفحة المصدر (Wikisource أو غيره) للترجمة/القصة.';

-- ─── تحديث upsert_story_draft: إضافة معاملات الاستشهاد الخمسة في نهاية
-- التوقيع (DEFAULT NULL) - إضافة معاملات جديدة بنهاية القائمة مع قيم
-- افتراضية أمر مسموح به عبر CREATE OR REPLACE FUNCTION في PostgreSQL
-- دون كسر أي استدعاء موقعي (positional) قائم. باقي فلسفة الدالة كما هي
-- تماماً من 20260803000000_secure_stories_table.sql: is_published يبقى
-- false دائماً، لا معامل لها في التوقيع أصلاً. ───
CREATE OR REPLACE FUNCTION public.upsert_story_draft(
  p_id            bigint DEFAULT NULL,
  p_category      text DEFAULT NULL,
  p_title_ar      text DEFAULT NULL,
  p_title_en      text DEFAULT NULL,
  p_summary_ar    text DEFAULT NULL,
  p_content_ar    text DEFAULT NULL,
  p_person_name   text DEFAULT NULL,
  p_period        text DEFAULT NULL,
  p_lessons       text[] DEFAULT NULL,
  p_tags          text[] DEFAULT NULL,
  p_order_index   integer DEFAULT NULL,
  p_source_book   text DEFAULT NULL,
  p_author        text DEFAULT NULL,
  p_source_volume text DEFAULT NULL,
  p_source_page   text DEFAULT NULL,
  p_source_url    text DEFAULT NULL
) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
  v_id bigint;
BEGIN
  IF p_id IS NULL THEN
    IF p_category IS NULL OR p_title_ar IS NULL THEN
      RAISE EXCEPTION
        'upsert_story_draft: category و title_ar مطلوبان عند إنشاء صف جديد (p_id فارغ)';
    END IF;

    INSERT INTO public.stories (
      category, title_ar, title_en, summary_ar, content_ar,
      person_name, period, lessons, tags, order_index, is_published,
      source_book, author, source_volume, source_page, source_url
    ) VALUES (
      p_category, p_title_ar, p_title_en, p_summary_ar, p_content_ar,
      p_person_name, p_period, p_lessons, p_tags,
      COALESCE(p_order_index, 0), false,
      p_source_book, p_author, p_source_volume, p_source_page, p_source_url
    )
    RETURNING id INTO v_id;
  ELSE
    UPDATE public.stories
    SET category      = COALESCE(p_category, category),
        title_ar       = COALESCE(p_title_ar, title_ar),
        title_en       = COALESCE(p_title_en, title_en),
        summary_ar     = COALESCE(p_summary_ar, summary_ar),
        content_ar     = COALESCE(p_content_ar, content_ar),
        person_name    = COALESCE(p_person_name, person_name),
        period         = COALESCE(p_period, period),
        lessons        = COALESCE(p_lessons, lessons),
        tags           = COALESCE(p_tags, tags),
        order_index    = COALESCE(p_order_index, order_index),
        source_book    = COALESCE(p_source_book, source_book),
        author         = COALESCE(p_author, author),
        source_volume  = COALESCE(p_source_volume, source_volume),
        source_page    = COALESCE(p_source_page, source_page),
        source_url     = COALESCE(p_source_url, source_url),
        is_published   = false
    WHERE id = p_id
    RETURNING id INTO v_id;

    IF NOT FOUND THEN
      RAISE EXCEPTION 'upsert_story_draft: لا يوجد صف بهذا id: %', p_id;
    END IF;
  END IF;

  RETURN v_id;
END;
$$;

COMMENT ON FUNCTION public.upsert_story_draft(
  bigint, text, text, text, text, text, text, text, text[], text[], integer,
  text, text, text, text, text
) IS
  'يكتب/يحدّث مسودة في stories (is_published=false دائماً) - p_id=NULL ينشئ صفاً جديداً (category/title_ar إلزاميان)، أي قيمة أخرى تعدّل صفاً قائماً بهذا id. معاملات الاستشهاد الخمسة الأخيرة (source_book/author/source_volume/source_page/source_url) مضافة 20260803200313 - أعمدة منفصلة بدل الدمج النصي في content_ar. لا معامل p_is_published في التوقيع أصلاً - لا مسار يقدر يكتب true. لا تلمس reviewed_by/reviewed_at (تحديث يدوي فقط من مالك المشروع).';

ALTER FUNCTION public.upsert_story_draft(
  bigint, text, text, text, text, text, text, text, text[], text[], integer,
  text, text, text, text, text
) OWNER TO postgres;

GRANT EXECUTE ON FUNCTION public.upsert_story_draft(
  bigint, text, text, text, text, text, text, text, text[], text[], integer,
  text, text, text, text, text
) TO anon;
GRANT EXECUTE ON FUNCTION public.upsert_story_draft(
  bigint, text, text, text, text, text, text, text, text[], text[], integer,
  text, text, text, text, text
) TO authenticated;
GRANT EXECUTE ON FUNCTION public.upsert_story_draft(
  bigint, text, text, text, text, text, text, text, text[], text[], integer,
  text, text, text, text, text
) TO service_role;
