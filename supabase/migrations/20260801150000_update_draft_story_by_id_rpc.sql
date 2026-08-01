-- دالة تعديل مسودة قصة موجودة بمعرّفها (update_draft_story_by_id): مسار
-- كتابي ضيّق الغرض SECURITY DEFINER يُتيح لـanon/authenticated تعديل صفّ
-- موجود في children_stories_drafts بـid صريح - بديل عن UPDATE مباشر بمفتاح
-- anon (غير متاح أصلاً: لا GRANT UPDATE ولا أي سياسة RLS لأمر UPDATE على هذا
-- الجدول، انظر المهجرة 20260801044536 - GRANT SELECT فقط لـanon/authenticated).
--
-- السبب: upsert_draft_story وحدها لا تكفي لتعديل التسع قصص المُهاجَرة (مصدرها
-- NULL,NULL لا يتطابق أبداً مع نفسه في قيد UNIQUE، فكل استدعاء يُدرِج صفاً
-- جديداً - موثَّق في docs/reviews/CHILDREN_STORIES_DRAFTS_REVIEW_GUIDE.md
-- القسم 3، والذي كان يفترض حتى الآن تحديثاً مباشراً بصلاحيات postgres/
-- service_role فقط عبر SQL Editor). أداة draft_story.py (tools/
-- children_stories_draft/) تحتاج مساراً آمناً بمفتاح anon العام لتعديل نص
-- إحدى التسع قصص بعد موافقة المالك اليدوية - هذه الدالة هي ذلك المسار.
--
-- ضمانتان دائمتان داخل الدالة نفسها (لا تعتمدان على انضباط الأداة المستدعية):
--   1) ترفض صراحة (RAISE EXCEPTION برسالة واضحة، لا فشل صامت) أي id خارج
--      نطاق legacy_order_index بين 1 و9 - أي لا تُعدِّل إلا التسع القصص
--      الأصلية المُهاجَرة، لا أي صف آخر (بما فيها صفوف يكتبها المالك لاحقاً
--      عبر upsert_draft_story بمصدر NULL). **هذا القيد ليس أبدياً** - إن
--      أُضيفت قصة عاشرة يوماً ما بمصدر NULL (لا legacy_order_index)، يحتاج
--      هذا الشرط تحديثاً يدوياً (توسيع النطاق أو إزالته) من مالك المشروع.
--   2) ترفض صراحة أي محاولة تعديل صف reviewed=true بالفعل (منشور فعلياً
--      للعموم) - لا مسار في هذه الدالة يقدر يكتب فوق قصة مُراجَعة ومنشورة.
--
-- p_title اختياري عمداً: القيمة الافتراضية NULL تعني "أبقِ العنوان الحالي
-- لهذه اللغة كما هو" (كل التسع قصص لها بالفعل localized.ar.title من الهجرة
-- الأصلية) - لا حاجة لتكرار العنوان في كل استدعاء تعديل نص فقط. إن لم يوجد
-- عنوان أصلاً لهذه اللغة ولم يُمرَّر p_title، ترفض الدالة الطلب صراحة بدل
-- كتابة عنوان فارغ. p_reading_time_minutes اختياري بنفس المنطق - NULL يعني
-- الإبقاء على القيمة الحالية إن وُجدت.
CREATE OR REPLACE FUNCTION public.update_draft_story_by_id(
  p_id                     bigint,
  p_original_language      text,
  p_simplified_text        text,
  p_reading_time_minutes   integer DEFAULT NULL,
  p_title                  text DEFAULT NULL
) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
  existing_localized     jsonb;
  existing_reviewed      boolean;
  existing_order_index   integer;
  effective_title        text;
  effective_reading_time integer;
BEGIN
  SELECT localized, reviewed, legacy_order_index
  INTO existing_localized, existing_reviewed, existing_order_index
  FROM public.children_stories_drafts
  WHERE id = p_id
  FOR UPDATE;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'update_draft_story_by_id: لا يوجد صف بهذا id: %', p_id;
  END IF;

  IF existing_order_index IS NULL OR existing_order_index NOT BETWEEN 1 AND 9 THEN
    RAISE EXCEPTION
      'update_draft_story_by_id: هذه الدالة تقبل حصراً id ضمن التسع القصص الأصلية (legacy_order_index بين 1 و9) - id % خارج هذا النطاق',
      p_id;
  END IF;

  IF existing_reviewed THEN
    RAISE EXCEPTION
      'update_draft_story_by_id: الصف % مُراجَع ومنشور بالفعل (reviewed=true) - لا يمكن تعديله عبر هذه الدالة',
      p_id;
  END IF;

  effective_title := COALESCE(p_title, existing_localized #>> ARRAY[p_original_language, 'title']);
  IF effective_title IS NULL THEN
    RAISE EXCEPTION
      'update_draft_story_by_id: لا عنوان موجود للغة % في الصف % ولم يُمرَّر p_title صراحة',
      p_original_language, p_id;
  END IF;

  effective_reading_time := COALESCE(
    p_reading_time_minutes,
    (existing_localized #>> ARRAY[p_original_language, 'reading_time_minutes'])::integer
  );

  UPDATE public.children_stories_drafts
  SET localized = jsonb_set(
        existing_localized,
        ARRAY[p_original_language],
        jsonb_build_object(
          'title', effective_title,
          'simplified_text', p_simplified_text,
          'reading_time_minutes', effective_reading_time
        ),
        true
      ),
      updated_at = now()
  WHERE id = p_id;
END;
$$;

COMMENT ON FUNCTION public.update_draft_story_by_id(bigint, text, text, integer, text) IS
  'يعدّل نص مسودة موجودة (reviewed=false فقط) بمعرّفها id - يرفض صراحة أي id خارج التسع القصص الأصلية (legacy_order_index 1-9) وأي صف reviewed=true بالفعل. لا يقدر أبداً تعيين reviewed=true. القيد على legacy_order_index ليس أبدياً - يحتاج توسيعاً يدوياً إن أُضيفت قصص جديدة بمصدر NULL مستقبلاً.';

ALTER FUNCTION public.update_draft_story_by_id(bigint, text, text, integer, text) OWNER TO postgres;

GRANT EXECUTE ON FUNCTION public.update_draft_story_by_id(bigint, text, text, integer, text) TO anon;
GRANT EXECUTE ON FUNCTION public.update_draft_story_by_id(bigint, text, text, integer, text) TO authenticated;
GRANT EXECUTE ON FUNCTION public.update_draft_story_by_id(bigint, text, text, integer, text) TO service_role;
