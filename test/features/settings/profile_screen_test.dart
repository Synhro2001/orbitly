import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/features/planet/domain/entities/my_planet.dart';
import 'package:orbitly/features/settings/domain/repositories/profile_repository.dart';

import '../../helpers/pump_app.dart';

void main() {
  Future<MockStore> openProfile(WidgetTester tester) async {
    final store = MockStore(latency: Duration.zero, withPlanet: true);
    final router = await pumpApp(tester, store: store);
    router.go(AppRoutes.settingsProfile);
    await tester.pumpAndSettle();
    return store;
  }

  testWidgets('the planet name changes from the profile', (tester) async {
    final store = await openProfile(tester);
    await tester.tap(find.byKey(const Key('profile-planet-name')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.byKey(const Key('profile-text-field')),
      'Венера',
    );
    await tester.pump();
    await tester.tap(find.byKey(const Key('profile-save')));
    await tester.pumpAndSettle();

    expect(store.myPlanet?['planet_name'], 'Венера');
    expect(find.text('Венера'), findsOneWidget);
  });

  testWidgets('a taken handle is refused; a free one is saved once', (
    tester,
  ) async {
    final store = await openProfile(tester);
    await tester.tap(find.byKey(const Key('profile-handle')));
    await tester.pumpAndSettle();

    final field = find.byKey(const Key('profile-handle-field'));
    final save = find.byKey(const Key('profile-handle-save'));
    // Anya's handle.
    await tester.enterText(field, 'anya.sky');
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();
    expect(find.text('Занят'), findsOneWidget);
    expect(tester.widget<TextButton>(save).onPressed, isNull);

    await tester.enterText(field, 'new.me');
    await tester.pump(const Duration(milliseconds: 500));
    await tester.pumpAndSettle();
    expect(find.text('Свободен'), findsOneWidget);
    await tester.tap(save);
    await tester.pumpAndSettle();

    expect(store.myPlanet?['handle'], 'new.me');
    // The next change waits 30 days: the row no longer opens the dialog.
    await tester.tap(find.byKey(const Key('profile-handle')));
    await tester.pumpAndSettle();
    expect(field, findsNothing);
  });

  testWidgets('the invite link is shown as a QR code', (tester) async {
    await openProfile(tester);
    expect(find.byKey(const Key('profile-qr')), findsOneWidget);
    expect(find.text('https://orbitily.app/invite/my-invite'), findsOneWidget);
  });

  group('handle rules', () {
    test('normalizes what the user typed', () {
      expect(normalizeHandle('  @Anya.Sky '), 'anya.sky');
    });

    test('the same pattern as the database', () {
      expect(handlePattern.hasMatch('ab'), isFalse);
      expect(handlePattern.hasMatch('anya.sky_1'), isTrue);
      expect(handlePattern.hasMatch('аня'), isFalse);
    });

    test('the next change is 30 days after the last one', () {
      final changed = DateTime(2026, 11);
      final planet = MyPlanet(
        name: 'P',
        handle: 'p',
        baseAppearance: const PlanetAppearance(
          type: PlanetType.ocean,
          seed: 1,
          hue: 200,
        ),
        level: 1,
        xp: 0,
        xpForNextLevel: 100,
        bestStreakDays: 0,
        mood: Mood.calm,
        handleChangedAt: changed,
      );
      expect(
        planet.nextHandleChangeAt(DateTime(2026, 11, 10)),
        DateTime(2026, 12),
      );
      expect(planet.nextHandleChangeAt(DateTime(2026, 12, 2)), isNull);
    });
  });
}
