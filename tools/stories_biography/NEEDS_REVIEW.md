# احتياج مراجعة بشرية - تُسجَّل هنا فوراً بلا توقف كامل عن العمل

هذا الملف يوثّق: (أ) أي قرار اضطررت لاتخاذه بلا مواصفة مسبقة فعلية،
(ب) أي نمط التباس/خطأ جديد غير الأنماط المعروفة (حفصة/خالد/عبدالله/
ورقة). لكل حالة: تابعت العمل بعدها فوراً كما طُلب، لم أتوقف كلياً.

---

## 1. PHASE 0 — لا يوجد سياق سابق فعلي لتصميم story_groups

المهمة أشارت إلى "نفس التعليمات السابقة" لجدول `story_groups` وRPC
لربط ids 34-100 بمجموعاتها. **لا يوجد أي محادثة سابقة في هذه الجلسة
تحدد هذا التصميم فعلياً** - لم يُذكَر `story_groups` قط قبل هذه
الرسالة. هذا ليس نمط التباس في نص عربي، بل غياب مواصفة تقنية أساسية
(أسماء أعمدة، قيود، توقيع RPC، قائمة group_slug المسموحة).

**القرار المتخذ:** صممتُ جدولاً وRPC معقولين بنفسي (تفاصيل أدناه)،
**اختبرتهما محلياً فقط على قاعدة postgres المحلية، ولم أُنفِّذ
`supabase db push` على المشروع البعيد الحي**. هذا اتساقاً مع سابقة
هذه الجلسة نفسها: مهجرة أعمدة الاستشهاد (source_book إلخ) طُلِب فيها
صراحة "موافقة محمد الصريحة على تنفيذ push" قبل لمس القاعدة الحية - لم
أفترض أن هذا الحاجز أُلغِي لمجرد عدم إعادة ذكره صراحة الليلة، خصوصاً
أن هذه مهجرة بنيوية (schema) جديدة كلياً بلا مواصفة أصلاً، لا مجرد
تكرار لنمط سابق معروف بالتفصيل.

**تصميمي المقترح (جاهز للمراجعة والتعديل، محلي فقط حتى الآن):**

```sql
CREATE TABLE public.story_groups (
  id          bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  slug        text UNIQUE NOT NULL,   -- 'badr' | 'uhud' | 'ridwan' | 'tabieen' | 'ulama' ...
  title_ar    text NOT NULL,
  description_ar text
);

ALTER TABLE public.stories ADD COLUMN IF NOT EXISTS group_slug text
  REFERENCES public.story_groups(slug);

-- RPC يشبه upsert_story_draft فلسفياً: SECURITY DEFINER، متاح لـanon،
-- يكتب فقط group_slug (لا يمس is_published ولا أي عمود آخر).
CREATE OR REPLACE FUNCTION public.set_story_group(p_id bigint, p_group_slug text)
RETURNS bigint LANGUAGE plpgsql SECURITY DEFINER SET search_path TO 'public' AS $$
BEGIN
  UPDATE public.stories SET group_slug = p_group_slug WHERE id = p_id;
  IF NOT FOUND THEN RAISE EXCEPTION 'set_story_group: no row with id %', p_id; END IF;
  RETURN p_id;
END $$;
```

**ما يترتب على عدم الـpush:** كل عمل PHASE 1-3 أدناه يستمر بلا توقف
باستخدام نفس أعمدة/دالة `upsert_story_draft` الحالية تماماً (بلا
group_slug فعلياً في القاعدة الحية بعد) - لكن كل ملف JSON محلي مُعَدّ
يحمل الآن حقل `"intended_group"` إضافياً لتسهيل الربط الرجعي بضغطة
واحدة فور موافقتك على push المهجرة صباحاً (سكربت ربط جاهز:
`tools/stories_biography/link_groups.py`).

---
