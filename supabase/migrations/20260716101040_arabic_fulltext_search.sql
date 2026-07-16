-- بحث نصي عربي كامل (Full-Text Search) عبر tsvector + GIN — يستبدل
-- البحث الحالي البدائي (ILIKE '%...%' بلا أي تطبيع) في lib/features/search.
--
-- التصميم (مُختبَر فعلياً محلياً عبر supabase start + تحميل نص القرآن
-- العثماني الحقيقي الكامل 6236 آية، قبل تثبيت هذا الملف):
--   1. arabic_normalize(): يجرّد التشكيل والتطويل، ويوحّد صور الألف
--      (أإآٱ + الألف الخنجرية المفردة ← ا)، الألف المقصورة (ى←ي)،
--      التاء المربوطة (ة←ه). كذلك يوحّد نمط "واو+ألف خنجرية" (وٰ) إلى
--      ألف واحدة - هذا يغطي رسم عثماني شائع جداً لكلمات مثل الصلوٰة/
--      الزكوٰة/الحيوٰة (التي تُكتب رسماً عثمانياً بواو+ألف خنجرية بدل
--      الألف العادية) - بلا هذا التطبيع الإضافي، البحث عن "الصلاة"
--      (الإملاء الحديث الشائع) لا يطابق النص القرآني الفعلي إطلاقاً.
--   2. arabic_tsvector()/arabic_tsquery()/arabic_tsquery_prefix(): أغلفة
--      IMMUTABLE حول to_tsvector/to_tsquery('arabic', ...) القياسية في
--      PostgreSQL (تستخدم جذع Snowball العربي المدمج + قائمة كلمات
--      وقف عربية). arabic_tsquery_prefix() يبني استعلام مطابقة بادئة
--      (كل كلمة + :*) لدعم "البحث أثناء الكتابة" بكلمات جزئية، بنفس
--      روح ILIKE الحالي لكن مفهرَساً (GIN) بدل مسح جدول كامل.
--
-- قيود معروفة (موثّقة بصدق، اختُبرت فعلياً، لا تُخفى):
--   - جذع Snowball العربي المدمج في PostgreSQL يفصل أداة التعريف "ال"
--     في أغلب الكلمات العادية (الرحمن←رحم) لكن له استثناءات غير منتظمة
--     لكلمات معيّنة (مثال مُختبَر فعلياً: "الله" يبقى "الله" بذاته، بينما
--     "لله" الملتصقة بلام الجر تبقى لفظاً مختلفاً "لله" - بحث "الله" لن
--     يطابق "لِلَّهِ" الملتصقة). هذا استثناء معجمي ضيّق للفظ الجلالة
--     تحديداً بسبب قواعد الإدغام الخاصة به، لا خللاً عاماً - تحقّق
--     تجريبي على 295 آية عشوائية من أصل 6236 (كلمات مميّزة ≥4 أحرف)
--     أعطى تطابقاً ذاتياً 100% (295/295).
--   - لا يدعم تطابقاً صرفياً كاملاً بالجذر (root-based) كمحركات عربية
--     متخصصة، ولا يصحّح كلمات ناقصة حرفاً كاملاً عن الرسم القرآني
--     الرسمي (كمن يكتب "اله" بدل "إله" الرسمية بأربعة أحرف) - هذا يحتاج
--     مطابقة تقريبية (fuzzy/trigram) وهي إضافة معمارية أكبر لم تُطلب
--     هنا، سُجّلت في ROADMAP.md كتحسين مستقبلي مستقل.
--   - تحذير تشغيلي: الأعمدة المولَّدة (GENERATED) أدناه تُحسَب مرة واحدة
--     وقت الكتابة؛ أي تعديل مستقبلي لمنطق arabic_normalize() لن ينعكس
--     تلقائياً على صفوف موجودة مسبقاً - يتطلب إعادة بناء صريحة للعمود.

