-- اقتراح فقط (المهمة 2 من دفعة المستوى 2) - غير مُطبَّق على القاعدة الحية.
-- لا db push حتى مراجعة صريحة من المالك. الهدف: تقييد إساءة استخدام
-- translation_reports (جدول إدراج عام بلا تسجيل دخول - انظر
-- 20260715140615_add_translation_reports.sql) عبر حد أقصى لطول النص
-- وحد معدل بسيط لكل IP.

-- 1) حدود طول النص - كانت غائبة تماماً (نص بلا حد أقصى في جدول إدراج
-- عام يقبله أي زائر غير مصادَق).
ALTER TABLE "public"."translation_reports"
    ADD CONSTRAINT "translation_reports_issue_text_length"
    CHECK (char_length("reported_issue_text") <= 2000);

ALTER TABLE "public"."translation_reports"
    ADD CONSTRAINT "translation_reports_note_length"
    CHECK ("reporter_note" IS NULL OR char_length("reporter_note") <= 500);

-- 2) عمود IP المُبلِّغ - تُعبَّأ قسراً من التريغر أدناه، لا من العميل، كي
-- لا يستطيع عميل خبيث إرسال IP مزيّف مختلف في كل طلب لتفادي حد المعدل.
ALTER TABLE "public"."translation_reports"
    ADD COLUMN IF NOT EXISTS "reporter_ip" "inet";

CREATE INDEX IF NOT EXISTS "idx_translation_reports_ip_created"
    ON "public"."translation_reports" ("reporter_ip", "created_at");

-- 3) دالة + trigger لحد المعدل: 5 بلاغات كحد أقصى لكل IP خلال ساعة واحدة.
-- SECURITY DEFINER ضروري هنا: لا توجد سياسة SELECT لـanon على هذا الجدول
-- (عمداً - انظر تعليق الهجرة الأصلية)، فبدونها يُرجع استعلام العدّ صفراً
-- دائماً ويصبح حد المعدل بلا أثر فعلي.
-- يعتمد على ترويسة x-forwarded-for التي يضبطها PostgREST/Supabase تلقائياً
-- (current_setting('request.headers', true))، مع سقوط احتياطي لعنوان
-- اتصال Postgres المباشر (inet_client_addr) عند غياب الترويسة.
CREATE OR REPLACE FUNCTION "public"."translation_reports_rate_limit"() RETURNS "trigger"
    LANGUAGE "plpgsql" SECURITY DEFINER
    SET "search_path" TO 'public'
    AS $$
DECLARE
  client_ip inet;
  recent_count integer;
  max_reports_per_window CONSTANT integer := 5;
  window_interval CONSTANT interval := interval '1 hour';
  forwarded_for text;
BEGIN
  BEGIN
    forwarded_for := (current_setting('request.headers', true)::json ->> 'x-forwarded-for');
  EXCEPTION WHEN OTHERS THEN
    forwarded_for := NULL;
  END;

  IF forwarded_for IS NOT NULL AND forwarded_for <> '' THEN
    -- أول عنوان في السلسلة (الأقرب فعلياً للعميل عند تعدد الوكلاء)
    client_ip := split_part(forwarded_for, ',', 1)::inet;
  ELSE
    client_ip := inet_client_addr();
  END IF;

  -- تجاهل أي قيمة أرسلها العميل لهذا العمود قسراً
  NEW."reporter_ip" := client_ip;

  IF client_ip IS NOT NULL THEN
    SELECT count(*) INTO recent_count
    FROM "public"."translation_reports"
    WHERE "reporter_ip" = client_ip
      AND "created_at" > (now() - window_interval);

    IF recent_count >= max_reports_per_window THEN
      RAISE EXCEPTION 'تجاوزت الحد المسموح من بلاغات الترجمة (% خلال ساعة). حاول لاحقاً.', max_reports_per_window
        USING ERRCODE = 'P0001';
    END IF;
  END IF;

  RETURN NEW;
END;
$$;

ALTER FUNCTION "public"."translation_reports_rate_limit"() OWNER TO "postgres";

CREATE TRIGGER "translation_reports_rate_limit_trigger"
    BEFORE INSERT ON "public"."translation_reports"
    FOR EACH ROW
    EXECUTE FUNCTION "public"."translation_reports_rate_limit"();
