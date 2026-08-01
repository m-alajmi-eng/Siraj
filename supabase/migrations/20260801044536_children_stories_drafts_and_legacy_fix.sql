-- تصحيح معماري بعد المهمة 1 الأصلية (20260801040635_add_children_stories.sql):
-- اكتُشف أن جدولاً باسم "children_stories" موجود بالفعل على القاعدة
-- الحية منذ baseline.sql بمخطط قديم مختلف تماماً (title_ar/content_ar/
-- moral_ar/emoji/color/order_index/is_published)، يحمل فعلياً 9 صفوف
-- مسودة حقيقية (عناوين/موعظة/إيموجي/لون مخطَّطة مسبقاً، لكن content_ar
-- فارغ للجميع - لا نص قصة فعلي بعد، is_published=false للتسعة).
--
-- CREATE TABLE IF NOT EXISTS في المهمة 1 الأصلية كان سيتجاهل هذا الجدول
-- القائم صمتاً عند أي db push فعلي (نفس الاسم) فلا يُنشئ أياً من الأعمدة
-- الجديدة (localized/reviewed/source_author_id...)، ودالتها
-- upsert_draft_story كانت ستفشل عند أي استدعاء فعلي (تشير لأعمدة غير
-- موجودة على الجدول القديم الفعلي).
--
-- القرار المعماري (من مالك المشروع): لا ALTER على مخطط الجدول القديم،
-- ولا بناء عليه. الجدول الجديد باسم مختلف صراحة: children_stories_drafts.
-- ملف المهجرة الأصلي (20260801040635) يبقى بلا تعديل كما هو - هذا الملف
-- الجديد يُصحِّح دالة upsert_draft_story فعلياً (نفس الاسم والتوقيع =
-- CREATE OR REPLACE يستبدل التعريف المعطوب السابق حقاً لا يضيف نسخة
-- موازية)، وينشئ الجدول الصحيح، ويهاجر التسع صفوف القديمة كمسودات.

-- ─── 1) الجدول الجديد ───────────────────────────────────────
-- نفس تصميم 20260801040635 حرفياً (localized jsonb، source_author_id،
-- reviewed...) فقط باسم مختلف لتفادي تصادم مع الجدول القديم القائم.
-- تعديلان ضروريان اكتُشفا فقط بمواجهة بيانات حقيقية:
--   • source_author_id/source_item_id أصبحا NULLABLE (بلا NOT NULL) -
--     التسع قصص المُهاجَرة مؤلَّفة يدوياً سابقاً بلا أي مصدر IslamHouse
--     حقيقي، فتثبيت 8042 (ابن كثير) عليها كان سيكون انتحال مصدر خاطئ.
--     NULL هنا يعني بصدق: "لا مصدر IslamHouse معروف لهذا الصف".
--   • أربعة أعمدة legacy_* جديدة (moral/category/emoji/color/order) +
--     عمود age_group يُستخدَم لنقل age_range - لا مكافئ لها في التصميم
--     الأصلي، والمالك طلب صراحةً عدم إسقاط moral_ar تحديداً.
CREATE TABLE IF NOT EXISTS public.children_stories_drafts (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  source_author_id integer,
  source_item_id integer,
  original_language text NOT NULL,
  localized jsonb NOT NULL DEFAULT '{}'::jsonb,
  age_group text,
  quran_references jsonb,
  legacy_moral text,
  legacy_category text,
  legacy_emoji text,
  legacy_color text,
  legacy_order_index integer,
  reviewed boolean NOT NULL DEFAULT false,
  reviewed_by text,
  reviewed_at timestamp with time zone,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  updated_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT children_stories_drafts_source_item_key UNIQUE (source_author_id, source_item_id)
);

COMMENT ON TABLE public.children_stories_drafts IS
  'جدول قصص الأطفال الفعلي (يخلف children_stories القديم بلا حذفه) - reviewed=false افتراضياً دائماً لكل صف، لا مسار كتابي يقدر يكتب true سوى تحديث يدوي مباشر من مالك المشروع. يضم حالياً 9 مسودة مُهاجَرة من children_stories القديم (بلا نص فعلي بعد) + أي قصص يكتبها المالك لاحقاً عبر upsert_draft_story.';

COMMENT ON COLUMN public.children_stories_drafts.source_author_id IS
  'معرّف مؤلف IslamHouse إن وُجد مصدر آلي حقيقي مستقبلاً - NULL يعني بصدق: لا مصدر IslamHouse معروف (كل الصفوف الحالية NULL: تسعة مُهاجَرة يدوياً قديماً، وأي إضافة من مرجع موثوق يكتبه المالك مباشرة).';

COMMENT ON COLUMN public.children_stories_drafts.legacy_moral IS
  'موعظة/عبرة القصة (moral_ar من children_stories القديم) - لا مكافئ لها في localized، أُبقيت كعمود مستقل بدل إسقاطها.';

COMMENT ON COLUMN public.children_stories_drafts.reviewed IS
  'false افتراضياً دائماً - لا مسار كتابي (بما فيه upsert_draft_story) يقدر يكتب true. فقط تحديث مباشر يدوي من مالك المشروع بعد قراءة فعلية لكل قصة.';

CREATE INDEX IF NOT EXISTS idx_children_stories_drafts_reviewed
  ON public.children_stories_drafts (reviewed);

CREATE INDEX IF NOT EXISTS idx_children_stories_drafts_original_language
  ON public.children_stories_drafts (original_language);

ALTER TABLE public.children_stories_drafts ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read access" ON public.children_stories_drafts
  FOR SELECT USING (reviewed = true);

