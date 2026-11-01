import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/app/routes.dart';

import '../../helpers/pump_app.dart';

void main() {
  // friend-0 — Аня: у неё непрочитанный снап.
  Future<void> openChat(WidgetTester tester) async {
    final router = await pumpApp(tester);
    router.go(AppRoutes.chat('friend-0'));
    await tester.pumpAndSettle();
  }

  testWidgets('shows friend, messages and the snap plaque', (tester) async {
    await openChat(tester);

    // Имя видно и в компактной шапке, и в карточке друга.
    expect(find.textContaining('Аня'), findsNWidgets(2));
    expect(find.text('@anya.sky'), findsOneWidget);
    expect(find.text('Ты видел закат сегодня?'), findsOneWidget);
    expect(find.text('Снап — нажми, чтобы посмотреть'), findsOneWidget);
    expect(find.text('Общие трофеи'), findsOneWidget);
  });

  testWidgets('sends a text message', (tester) async {
    await openChat(tester);

    await tester.enterText(find.byType(TextField), 'Привет с орбиты');
    await tester.tap(find.byTooltip('Отправить'));
    await tester.pumpAndSettle();

    expect(find.text('Привет с орбиты'), findsOneWidget);
  });

  testWidgets('opening a snap marks it as viewed', (tester) async {
    await openChat(tester);

    await tester.tap(find.text('Снап — нажми, чтобы посмотреть'));
    await tester.pump();
    expect(find.text('Снап от Аня'), findsOneWidget);

    // Просмотр закрывается сам по таймеру.
    await tester.pumpAndSettle();

    expect(find.text('Снап от Аня'), findsNothing);
    expect(find.text('Снап — нажми, чтобы посмотреть'), findsNothing);
    expect(find.text('Снап просмотрен'), findsOneWidget);
  });
}
