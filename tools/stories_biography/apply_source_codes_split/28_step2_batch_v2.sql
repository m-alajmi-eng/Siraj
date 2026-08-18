-- الخطوة 2 (v2: LIKE بالبداية + معاملة مستقلة لكل صف) - دفعة 28/31 (13 صفوف)

-- id=205  ثعلبة بن غنمة (عنمة)
SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 205;

BEGIN;

UPDATE public.stories
SET source_codes = 'ب د ع',
    content_ar = 'ثعلبة بن غنمة بن عدي بن نابي بن عمرو بن سواد بن غنم بن كعب بن سلمة الأنصاري الخزرجي السلمي شهد العقبة في البيعتين وشهد بدرا وهو أحد الذين كسروا آلهة بني سلمة قتل يوم الخندق شهيدا قاله ابن إسحاق قتله هبيرة بن أبي وهب المخزومي وقال عروة بن الزبير إنه قتل يوم خيبر والذين كسروا الأصنام معاذ بن جبل وعبد الله بن أنيس وثعلبة بن غنمة وروى أبو صالح عن ابن عباس في قوله تعالى يسألونك عن الأهلة قال نزلت في معاذ ابن جبل وثعلبة بن غنمة وهما من الأنصار قالا يا رسول الله ما بال الهلال يبدو فيطلع رقيقا ثم يزيد حتى يعظم ويستوي ويستدير ثم لا يزال ينقص حتى يعود كما كان فنزلت الآية أخرجه الثلاثة'
WHERE id = 205
  AND content_ar LIKE '(ب د ع) ثعلبة بن غنم%'
  AND source_codes IS NULL;

COMMIT;

SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 205;

-- id=206  نوفل بن ثعلبة
SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 206;

BEGIN;

UPDATE public.stories
SET source_codes = 'ب',
    content_ar = 'نوفل بن ثعلبة بن عبد الله بن نضلة بن مالك بن العجلان بن زيد بن غنم بن سالم بن عوف بن الخزرج الأنصاري الخزرجي ثم من بني سالم بن عوف شهد بدرا أخبرنا عبيد الله بن أحمد بإسناده عن يونس عن ابن إسحاق في تسمية من شهد بدرا من بني سالم بن عوف ثم من بني العجلان نوفل بن

عبد الله رجل كذا قال ابن إسحاق نوفل بن عبد الله ولم يذكر ثعلبة ومثل يونس رواه البكائي وسلمة عن ابن إسحاق وشهد أحدا وقتل بها وبهذا الإسناد عن ابن إسحاق فيمن قتل يوم أحد من بني عوف بن الخزرج ثم من بني سالم نوفل بن عبد الله بن نضلة مثل ابن إسحاق وأما النسب الأول فذكره أبو عمر'
WHERE id = 206
  AND content_ar LIKE '(ب) نوفل بن ثعلبة بن%'
  AND source_codes IS NULL;

COMMIT;

SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 206;

-- id=207  عقبة بن عثمان
SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 207;

BEGIN;

UPDATE public.stories
SET source_codes = 'ب س',
    content_ar = 'عقبة بن عثمان بن خلدة بن مخلد بن عامر بن زريق الأنصاري الزرقي شهد بدرا هو وأخوه سعد بن عثمان أخبرنا أبو جعفر بن السمين بإسناده إلى يونس بن بكير عن ابن إسحاق في تسمية من شهد بدرا قال ومن بني زريق بن عامر ثم من بني مخلد ابن عامر بن زريق وأبو عبادة وهو سعد بن عثمان بن خلدة بن مخلد وأخوه عقبة ابن عثمان قال ابن إسحاق وفر يعني يوم أحد عقبة بن عثمان وسعد بن عثمان رجلان من الأنصار حتى بلغوا جبلا مقابل الأعوص فأقاما به ثلاثا ثم رجعا إلى رسول الله صلى الله عليه وسلم فذكروا أن رسول الله صلى الله عليه وسلم قال لقد ذهبتم فيها عريضة أخرجه أبو عمر وأبو موسى'
WHERE id = 207
  AND content_ar LIKE '(ب س) عقبة بن عثمان %'
  AND source_codes IS NULL;

COMMIT;

SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 207;

-- id=208  حريث بن زيد
SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 208;

BEGIN;

