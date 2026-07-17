-- توحيد أول علاقتين فقط (ayah_hadiths + verse_hadith_relations) في جدول
-- علاقات موحَّد kg_edges. لا حذف للجداول القديمة - تبقيان كنسختين
-- احتياطيتين حتى مراجعة بشرية لاحقة تقرّر إزالتهما.
--
-- التصميم (مُختبَر فعلياً محلياً عبر supabase start قبل تثبيت هذا الملف،
-- ببيانات اختبار مصطنعة تحاكي الجدولين المصدر):
--   - ayah_hadiths (ayah_id↔hadith_id حقيقي): يُهاجَر كـ dst_type='hadith'،
--     dst_id=hadith_id الفعلي (مفتاح خارجي حقيقي لجدول hadiths)،
--     edge_type='ayah_hadith'. الجدول المصدر لم يملك عمود reviewed
--     إطلاقاً وكان يُعرض دون أي قيد مراجعة - يُهاجَر بـ reviewed=false
--     (لا اختراع قيمة "true" لم تكن موجودة أصلاً)، لكن سياسة RLS أدناه
--     تُبقي هذا النوع مرئياً للجميع بلا قيد (كما كان تماماً)، لأن قيد
--     "reviewed فقط" في RLS يخص حصراً استشهادات أضواء البيان تحديداً
--     (كما كان في verse_hadith_relations الأصلي).
--   - verse_hadith_relations (استشهادات أضواء البيان: نص مقتبس + فقرة +
--     مرجع، بلا كيان "hadith" منفصل مُطابَق): يُهاجَر كـ dst_type='citation'،
--     dst_id=NULL (لا كيان مطابَق)، والمحتوى الكامل (quoted_text/
--     full_paragraph/source_book/source_author/shamela_url/shamela_page)
--     يُحفَظ في أعمدة citation_* الإضافية بدل فقدانه (المخطط الأساسي
--     المطلوب src_id/dst_id/edge_type/source_reference/reviewed لا يكفي
--     وحده لعرض محتوى استشهاد نصي بلا كيان dst منفصل - أعمدة citation_*
--     امتداد ضروري، ليس قراراً معمارياً مختلفاً).
--     **قيمة reviewed تُنسَخ كما هي من المصدر (لا تُصفَّر لـfalse)**: هذه
--     ليست حالة يقرّرها الذكاء الاصطناعي الآن، بل قرار بشري ماضٍ حقيقي
--     مسجَّل فعلاً في الجدول المصدر (reviewed=true تعني إنساناً راجع هذا
--     الاستشهاد سابقاً وقرَّر نشره) - إعادة ضبطها لـfalse أثناء ترحيل
--     تخزين بحت كانت ستكون تزويراً لتاريخ مراجعة فعلي، لا امتثالاً لقاعدة
--     "لا يضع الذكاء الاصطناعي reviewed=true من تلقاء نفسه" (تلك القاعدة
--     تمنع الذكاء الاصطناعي من اتخاذ قرار مراجعة جديد، لا نسخ قرار بشري
--     سابق أثناء تغيير مكان التخزين).
--
--   تحقّق فعلي عبر SET ROLE anon محلياً: صفّ ayah_hadith يظهر دائماً،
--   صفّ استشهاد reviewed=true يظهر، صفّ استشهاد reviewed=false يُخفى -
--   مطابق تماماً لسلوك الجدولين القديمين مجتمعين قبل هذا التوحيد.

CREATE TABLE IF NOT EXISTS public.kg_edges (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  src_type text NOT NULL DEFAULT 'ayah',
  src_id bigint NOT NULL,
  dst_type text NOT NULL,
  dst_id bigint,
  edge_type text NOT NULL,
  source_reference text,
  citation_text text,
  citation_context text,
  citation_book text,
  citation_author text,
  citation_url text,
  citation_page integer,
  reviewed boolean NOT NULL DEFAULT false,
  reviewed_at timestamp with time zone,
  created_at timestamp with time zone NOT NULL DEFAULT now(),
  CONSTRAINT kg_edges_edge_type_check CHECK (edge_type IN ('ayah_hadith', 'authentic_hadith_citation', 'israiliyyat_citation')),
  CONSTRAINT kg_edges_dst_type_check CHECK (dst_type IN ('hadith', 'citation')),
  CONSTRAINT kg_edges_src_ayah_fkey FOREIGN KEY (src_id) REFERENCES public.ayahs(id),
  CONSTRAINT kg_edges_dst_hadith_fkey FOREIGN KEY (dst_id) REFERENCES public.hadiths(id)
);

COMMENT ON TABLE public.kg_edges IS
  'جدول علاقات موحَّد (Knowledge Graph edges) - يبدأ بتوحيد ayah_hadiths وverse_hadith_relations فقط. الجدولان القديمان لم يُحذَفا، يبقيان كنسخة احتياطية حتى مراجعة بشرية.';

CREATE INDEX IF NOT EXISTS idx_kg_edges_src ON public.kg_edges (src_type, src_id);
CREATE INDEX IF NOT EXISTS idx_kg_edges_dst ON public.kg_edges (dst_type, dst_id) WHERE dst_id IS NOT NULL;

ALTER TABLE public.kg_edges ENABLE ROW LEVEL SECURITY;

-- نفس منطق العرض القديم مجتمعاً: روابط الأحاديث (ayah_hadith) كانت تُعرض
-- دون قيد مراجعة، واستشهادات أضواء البيان كانت تُعرض فقط عند reviewed=true.
CREATE POLICY "قراءة عامة - حسب نوع الرابط"
ON public.kg_edges FOR SELECT
USING (edge_type = 'ayah_hadith' OR reviewed = true);

GRANT ALL ON TABLE public.kg_edges TO anon;
GRANT ALL ON TABLE public.kg_edges TO authenticated;
GRANT ALL ON TABLE public.kg_edges TO service_role;
GRANT ALL ON SEQUENCE public.kg_edges_id_seq TO anon;
GRANT ALL ON SEQUENCE public.kg_edges_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.kg_edges_id_seq TO service_role;

-- ─── هجرة البيانات (نسخ، لا نقل - الجداول المصدر تبقى كما هي) ───

INSERT INTO public.kg_edges (src_type, src_id, dst_type, dst_id, edge_type, source_reference, reviewed)
SELECT 'ayah', ah.ayah_id, 'hadith', ah.hadith_id, 'ayah_hadith', ah.relevance, false
FROM public.ayah_hadiths ah
WHERE ah.ayah_id IS NOT NULL AND ah.hadith_id IS NOT NULL;

INSERT INTO public.kg_edges (
  src_type, src_id, dst_type, dst_id, edge_type, source_reference,
  citation_text, citation_context, citation_book, citation_author,
  citation_url, citation_page, reviewed, reviewed_at
)
SELECT
  'ayah', vhr.ayah_id, 'citation', NULL,
  CASE vhr.citation_type
    WHEN 'authentic_hadith' THEN 'authentic_hadith_citation'
    ELSE 'israiliyyat_citation'
  END,
  vhr.source_reference, vhr.quoted_text, vhr.full_paragraph, vhr.source_book,
  vhr.source_author, vhr.shamela_url, vhr.shamela_page, vhr.reviewed, vhr.reviewed_at
FROM public.verse_hadith_relations vhr;
