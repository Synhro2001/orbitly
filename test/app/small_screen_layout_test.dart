import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/app/routes.dart';

import '../helpers/pump_app.dart';

/// Every screen opens on a small phone without overflow: the yellow-black
/// stripe in Flutter is an error, and the test fails on it.
void main() {
  const screens = [
    AppRoutes.system,
    AppRoutes.chats,
    AppRoutes.friends,
    AppRoutes.planet,
    AppRoutes.report,
    AppRoutes.camera,
    AppRoutes.collection,
    AppRoutes.wardrobe,
  ];

  for (final route in [...screens, AppRoutes.chat('friend-0')]) {
    testWidgets('$route fits a 360×640 phone', (tester) async {
      tester.view
        ..physicalSize = const Size(360, 640) * 3
        ..devicePixelRatio = 3;
      addTearDown(tester.view.reset);

      final router = await pumpApp(tester);
      router.go(route);
      await tester.pumpAndSettle();

      // Scroll to the end so the bottom items get built too.
      final scrollable = find.byType(Scrollable);
      if (scrollable.evaluate().isNotEmpty) {
        await tester.drag(scrollable.first, const Offset(0, -2000));
        await tester.pumpAndSettle();
      }
      // The framework reports an overflow as an error and fails the test,
      // naming the widget that did not fit.
    });
  }
}
