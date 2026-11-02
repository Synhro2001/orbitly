import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/data/mock/mock_store.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('the chat shows its rule and either friend can change it', (
    tester,
  ) async {
    final store = MockStore(latency: Duration.zero, withPlanet: true);
    final router = await pumpApp(tester, store: store);
    router.go(AppRoutes.chat('friend-0'));
    await tester.pumpAndSettle();

    // Seeded chats keep their history.
    expect(find.text('Сообщения хранятся'), findsOneWidget);

    await tester.tap(find.byKey(const Key('chat-menu')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Исчезающие сообщения'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('retention-day')));
    await tester.pumpAndSettle();

    expect(store.retention['friend-0'], 'day');
    expect(find.text('⏱ Сообщения исчезают через 24 часа'), findsOneWidget);
  });
}
