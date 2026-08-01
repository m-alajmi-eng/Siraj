-- جدول قصص الأطفال (children_stories): المرحلة الأولى من وحدة قصص
-- الأطفال - يخزّن مسودات خام محصودة من عمل ابن كثير (IslamHouse
-- author_id=8042) عبر get-author-items الحقيقي فقط. لا نص قصصي مُختلَق
-- بأي حال - المصدر الوحيد المعتمَد هو استجابة IslamHouse الفعلية.
--
-- **خلافاً لـlibrary_authors (ADR-013)**: لا استثناء "مصدر معتمَد" هنا.
-- reviewed=false افتراضياً دائماً ولكل صفّ على حدة، ولا مسار كتابي
-- (بما فيه الدالة أدناه) يقدر يكتب true - ذلك فقط عبر تحديث يدوي مباشر
-- من مالك المشروع (لوحة تحكم Supabase أو استعلام SQL مباشر) بعد مراجعة
-- بشرية فعلية لكل قصة. نفس نمط verse_hadith_relations/kg_edges تماماً،
-- لا نمط library_authors.
--
-- كل صفّ = عنصر واحد فعلي كما أعادته get-author-items للغة واحدة محدَّدة
-- (original_language) - لا دمج افتراضي بين إصدارات لغات مختلفة لنفس
-- "القصة المفهومية"، لأن IslamHouse يُرجع مُعرِّف عنصر مختلف لكل إصدار
-- لغة عملياً (تحقّقنا: نفس المؤلف بلغات مختلفة = source_item_id مختلفة).
-- عمود localized jsonb يبدأ بمفتاح original_language وحده (النص الخام)،
-- ويتّسع لاحقاً بمفاتيح لغات أخرى إن أضاف محرِّر بشري ترجمة/تبسيطاً
-- لنفس هذا العنصر تحديداً - لا حقول لغات فارغة لتغطية وهمية.

CREATE TABLE IF NOT EXISTS public.children_stories (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  source_author_id integer NOT NULL DEFAULT 8042,
  source_item_id integer NOT NULL,
  original_language text NOT NULL,
  localized jsonb NOT NULL DEFAULT '{}'::jsonb,
  age_group text,
  quran_references jsonb,
  reviewed boolean NOT NULL DEFAULT false,
  reviewed_by text,
  reviewed_at timestamp with time zone,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  updated_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT children_stories_source_item_key UNIQUE (source_author_id, source_item_id)
);

COMMENT ON TABLE public.children_stories IS
  'مسودات قصص أطفال محصودة من IslamHouse get-author-items (المؤلف 8042 = ابن كثير حالياً). كل صفّ = عنصر فعلي بلغة مصدر واحدة (original_language). لا نشر بلا reviewed=true يدوي من المالك.';

COMMENT ON COLUMN public.children_stories.source_author_id IS
  'معرّف مؤلف IslamHouse (get-author-items) - 8042 (ابن كثير) لكل الصفوف حالياً، عمود حقيقي لا قيمة مثبَّتة في الاستعلامات تحسباً لمؤلفين لاحقين.';

COMMENT ON COLUMN public.children_stories.source_item_id IS
  'معرّف العنصر كما يرجع من IslamHouse (data[].id في get-author-items) - فريد لكل (source_author_id, source_item_id).';

COMMENT ON COLUMN public.children_stories.localized IS
  'خريطة lang_code -> {title, simplified_text, reading_time_minutes}. عند الحصاد الخام (بلا مراجعة/تبسيط بشري بعد) يحمل المفتاح original_language فقط والنص هو نص المصدر الحرفي دون أي تعديل.';

COMMENT ON COLUMN public.children_stories.age_group IS
  'فئة عمرية مستهدَفة - نص حر، تُملأ يدوياً أثناء المراجعة التحريرية. لا قيمة افتراضية ولا قيد CHECK بعد (الفئات لم تُحسَم تصميمياً بعد).';

COMMENT ON COLUMN public.children_stories.quran_references IS
  'مصفوفة JSON اختيارية لآيات ذات صلة ({surah, ayah}) - تُملأ يدوياً أثناء المراجعة التحريرية، لا استنتاج آلي.';

COMMENT ON COLUMN public.children_stories.reviewed IS
  'false افتراضياً دائماً - يعني تحديداً: لم يراجعه إنسان بعد. لا مسار كتابي (بما في ذلك upsert_draft_story أدناه) يقدر يكتب true - فقط تحديث مباشر يدوي من مالك المشروع بعد قراءة فعلية للقصة. خلافاً جوهرياً لـlibrary_authors.reviewed (ADR-013): هنا مراجعة فردية لكل قصة إلزامية دوماً.';

CREATE INDEX IF NOT EXISTS idx_children_stories_reviewed
  ON public.children_stories (reviewed);

CREATE INDEX IF NOT EXISTS idx_children_stories_original_language
  ON public.children_stories (original_language);

ALTER TABLE public.children_stories ENABLE ROW LEVEL SECURITY;

-- قراءة عامة فقط للصفوف المُراجَعة فعلياً - نفس نمط verse_hadith_relations
-- وkg_edges تماماً.
CREATE POLICY "Public read access" ON public.children_stories
  FOR SELECT USING (reviewed = true);

-- لا INSERT/UPDATE/DELETE مباشر لـanon/authenticated على الجدول - المسار
-- الكتابي الوحيد المسموح هو upsert_draft_story أدناه (يكتب reviewed=false
-- حصراً). تحديث reviewed=true لاحقاً يتم فقط عبر service_role (لوحة تحكم
-- Supabase أو اتصال مباشر بمفتاح الخدمة)، لا عبر أي RPC مكشوف للعميل.
GRANT SELECT ON TABLE public.children_stories TO anon;
GRANT SELECT ON TABLE public.children_stories TO authenticated;
GRANT ALL ON TABLE public.children_stories TO service_role;
GRANT ALL ON SEQUENCE public.children_stories_id_seq TO service_role;

-- يكتب/يحدّث مسودة خام واحدة عبر (source_author_id, source_item_id).
-- SECURITY DEFINER لتجاوز غياب صلاحية الكتابة المباشرة لـanon/authenticated
-- على الجدول - هذه الدالة نفسها هي الجسر الوحيد المسموح. لا تقدر أبداً
-- تكتب reviewed=true: القيمة الافتراضية عند الإدراج الأول هي false فقط،
-- وجملة التحديث (ON CONFLICT) لا تذكر عمود reviewed إطلاقاً - فتبقى
-- كما كانت (false ما لم يُحدِّثها المالك يدوياً بمعزل تام عن هذه الدالة).
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
  INSERT INTO public.children_stories (
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
        public.children_stories.localized,
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
  'يكتب/يحدّث مسودة خام (reviewed=false دائماً) من عنصر IslamHouse فعلي - المسار الكتابي الوحيد المسموح لـchildren_stories من anon/authenticated. لا يقدر أبداً تعيين reviewed=true.';

ALTER FUNCTION public.upsert_draft_story(integer, integer, text, text, text, integer) OWNER TO postgres;

GRANT EXECUTE ON FUNCTION public.upsert_draft_story(integer, integer, text, text, text, integer) TO anon;
GRANT EXECUTE ON FUNCTION public.upsert_draft_story(integer, integer, text, text, text, integer) TO authenticated;
GRANT EXECUTE ON FUNCTION public.upsert_draft_story(integer, integer, text, text, text, integer) TO service_role;
