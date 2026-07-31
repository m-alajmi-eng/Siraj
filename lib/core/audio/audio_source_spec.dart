// أوصاف مصادر صوت محايدة عن المحرّك — الميزات تبني هذه الكائنات فقط،
// ولا تعرف كيف يترجمها `SirajAudioController` لمصدر تشغيل فعلي.

/// تلاوة سورة كاملة (أو من آية بداية معيّنة) لقارئ محدَّد.
class QuranAudioSpec {
  final int surahId;
  final int totalAyahs;
  final String reciter;
  final String surahName;
  final int startAyah;
  final bool withBasmala;

  const QuranAudioSpec({
    required this.surahId,
    required this.totalAyahs,
    required this.reciter,
    required this.surahName,
    this.startAyah = 1,
    this.withBasmala = true,
  });
}

/// بث راديو مباشر (محطة واحدة، بلا قائمة تشغيل).
class RadioAudioSpec {
  final String stationId;
  final String streamUrl;
  final String title;
  final String subtitle;

  const RadioAudioSpec({
    required this.stationId,
    required this.streamUrl,
    required this.title,
    required this.subtitle,
  });
}

/// أصل محلي مرفَق بالتطبيق (معاينة صوت أذان في الإعدادات).
class AssetAudioSpec {
  /// المسار كما هو معلَن في `pubspec.yaml` (مثال: `assets/audio/adhan/makkah.mp3`).
  final String assetPath;
  final String title;

  const AssetAudioSpec({required this.assetPath, required this.title});
}

/// تسجيل صوتي مفرد لذكر واحد (مصدر بعيد، بلا قائمة تشغيل) - hisnmuslim.com.
class AthkarAudioSpec {
  /// معرّف الذكر (AthkarEntity.id) - يُستخدم لاحقاً لمطابقة "هل هذا الذكر
  /// هو ما يُشغَّل فعلياً الآن" عبر SirajNowPlaying.currentIndex.
  final int id;
  final String url;
  final String title;
  final String subtitle;

  const AthkarAudioSpec({
    required this.id,
    required this.url,
    required this.title,
    required this.subtitle,
  });
}
