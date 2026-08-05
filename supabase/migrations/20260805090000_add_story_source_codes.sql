-- TASK K: عمود جديد لرموز مصادر ابن الأثير الأصلية (أسد الغابة) التي كانت
-- مدموجة في بداية content_ar كنمط "(ب د ع) اسم" أو "(ب س) اسم" إلخ - كل
-- حرف يشير لمن روى/ذكر ترجمة الصحابي (البخاري، ابن منده، أبو نعيم، ابن
-- السكن...). معلومة مصدر حقيقية أصيلة من ابن الأثير نفسه، لا تُفقَد - فقط
-- تُنقَل من متن النص إلى عمود مستقل ليعرضها الهامش بدل متن الترجمة. لا
-- تعديل بيانات هنا - Backfill منفصل بعد مراجعة العيّنة (نفس نمط
-- 20260803200313_add_story_source_columns.sql).

ALTER TABLE public.stories
  ADD COLUMN source_codes text;

COMMENT ON COLUMN public.stories.source_codes IS
  'رموز مصادر ابن الأثير الأصلية من أول content_ar (أسد الغابة فقط - مثال "ب د ع") - تشير لمن ذكر الصحابي: ب=البخاري، د=ابن منده، ع=أبو نعيم، س=ابن السكن. نُقلت من متن content_ar عبر backfill منفصل، لا تُفقَد.';

-- ─── تحديث upsert_story_draft: إضافة p_source_codes بنهاية التوقيع
-- (DEFAULT NULL). **تحقَّقت فعلياً محلياً أن CREATE OR REPLACE FUNCTION مع
-- إضافة معامل جديد (حتى بقيمة افتراضية) لا "يستبدل" الدالة القديمة فعلياً
-- - يُنشئ تحميلاً زائداً (overload) ثانياً بجوارها، لأن عدد المعاملات
-- اختلف. هذا يسبب خطأ "is not unique" عند أي نداء موقعي قديم (16 معاملاً)
-- لأنه يطابق كلا التحميلين بالتساوي (الجديد بتعبئة المعامل السابع عشر
-- افتراضياً). DROP صريح للتوقيع القديم أولاً يضمن عدم حدوث هذا - بخلاف
-- 20260803200313 التي لم تتضمن DROP مماثلاً (نجت لسبب غير موثَّق في
-- تاريخ المشروع، ربما تنظيف يدوي غير مسجَّل) - هذه المهجرة تصحح النمط
-- لأي إضافة معامل مستقبلية مشابهة. ───
DROP FUNCTION IF EXISTS public.upsert_story_draft(
  bigint, text, text, text, text, text, text, text, text[], text[], integer,
  text, text, text, text, text
);

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
  p_source_url    text DEFAULT NULL,
  p_source_codes  text DEFAULT NULL
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
      source_book, author, source_volume, source_page, source_url,
      source_codes
    ) VALUES (
      p_category, p_title_ar, p_title_en, p_summary_ar, p_content_ar,
      p_person_name, p_period, p_lessons, p_tags,
      COALESCE(p_order_index, 0), false,
      p_source_book, p_author, p_source_volume, p_source_page, p_source_url,
      p_source_codes
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
        source_codes   = COALESCE(p_source_codes, source_codes),
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
  text, text, text, text, text, text
) IS
  'يكتب/يحدّث مسودة في stories (is_published=false دائماً) - p_id=NULL ينشئ صفاً جديداً (category/title_ar إلزاميان)، أي قيمة أخرى تعدّل صفاً قائماً بهذا id. معاملات الاستشهاد الخمسة (20260803200313) + p_source_codes (20260805، رموز أسد الغابة المفصولة عن content_ar) مضافة بنهاية التوقيع. لا معامل p_is_published في التوقيع أصلاً - لا مسار يقدر يكتب true. لا تلمس reviewed_by/reviewed_at (تحديث يدوي فقط من مالك المشروع).';

ALTER FUNCTION public.upsert_story_draft(
  bigint, text, text, text, text, text, text, text, text[], text[], integer,
  text, text, text, text, text, text
) OWNER TO postgres;

GRANT EXECUTE ON FUNCTION public.upsert_story_draft(
  bigint, text, text, text, text, text, text, text, text[], text[], integer,
  text, text, text, text, text, text
) TO anon;
GRANT EXECUTE ON FUNCTION public.upsert_story_draft(
  bigint, text, text, text, text, text, text, text, text[], text[], integer,
  text, text, text, text, text, text
) TO authenticated;
GRANT EXECUTE ON FUNCTION public.upsert_story_draft(
  bigint, text, text, text, text, text, text, text, text[], text[], integer,
  text, text, text, text, text, text
) TO service_role;
