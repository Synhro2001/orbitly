import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/features/achievements/presentation/widgets/unlock_celebration.dart';

import '../../helpers/pump_app.dart';

/// The first vertical list on screen (the tabs have horizontal ones too).
final Finder _verticalList = find
    .byWidgetPredicate(
      (w) => w is Scrollable && w.axisDirection == AxisDirection.down,
    )
    .first;

void main() {
  group('Collection', () {
    testWidgets('progress, rarity, progress bars and hidden secrets', (
      tester,
    ) async {
      final router = await pumpApp(tester);
      router.go(AppRoutes.collection);
      await tester.pumpAndSettle();

      expect(find.text('Открыто 6 из 13'), findsOneWidget);
      expect(find.text('Первый контакт'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('48 / 100'),
        300,
        scrollable: _verticalList,
      );
      expect(find.text('Сто дней'), findsOneWidget);

      await tester.scrollUntilVisible(
        find.text('Год дружбы'),
        300,
        scrollable: _verticalList,
      );
      expect(find.text('???'), findsWidgets);
      // Secrets reveal neither their title nor their reward.
      expect(find.text('Синхрон'), findsNothing);
      expect(find.textContaining('Чёрная дыра'), findsNothing);
    });

    testWidgets('the Secrets tab shows only secrets', (tester) async {
      final router = await pumpApp(tester);
      router.go(AppRoutes.collection);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Секреты'));
      await tester.pumpAndSettle();

      expect(find.text('???'), findsNWidgets(2));
      expect(find.text('Первый контакт'), findsNothing);
    });
  });

  group('Unlock animation', () {
    testWidgets('an unseen unlock is celebrated and the reward can be worn', (
      tester,
    ) async {
      final store = MockStore(
        latency: Duration.zero,
        withPlanet: true,
        withNewUnlock: true,
      );
      await pumpApp(tester, store: store);

      expect(find.byType(UnlockCelebration), findsOneWidget);
      expect(find.text('Новое достижение!'), findsOneWidget);
      expect(find.textContaining('Хранитель времени'), findsOneWidget);
      expect(find.text('Награда: Песочные часы'), findsOneWidget);

      await tester.tap(find.widgetWithText(FilledButton, 'Надеть'));
      await tester.pumpAndSettle();

      expect(find.byType(UnlockCelebration), findsNothing);
      expect(store.equipped, contains('moon_hourglass'));
      // The other moon is taken off: one item of each kind.
      expect(store.equipped, isNot(contains('moon_first')));
    });

    testWidgets('a new unlock from the server appears right away', (
      tester,
    ) async {
      final store = MockStore(latency: Duration.zero, withPlanet: true);
      await pumpApp(tester, store: store);
      expect(find.byType(UnlockCelebration), findsNothing);

      store.unlock('comeback');
      await tester.pumpAndSettle();

      expect(find.textContaining('Возвращение'), findsOneWidget);

      await tester.tap(find.text('Позже'));
      await tester.pumpAndSettle();
      expect(find.byType(UnlockCelebration), findsNothing);
    });
  });

  testWidgets('Wardrobe: put on a rare planet', (tester) async {
    final store = MockStore(latency: Duration.zero, withPlanet: true);
    final router = await pumpApp(tester, store: store);
    router.go(AppRoutes.wardrobe);
    await tester.pumpAndSettle();

    final nebula = find.widgetWithText(ListTile, 'Туманность');
    await tester.scrollUntilVisible(nebula, 200, scrollable: _verticalList);
    await tester.tap(
      find.descendant(of: nebula, matching: find.text('Надеть')),
    );
    await tester.pumpAndSettle();

    expect(store.equipped, contains('planet_nebula'));
    expect(
      find.descendant(of: nebula, matching: find.text('Снять')),
      findsOneWidget,
    );
  });
}
