class SurahEntity {
  final int id;
  final String nameArabic;
  final String nameTransliteration;
  final String nameTranslationEn;
  final String revelationType;
  final int ayahCount;

  const SurahEntity({
    required this.id,
    required this.nameArabic,
    required this.nameTransliteration,
    required this.nameTranslationEn,
    required this.revelationType,
    required this.ayahCount,
  });
}