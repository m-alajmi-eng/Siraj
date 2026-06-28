import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> fetchTranslation({
  required String edition,
  required int surahId,
  required int ayahNumber,
}) async {
  final url = 'https://api.alquran.cloud/v1/ayah/$surahId:$ayahNumber/$edition';
  print('TRANSLATION URL: \$url');
  final res = await http.get(Uri.parse(url));
  print('TRANSLATION STATUS: \${res.statusCode}');
  if (res.statusCode == 200) {
    final data = json.decode(res.body);
    return data['data']['text'] ?? '';
  }
  return '';
}

final translationProvider = FutureProvider.family<String, ({String edition, int surahId, int ayahNumber})>(
  (ref, params) => fetchTranslation(
    edition:    params.edition,
    surahId:    params.surahId,
    ayahNumber: params.ayahNumber,
  ),
);
