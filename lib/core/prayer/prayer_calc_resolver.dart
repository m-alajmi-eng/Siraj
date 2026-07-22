import 'package:adhan/adhan.dart';

/// مصدر الحقيقة الوحيد لتحويل معرّفات طريقة الحساب/المذهب (كما تُخزَّن في
/// الإعدادات) إلى كائنات مكتبة adhan. يُستهلَك من مسار العرض
/// (`prayer_local_datasource.dart`) ومسار الإشعارات (`adhan_service.dart`)
/// معاً، حتى لا يظهر وقتان مختلفان للصلاة نفسها داخل التطبيق (ADR-011).
CalculationMethod resolveCalculationMethod(String id) {
  switch (id) {
    case 'ISNA':
      return CalculationMethod.north_america;
    case 'Egypt':
      return CalculationMethod.egyptian;
    case 'Makkah':
      return CalculationMethod.umm_al_qura;
    case 'Kuwait':
      return CalculationMethod.kuwait;
    case 'Qatar':
      return CalculationMethod.qatar;
    case 'Dubai':
      return CalculationMethod.dubai;
    case 'Karachi':
      return CalculationMethod.karachi;
    case 'Singapore':
      return CalculationMethod.singapore;
    case 'Turkey':
      return CalculationMethod.turkey;
    case 'MoonSighting':
      return CalculationMethod.moon_sighting_committee;
    case 'MWL':
    default:
      return CalculationMethod.muslim_world_league;
  }
}

/// مكتبة adhan تفرّق بين مذهبين فقط لحساب العصر (Madhab.shafi/Madhab.hanafi)
/// لأن المالكي والحنبلي يتّبعان نفس طول الظل (مِثلي) الذي يتّبعه الشافعي؛
/// الحنفي وحده يستخدم طول ظل مضاعف. لذا كل المذاهب الأربعة المعروضة في
/// الإعدادات (hanafi/maliki/shafi/hanbali) تُختزَل هنا لقيمتين فقط.
Madhab resolveMadhab(String id) {
  return id == 'hanafi' ? Madhab.hanafi : Madhab.shafi;
}

CalculationParameters resolvePrayerParameters({
  required String calcMethodId,
  required String madhabId,
}) {
  final params = resolveCalculationMethod(calcMethodId).getParameters();
  params.madhab = resolveMadhab(madhabId);
  return params;
}
