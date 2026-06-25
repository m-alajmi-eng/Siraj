import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/hadith_entity.dart';
import '../../../../core/storage/cache_service.dart';

class HadithRemoteDataSource {
  static const String _baseUrl =
      'https://cdn.jsdelivr.net/gh/fawazahmed0/hadith-api@1/editions';

  static const Map<String, String> collections = {
    'ara-bukhari':  'صحيح البخاري',
    'ara-muslim':   'صحيح مسلم',
    'ara-abudawud': 'سنن أبي داود',
    'ara-tirmidhi': 'سنن الترمذي',
    'ara-nasai':    'سنن النسائي',
    'ara-ibnmajah': 'سنن ابن ماجه',
  };

  Future<List<HadithEntity>> getHadiths(String collection,
      {int page = 1, int limit = 20}) async {

    final cacheKey = 'hadith_${collection}_p$page';

    // جرب الـ cache أولاً
    final cached = CacheService.getSetting(cacheKey);
    if (cached != null) {
      final List data = jsonDecode(cached);
      return data.map((h) => HadithEntity(
        id:         h['id'],
        collection: collection,
        arabic:     h['arabic'],
        grade:      'صحيح',
        source:     collections[collection] ?? collection,
      )).toList();
    }

    // جلب من API
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/$collection.json'),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data     = jsonDecode(response.body);
        final List all = data['hadiths'];
        final start    = (page - 1) * limit;
        final end      = (start + limit).clamp(0, all.length);
        final result   = all.sublist(start, end).map((h) => HadithEntity(
          id:         h['hadithnumber'] ?? h['arabicnumber'] ?? 0,
          collection: collection,
          arabic:     h['text'] ?? '',
          grade:      'صحيح',
          source:     collections[collection] ?? collection,
        )).toList();

        // حفظ في cache
        await CacheService.saveSetting(
          cacheKey,
          jsonEncode(result.map((h) => {
            'id':     h.id,
            'arabic': h.arabic,
          }).toList()),
        );

        return result;
      }
    } catch (e) {
      // إذا فشل الإنترنت — أرجع قائمة فارغة
    }

    return [];
  }
}