-- اقتراح فقط (المهمة 3 من دفعة المستوى 2) - غير مُطبَّق على القاعدة الحية.
-- لا db push حتى مراجعة صريحة من المالك.

-- دالة "public"."rls_auto_enable"() موجودة أصلاً منذ baseline.sql (ترجع
-- event_trigger وتُفعّل RLS تلقائياً على أي جدول جديد في public)، لكن لا
-- يوجد أي CREATE EVENT TRIGGER يربطها فعلياً بحدث DDL - فهي معطّلة تماماً
-- منذ إنشائها، وأي جدول جديد يُنشأ بعدها يبقى بلا RLS تلقائي (يعتمد فقط
-- على تذكّر الكاتب لسطر ENABLE ROW LEVEL SECURITY يدوياً في كل هجرة - وهو
-- بالضبط ما فشل سابقاً وأدى لثغرة RLS المذكورة في تعليق هجرة
-- translation_reports وenable_rls_missing_tables.sql).
CREATE EVENT TRIGGER "rls_auto_enable_trigger"
    ON "ddl_command_end"
    WHEN TAG IN ('CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO')
    EXECUTE FUNCTION "public"."rls_auto_enable"();
