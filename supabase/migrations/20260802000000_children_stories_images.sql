-- صور قصص الأطفال: عمود images على مستوى الصف (لا داخل localized - الصور لا
-- تختلف حسب اللغة، خلافاً لـtitle/simplified_text/reading_time_minutes)،
-- bucket تخزين مخصَّص للصور نفسها، ودالة SECURITY DEFINER ضيّقة لكتابتها
-- بنفس نمط update_draft_story_by_id (المهجرة 20260801150000) تماماً - نفس
-- ضمانتَي القبول (id ضمن التسع الأصلية) والرفض (reviewed=true).
--
-- shape عمود images المتوقَّع (بلا CHECK صارم بعد - نفس نمط quran_references
-- في هذا الجدول): مصفوفة JSON من كائنات {"url": "...", "role": "..."}،
-- role ∈ opening|climax|closing (لا قيد enum في القاعدة - التحقّق من القيم
-- يتم في السكربت المستدعي tools/children_stories_draft/draft_story.py).

-- ─── 1) عمود images ─────────────────────────────────────────
ALTER TABLE public.children_stories_drafts
  ADD COLUMN IF NOT EXISTS images jsonb NOT NULL DEFAULT '[]'::jsonb;

COMMENT ON COLUMN public.children_stories_drafts.images IS
  'مصفوفة JSON لصور القصة على مستوى الصف (لا تختلف حسب اللغة) - [{"url": "...", "role": "opening|climax|closing"}, ...]. فارغة [] افتراضياً. يُكتَب حصراً عبر set_draft_story_images (SECURITY DEFINER) - لا مسار كتابي مباشر لـanon/authenticated على هذا العمود.';

-- ─── 2) bucket تخزين الصور ──────────────────────────────────
-- public=true يسمح بقراءة مباشرة عبر رابط عام (/storage/v1/object/public/...)
-- بلا أي مصادقة - مناسب لصور معروضة في شاشة عامة (StoryReaderScreen). سياسة
-- SELECT صريحة أدناه على storage.objects موثِّقة لهذا الغرض بدل الاعتماد
-- الضمني على public=true وحده - نفس فلسفة هذا المشروع (صراحة بدل الاعتماد
-- على سلوك افتراضي غير موثَّق). لا سياسة INSERT/UPDATE/DELETE لـanon/
-- authenticated إطلاقاً - الرفع يدوي مرة واحدة من المالك عبر service_role
-- (الذي يتجاوز RLS افتراضياً على storage.objects في Supabase)، لا ميزة
-- مستخدم متكررة تحتاج مسار كتابة للعميل.
INSERT INTO storage.buckets (id, name, public)
VALUES ('children-stories-images', 'children-stories-images', true)
ON CONFLICT (id) DO NOTHING;

CREATE POLICY "Public read access - children-stories-images"
ON storage.objects FOR SELECT
USING (bucket_id = 'children-stories-images');

-- ─── 3) دالة كتابة الصور - نفس نمط update_draft_story_by_id تماماً ─────
CREATE OR REPLACE FUNCTION public.set_draft_story_images(
  p_id     bigint,
  p_images jsonb
) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
  existing_reviewed     boolean;
  existing_order_index  integer;
BEGIN
  IF jsonb_typeof(p_images) IS DISTINCT FROM 'array' THEN
    RAISE EXCEPTION 'set_draft_story_images: p_images يجب أن يكون مصفوفة JSON - وصل %', jsonb_typeof(p_images);
  END IF;

  SELECT reviewed, legacy_order_index
  INTO existing_reviewed, existing_order_index
  FROM public.children_stories_drafts
  WHERE id = p_id
  FOR UPDATE;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'set_draft_story_images: لا يوجد صف بهذا id: %', p_id;
  END IF;

  IF existing_order_index IS NULL OR existing_order_index NOT BETWEEN 1 AND 9 THEN
    RAISE EXCEPTION
      'set_draft_story_images: هذه الدالة تقبل حصراً id ضمن التسع القصص الأصلية (legacy_order_index بين 1 و9) - id % خارج هذا النطاق',
      p_id;
  END IF;

  IF existing_reviewed THEN
    RAISE EXCEPTION
      'set_draft_story_images: الصف % مُراجَع ومنشور بالفعل (reviewed=true) - لا يمكن تعديله عبر هذه الدالة',
      p_id;
  END IF;

  UPDATE public.children_stories_drafts
  SET images     = p_images,
      updated_at = now()
  WHERE id = p_id;
END;
$$;

COMMENT ON FUNCTION public.set_draft_story_images(bigint, jsonb) IS
  'يكتب عمود images (مصفوفة JSON لروابط صور القصة) لصفّ موجود بمعرّفه id - نفس ضمانتَي update_draft_story_by_id تماماً: يرفض صراحة أي id خارج التسع القصص الأصلية (legacy_order_index 1-9) وأي صف reviewed=true بالفعل. لا يقدر أبداً تعيين reviewed=true. القيد على legacy_order_index ليس أبدياً - يحتاج توسيعاً يدوياً إن أُضيفت قصص جديدة بمصدر NULL مستقبلاً.';

ALTER FUNCTION public.set_draft_story_images(bigint, jsonb) OWNER TO postgres;

GRANT EXECUTE ON FUNCTION public.set_draft_story_images(bigint, jsonb) TO anon;
GRANT EXECUTE ON FUNCTION public.set_draft_story_images(bigint, jsonb) TO authenticated;
GRANT EXECUTE ON FUNCTION public.set_draft_story_images(bigint, jsonb) TO service_role;