UPDATE public.stories
SET source_codes = 'ع ب س',
    content_ar = 'حريث ابن زيد بن عبد ربه بن ثعلبة بن زيد من بني جشم بن الحارث بن الخزرج شهد بدرا مع أخيه عبد الله بن زيد الذي أري الأذان وشهد أيضا أحدا في قول جميعهم كذا نسبه أبو عمر ونسبه أبو نعيم وأبو موسى فقالا حريث بن زيد بن ثعلبة بن عبد ربه ابن زيد بن الحارث بن الخزرج الخزرجي قلت والحق معهما فإنه ليس من بني جشم ابن الحارث بن الخزرج وإنما هو من بني زيد بن الحارث وكذلك نسبه ابن إسحاق أيضا فقال حريث بن زيد بن ثعلبة بن عبد ربه بن زيد ووافقه على هذا النسب هشام ابن الكلبي والله أعلم أخرجه أبو نعيم وأبو عمر وأبو موسى'
WHERE id = 208
  AND content_ar LIKE '(ع ب س) حريث ابن زيد%'
  AND source_codes IS NULL;

COMMIT;

SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 208;

-- id=209  أسير بن عمرو، أبو سليط
SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 209;

BEGIN;

UPDATE public.stories
SET source_codes = 'ب د ع',
    content_ar = 'أسير بالضم والراء أيضا هو أسير بن عمرو بن قيس بن مالك ابن عدي بن عامر بن غنم بن عدي بن النجار بن ثعلبة بن عمرو بن الخزرج يكنى أبا سليط بن أبي خارجة الأنصاري الخزرجي النجاري من بني عدي بن النجار شهد بدرا روى عنه ابنه عبد الله أن النبي صلى الله عليه وسلم نهى عن أكل لحوم الحمر الأهلية بخيبر والقدور تفور بها فأكفأناها وقيل فيه أسيرة بالهاء في آخره ذكره ابن ماكولا وأبو عمر وقد ذكره محمد بن إسحاق من رواية سلمة أسيرة وذكره من رواية يونس أنس ونذكره في أنس إن شاء الله تعالى أخرجه ثلاثتهم ويذكر في الكنى إن شاء الله تعالى'
WHERE id = 209
  AND content_ar LIKE '(ب د ع) أسير بالضم و%'
  AND source_codes IS NULL;

COMMIT;

SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 209;

-- id=210  الحصين بن الحارث بن المطلب
SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 210;

BEGIN;

UPDATE public.stories
SET source_codes = 'ب د ع س',
    content_ar = 'حصين بن الحارث ابن المطلب بن عبد مناف بن قصي أخو عبيدة والطفيل شهد بدرا هو وأخواه فقتل عبيدة بها شهيدا قاله ابن إسحاق وقال عبيد الله بن أبي رافع شهد الحصين مع علي بن أبي طالب رضي الله عنه مشاهده وقد أخرجه أبو موسى على ابن منده فقال حصين ابن الحارث ذكر أبو الوفاء البغدادي عن ابن عباس في قوله تبارك وتعالى فمن كان يرجو لقاء ربه قال نزلت في علي وحمزة وجعفر وعبيدة والطفيل والحصين بني الحارث أخرجه الثلاثة وأبو موسى قلت لا وجه لاستدراك أبي موسى على ابن منده فإن ابن منده قد أخرجه كما ذكرناه والله أعلم'
WHERE id = 210
  AND content_ar LIKE '(ب د ع س) حصين بن ال%'
  AND source_codes IS NULL;

COMMIT;

SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 210;

-- id=211  خارجة بن الحمير الأشجعي
SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 211;

BEGIN;

UPDATE public.stories
SET source_codes = 'ب س',
    content_ar = 'خارجة بن حمير الأشجعي من بني دهمان حليف لبني خنساء بن سنان من الأنصار شهد بدرا هو وأخوه عبد الله بن حمير كذا قال ابن إسحاق خارجة من رواية إبراهيم بن سعد عنه وقال موسى بن عقبة جارية بن الحمير ولم يختلفوا أنه من أشجع وأنه شهد بدرا وقال يونس بن بكير عوض حمير خمير بالخاء المعجمة هذا قول أبي عمر وأخرجه أبو موسى فقال عن عبدان هو حليف لبني عبيد بن عدي بن عمير بن كعب بن سلمة بن سعد وقال شهد بدرا وقال ابن أبي حاتم الجميز بالجيم والزاي قال ويقال حمزة بن الجميز أخرجه أبو عمر وأبو موسى'
