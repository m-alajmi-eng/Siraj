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
  /// المفتاح الخام كما يُحفَظ في الإعدادات ('uthmani'/'hafs') — يُستخدم
  /// في واجهة الإعدادات نفسها للمقارنة/العرض، بينما [fontFamily] المشتقّ
  /// منه هو ما يستهلكه القارئ فعلياً.
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

/// 'uthmani'/'hafs': اختيار صريح للمستخدم عبر شاشة الإعدادات — يُحترَم
/// كما هو (منطق PHASE C5 الذي وصل هذا الاختيار فعلياً، لم يُلغَ). أي
/// قيمة أخرى (تحديداً المفتاح الافتراضي عند عدم وجود اختيار محفوظ
/// إطلاقاً في Hive) تعني "لم يختر المستخدم بعد" فتُستخدَم QuranFont —
/// الخط الأوضح، وهو الافتراضي البصري المطلوب.
String _familyForKey(String quranFontKey) {
  switch (quranFontKey) {
    case 'uthmani': return 'UthmanTNB';
    case 'hafs':    return 'HafsSmart';
    default:        return 'QuranFont';
  }
}

class ReaderFontNotifier extends Notifier<ReaderFontSettings> {
  @override
  ReaderFontSettings build() {
    final size = CacheService.getSetting('font_size', defaultValue: 28.0) as double;
    // 'default' هنا مفتاح داخلي فقط لتمييز "لا اختيار محفوظ" — لا يُكتب
    // أبداً في Hive صراحة (setQuranFont لا تكتب سوى 'uthmani'/'hafs').
    final fontKey =
        CacheService.getSetting('quran_font', defaultValue: 'default') as String;
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
