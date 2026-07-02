import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/gateway_local_datasource.dart';
import '../../domain/entities/gateway_entity.dart';

final gatewayDataSourceProvider = Provider<GatewayLocalDataSource>((ref) {
  return GatewayLocalDataSource();
});

/// الطبقة 1: محطات رحلة الوعي.
final gatewayStationsProvider = FutureProvider<List<GatewayStation>>((ref) {
  return ref.watch(gatewayDataSourceProvider).getStations();
});

/// الطبقة 2: مواضيع مبادئ الإسلام.
final gatewayPrinciplesProvider = FutureProvider<List<PrincipleTopic>>((ref) {
  return ref.watch(gatewayDataSourceProvider).getPrinciples();
});

/// موضوع واحد بالمعرّف.
final gatewayTopicProvider =
    FutureProvider.family<PrincipleTopic?, String>((ref, id) {
  return ref.watch(gatewayDataSourceProvider).getTopic(id);
});

/// تتبّع المحطة الحالية في الرحلة (للتنقّل والمؤشّر).
/// لا نحفظ تقدّماً دائماً احتراماً لخصوصية التجربة.
class JourneyPositionNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void goTo(int index) => state = index;
  void next() => state = state + 1;
  void prev() => state = state > 0 ? state - 1 : 0;
  void reset() => state = 0;
}

final journeyPositionProvider =
    NotifierProvider<JourneyPositionNotifier, int>(() {
  return JourneyPositionNotifier();
});