WHERE id = 211
  AND content_ar LIKE '(ب س) خارجة بن حمير %'
  AND source_codes IS NULL;

COMMIT;

SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 211;

-- id=212  أنس بن معاذ
SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 212;

BEGIN;

UPDATE public.stories
SET source_codes = 'ب د ع',
    content_ar = 'أنس بن معاذ بن أنس بن قيس بن عبيد بن زيد بن معاوية بن عمرو بن مالك بن النجار بن ثعلبة بن عمرو بن الخزرج الأنصاري الخزرجي النجاري شهد بدرا مع رسول الله صلى الله عليه وسلم واختلف

في اسمه فقيل أنس وقيل أنيس وقال ابن إسحاق اسمه أنس بن معاذ وقال الواقدي أنس بن معاذ ونسبه كما ذكرناه وقال شهد بدرا وأحدا والخندق ومات في خلافة عثمان هذا كلام أبي عمر وروى ابن منده وأبو نعيم بإسنادهما عن الزهري قال وأنس بن معاذ بن أنس من بني عمرو بن مالك بن النجار لا عقب له شهد بدرا أخرجه الثلاثة'
WHERE id = 212
  AND content_ar LIKE '(ب د ع) أنس بن معاذ %'
  AND source_codes IS NULL;

COMMIT;

SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 212;

-- id=213  بجير بن أبي بجير
SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 213;

BEGIN;

UPDATE public.stories
SET source_codes = 'ب د ع',
    content_ar = 'بجير ابن أبي بجير العبسي من بني عبس بن بغيض بن ريث بن غطفان وقيل بل هو من جهينة حليف لبني دينار بن النجار شهد بدرا وأحدا وبنو دينار بن النجار يقولون هو مولانا قاله أبو عمر وقال ابن منده وأبو نعيم قال الزهري إنه شهد بدرا * بجير بضم الباء وفتح الجيم أيضا
(بجير) مثله هو الثقفي قال ابن ماكولا له صحبة ورواية عن النبي صلى الله عليه وسلم روت عنه حفصة بنت سيرين وقال رواه أبو بكر الشافعي فقال بجير ورواه الإسماعيلي فقال بشير بالفتح وقيل بشير بالضم'
WHERE id = 213
  AND content_ar LIKE '(ب د ع) بجير ابن أبي%'
  AND source_codes IS NULL;

COMMIT;

SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 213;

-- id=214  وديعة بن عمرو الجهني
SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 214;

BEGIN;

UPDATE public.stories
SET source_codes = 'ب س',
    content_ar = 'وديعة بن عمرو بن جراد بن يربوع الجهني كذا قال أبو عمر وقال ابن الكلبي وديعة بن عمرو بن يسار بن عوف بن جراد بن يربوع بن طحيل بن عدي بن الربعة بن رشدان بن قيس بن جهينة حليف لبني سواد بن مالك ابن غنم بن مالك بن النجار شهد بدرا قاله موسى وابن إسحاق أخبرنا أبو جعفر بإسناده عن يونس عن ابن إسحاق في تسمية من شهد بدرا وديعة بن عمرو الجهني وروى أيضا عن ابن إسحاق أنه من أشجع والأول أصح أخرجه أبو عمر وأبو موسى'
WHERE id = 214
  AND content_ar LIKE '(ب س) وديعة بن عمرو %'
  AND source_codes IS NULL;

COMMIT;

SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 214;

-- id=216  النعمان بن عبد عمرو
SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 216;

BEGIN;

UPDATE public.stories
SET source_codes = 'ب د ع',
    content_ar = 'النعمان بن عبد عمرو بن مسعود بن عبد الأشهل بن حارثة بن دينار بن 
النجار الأنصاري الخزرجي شهد بدرا مع أخيه الضحاك بن عبد عمر وأخبرنا أبو جعفر بإسناده عن يونس عن ابن إسحاق في تسمية من شهد بدرا من بني دينار بن النجار ثم من بني مسعود بن عبد الأشهل النعمان بن عبد عمر وبن مسعود وأخوه الضحاك بن عبد عمرو وشهد النعمان أيضا أحدا وقتل ذلك اليوم شهيدا قاله يونس عن ابن إسحاق بهذا الإسناد ولا عقب له ولا لأخيه الضحاك أخرجه الثلاثة'
WHERE id = 216
  AND content_ar LIKE '(ب د ع) النعمان بن ع%'
  AND source_codes IS NULL;

