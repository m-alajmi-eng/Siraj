-- جدول مؤلفي المكتبة (library_authors): يخزّن بيانات مؤلفين محصودة من
-- IslamHouse API (get-author) أثناء التصفّح العادي للمستخدمين، بدل نداء
-- شبكي مباشر من كل جهاز في كل مرة. الحقلان title/description داخل
-- localized نسخ حرفي غير معدَّل من IslamHouse - استثناء ضيّق من بوابة
-- reviewed=false القياسية موثَّق في ADR-013
-- (docs/adr/ADR-013-harvested-author-metadata-exemption.md)، محصور
-- بهذين الحقلين فقط ولا يمتد لأي محتوى تحريري مستقبلي.
--
-- reviewed=true هنا استثناء على مستوى المصدر (IslamHouse get-author،
-- معتمَد صراحة من مالك المشروع بتاريخ 2026-07-23 لهذا الغرض تحديداً)،
-- لا مراجعة بشرية فردية لكل سطر - انظر COMMENT ON COLUMN أدناه وADR-013
-- للصياغة الكاملة. هذا يختلف جوهرياً عن verse_hadith_relations التي
-- تتطلب مراجعة فردية لكل علاقة.
--
-- الكتابة تمر حصراً عبر upsert_harvested_author (RPC واحد، SECURITY
-- DEFINER) - لا صلاحية INSERT/UPDATE/DELETE مباشرة على الجدول لـ
-- anon/authenticated، فقط SELECT للقراءة العامة (وفقط للصفوف
-- reviewed=true، نفس نمط verse_hadith_relations تماماً). هذا يمنع أي
-- طرف من إدخال بيانات مؤلفين مزيّفة مباشرة عبر REST API متجاوزاً منطق
-- الدمج.

CREATE TABLE IF NOT EXISTS public.library_authors (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  islamhouse_author_id integer NOT NULL,
  localized jsonb NOT NULL DEFAULT '{}'::jsonb,
  items_count integer,
  first_seen_category_id integer,
  reviewed boolean NOT NULL DEFAULT true,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  updated_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT library_authors_islamhouse_author_id_key UNIQUE (islamhouse_author_id)
);

COMMENT ON TABLE public.library_authors IS
  'مؤلفو المكتبة محصودون تدريجياً من IslamHouse get-author أثناء التصفّح العادي. localized.title/description نسخ حرفي (ADR-013) - لا كتابة مباشرة، فقط عبر upsert_harvested_author.';

COMMENT ON COLUMN public.library_authors.reviewed IS
  'reviewed=true هنا يعني تحديداً: محتوى مُنسوخ حرفياً بلا أي تحويل من استجابة get-author لـIslamHouse (مصدر مؤسسي معتمَد صراحة من مالك المشروع لهذا الغرض بتاريخ 2026-07-23)، لا مراجعة بشرية فردية لكل سطر. هذا استثناء على مستوى المصدر، لا على مستوى العنصر - يختلف عن verse_hadith_relations التي تتطلب مراجعة فردية لكل علاقة. أي مصدر مستقبلي أقل ثقة لهذا الجدول نفسه يُدرَج بـreviewed=false افتراضياً.';

CREATE INDEX IF NOT EXISTS idx_library_authors_items_count
  ON public.library_authors (items_count DESC NULLS LAST);

ALTER TABLE public.library_authors ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read access" ON public.library_authors
  FOR SELECT USING (reviewed = true);

-- قراءة فقط لـanon/authenticated - لا INSERT/UPDATE/DELETE مباشر على
-- الجدول (خلافاً لنمط GRANT ALL المعتاد في هذا المشروع)؛ الكتابة الوحيدة
-- المسموحة تمر عبر RPC أدناه فقط.
GRANT SELECT ON TABLE public.library_authors TO anon;
GRANT SELECT ON TABLE public.library_authors TO authenticated;
GRANT ALL ON TABLE public.library_authors TO service_role;
GRANT ALL ON SEQUENCE public.library_authors_id_seq TO service_role;

-- دمج مؤلف محصود من استدعاء get-author/get-category-items حقيقي.
-- SECURITY DEFINER لأن anon/authenticated ليس لديهما صلاحية كتابة مباشرة
-- على الجدول - الدالة نفسها هي الجسر الوحيد المسموح للكتابة.
CREATE OR REPLACE FUNCTION public.upsert_harvested_author(
  p_author_id integer,
  p_lang text,
  p_title text,
  p_description text,
  p_items_count integer,
  p_category_id integer
) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
  existing_localized jsonb;
  existing_description text;
BEGIN
  SELECT localized INTO existing_localized
  FROM public.library_authors
  WHERE islamhouse_author_id = p_author_id
  FOR UPDATE;

  IF NOT FOUND THEN
    INSERT INTO public.library_authors (
      islamhouse_author_id, localized, items_count, first_seen_category_id
    ) VALUES (
      p_author_id,
      jsonb_build_object(p_lang, jsonb_build_object('title', p_title, 'description', p_description)),
      p_items_count,
      p_category_id
    );
    RETURN;
  END IF;

  existing_description := existing_localized #>> ARRAY[p_lang, 'description'];

  -- لا نستبدل وصفاً غنياً موجوداً بوصف جديد أقصر/فارغ لنفس اللغة؛
  -- items_count يُحدَّث دائماً بغضّ النظر (أحدث رقم متاح من المصدر).
  IF existing_description IS NULL
     OR length(coalesce(p_description, '')) > length(existing_description) THEN
    UPDATE public.library_authors
    SET localized = jsonb_set(
          existing_localized,
          ARRAY[p_lang],
          jsonb_build_object('title', p_title, 'description', p_description),
          true
        ),
        items_count = p_items_count,
        updated_at = now()
    WHERE islamhouse_author_id = p_author_id;
  ELSE
    UPDATE public.library_authors
    SET items_count = p_items_count,
        updated_at = now()
    WHERE islamhouse_author_id = p_author_id;
  END IF;
END;
$$;

COMMENT ON FUNCTION public.upsert_harvested_author(integer, text, text, text, integer, integer) IS
  'يدمج مؤلفاً محصوداً من IslamHouse في library_authors - المسار الكتابي الوحيد المسموح للجدول. لا يستبدل وصفاً موجوداً بأقصر منه لنفس اللغة.';

ALTER FUNCTION public.upsert_harvested_author(integer, text, text, text, integer, integer) OWNER TO postgres;

GRANT EXECUTE ON FUNCTION public.upsert_harvested_author(integer, text, text, text, integer, integer) TO anon;
GRANT EXECUTE ON FUNCTION public.upsert_harvested_author(integer, text, text, text, integer, integer) TO authenticated;
GRANT EXECUTE ON FUNCTION public.upsert_harvested_author(integer, text, text, text, integer, integer) TO service_role;
