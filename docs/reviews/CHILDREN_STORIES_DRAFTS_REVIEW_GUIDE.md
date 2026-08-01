# دليل مراجعة قصص الأطفال (children_stories_drafts)

> دليل تشغيلي للمالك فقط - كل الاستعلامات هنا تُنفَّذ من **SQL Editor في
> لوحة تحكم Supabase** (يعمل بصلاحيات postgres، يتجاوز RLS تلقائياً) أو
> اتصال psql مباشر بمفتاح service_role. **لا تُنفَّذ عبر أي مسار عميل**
> (anon/authenticated) - RLS على الجدول (`reviewed = true`) يحجب هذه
> الصفوف عمداً عن أي عميل عادي طالما لم تُراجَع، وهذا الدليل يفترض دوماً
> اتصالاً بصلاحيات المالك الكاملة.

## لماذا لا تكفي upsert_draft_story وحدها

`children_stories_drafts` لها قيد `UNIQUE (source_author_id, source_item_id)`.
كل التسع قصص المُهاجَرة من الجدول القديم لها `source_author_id = NULL`
و`source_item_id = NULL` (لا مصدر IslamHouse حقيقي لها - انظر المهجرة
`20260801044536`). في PostgreSQL، `NULL` لا يساوي `NULL` أبداً في فحص
قيود `UNIQUE`، لذا `ON CONFLICT (source_author_id, source_item_id)` في
`upsert_draft_story` **لا يتطابق أبداً** مع صفَّين لهما `NULL, NULL` معاً
- كل استدعاء لهذه الدالة بمصدر `NULL, NULL` يُدرِج صفاً **جديداً** دوماً،
ولا يقدر أبداً أن يُحدِّث صفاً موجوداً بلا مصدر حقيقي.

لذلك: **الإدخال** الجديد يمر عبر `upsert_draft_story` كالمعتاد، أما
**التعديل** على صفّ موجود (وبالتحديد: كتابة نص التسع قصص المُهاجَرة) فيتم
حصراً بتحديث مباشر عبر `id` الصف الحقيقي - لا RPC جديدة لهذا الغرض عمداً،
لتفادي توسيع سطح أي دالة SECURITY DEFINER مكشوفة للعميل بمنطق تعديل لا
يحتاجه أي مستخدم غير المالك.

## 1) عرض قائمة القصص التسع بمعرّفاتها (id)

```sql
SELECT
  id,
  legacy_category,
  legacy_emoji,
  legacy_order_index,
  localized #>> ARRAY['ar', 'title']            AS title_ar,
  localized #>> ARRAY['ar', 'simplified_text']   AS simplified_text_ar,
  legacy_moral,
  reviewed
FROM public.children_stories_drafts
ORDER BY legacy_order_index NULLS LAST, id;
```

هذا يُرجع التسع صفوف كاملة (بصرف النظر عن `reviewed`، لأن الاستعلام هنا
بصلاحيات postgres/service_role لا anon). عمود `id` هو المعرّف المطلوب
للخطوتين التاليتين. `simplified_text_ar` سيكون `NULL` لكل التسعة حالياً -
هذا هو الفراغ المطلوب ملؤه.

## 2) إدخال قصة جديدة بالكامل (بلا مصدر IslamHouse)

عبر `upsert_draft_story` كالمعتاد - `NULL, NULL` صراحةً لأنها لا تأتي من
حصاد آلي:

```sql
SELECT public.upsert_draft_story(
  NULL,               -- p_source_author_id
  NULL,               -- p_source_item_id
  'ar',               -- p_original_language
  $title$عنوان القصة الجديدة$title$,
  $text$النص المبسَّط الكامل هنا...$text$,
  5                    -- p_reading_time_minutes (اختياري)
);
```

كل استدعاء بهذا الشكل يُدرِج صفاً جديداً (لا يُحدِّث أي صف قائم - انظر
السبب أعلاه). للتحقق من نجاح الإدراج، أعد تشغيل استعلام القسم (1).

## 3) تعديل نص قصة موجودة (بـid الحقيقي)

استبدل `<ID>` بالمعرّف الحقيقي من القسم (1)، والنص بين علامات `$text$`
بالنص المبسَّط الفعلي. `jsonb_set` هنا يستهدف تحديداً المفتاح
`ar.simplified_text` داخل `localized` بلا المساس بأي مفتاح آخر (title/
reading_time_minutes تبقيان كما هما ما لم تُحدَّثا صراحة أيضاً):

```sql
UPDATE public.children_stories_drafts
SET localized = jsonb_set(
      localized,
      ARRAY['ar', 'simplified_text'],
      to_jsonb($text$النص المبسَّط الفعلي الكامل هنا...$text$::text),
      true
    ),
    updated_at = now()
WHERE id = <ID>;
```

لتحديث العنوان أو زمن القراءة معاً في نفس الاستعلام، كرّر `jsonb_set`
متداخلاً لكل مفتاح إضافي:

```sql
UPDATE public.children_stories_drafts
SET localized = jsonb_set(
      jsonb_set(
        localized,
        ARRAY['ar', 'simplified_text'],
        to_jsonb($text$النص المبسَّط الفعلي الكامل هنا...$text$::text),
        true
      ),
      ARRAY['ar', 'reading_time_minutes'],
      to_jsonb(5),
      true
    ),
    updated_at = now()
WHERE id = <ID>;
```

## 4) تعيين reviewed = true بعد الرضا عن القصة

هذه الخطوة الوحيدة التي تنشر القصة فعلياً للعموم (السياسة
`FOR SELECT USING (reviewed = true)`). لا تُنفَّذ إلا بعد قراءة النص
الكامل فعلياً والتأكد من سلامته وملاءمته:

```sql
UPDATE public.children_stories_drafts
SET reviewed    = true,
    reviewed_by = 'اسم المالك أو معرّفه',
    reviewed_at = now()
WHERE id = <ID>;
```

## تذكير أمني

- كل استعلامات هذا الدليل تفترض اتصالاً بصلاحيات postgres/service_role
  (SQL Editor في Supabase أو psql بمفتاح الخدمة). **لا تُبنَ أبداً** في
  أي كود عميل (Flutter) أو RPC مكشوفة لـanon/authenticated.
- لا مسار آلي في هذا التطبيق يقدر يكتب `reviewed = true` - فقط القسم (4)
  أعلاه يدوياً. `upsert_draft_story` والتحديثات في القسم (3) لا تذكران
  عمود `reviewed` إطلاقاً، فيبقى `false` كما هو حتى تحديث القسم (4)
  الصريح.
