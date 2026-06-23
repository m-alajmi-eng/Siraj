class AyahEntity {
  final int id;
  final int surahId;
  final int ayahNumber;
  final String textUthmani;
  final int juz;
  final int page;

  const AyahEntity({
    required this.id,
    required this.surahId,
    required this.ayahNumber,
    required this.textUthmani,
    required this.juz,
    required this.page,
  });
}