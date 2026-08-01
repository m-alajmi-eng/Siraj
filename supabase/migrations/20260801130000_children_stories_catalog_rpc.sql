-- دالة كتالوج قصص الأطفال (get_children_stories_catalog): تُرجع بيانات
-- العرض غير الحسّاسة فقط (عنوان/تصنيف/إيموجي/لون/ترتيب) لكل صفوف
-- children_stories_drafts بصرف النظر عن reviewed - هذا كتالوج عناوين
-- محايد لا محتوى قصصي فعلي، خلافاً جوهرياً لـsimplified_text الذي يبقى
-- محجوباً خلف RLS (reviewed=true) في كل مسار عبر هذه الدالة.
--
-- السبب: سياسة "Public read access" على children_stories_drafts
-- (المهجرة 20260801044536) تحصر SELECT المباشر لـanon/authenticated
-- بالصفوف reviewed=true فقط. التسع قصص المُرحَّلة كلها reviewed=false
-- (مُتعمَّد - لا نشر بلا مراجعة بشرية فعلية لكل قصة)، فأي استعلام مباشر
-- من التطبيق يُرجع صفراً صفوف حتى للعنوان/الإيموجي/اللون رغم أنها بيانات
-- كتالوج غير حسّاسة أصلاً (لا تكشف نصاً غير مراجَع). القرار المعماري
-- (من مالك المشروع): لا تعديل على سياسة RLS نفسها ولا view منفصل - بدلاً
-- من ذلك RPC واحدة SECURITY DEFINER ضيّقة الغرض تُرجع الأعمدة المحدَّدة
-- أدناه فقط وتتجاوز RLS لهذه الأعمدة تحديداً، دون أي مسار يُرجع
-- simplified_text أو أي حقل آخر من localized عبرها إطلاقاً.
--
-- title يُستخرَج من localized بمنطق سقوط اللغة: لغة الواجهة الحالية
-- (p_lang) → عربي → إنجليزي → أي لغة أخرى متاحة بعنوان فعلي - نفس نمط
-- LibraryAuthorsRemoteDataSource._resolveLocalizedEntry تماماً (نُسخة
-- SQL منه)، فقط لعمود title بدل الكائن الكامل لأن هذه الدالة لا تُرجع
-- شيئاً غير title من localized أبداً.
CREATE OR REPLACE FUNCTION public.get_children_stories_catalog(
  p_lang text DEFAULT 'ar'
) RETURNS TABLE (
  id                 bigint,
  legacy_category    text,
  legacy_emoji       text,
  legacy_color       text,
  legacy_order_index integer,
  title              text
)
    LANGUAGE sql STABLE SECURITY DEFINER
    SET search_path TO 'public'
    AS $$
  SELECT
    d.id,
    d.legacy_category,
    d.legacy_emoji,
    d.legacy_color,
    d.legacy_order_index,
    COALESCE(
      NULLIF(d.localized #>> ARRAY[p_lang, 'title'], ''),
      NULLIF(d.localized #>> ARRAY['ar', 'title'], ''),
      NULLIF(d.localized #>> ARRAY['en', 'title'], ''),
      (
        SELECT NULLIF(kv.value #>> ARRAY['title'], '')
        FROM jsonb_each(d.localized) AS kv
        WHERE NULLIF(kv.value #>> ARRAY['title'], '') IS NOT NULL
        LIMIT 1
      )
    ) AS title
  FROM public.children_stories_drafts d
  ORDER BY d.legacy_order_index NULLS LAST, d.id;
$$;

COMMENT ON FUNCTION public.get_children_stories_catalog(text) IS
  'كتالوج عرض غير حسّاس (id/تصنيف/إيموجي/لون/ترتيب/عنوان) لكل صفوف children_stories_drafts بصرف النظر عن reviewed - SECURITY DEFINER يتجاوز RLS لهذه الأعمدة فقط. لا يُرجع simplified_text ولا أي حقل آخر من localized إطلاقاً - المحتوى الفعلي يبقى محجوباً خلف RLS حتى reviewed=true عبر SELECT مباشر في StoryReaderScreen.';

ALTER FUNCTION public.get_children_stories_catalog(text) OWNER TO postgres;

GRANT EXECUTE ON FUNCTION public.get_children_stories_catalog(text) TO anon;
GRANT EXECUTE ON FUNCTION public.get_children_stories_catalog(text) TO authenticated;
GRANT EXECUTE ON FUNCTION public.get_children_stories_catalog(text) TO service_role;
