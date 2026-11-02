import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/features/friends/data/models/friends_models.dart';

import '../../helpers/pump_app.dart';

void main() {
  Future<MockStore> openChatMenu(WidgetTester tester) async {
    final store = MockStore(latency: Duration.zero, withPlanet: true);
    final router = await pumpApp(tester, store: store);
    router.go(AppRoutes.chat('friend-0'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('chat-menu')));
    await tester.pumpAndSettle();
    return store;
  }

  testWidgets('block: the friend leaves my orbit and chats; unblock in '
      'settings', (tester) async {
    final store = await openChatMenu(tester);
    await tester.tap(find.text('Заблокировать'));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('block-confirm')));
    await tester.pumpAndSettle();

    // Back on the chat list, without Anya.
    expect(find.text('Чаты'), findsWidgets);
    expect(find.text('Аня'), findsNothing);
    expect(store.friends.any((f) => f['id'] == 'friend-0'), isFalse);

    final router = await pumpApp(tester, store: store);
    router.go(AppRoutes.settingsBlocked);
    await tester.pumpAndSettle();
    expect(find.text('Аня'), findsOneWidget);
    await tester.tap(find.text('Разблокировать'));
    await tester.pumpAndSettle();
    expect(find.text('Аня'), findsNothing);
  });

  testWidgets('quiet orbit: muted from the chat, listed in settings', (
    tester,
  ) async {
    final store = await openChatMenu(tester);
    await tester.tap(find.text('В тихую орбиту'));
    await tester.pumpAndSettle();
    expect(store.muted, {'friend-0'});
    expect(store.friendJson('friend-0')['muted'], isTrue);

    final router = await pumpApp(tester, store: store);
    router.go(AppRoutes.settingsQuietOrbit);
    await tester.pumpAndSettle();
    expect(find.text('Аня'), findsOneWidget);
    await tester.tap(find.text('Вернуть из тихой орбиты'));
    await tester.pumpAndSettle();
    expect(store.muted, isEmpty);
  });

  testWidgets('report: a reason is required, then the report is filed', (
    tester,
  ) async {
    final store = await openChatMenu(tester);
    await tester.tap(find.text('Пожаловаться'));
    await tester.pumpAndSettle();

    final send = find.byKey(const Key('report-send'));
    expect(tester.widget<FilledButton>(send).onPressed, isNull);
    await tester.tap(find.byKey(const Key('report-spam')));
    await tester.pumpAndSettle();
    await tester.tap(send);
    await tester.pumpAndSettle();

    expect(store.reports.single['reason'], 'spam');
    expect(find.text('Жалоба отправлена. Спасибо, что помогаешь'), findsOne);
  });

  test('server user rows take the name from display_name', () {
    final user = userSummaryFromRow({
      'id': 'a0000000-0000-0000-0000-000000000002',
      'handle': 'misha_m',
      'display_name': 'Миша',
      'appearance': {'type': 'lava', 'seed': 1, 'hue': 12},
    });
    expect(user.name, 'Миша');
  });
}
