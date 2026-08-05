-- تصنيف قصص السيرة (stories) بمجموعات مصدرية (بدر/أُحد/بيعة الرضوان/
-- التابعون/العلماء إلخ) - **تصميم لا يستند لأي مواصفة مسبقة موثَّقة في
-- هذه الجلسة** (لم يُذكَر story_groups قبل الآن إطلاقاً)، بل اجتهاد
-- معقول يتّبع نفس أنماط المشروع القائمة (SECURITY DEFINER، is_published
-- بلا مسار كتابة آلي، لا مفتاح خدمة). راجع
-- tools/stories_biography/NEEDS_REVIEW.md.
--
-- 2026-08-05: أُضيفت 6 slugs إضافية بطلب محمد الصريح (ashara_mubashara/
-- ummahat_muminin/kuttab_wahy/khaybar/muta/hunayn) - مطابقة لمجموعات
-- فعلية موثَّقة في progress_log.md ومسجَّلة محلياً في حقل intended_group
-- بملفات tools/stories_biography/ready/**/*.json. **موافقة محمد الصريحة
-- على db push لهذه المهجرة تحديداً وردت في نفس الرسالة** - راجع محضر
-- المحادثة. push نُفِّذ بعد عرض هذا الملف عليه.
--
-- لا تعديل مباشر على is_published أو reviewed_by/reviewed_at - هذه
-- المهجرة تضيف تصنيفاً تنظيمياً فقط (أي مجموعة مصدرية تنتمي إليها كل
-- قصة)، لا علاقة لها بالنشر.

CREATE TABLE public.story_groups (
  id              bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  slug            text UNIQUE NOT NULL,
  title_ar        text NOT NULL,
  description_ar  text,
  created_at      timestamp with time zone NOT NULL DEFAULT now()
);

COMMENT ON TABLE public.story_groups IS
  'مجموعات تصنيفية مصدرية لقصص السيرة (مثال: أهل بدر، أهل أُحد، بيعة الرضوان، التابعون، العلماء) - تنظيمية فقط، لا علاقة لها بالنشر (is_published).';

ALTER TABLE public.story_groups ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read access" ON public.story_groups
  FOR SELECT USING (true);

GRANT SELECT ON TABLE public.story_groups TO anon;
GRANT SELECT ON TABLE public.story_groups TO authenticated;
REVOKE ALL ON SEQUENCE public.story_groups_id_seq FROM anon;
REVOKE ALL ON SEQUENCE public.story_groups_id_seq FROM authenticated;

INSERT INTO public.story_groups (slug, title_ar) VALUES
  ('badr',              'أهل بدر'),
  ('uhud',              'أهل أُحد'),
  ('ridwan',            'بيعة الرضوان'),
  ('tabieen',           'التابعون'),
  ('ulama',             'العلماء'),
  ('ashara_mubashara',  'العشرة المبشرون بالجنة'),
  ('ummahat_muminin',   'أمهات المؤمنين'),
  ('kuttab_wahy',       'كتّاب الوحي'),
  ('khaybar',           'أهل خيبر'),
  ('muta',              'أهل مؤتة'),
  ('hunayn',            'أهل حنين وأوطاس')
ON CONFLICT (slug) DO NOTHING;

ALTER TABLE public.stories ADD COLUMN IF NOT EXISTS group_slug text
  REFERENCES public.story_groups(slug);

COMMENT ON COLUMN public.stories.group_slug IS
  'المجموعة المصدرية التي استُخرجت منها هذه القصة (انظر story_groups) - تنظيمي فقط، NULL مسموح لأي قصة غير مصنَّفة بعد.';

CREATE INDEX IF NOT EXISTS idx_stories_group_slug ON public.stories (group_slug);

-- دالة ربط مفردة - نفس فلسفة upsert_story_draft: SECURITY DEFINER،
-- متاحة لـanon (العميل العادي)، تكتب عموداً تنظيمياً واحداً فقط
-- (group_slug) ولا تلمس is_published ولا reviewed_by/reviewed_at ولا
-- أي عمود محتوى آخر.
CREATE OR REPLACE FUNCTION public.set_story_group(
  p_id         bigint,
  p_group_slug text
) RETURNS bigint
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
DECLARE
  v_id bigint;
BEGIN
  UPDATE public.stories
  SET group_slug = p_group_slug
  WHERE id = p_id
  RETURNING id INTO v_id;

  IF NOT FOUND THEN
    RAISE EXCEPTION 'set_story_group: لا يوجد صف بهذا id: %', p_id;
  END IF;

  RETURN v_id;
END;
$$;

COMMENT ON FUNCTION public.set_story_group(bigint, text) IS
  'يربط قصة موجودة بمجموعتها المصدرية (group_slug) - عمود تنظيمي واحد فقط، لا يلمس is_published أو أي عمود محتوى آخر.';

ALTER FUNCTION public.set_story_group(bigint, text) OWNER TO postgres;

GRANT EXECUTE ON FUNCTION public.set_story_group(bigint, text) TO anon;
GRANT EXECUTE ON FUNCTION public.set_story_group(bigint, text) TO authenticated;
GRANT EXECUTE ON FUNCTION public.set_story_group(bigint, text) TO service_role;
