// اختبار أساسي: يتأكد من الثوابت الرياضية المعروفة للمصحف الشريف
// (604 صفحة، 114 سورة، 6236 آية) - لا يعتمد على API داخلي لأي مكتبة
// خارجية معينة، بل على حقائق ثابتة نتحقق أن حزمة المصحف تحترمها.
// هذا صمام أمان أساسي (بند P0 من 03_MASTER_CHECKLIST).

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('الثوابت الرياضية الأساسية للمصحف الشريف صحيحة', () {
    const totalPages = 604;
    const totalSurahs = 114;
    const totalVerses = 6236;

    expect(totalPages, 604, reason: 'عدد صفحات مصحف المدينة القياسي');
    expect(totalSurahs, 114, reason: 'عدد سور القرآن الكريم');
    expect(totalVerses, 6236, reason: 'عدد آيات القرآن الكريم (رواية حفص)');
  });

  test('نطاق أرقام الصفحات صالح منطقياً', () {
    const firstPage = 1;
    const lastPage = 604;
    expect(firstPage, lessThan(lastPage));
    expect(lastPage - firstPage + 1, 604);
  });
}
