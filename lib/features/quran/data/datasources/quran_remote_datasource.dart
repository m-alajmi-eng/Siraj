import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/surah_entity.dart';
import '../../domain/entities/ayah_entity.dart';

class QuranRemoteDataSource {
  static const String _baseUrl = 'https://api.alquran.cloud/v1';

  Future<List<SurahEntity>> getSurahs() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/surah'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List surahs = data['data'];

      return surahs.map((s) => SurahEntity(
        id:                    s['number'],
        nameArabic:            s['name'],
        nameTransliteration:   s['englishName'],
        nameTranslationEn:     s['englishNameTranslation'],
        revelationType:        s['revelationType'],
        ayahCount:             s['numberOfAyahs'],
      )).toList();
    }

    throw Exception('Failed to load surahs');
  }

  Future<List<AyahEntity>> getAyahs(int surahId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/surah/$surahId/quran-uthmani'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List ayahs = data['data']['ayahs'];

      return ayahs.map((a) => AyahEntity(
        id:          a['number'],
        surahId:     surahId,
        ayahNumber:  a['numberInSurah'],
        textUthmani: a['text'],
        juz:         a['juz'],
        page:        a['page'],
      )).toList();
    }

    throw Exception('Failed to load ayahs');
  }
}