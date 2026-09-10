-- عمود تتبّع هوية المراجع البشري لجدول kg_edges - يوثّق مَن راجع/نشر
-- كل رابط (سجل تدقيق بسيط، لا يغيّر سلوك RLS القائم على reviewed).
ALTER TABLE public.kg_edges ADD COLUMN IF NOT EXISTS reviewed_by text;

COMMENT ON COLUMN public.kg_edges.reviewed_by IS
  'اسم المراجع البشري الذي حوّل reviewed إلى true - لا يُملأ آلياً أبداً، فقط عبر تدخل بشري صريح';
