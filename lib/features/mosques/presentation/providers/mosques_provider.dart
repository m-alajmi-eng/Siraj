import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

// ─── نموذج المسجد ───
class Mosque {
  final String id;
  /// فارغ = بلا اسم في OSM (`tags` قد تكون غائبة تماماً على أي node —
  /// شائع جداً)؛ الواجهة تعرض نصاً احتياطياً مترجَماً بدل الانهيار.
  final String name;
  final double lat;
  final double lon;

  const Mosque({
    required this.id,
    required this.name,
    required this.lat,
    required this.lon,
  });
}

// ─── أخطاء نوعية (PHASE G: 4 حالات واضحة بدل صمت كامل) ───
// رفض الإذن وتعطيل خدمة الموقع يُستخدَم لهما نوعا الاستثناء الجاهزان من
// geolocator نفسه (PermissionDeniedException/LocationServiceDisabledException)
// بدل تعريف نسخة مكرّرة تتصادم بالاسم مع تصدير المكتبة.
class MosquesNetworkException implements Exception {
  final String message;
  const MosquesNetworkException(this.message);
}

const _overpassPrimary = 'https://overpass-api.de/api/interpreter';
const _overpassBackup = 'https://overpass.kumi.systems/api/interpreter';
const _radiusLadderMeters = [2000, 5000, 10000];
const _requestTimeout = Duration(seconds: 15);

class MosquesNotifier extends AsyncNotifier<List<Mosque>> {
  @override
  Future<List<Mosque>> build() async => const [];

  Future<void> fetchNearbyMosques() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(_fetch);
  }

  Future<List<Mosque>> _fetch() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw const LocationServiceDisabledException();

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw const PermissionDeniedException('Location permission denied');
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.reduced),
    );

    // توسّع تلقائي 2→5→10كم: نتوقّف عند أول نطاق يعطي نتيجة، أو نُرجع
    // القائمة (قد تكون فارغة فعلياً) عند بلوغ أقصى نطاق.
    for (final radius in _radiusLadderMeters) {
      final mosques = await _queryOverpass(
        position.latitude, position.longitude, radius);
      if (mosques.isNotEmpty || radius == _radiusLadderMeters.last) {
        return mosques;
      }
    }
    return const [];
  }

  Future<List<Mosque>> _queryOverpass(
      double lat, double lon, int radiusMeters) async {
    final query = '''
    [out:json][timeout:15];
    node["amenity"="place_of_worship"]["religion"="muslim"](around:$radiusMeters,$lat,$lon);
    out;
    ''';

    try {
      return await _postQuery(_overpassPrimary, query);
    } catch (_) {
      // خادم Overpass بديل قبل الاستسلام (الخادم الرئيسي عرضة للازدحام).
      try {
        return await _postQuery(_overpassBackup, query);
      } catch (e) {
        throw MosquesNetworkException(e.toString());
      }
    }
  }

  Future<List<Mosque>> _postQuery(String endpoint, String query) async {
    final response = await http
        .post(Uri.parse(endpoint), body: query)
        .timeout(_requestTimeout);

    if (response.statusCode != 200) {
      throw MosquesNetworkException('HTTP ${response.statusCode}');
    }

    final data = json.decode(response.body) as Map<String, dynamic>;
    final elements = (data['elements'] as List?) ?? const [];

    return elements
        .whereType<Map<String, dynamic>>()
        .map(_mosqueFromElement)
        .whereType<Mosque>()
        .toList();
  }

  /// أمان null كامل للـtags — أي node في OSM قد يفتقدها تماماً (كان هذا
  /// يسبّب انهياراً مضموناً في الكود القديم `e['tags']['name']`).
  Mosque? _mosqueFromElement(Map<String, dynamic> e) {
    final lat = e['lat'] as num?;
    final lon = e['lon'] as num?;
    if (lat == null || lon == null) return null;

    final tags = e['tags'] as Map<String, dynamic>?;
    final name = tags?['name'] as String?;

    return Mosque(
      id: e['id'].toString(),
      name: name ?? '',
      lat: lat.toDouble(),
      lon: lon.toDouble(),
    );
  }
}

final mosquesProvider = AsyncNotifierProvider<MosquesNotifier, List<Mosque>>(
  MosquesNotifier.new,
);
