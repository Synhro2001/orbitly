import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/features/settings/presentation/screens/help_settings_screen.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('a planet is created only after confirming 18+', (tester) async {
    final store = MockStore(latency: Duration.zero);
    await pumpApp(tester, store: store);

    // The form is longer than the screen: scroll to each part first.
    await tester.drag(find.byType(ListView).first, const Offset(0, -2000));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, 'Венера');
    await tester.enterText(
      find.byKey(const Key('onboarding-display-name')),
      'Аня',
    );
    await tester.pump();
    final adult = find.byKey(const Key('onboarding-adult'));
    final create = find.widgetWithText(FilledButton, 'Создать планету');
    await tester.ensureVisible(create);
    expect(tester.widget<FilledButton>(create).onPressed, isNull);

    await tester.tap(adult);
    await tester.pump();
    expect(tester.widget<FilledButton>(create).onPressed, isNotNull);
    await tester.tap(create);
    await tester.pumpAndSettle();
    expect(store.myPlanet?['planet_name'], 'Венера');
  });

  testWidgets('a problem report goes out with the text and the device', (
    tester,
  ) async {
    final store = MockStore(latency: Duration.zero, withPlanet: true);
    final router = await pumpApp(
      tester,
      store: store,
      overrides: [
        deviceDescriptionProvider.overrideWith((_) async => 'Test phone'),
      ],
    );
    router.go(AppRoutes.settingsHelp);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('help-feedback')));
    await tester.pumpAndSettle();
    final send = find.byKey(const Key('feedback-send'));
    expect(tester.widget<TextButton>(send).onPressed, isNull);
    await tester.enterText(find.byKey(const Key('feedback-text')), 'Чат завис');
    await tester.pump();
    await tester.tap(send);
    await tester.pumpAndSettle();

    expect(store.feedback.single['message'], 'Чат завис');
    expect(store.feedback.single['device'], 'Test phone');
    expect(find.text('Спасибо! Мы прочитаем'), findsOneWidget);
  });
}
