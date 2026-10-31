import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/app/routes.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('enter the shadow for 3 days and leave early', (tester) async {
    final router = await pumpApp(tester);
    router.go(AppRoutes.planet);
    await tester.pumpAndSettle();

    final list = find.byType(Scrollable).first;
    await tester.scrollUntilVisible(find.text('3 дня'), 200, scrollable: list);
    await tester.ensureVisible(find.text('3 дня'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('3 дня'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Ты в тени ещё 3 дня'), findsOneWidget);

    await tester.tap(find.widgetWithText(OutlinedButton, 'Выйти из тени'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Ты в тени'), findsNothing);
    expect(find.text('3 дня'), findsOneWidget);
  });
}
