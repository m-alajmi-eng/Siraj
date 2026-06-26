import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ─── نموذج المسجد ───
class Mosque {
  final String id;
  final String name;
  final double lat;
  final double lon;

  Mosque({
    required this.id,
    required this.name,
    required this.lat,
    required this.lon,
  });
}

// ─── منطق جلب البيانات ───
class MosquesNotifier extends Notifier<List<Mosque>> {
  @override
  List<Mosque> build() => [];

  Future<void> fetchNearbyMosques() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return;

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final query = '''
    [out:json];
    node["amenity"="place_of_worship"]["religion"="muslim"](around:2000,${position.latitude},${position.longitude});
    out;
    ''';

    final response = await http.post(
      Uri.parse('https://overpass-api.de/api/interpreter'),
      body: query,
    );

    if (response.statusCode == 200) {
      final data     = json.decode(response.body);
      final List elements = data['elements'];

      state = elements.map((e) => Mosque(
        id:   e['id'].toString(),
        name: e['tags']['name'] ?? 'مسجد غير مسمى',
        lat:  e['lat'],
        lon:  e['lon'],
      )).toList();
    }
  }
}

final mosquesProvider = NotifierProvider<MosquesNotifier, List<Mosque>>(
  () => MosquesNotifier(),
);