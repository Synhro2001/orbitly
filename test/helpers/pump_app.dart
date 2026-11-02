import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/app.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/app/router.dart';
import 'package:orbitly/core/data/mock/mock_store.dart';

/// Starts the app with a ready planet, no network delays and no endless
/// animations ("reduce motion" is on).
///
/// [store] is a custom mock store, for example one with a new unlock.
/// [overrides] replace single repositories, for example with a failing one.
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