COMMIT;

SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 216;

-- id=217  عبد الرحمن بن جبر، أبو عبس الأنصاري
SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 217;

BEGIN;

UPDATE public.stories
SET source_codes = 'ب س',
    content_ar = 'أبو عبس بن جبر وقيل ابن جابر بن عمرو بن زيد بن جشم بن مجدعة بن حارثة بن الحارث بن الخزرج بن عمرو بن مالك بن الأوس كذا نسبه أبو عمر ونسبه ابن الكلبي مثله إلا أنه أسقط مجدعة وقال جشم بن حارثة الأنصاري الأوسي الحارثي اسمه عبد الرحمن شهد بدرا والمشاهد كلها أخبرنا أبو جعفر بإسناده عن يونس عن ابن إسحاق في تسمية من شهد بدرا من بني الحارث بن الخزرج بن عمرو بن مالك بن الأوس وأبو عبس بن جبر بن عمرو وهو ممن قتل كعب بن الأشرف وبهذا الإسناد عن محمد ابن إسحاق قال فاجتمع في قتل كعب بن الأشرف محمد بن مسلمة وسلكان بن سلام أبو نائلة وعباد بن بشر وأبو عبس بن جبر أحد بني حارثة وذكر الحديث وهو معدود في كبار الصحابة أخبرنا يحيى بن محمود إجازة بإسناده إلى ابن أبي عاصم حدثنا عبد الوهاب بن بجدة أخبرنا الوليد بن مسلم أخبرنا يزيد بن أبي مريم قال أدركني عباية بن رفاعة بن رافع بن خديج وأنا أمشي إلى الجمعة فقال

سمعت أبا عبس بن جبر يقول سمعت رسول الله صلى الله عليه وسلم يقول من اغبرت قدماه في سبيل الله حرمهما الله على النار ومات سنة أربع وثلاثين وهو ابن سبعين سنة وصلى عليه عثمان ودفن بالبقيع ونزل في قبره أبو بردة بن نيار وقتادة بن النعمان ومحمد بن مسلمة وسلمة بن سلامة بن وقش وقيل إنه كان يكتب بالعربية قبل الإسلام أخرجه أبو عمر وأبو موسى وقال أبو موسى اسمه عبد الرحمن وقد ذكرناه في عبد الرحمن'
WHERE id = 217
  AND content_ar LIKE '(ب س) أبو عبس بن جبر%'
  AND source_codes IS NULL;

COMMIT;

SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 217;

-- id=218  سواد بن غزية الأنصاري
SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 218;

BEGIN;

UPDATE public.stories
SET source_codes = 'ب',
    content_ar = 'سواد بن غزية الأنصاري من بني عدي بن النجار وقيل هو حليف لهم من بلي بن عمرو بن الحاف بن قضاعة شهد بدرا والمشاهد بعدها وهو الذي أسر خالد بن هشام المخزومي يوم بدر وهو كان عامل رسول الله صلى الله

عليه وسلم على خيبر فأتاه بتمر جنيب قد اشترى منه صاعا بصاعين من الجمع أخبرنا أبو جعفر بن أحمد بن علي بإسناده عن يونس بن بكير عن ابن إسحاق قال حدثنا حبان بن واسع عن أشياخ من قومه أن رسول الله صلى الله عليه وسلم عدل الصفوف يوم بدر وفي يده قدح يعدل به القوم فمر بسواد بن غزية حليف بني عدي ابن النجار وهو مستنتل من الصف فطعنه رسول الله بالقدح في بطنه وقال استو يا سواد فقال يا رسول الله أوجعتني وقد بعثك الله بالحق فأقدني فكشف رسول الله عن بطنه وقال استقد فاعتنقه وقبل بطنه وقال ما حملك على هذا يا سواد فقال يا رسول الله حضر ما ترى ولم آمن القتل فإني أحب أن أكون آخر العهد بك وان يمس جلدي جلدك فدعا له رسول الله بخير أخرجه الثلاثة وقال أبو عمر وقد رويت هذه القصة لسواد بن عمرو لا لسواد بن غزية'
WHERE id = 218
  AND content_ar LIKE '(ب) سواد بن غزية الأ%'
  AND source_codes IS NULL;

COMMIT;

SELECT id, source_codes, left(content_ar, 60) AS content_preview
FROM public.stories WHERE id = 218;

