-- حالة مراجعة المجتمع لكل لغة ترجمة. ملاحظة معمارية مهمة: لا يوجد جدول
-- "ترجمات" في Supabase أصلاً - ترجمات القرآن الـ14 محلية بالكامل
-- (assets/data/quran_translations.json، ADR-006 عدم اعتماد على الشبكة).
-- لذا بدل عمود على جدول غير موجود، أُنشئ هذا الجدول الصغير المستقل:
-- صف واحد لكل رمز لغة، يُقرأ من التطبيق لعرض شارة "بانتظار مراجعة
-- المجتمع" - ويسمح بتحديث حالة المراجعة لاحقاً دون إصدار تطبيق جديد.

CREATE TABLE IF NOT EXISTS "public"."translation_review_status" (
    "language_code" "text" PRIMARY KEY,
    "reviewed_by_community" boolean DEFAULT false NOT NULL,
    "reviewed_at" timestamp with time zone,
    "reviewed_by" "text",
    "updated_at" timestamp with time zone DEFAULT "now"() NOT NULL
);

ALTER TABLE "public"."translation_review_status" OWNER TO "postgres";

ALTER TABLE "public"."translation_review_status" ENABLE ROW LEVEL SECURITY;

-- قراءة عامة فقط (نفس نمط جداول المحتوى الأخرى) - لا كتابة من anon؛
-- تحديث حالة المراجعة قرار بشري يتم عبر لوحة تحكم Supabase مباشرة.
CREATE POLICY "Public read access" ON "public"."translation_review_status"
    FOR SELECT USING (true);

-- بذر الصفوف الـ14 كلها بالحالة الصادقة الحالية: لا شيء رُوجِع من
-- مجتمع بعد. هذا ليس افتراضاً تقنياً فقط بل انعكاساً لواقع فعلي موثَّق
-- في 03_MASTER_CHECKLIST.md (قسم ح): "14 ترجمة كاملة عدّاً؛ مراجعة
-- عينات بشرية لكل لغة لم تتم بعد".
INSERT INTO "public"."translation_review_status" ("language_code", "reviewed_by_community")
VALUES
    ('en', false), ('ur', false), ('fa', false), ('id', false),
    ('tr', false), ('fr', false), ('bn', false), ('ms', false),
    ('ha', false), ('sw', false), ('de', false), ('ru', false),
    ('zh', false), ('es', false)
ON CONFLICT ("language_code") DO NOTHING;
