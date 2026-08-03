-- تصحيح أمني على جدول public.stories (قصص أنبياء/صحابة/علماء - شاشة
-- StoriesScreen بتبويباتها الثلاثة)، بنفس النمط المُطبَّق الليلة الماضية
-- على children_stories في 20260801044536_children_stories_drafts_and_legacy_fix.sql
-- (قسم 4 من ذلك الملف: DROP/CREATE POLICY + REVOKE/GRANT SELECT فقط).
--
-- الفجوة المكتشفة: سياسة RLS الوحيدة على الجدول (من baseline.sql سطر 662)
-- كانت "Public read access" USING (true) - لا تفرض is_published إطلاقاً،
-- بالإضافة لـGRANT ALL (لا SELECT فقط) لـanon/authenticated (baseline.sql
-- سطر 1001-1003, 1007-1008). غير مُستغَلَّة عملياً حالياً فقط لأن الجدول
-- فارغ من كل الصفوف (لا INSERT له في أي مهجرة) - لكنها فجوة كامنة حقيقية
-- بانتظار أول صف يُكتب.
--
-- لا db push في هذه الجلسة - ملف هجرة للمراجعة فقط.

-- ─── 1) إحكام قراءة الجدول: is_published فقط، لا USING(true) ────
DROP POLICY IF EXISTS "Public read access" ON public.stories;
CREATE POLICY "Public read access" ON public.stories
  FOR SELECT USING (is_published = true);

REVOKE ALL ON TABLE public.stories FROM anon;
REVOKE ALL ON TABLE public.stories FROM authenticated;
GRANT SELECT ON TABLE public.stories TO anon;
GRANT SELECT ON TABLE public.stories TO authenticated;

REVOKE ALL ON SEQUENCE public.stories_id_seq FROM anon;
REVOKE ALL ON SEQUENCE public.stories_id_seq FROM authenticated;

-- ─── 2) أعمدة توثيق المراجعة - نفس نمط children_stories_drafts
-- (reviewed_by/reviewed_at) - لا يكتبها أي مسار آلي، تحديث يدوي فقط من
-- مالك المشروع بعد قراءة فعلية لكل قصة قبل تعيين is_published=true. ───
ALTER TABLE public.stories ADD COLUMN IF NOT EXISTS reviewed_by text;
ALTER TABLE public.stories ADD COLUMN IF NOT EXISTS reviewed_at timestamp with time zone;

COMMENT ON COLUMN public.stories.reviewed_by IS
  'من راجع القصة قبل نشرها (is_published=true) - تحديث يدوي فقط من مالك المشروع، لا يكتبه upsert_story_draft ولا أي مسار آلي آخر.';

COMMENT ON COLUMN public.stories.reviewed_at IS
  'متى تمت المراجعة - نفس قيود reviewed_by، تحديث يدوي فقط.';

COMMENT ON COLUMN public.stories.is_published IS
  'false افتراضياً دائماً - لا مسار كتابي (بما فيه upsert_story_draft) يقدر يكتب true. فقط تحديث مباشر يدوي من مالك المشروع بعد قراءة فعلية للقصة.';

CREATE INDEX IF NOT EXISTS idx_stories_is_published
  ON public.stories (is_published);

-- ─── 3) دالة الكتابة - upsert_story_draft، بنفس فلسفة
-- upsert_draft_story (children_stories_drafts) تماماً: تكتب is_published
-- دائماً false بغض النظر عمّا يُمرَّر - لا معامل p_is_published أصلاً في
-- توقيع الدالة، فلا مسار يقدر يعيّنها true. لا تلمس reviewed_by/
-- reviewed_at إطلاقاً (تحديث يدوي فقط، كما في التعليقات أعلاه).
--
-- خلافاً لـupsert_draft_story (التي تعتمد ON CONFLICT على قيد UNIQUE
-- طبيعي على source_author_id/source_item_id)، جدول stories لا يملك أي
-- مفتاح عمل طبيعي مكافئ - فالتمييز بين "أنشئ جديداً" و"عدّل موجوداً" هنا
-- عبر p_id صراحة: NULL يعني إنشاء صف جديد (category وtitle_ar إلزاميان
-- عندها)، وأي قيمة أخرى تستهدف تعديل صف قائم بهذا id (ترفض الدالة صراحة
-- إن لم يوجد صف بهذا المعرّف).
CREATE OR REPLACE FUNCTION public.upsert_story_draft(
  p_id           bigint DEFAULT NULL,
  p_category     text DEFAULT NULL,
  p_title_ar     text DEFAULT NULL,
  p_title_en     text DEFAULT NULL,
  p_summary_ar   text DEFAULT NULL,
  p_content_ar   text DEFAULT NULL,
  p_person_name  text DEFAULT NULL,
  p_period       text DEFAULT NULL,
  p_lessons      text[] DEFAULT NULL,
  p_tags         text[] DEFAULT NULL,
  p_order_index  integer DEFAULT NULL
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
      person_name, period, lessons, tags, order_index, is_published
    ) VALUES (
      p_category, p_title_ar, p_title_en, p_summary_ar, p_content_ar,
      p_person_name, p_period, p_lessons, p_tags,
      COALESCE(p_order_index, 0), false
    )
    RETURNING id INTO v_id;
  ELSE
    UPDATE public.stories
    SET category    = COALESCE(p_category, category),
        title_ar     = COALESCE(p_title_ar, title_ar),
        title_en     = COALESCE(p_title_en, title_en),
        summary_ar   = COALESCE(p_summary_ar, summary_ar),
        content_ar   = COALESCE(p_content_ar, content_ar),
        person_name  = COALESCE(p_person_name, person_name),
        period       = COALESCE(p_period, period),
        lessons      = COALESCE(p_lessons, lessons),
        tags         = COALESCE(p_tags, tags),
        order_index  = COALESCE(p_order_index, order_index),
        is_published = false
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
  bigint, text, text, text, text, text, text, text, text[], text[], integer
) IS
  'يكتب/يحدّث مسودة في stories (is_published=false دائماً) - p_id=NULL ينشئ صفاً جديداً (category/title_ar إلزاميان)، أي قيمة أخرى تعدّل صفاً قائماً بهذا id. لا معامل p_is_published في التوقيع أصلاً - لا مسار يقدر يكتب true. لا تلمس reviewed_by/reviewed_at (تحديث يدوي فقط من مالك المشروع).';

ALTER FUNCTION public.upsert_story_draft(
  bigint, text, text, text, text, text, text, text, text[], text[], integer
) OWNER TO postgres;

GRANT EXECUTE ON FUNCTION public.upsert_story_draft(
  bigint, text, text, text, text, text, text, text, text[], text[], integer
) TO anon;
GRANT EXECUTE ON FUNCTION public.upsert_story_draft(
  bigint, text, text, text, text, text, text, text, text[], text[], integer
) TO authenticated;
GRANT EXECUTE ON FUNCTION public.upsert_story_draft(
  bigint, text, text, text, text, text, text, text, text[], text[], integer
) TO service_role;
