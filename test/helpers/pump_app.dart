import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/app.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/app/router.dart';
import 'package:orbitly/core/data/mock/mock_store.dart';

/// Запускает приложение с готовой планетой, без задержек сети и без
/// бесконечных анимаций (включено «уменьшить движение»).
///
/// [store] — своё моковое хранилище, например с новым открытием.
/// [overrides] — подмена отдельных репозиториев, например падающего.
Future<GoRouter> pumpApp(
  WidgetTester tester, {
  MockStore? store,
  List<Override> overrides = const [],
}) async {
  tester.platformDispatcher.accessibilityFeaturesTestValue =
      const FakeAccessibilityFeatures(disableAnimations: true);
  addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        mockStoreProvider.overrideWithValue(
          store ?? MockStore(latency: Duration.zero, withPlanet: true),
        ),
        ...overrides,
      ],
      child: const OrbitlyApp(),
    ),
  );
  await tester.pumpAndSettle();
  final container = ProviderScope.containerOf(
    tester.element(find.byType(OrbitlyApp)),
  );
  final router = container.read(routerProvider);
  return router;
}
