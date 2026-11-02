import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:orbitly/app/app.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/app/router.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/data/mock/mock_store.dart';

/// Smoothness benchmark: frame build and raster times on the main screens.
///
/// flutter drive --profile --driver=test_driver/perf_driver.dart \
///   --target=integration_test/perf_test.dart
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized()
    ..framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive
    ..reportData = <String, dynamic>{};

  testWidgets('frame timings on the main screens', (tester) async {
    final store = MockStore(latency: Duration.zero, withPlanet: true);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [mockStoreProvider.overrideWithValue(store)],
        child: const OrbitlyApp(),
      ),
    );
    await _settle(tester);
    final router = ProviderScope.containerOf(
      tester.element(find.byType(OrbitlyApp)),
    ).read(routerProvider);

    Future<void> visit(String route) async {
      router.go(route);
      await _settle(tester);
    }

    await _measure(binding, () async {
      await tester.pump(const Duration(seconds: 6));
    }, 'system_idle');

    await _measure(binding, () async {
      final scene = find.byType(InteractiveViewer);
      for (var i = 0; i < 3; i++) {
        await tester.fling(scene, const Offset(-250, 120), 800);
        await tester.pump(const Duration(milliseconds: 700));
        await tester.fling(scene, const Offset(250, -120), 800);
        await tester.pump(const Duration(milliseconds: 700));
      }
    }, 'system_pan');

    await visit(AppRoutes.chats);
    await _measure(binding, () async {
      await _scroll(tester);
    }, 'chats_scroll');

    await visit(AppRoutes.planet);
    await _measure(binding, () async {
      await _scroll(tester);
    }, 'planet_scroll');

    await visit(AppRoutes.collection);
    await _measure(binding, () async {
      await _scroll(tester);
    }, 'collection_scroll');

    await visit(AppRoutes.wardrobe);
    await _measure(binding, () async {
      await _scroll(tester);
    }, 'wardrobe_scroll');

    await visit(AppRoutes.friends);
    await _measure(binding, () async {
      await _scroll(tester);
    }, 'friends_scroll');

    router.go(AppRoutes.system);
    await _measure(binding, () async {
      await tester.pump(const Duration(seconds: 2));
    }, 'back_to_system');

    // Transitions: open a screen and let its animation finish.
    await _measure(binding, () async {
      router.go(AppRoutes.chat('friend-0'));
      await tester.pump(const Duration(seconds: 2));
      router.go(AppRoutes.system);
      await tester.pump(const Duration(seconds: 1));
      router.go(AppRoutes.collection);
      await tester.pump(const Duration(seconds: 2));
      router.go(AppRoutes.wardrobe);
      await tester.pump(const Duration(seconds: 2));
      router.go(AppRoutes.camera);
      await tester.pump(const Duration(seconds: 2));
      router.go(AppRoutes.system);
      await tester.pump(const Duration(seconds: 1));
    }, 'navigation');

    await _measure(binding, () async {
      store.unlock('comeback');
      await tester.pump(const Duration(seconds: 3));
    }, 'unlock_celebration');
  });
}

/// pumpAndSettle would never return: the system animation is endless.
Future<void> _settle(WidgetTester tester) =>
    tester.pump(const Duration(seconds: 2));

Future<void> _scroll(WidgetTester tester) async {
  final list = find.byType(Scrollable).first;
  for (var i = 0; i < 3; i++) {
    await tester.fling(list, const Offset(0, -500), 2500);
    await tester.pump(const Duration(milliseconds: 900));
    await tester.fling(list, const Offset(0, 500), 2500);
    await tester.pump(const Duration(milliseconds: 900));
  }
}

/// Collects FrameTiming during [action] and puts a summary into reportData.
Future<void> _measure(
  IntegrationTestWidgetsFlutterBinding binding,
  Future<void> Function() action,
  String key,
) async {
  final frames = <FrameTiming>[];
  void collect(List<FrameTiming> t) => frames.addAll(t);
  SchedulerBinding.instance.addTimingsCallback(collect);
  await action();
  // Timings arrive in batches; let the last one come in.
  await Future<void>.delayed(const Duration(milliseconds: 300));
  SchedulerBinding.instance.removeTimingsCallback(collect);

  double ms(Duration d) => d.inMicroseconds / 1000;
  List<double> sorted(Iterable<double> v) => v.toList()..sort();
  double pct(List<double> v, double p) =>
      v.isEmpty ? 0 : v[((v.length - 1) * p).round()];
  final build = sorted(frames.map((f) => ms(f.buildDuration)));
  final raster = sorted(frames.map((f) => ms(f.rasterDuration)));
  const budget = 1000 / 60;
  binding.reportData![key] = {
    'frames': frames.length,
    'build_p50': pct(build, .5),
    'build_p90': pct(build, .9),
    'build_max': build.isEmpty ? 0 : build.last,
    'raster_p50': pct(raster, .5),
    'raster_p90': pct(raster, .9),
    'raster_max': raster.isEmpty ? 0 : raster.last,
    'fps': frames.length < 2
        ? 0
        : frames.length *
              1e6 /
              (frames.last.timestampInMicroseconds(FramePhase.rasterFinish) -
                  frames.first.timestampInMicroseconds(FramePhase.buildStart)),
    // Frames that visibly stuttered: longer than two frames at 60 Hz.
    'dropped': frames.where((f) => ms(f.totalSpan) > 2 * budget).length,
    'janky': frames
        .where(
          (f) => ms(f.buildDuration) > budget || ms(f.rasterDuration) > budget,
        )
        .length,
  };
}
