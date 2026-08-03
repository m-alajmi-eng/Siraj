#!/usr/bin/env python3
"""يفصّل نص صفحة "باب" متعددة التراجم من أسد الغابة (أو صفحات مشابهة) إلى
تراجم مفردة، ويطبع الترجمة التي يحويها أولها نص بحث معيّن.

**تحذير مهم (اكتُشف أثناء دفعة أمهات المؤمنين 2026-08-04):** ترويسات
التراجم في هذا الكتاب تأتي بصيغتين مختلفتين على الأقل:
  1. (حروف رمز المصادر * الاسم)   مثل (ب د ع * عمر)
  2. (الاسم) * تكملة النسب        مثل (حفصة) * بنت عمر بن الخطاب
النمط الأول شائع في صفحات الرجال، لكن الصيغة الثانية شائعة أيضاً في
"كتاب النساء"/"الكنى من النساء الصحابيات". أي نمط (regex) يتعرف على
الصيغة الأولى فقط سيدمج نهاية الترجمة المطلوبة مع بداية التالية بصمت -
هذا بالضبط ما حدث مع "حفصة" (استُخرج شخص آخر تماماً) و"سودة"/"صفية"/
"زينب بنت خزيمة" (امتداد النص للترجمة التالية) قبل التصحيح. استخدم دائماً
split_entries() من هذا الملف، لا نمطاً مخصصاً مكتوباً على عجل.

**تحقق إلزامي بعد أي استخراج:** كل ترجمة يجب أن:
  - تبدأ بتفاصيل نسب/هوية الشخص المطلوب تحديداً (وليس شخص آخر بنفس الاسم
    الأول - أسماء متكررة جداً في هذا الكتاب).
  - تنتهي بعبارة ختم قياسية واحدة فقط ("أخرجه.../أخرجها الثلاثة" أو
    مشابه) - وجود أكثر من عبارة ختم حقيقية علامة تلوث بترجمة مجاورة.
"""

from __future__ import annotations

import re
import sys

ENTRY_PATTERN = re.compile(
    r'\([^\(\)]{1,15}\*[^\(\)]{1,60}\)'   # (ب د ع * اسم)
    r'|'
    r'\([^\(\)]{1,30}\)\s*\*'              # (اسم) * تكملة
)


def split_entries(text: str) -> list[tuple[str, str]]:
    """يرجع قائمة (نص_الترويسة, نص_الترجمة_كاملاً) بترتيب ظهورها."""
    matches = list(ENTRY_PATTERN.finditer(text))
    entries = []
    for i, m in enumerate(matches):
        start = m.start()
        end = matches[i + 1].start() if i + 1 < len(matches) else len(text)
        entries.append((m.group(), text[start:end].strip()))
    return entries


def entry_containing(text: str, needle: str, window: int = 200) -> str:
    """يرجع الترجمة الوحيدة التي يحوي أول `window` حرفاً منها `needle`.
    يرفع ValueError إن كان العدد صفراً أو أكثر من واحد - تعمّداً، لمنع
    اعتماد صامت على مطابقة غامضة."""
    matches = [b for _, b in split_entries(text) if needle in b[:window]]
    if len(matches) != 1:
        raise ValueError(f"expected exactly 1 match for {needle!r}, got {len(matches)}")
    return matches[0]


def main() -> None:
    if len(sys.argv) < 3:
        raise SystemExit("الاستخدام: split_entries.py <ملف_نص> <نص_بحث>")
    path, needle = sys.argv[1], sys.argv[2]
    with open(path, encoding="utf-8") as f:
        text = f.read()
    print(entry_containing(text, needle))


if __name__ == "__main__":
    main()
