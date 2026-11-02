import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/app/routes.dart';

import '../helpers/pump_app.dart';

/// Каждый экран открывается на маленьком телефоне без переполнений:
/// жёлто-чёрная полоса в Flutter — это ошибка, и тест на ней падает.
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

      // Прокручиваем до конца, чтобы построились и нижние элементы.
      final scrollable = find.byType(Scrollable);
      if (scrollable.evaluate().isNotEmpty) {
        await tester.drag(scrollable.first, const Offset(0, -2000));
        await tester.pumpAndSettle();
      }
      // Переполнение фреймворк сам сообщит как ошибку и уронит тест —
      // с указанием виджета, который не влез.
    });
  }
}
