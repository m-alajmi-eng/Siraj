-- تعليقات توثيقية على الجداول الرئيسية (تغيير آمن تماماً، لا يمس البيانات)
-- أول هجرة حقيقية بعد الـbaseline - إثبات عمل الأنبوب

COMMENT ON TABLE public.verse_hadith_relations IS
  'استشهادات حديث/إسرائيليات مستخرجة من كتاب أضواء البيان للشنقيطي، مربوطة بالآيات. reviewed=false افتراضياً حتى المراجعة اليدوية.';

COMMENT ON TABLE public.adwaa_al_bayan_pages IS
  'نص كامل لكل صفحات كتاب أضواء البيان (4343 صفحة)، مصدر داخلي للقراءة بدل الاعتماد على رابط خارجي.';

COMMENT ON TABLE public.adwaa_al_bayan_toc IS
  'فهرس آية-صفحة لكتاب أضواء البيان (1359 آية مفهرَسة)، يُستخدم لحساب نطاق التفسير الكامل لكل آية.';

COMMENT ON FUNCTION public.delete_user() IS
  'حذف حساب المستخدم الحالي فقط (SECURITY DEFINER + auth.uid()) - يفي بمتطلبات حذف الحساب لمتاجر التطبيقات.';
