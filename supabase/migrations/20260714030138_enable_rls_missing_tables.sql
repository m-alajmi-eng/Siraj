-- إصلاح أمني P0: ثلاثة جداول من الـbaseline كانت بلا RLS مفعّل
-- (سبقت تركيب event trigger "ensure_rls" الذي يُفعّل RLS تلقائياً على أي
-- جدول جديد، فلم يشملها بأثر رجعي). تحقّقنا عبر
-- `supabase db advisors --type security` و`pg_class.relrowsecurity` أن
-- مفتاح anon كان يملك DELETE/INSERT/UPDATE/TRUNCATE فعلياً على الجداول
-- الثلاثة دون أي قيد RLS. النمط أدناه مطابق تماماً للسياسة المستخدمة على
-- بقية جداول المحتوى (قراءة عامة فقط عبر SELECT، لا سياسات كتابة).

ALTER TABLE "public"."surahs" ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read access" ON "public"."surahs" FOR SELECT USING (true);

ALTER TABLE "public"."tafsir_sources" ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read access" ON "public"."tafsir_sources" FOR SELECT USING (true);

ALTER TABLE "public"."hadith_books" ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public read access" ON "public"."hadith_books" FOR SELECT USING (true);
