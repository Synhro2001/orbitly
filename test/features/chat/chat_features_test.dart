import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/app/routes.dart';

import '../../helpers/pump_app.dart';

void main() {
  Future<void> openChat(WidgetTester tester, String friendId) async {
    final router = await pumpApp(tester);
    router.go(AppRoutes.chat(friendId));
    await tester.pumpAndSettle();
  }

  group('Time capsule', () {
    testWidgets('sends a capsule that opens in a week', (tester) async {
      await openChat(tester, 'friend-0');

      await tester.enterText(find.byType(TextField), 'Открой через неделю');
      await tester.pump();
      await tester.tap(find.byTooltip('Капсула времени'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Через неделю'));
      await tester.pumpAndSettle();

      expect(find.text('Откроется через 7 дней'), findsOneWidget);
      // The sender sees their message right away.
      expect(find.text('Открой через неделю'), findsOneWidget);
    });

    testWidgets("hides a friend's capsule until its date", (tester) async {
      // Lera (friend-2) has a sealed capsule at the start of the chat.
      await openChat(tester, 'friend-2');
      await tester.dragUntilVisible(
        find.text('Запечатана до срока 🔒'),
        find.byType(ListView),
        const Offset(0, 200),
      );

      expect(find.text('Откроется через 5 дней'), findsOneWidget);
      expect(find.textContaining('С днём рождения'), findsNothing);
    });

    testWidgets('capsule buttons are disabled without text', (tester) async {
      await openChat(tester, 'friend-0');

      final capsule = tester.widget<IconButton>(
        find.widgetWithIcon(IconButton, Icons.hourglass_top_rounded),
      );
      expect(capsule.onPressed, isNull);
    });
  });

  group('Conversation openers', () {
    testWidgets('suggests openers for a drifting friend', (tester) async {
      // Pasha (friend-7) is on the drifting list.
      await openChat(tester, 'friend-7');

      expect(find.text('С чего начать?'), findsOneWidget);
      const opener = 'Привет, Паша! Давно не болтали — как ты?';
      await tester.tap(find.text(opener));
      await tester.pump();
      final field = tester.widget<TextField>(find.byType(TextField));
      expect(field.controller!.text, opener);

      await tester.tap(find.byTooltip('Отправить'));
      await tester.pumpAndSettle();
      expect(find.text('С чего начать?'), findsNothing);
    });

    testWidgets('no openers when the conversation is lively', (tester) async {
      // The chat with Anya is recent.
      await openChat(tester, 'friend-0');
      expect(find.text('С чего начать?'), findsNothing);
    });
  });

  testWidgets('streak with a friend in shadow is paused', (tester) async {
    await openChat(tester, 'friend-7');
    expect(find.textContaining('на паузе, кто-то в тени'), findsOneWidget);
  });
}