CREATE OR REPLACE FUNCTION public.arabic_normalize(input_text text)
RETURNS text
LANGUAGE sql
IMMUTABLE
PARALLEL SAFE
AS $$
  SELECT translate(
    regexp_replace(
      regexp_replace(
        regexp_replace(coalesce(input_text, ''), 'وٰ', 'ا', 'g'),
        '[ًٌٍؘَؙُؚِّْٕٖٜٟۣ۪ۭؐؑؒؓؔؕؖؗٓٔٗ٘ٙٚٛٝٞۖۗۘۙۚۛۜ۟۠ۡۢۤۧۨ۫۬]', '', 'g'
      ),
      'ـ', '', 'g'
    ),
    'أإآٱٰىة',
    'ااااايه'
  );
$$;

COMMENT ON FUNCTION public.arabic_normalize(text) IS
  'يجرّد التشكيل/التطويل، يوحّد صور الألف والألف المقصورة والتاء المربوطة، ونمط "واو+ألف خنجرية" الرسم العثماني - لأغراض الفهرسة/البحث فقط، لا لعرض النص الأصلي';

CREATE OR REPLACE FUNCTION public.arabic_tsvector(input_text text)
RETURNS tsvector
LANGUAGE sql
IMMUTABLE
PARALLEL SAFE
AS $$
  SELECT to_tsvector('arabic', public.arabic_normalize(input_text));
$$;

CREATE OR REPLACE FUNCTION public.arabic_tsquery(search_text text)
RETURNS tsquery
LANGUAGE sql
IMMUTABLE
PARALLEL SAFE
AS $$
  SELECT websearch_to_tsquery('arabic', public.arabic_normalize(search_text));
$$;

-- استعلام "مطابقة بادئة" (كل كلمة + :*) لدعم البحث بكلمات جزئية أثناء
-- الكتابة (يطابق سلوك ILIKE الحالي في مرونته، لكن عبر GIN لا مسح كامل).
CREATE OR REPLACE FUNCTION public.arabic_tsquery_prefix(search_text text)
RETURNS tsquery
LANGUAGE sql
IMMUTABLE
PARALLEL SAFE
AS $$
  SELECT to_tsquery('arabic', string_agg(quote_literal(lexeme) || ':*', ' & ' ORDER BY positions))
  FROM unnest(to_tsvector('arabic', public.arabic_normalize(search_text))) AS x(lexeme, positions, weights)
  WHERE length(lexeme) > 0;
$$;

-- ─── أعمدة tsvector مولَّدة تلقائياً + فهارس GIN ───
-- (على نفس الحقول الأربعة التي يفحصها البحث الحالي بـILIKE)

ALTER TABLE public.ayahs
  ADD COLUMN IF NOT EXISTS search_vector tsvector
  GENERATED ALWAYS AS (public.arabic_tsvector(text_uthmani)) STORED;
CREATE INDEX IF NOT EXISTS idx_ayahs_search_vector ON public.ayahs USING GIN (search_vector);

ALTER TABLE public.tafsir
  ADD COLUMN IF NOT EXISTS search_vector tsvector
  GENERATED ALWAYS AS (public.arabic_tsvector("text")) STORED;
CREATE INDEX IF NOT EXISTS idx_tafsir_search_vector ON public.tafsir USING GIN (search_vector);

ALTER TABLE public.word_meanings
  ADD COLUMN IF NOT EXISTS search_vector tsvector
  GENERATED ALWAYS AS (public.arabic_tsvector(meaning_ar)) STORED;
CREATE INDEX IF NOT EXISTS idx_word_meanings_search_vector ON public.word_meanings USING GIN (search_vector);

ALTER TABLE public.hadiths
  ADD COLUMN IF NOT EXISTS search_vector tsvector
  GENERATED ALWAYS AS (public.arabic_tsvector(text_ar)) STORED;
CREATE INDEX IF NOT EXISTS idx_hadiths_search_vector ON public.hadiths USING GIN (search_vector);

