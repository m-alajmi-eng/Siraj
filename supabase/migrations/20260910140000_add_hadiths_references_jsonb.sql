-- عمود المراجع الحقيقية المستوردة من HadeethEnc.com (حقل citation ضمن
-- بيانات schema.org JSON-LD المضمَّنة بكل صفحة حديث على الموقع) - نسخ
-- حرفي كامل، لا تلخيص أو إعادة صياغة. لا علاقة لعمود explanation.
--
-- ⚠ "references" كلمة محجوزة بـPostgreSQL (تُستخدم بصياغة FOREIGN KEY) -
-- يجب اقتباسها بعلامتي تنصيص مزدوجتين "references" في كل استعلام SQL
-- يلمس هذا العمود، دائماً بلا استثناء (لن يعمل بلا اقتباس).
ALTER TABLE public.hadiths ADD COLUMN IF NOT EXISTS "references" jsonb;

COMMENT ON COLUMN public.hadiths."references" IS
  'قائمة المراجع الحرفية من حقل citation بصفحة HadeethEnc.com الأصلية لكل حديث (id يطابق مباشرة hadeethenc.com/ar/browse/hadith/[id]) - مصفوفة JSON، كل عنصر نسخ حرفي كامل بلا تلخيص. NULL لأي حديث ليس مصدره HadeethEnc.com.';
