import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/misc.dart' show Override;
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/app.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/app/router.dart';
import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/features/settings/data/repositories/in_memory_settings_repository.dart';
import 'package:orbitly/features/settings/domain/repositories/settings_repository.dart';

/// Starts the app with a ready planet, no network delays and no endless
/// animations ("reduce motion" is on).
///
/// [store] is a custom mock store, for example one with a new unlock.
/// [overrides] replace single repositories, for example with a failing one.
/// [phoneLanguages] are the phone's languages; the app follows them unless
/// [settings] has a language picked. Russian by default, like most tests.
Future<GoRouter> pumpApp(
  WidgetTester tester, {
  MockStore? store,
  List<Override> overrides = const [],
  List<Locale> phoneLanguages = const [Locale('ru')],
  SettingsRepository? settings,
}) async {
  tester.platformDispatcher.localesTestValue = phoneLanguages;
  addTearDown(tester.platformDispatcher.clearLocalesTestValue);
  tester.platformDispatcher.accessibilityFeaturesTestValue =
      const FakeAccessibilityFeatures(disableAnimations: true);
  addTearDown(tester.platformDispatcher.clearAccessibilityFeaturesTestValue);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        settingsRepositoryProvider.overrideWithValue(
          settings ?? InMemorySettingsRepository(),
        ),
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