GRANT SELECT ON TABLE public.children_stories_drafts TO anon;
GRANT SELECT ON TABLE public.children_stories_drafts TO authenticated;
GRANT ALL ON TABLE public.children_stories_drafts TO service_role;
GRANT ALL ON SEQUENCE public.children_stories_drafts_id_seq TO service_role;

-- ─── 2) ترحيل التسع صفوف القديمة كمسودات ────────────────────
-- content_ar فارغ (NULL) لكل التسعة فعلياً - لا محتوى نصي يُفقد، فقط
-- عنوان/تصنيف/موعظة/هوية بصرية مخطَّطة مسبقاً. simplified_text يبقى NULL
-- بصدق (لا نص فعلي بعد) بدل اختلاق نص أو نسخ العنوان في حقل النص.
INSERT INTO public.children_stories_drafts (
  source_author_id, source_item_id, original_language, localized,
  age_group, legacy_moral, legacy_category, legacy_emoji, legacy_color,
  legacy_order_index, reviewed
)
SELECT
  NULL,
  NULL,
  'ar',
  jsonb_build_object('ar', jsonb_build_object(
    'title', cs.title_ar,
    'simplified_text', NULL,
    'reading_time_minutes', NULL
  )),
  cs.age_range,
  cs.moral_ar,
  cs.category,
  cs.emoji,
  cs.color,
  cs.order_index,
  false
FROM public.children_stories cs
ORDER BY cs.id;

-- ─── 3) دالة الكتابة - CREATE OR REPLACE يستبدل تعريف الدالة المعطوب
-- من المهجرة الأصلية فعلياً (نفس الاسم والتوقيع تماماً)، لا يضيف نسخة
-- موازية. تستهدف الآن children_stories_drafts الصحيح. تُستهلَك من أداة
-- مراجعة المالك (لا حصاد آلي بعد إلغاء تلك المهمة نهائياً) - المالك
-- يمرر p_source_author_id/p_source_item_id كـNULL صراحة لأي قصة يكتبها
-- بنفسه من مرجع موثوق.
CREATE OR REPLACE FUNCTION public.upsert_draft_story(
  p_source_author_id integer,
  p_source_item_id integer,
  p_original_language text,
  p_title text,
  p_simplified_text text,
  p_reading_time_minutes integer DEFAULT NULL
) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
BEGIN
  INSERT INTO public.children_stories_drafts (
    source_author_id, source_item_id, original_language, localized
  ) VALUES (
    p_source_author_id,
    p_source_item_id,
    p_original_language,
    jsonb_build_object(
      p_original_language,
      jsonb_build_object(
        'title', p_title,
        'simplified_text', p_simplified_text,
        'reading_time_minutes', p_reading_time_minutes
      )
    )
  )
  ON CONFLICT (source_author_id, source_item_id) DO UPDATE
  SET localized = jsonb_set(
        public.children_stories_drafts.localized,
        ARRAY[p_original_language],
        jsonb_build_object(
          'title', p_title,
          'simplified_text', p_simplified_text,
          'reading_time_minutes', p_reading_time_minutes
        ),
        true
      ),
      updated_at = now();
END;
$$;

COMMENT ON FUNCTION public.upsert_draft_story(integer, integer, text, text, text, integer) IS
  'يكتب/يحدّث مسودة خام (reviewed=false دائماً) في children_stories_drafts - يستبدل تعريفاً معطوباً من المهجرة الأصلية كان يشير لجدول/أعمدة غير موجودة فعلياً. لا يقدر أبداً تعيين reviewed=true.';

ALTER FUNCTION public.upsert_draft_story(integer, integer, text, text, text, integer) OWNER TO postgres;

GRANT EXECUTE ON FUNCTION public.upsert_draft_story(integer, integer, text, text, text, integer) TO anon;
GRANT EXECUTE ON FUNCTION public.upsert_draft_story(integer, integer, text, text, text, integer) TO authenticated;
GRANT EXECUTE ON FUNCTION public.upsert_draft_story(integer, integer, text, text, text, integer) TO service_role;

-- ─── 4) تصحيح أمني فوري على الجدول القديم (بصرف النظر عن مصيره
-- النهائي لاحقاً - قد يُحذف أو يُؤرشَف بعد التأكد من نجاح الترحيل أعلاه) ───
-- السياسة الحالية "USING (true)" لا تفرض is_published إطلاقاً - فجوة
-- كامنة غير مُستغَلَّة حالياً فقط لأن content_ar فارغ للجميع. وGRANT ALL
-- (لا SELECT فقط) لـanon/authenticated أوسع مما يلزم قياساً على بقية
-- الجداول المُصلَحة سابقاً في هذا المشروع (RLS بلا سياسات كتابة يحجب
-- الكتابة فعلياً رغم الـGRANT، لكن لا داعٍ للاحتفاظ بالصلاحية أصلاً).
DROP POLICY IF EXISTS "Public read access" ON public.children_stories;
CREATE POLICY "Public read access" ON public.children_stories
  FOR SELECT USING (is_published = true);

REVOKE ALL ON TABLE public.children_stories FROM anon;
REVOKE ALL ON TABLE public.children_stories FROM authenticated;
GRANT SELECT ON TABLE public.children_stories TO anon;
GRANT SELECT ON TABLE public.children_stories TO authenticated;

REVOKE ALL ON SEQUENCE public.children_stories_id_seq FROM anon;
REVOKE ALL ON SEQUENCE public.children_stories_id_seq FROM authenticated;
