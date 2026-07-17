# ملخص مقارنة الترجمات المرجعية

> ⚠️ **تنويه إلزامي قبل قراءة أي شيء أدناه**
>
> هذا تقرير **مقارنة آلية نصّية** (text-similarity heuristic عبر
> تشابه Jaccard على الكلمات) بين ترجمة سراج المحلية ومرجع مستقل من Quran.com. **هذا
> ليس مراجعة دلالية أو شرعية**، ولا ادّعاءً بأن أي ذكاء اصطناعي "فهم"
> معنى الآيات أو راجعها كناطق أصلي أو كمتخصص. الأداة تقيس فقط تشابه
> النص السطحي، والآيات المُبرزة أدناه هي **أدنى 1% تشابهاً إحصائياً
> ضمن هذه اللغة فقط** - أي أنها مرشحة للمراجعة البشرية، لا أخطاء
> مؤكَّدة. اختلاف الأسلوب بين مترجمَين مستقلَّين لنفس الآية أمر طبيعي
> ومتوقَّع تماماً ولا يعني خطأً بحد ذاته. **لا يُتخذ أي قرار نهائي بشأن
> صحة أي ترجمة إلا بمراجعة بشرية مختصة فعلية.**
>
> **ملاحظة منهجية مهمة عن "نسبة الطول الشاذة":** هذا المؤشر يقيس عدد
> الكلمات (بالفراغات) لا المعنى، وهو **غير موثوق إحصائياً للغات
> الإلصاقية/التركيبية الغنية** (كالتركية والروسية والسواحيلية، وينعدم
> معناه كلياً للصينية التي لا تفصل كلماتها بفراغات أصلاً) - كلمة واحدة
> في هذه اللغات قد تقابل جملة كاملة بلغة أخرى بنيوياً، فتُبرَز أعداد
> كبيرة زائفة. اعتبر هذا القسم مؤشراً ضعيفاً لهذه اللغات تحديداً، لا
> إشارة خطأ حقيقية.


## طريقة العمل
1. لكل لغة، اختير مترجم **مستقل** عن مترجم سراج الحالي من Quran.com (انظر `tools/translation_review/reference_editions.json`).
2. جُلبت ترجمة كل سورة كاملة عبر Quran.com API (114 سورة × كل لغة).
3. حُسب تشابه محتوى (تداخل مجموعة الكلمات - Jaccard) بين نص سراج والنص المرجعي لكل آية بعد تنظيف بسيط (إزالة HTML/ترقيم، توحيد الحالة).
4. أُبرزت أدنى 1% تشابهاً ضمن كل لغة على حدة كمرشحة للمراجعة البشرية.

## جدول اللغات

| اللغة | مترجم سراج | المرجع المستقل | مستقل فعلاً؟ | آيات مقارَنة | متوسط تشابه | مُبرَزة |
|---|---|---|---|---|---|---|
| en | alquran.cloud en.sahih (Saheeh International) | A. Yusuf Ali | ✅ | 6236 | 0.406 | 62 |
| ur | alquran.cloud ur.jalandhry (Fatah Muhammad Jalandhari) | Maulana Wahiduddin Khan | ✅ | 6236 | 0.387 | 62 |
| fa | alquran.cloud fa.makarem (Makarem Shirazi) | IslamHouse.com | ✅ | 6236 | 0.388 | 62 |
| id | alquran.cloud id.indonesian (Indonesian Ministry of Religious Affairs) | King Fahad Quran Complex | ⚠️ تشابه مرتفع جداً | 6236 | 0.898 | 62 |
| tr | alquran.cloud tr.diyanet (Diyanet Isleri) | Elmalili Hamdi Yazir | ✅ | 6236 | 0.288 | 195 |
| fr | alquran.cloud fr.hamidullah (Muhammad Hamidullah) | Montada Islamic Foundation | ✅ | 6236 | 0.441 | 66 |
| bn | alquran.cloud bn.bengali | Dr. Abu Bakr Muhammad Zakaria | ✅ | 6236 | 0.502 | 64 |
| ha | alquran.cloud ha.gumi (Abubakar Mahmoud Gumi) | Abubakar Mahmood Jummi | ⚠️ لا | 6236 | 0.978 | 65 |
| sw | alquran.cloud sw.barwani (Ali Muhsin Al-Barwani) | Dr. Abdullah Muhammad Abu Bakr and Sheikh Nasir Khamis | ✅ | 6236 | 0.176 | 167 |
| de | alquran.cloud de.bubenheim (Frank Bubenheim and Nadeem Elyas) | Abu Reda Muhammad ibn Ahmad | ✅ | 6236 | 0.445 | 63 |
| ru | alquran.cloud ru.kuliev (Elmir Kuliev) | Abu Adel | ✅ | 6236 | 0.308 | 62 |
| zh | alquran.cloud zh.jian (Ma Jian) | Muhammad Makin | ✅ | 6236 | 0.717 | 295 |
| es | alquran.cloud es.garcia (Sheikh Isa Garcia) | Noor International Center | ✅ | 6236 | 0.342 | 62 |

## لغات مستبعدة من المقارنة
- **ms**: Quran.com لا يوفر إلا مترجماً واحداً للملايوية (Basmeih)، وهو نفس مترجم سراج بالضبط. لا يوجد مصدر مستقل بديل متاح عبر هذا الـAPI - المقارنة هنا ستكون بلا معنى (نفس النص أساساً)، لذا استُبعدت لغة الملايو من هذه المقارنة صراحة (انظر تقريرها لملاحظة الاستبعاد بدل تقرير مزيّف)

## التقارير التفصيلية
- [en.md](./en.md)
- [ur.md](./ur.md)
- [fa.md](./fa.md)
- [id.md](./id.md)
- [tr.md](./tr.md)
- [fr.md](./fr.md)
- [bn.md](./bn.md)
- [ha.md](./ha.md)
- [sw.md](./sw.md)
- [de.md](./de.md)
- [ru.md](./ru.md)
- [zh.md](./zh.md)
- [es.md](./es.md)
