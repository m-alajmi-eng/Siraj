import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/storage/cache_service.dart';

/// إعداد خط القارئ (ADR-003/011): يوصل `font_size`/`quran_font` المحفوظَين
/// في الإعدادات إلى `SurahReaderScreen` فعلياً بدل الأحجام الثابتة
/// (24/26/28) والخط العام `QuranFont` غير المرتبط بخيار المستخدم.
class ReaderFontSettings {
  /// الحجم المرجعي (نص الآية في وضع المصحف المتّصل، أبرز سياقات القراءة).
  /// بقية السياقات (البسملة، رقم الآية، وضع الترجمة) تُشتَق منه بنفس
  /// الفروق النسبية المعتمَدة سابقاً في التصميم الثابت.
  final double baseSize;
  final String fontFamily;
  /// المفتاح الخام كما يُحفَظ في الإعدادات ('quran'/'uthmani'/'hafs') —
  /// يُستخدم في واجهة الإعدادات نفسها للمقارنة/العرض، بينما [fontFamily]
  /// المشتقّ منه هو ما يستهلكه القارئ فعلياً.
  final String quranFontKey;

  const ReaderFontSettings({
    required this.baseSize,
    required this.fontFamily,
    required this.quranFontKey,
  });

  double get mushafBody   => baseSize;
  double get mushafMarker => baseSize - 4;
  double get mushafBasmala => baseSize - 2;
  double get listBody     => baseSize - 2;
  double get listBasmala  => baseSize - 4;
}

/// ثلاثة خيارات صريحة قابلة للاختيار من شاشة الإعدادات: 'quran'
/// (QuranFont)، 'uthmani' (UthmanTNB)، 'hafs' (HafsSmart — خط مجمّع
/// الملك فهد، وهو أيضاً الافتراضي). لا مفهوم "غير مُختار" منفصلاً —
/// الافتراضي نفسه أحد الخيارات الثلاثة صراحة.
String _familyForKey(String quranFontKey) {
  switch (quranFontKey) {
    case 'uthmani': return 'UthmanTNB';
    case 'quran':   return 'QuranFont';
    default:        return 'HafsSmart';
  }
}

class ReaderFontNotifier extends Notifier<ReaderFontSettings> {
  @override
  ReaderFontSettings build() {
    final size = CacheService.getSetting('font_size', defaultValue: 28.0) as double;
    final fontKey =
        CacheService.getSetting('quran_font', defaultValue: 'hafs') as String;
    return ReaderFontSettings(
      baseSize: size,
      fontFamily: _familyForKey(fontKey),
      quranFontKey: fontKey,
    );
  }

  Future<void> setFontSize(double size) async {
    state = ReaderFontSettings(
      baseSize: size,
      fontFamily: state.fontFamily,
      quranFontKey: state.quranFontKey,
    );
    await CacheService.saveSetting('font_size', size);
  }

  Future<void> setQuranFont(String quranFontKey) async {
    state = ReaderFontSettings(
      baseSize: state.baseSize,
      fontFamily: _familyForKey(quranFontKey),
      quranFontKey: quranFontKey,
    );
    await CacheService.saveSetting('quran_font', quranFontKey);
  }
}

final readerFontProvider =
    NotifierProvider<ReaderFontNotifier, ReaderFontSettings>(
  ReaderFontNotifier.new,
);
