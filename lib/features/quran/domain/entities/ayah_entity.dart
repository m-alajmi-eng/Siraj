class AyahEntity {
  final int    id;
  final int    surahId;
  final int    ayahNumber;
  final String textUthmani;
  final int    juz;
  final int    page;
  final String? tafsir;
  final String? translation;

  const AyahEntity({
    required this.id,
    required this.surahId,
    required this.ayahNumber,
    required this.textUthmani,
    required this.juz,
    required this.page,
    this.tafsir,
    this.translation,
  });
}
