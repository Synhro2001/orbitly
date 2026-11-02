import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/features/settings/domain/entities/user_settings.dart';
import 'package:orbitly/features/settings/domain/repositories/user_settings_repository.dart';

import '../../helpers/pump_app.dart';

/// Loads defaults; every save fails, like a phone without network.
class _OfflineSettings implements UserSettingsRepository {
  @override
  Future<UserSettings> load() async => const UserSettings();

  @override
  Future<void> save(UserSettings settings) async => throw StateError('Offline');
}

void main() {
  testWidgets('privacy starts closed and a choice is saved at once', (
    tester,
  ) async {
    final store = MockStore(latency: Duration.zero, withPlanet: true);
    final router = await pumpApp(tester, store: store);
    router.go(AppRoutes.settingsPrivacy);
    await tester.pumpAndSettle();

    // The private defaults.
    expect(find.text('Друзья друзей'), findsNWidgets(2));

    await tester.tap(find.byKey(const Key('privacy-search')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Никто').last);
    await tester.pumpAndSettle();

    expect(store.settings['search_visibility'], 'nobody');
    expect(find.text('Никто'), findsOneWidget);
  });

  testWidgets('a setting that could not be saved goes back and says so', (
    tester,
  ) async {
    final router = await pumpApp(
      tester,
      overrides: [
        userSettingsRepositoryProvider.overrideWithValue(_OfflineSettings()),
      ],
    );
    router.go(AppRoutes.settingsPrivacy);
    await tester.pumpAndSettle();

    final lastSeen = find.descendant(
      of: find.byKey(const Key('privacy-last-seen')),
      matching: find.byType(Switch),
    );
    await tester.tap(lastSeen);
    await tester.pumpAndSettle();

    expect(find.text('Не удалось сохранить. Проверь связь'), findsOneWidget);
    expect(tester.widget<Switch>(lastSeen).value, isFalse);
  });

  group('Invite link', () {
    testWidgets('shows who invites and sends the request', (tester) async {
      final router = await pumpApp(tester);
      router.go(AppRoutes.invite('user-1'));
      await tester.pumpAndSettle();

      expect(find.text('Алиса зовёт тебя на свою орбиту'), findsOneWidget);
      await tester.tap(find.byKey(const Key('invite-accept')));
      await tester.pumpAndSettle();
      expect(find.text('Заявка отправлена'), findsOneWidget);
    });

    testWidgets('an old or wrong code says so', (tester) async {
      final router = await pumpApp(tester);
      router.go(AppRoutes.invite('nope'));
      await tester.pumpAndSettle();

      expect(
        find.text('Ссылка устарела или неверна. Попроси у друга новую'),
        findsOneWidget,
      );
      expect(find.byKey(const Key('invite-accept')), findsNothing);
    });
  });
}