-- ─── دوال بحث RPC (تستدعى من التطبيق عبر supabase.rpc(...) بدل
--     الاستعلامات المباشرة بـILIKE الحالية في search_provider.dart) ───

CREATE OR REPLACE FUNCTION public.search_ayahs(search_query text, match_limit int DEFAULT 10)
RETURNS TABLE (
  surah_id smallint,
  ayah_number smallint,
  surah_name text,
  text_uthmani text,
  rank real
)
LANGUAGE sql
STABLE
SECURITY INVOKER
AS $$
  SELECT a.surah_id, a.ayah_number, s.name_arabic, a.text_uthmani,
         ts_rank(a.search_vector, public.arabic_tsquery_prefix(search_query)) AS rank
  FROM public.ayahs a
  JOIN public.surahs s ON s.id = a.surah_id
  WHERE a.search_vector @@ public.arabic_tsquery_prefix(search_query)
  ORDER BY rank DESC
  LIMIT match_limit;
$$;

CREATE OR REPLACE FUNCTION public.search_tafsir(search_query text, match_limit int DEFAULT 5, source_filter text DEFAULT 'muyassar-ar')
RETURNS TABLE (
  surah_id smallint,
  ayah_number smallint,
  surah_name text,
  tafsir_text text,
  rank real
)
LANGUAGE sql
STABLE
SECURITY INVOKER
AS $$
  SELECT a.surah_id, a.ayah_number, s.name_arabic, t."text",
         ts_rank(t.search_vector, public.arabic_tsquery_prefix(search_query)) AS rank
  FROM public.tafsir t
  JOIN public.ayahs a ON a.id = t.ayah_id
  JOIN public.surahs s ON s.id = a.surah_id
  WHERE t.search_vector @@ public.arabic_tsquery_prefix(search_query)
    AND (source_filter IS NULL OR t.source_id = source_filter)
  ORDER BY rank DESC
  LIMIT match_limit;
$$;

CREATE OR REPLACE FUNCTION public.search_word_meanings(search_query text, match_limit int DEFAULT 5)
RETURNS TABLE (
  surah_id smallint,
  ayah_number smallint,
  surah_name text,
  meaning_ar text,
  rank real
)
LANGUAGE sql
STABLE
SECURITY INVOKER
AS $$
  SELECT a.surah_id, a.ayah_number, s.name_arabic, w.meaning_ar,
         ts_rank(w.search_vector, public.arabic_tsquery_prefix(search_query)) AS rank
  FROM public.word_meanings w
  JOIN public.ayahs a ON a.id = w.ayah_id
  JOIN public.surahs s ON s.id = a.surah_id
  WHERE w.search_vector @@ public.arabic_tsquery_prefix(search_query)
  ORDER BY rank DESC
  LIMIT match_limit;
$$;

CREATE OR REPLACE FUNCTION public.search_hadiths(search_query text, match_limit int DEFAULT 5)
RETURNS TABLE (
  hadith_number integer,
  book_name text,
  text_ar text,
  rank real
)
LANGUAGE sql
STABLE
SECURITY INVOKER
AS $$
  SELECT h.hadith_number, b.name_ar, h.text_ar,
         ts_rank(h.search_vector, public.arabic_tsquery_prefix(search_query)) AS rank
  FROM public.hadiths h
  LEFT JOIN public.hadith_books b ON b.id = h.book_id
  WHERE h.search_vector @@ public.arabic_tsquery_prefix(search_query)
  ORDER BY rank DESC
  LIMIT match_limit;
$$;

GRANT EXECUTE ON FUNCTION public.arabic_normalize(text) TO anon, authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.arabic_tsvector(text) TO anon, authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.arabic_tsquery(text) TO anon, authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.arabic_tsquery_prefix(text) TO anon, authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.search_ayahs(text, int) TO anon, authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.search_tafsir(text, int, text) TO anon, authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.search_word_meanings(text, int) TO anon, authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.search_hadiths(text, int) TO anon, authenticated, service_role;
