import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/features/settings/data/repositories/mock_account_repository.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('deleting the account: what happens → code → done', (
    tester,
  ) async {
    final store = MockStore(latency: Duration.zero, withPlanet: true);
    final router = await pumpApp(tester, store: store);
    router.go(AppRoutes.settingsAccount);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('account-delete')));
    await tester.pumpAndSettle();

    // Step 1: a clear list of what happens, including the 7 days.
    expect(find.textContaining('через 7 дней'), findsOneWidget);
    await tester.tap(find.byKey(const Key('delete-start')));
    await tester.pumpAndSettle();

    // Step 2: the code from email.
    await tester.enterText(find.byKey(const Key('delete-code')), '123456');
    await tester.tap(find.byKey(const Key('delete-confirm')));
    await tester.pumpAndSettle();

    // Step 3: hidden now, deleted in 7 days.
    expect(store.deletionRequestedAt, isNotNull);
    expect(find.byKey(const Key('delete-done')), findsOneWidget);
  });

  testWidgets('signing in again cancels a requested deletion', (tester) async {
    final store = MockStore(latency: Duration.zero, withPlanet: true)
      ..deletionRequestedAt = DateTime.now().subtract(const Duration(days: 2));
    await pumpApp(tester, store: store);

    expect(store.deletionRequestedAt, isNull);
    expect(
      find.text('Удаление аккаунта отменено. С возвращением!'),
      findsOneWidget,
    );
  });

  test('the export contains my own profile and settings', () async {
    final store = MockStore(latency: Duration.zero, withPlanet: true)
      ..settings = {'hide_streaks': true};
    final data = await MockAccountRepository(store).exportData();
    expect((data['profile']! as Map)['planet_name'], 'Орбитания');
    expect(data['settings'], {'hide_streaks': true});
  });

  testWidgets('the delete-account web page is a plain route', (tester) async {
    final router = await pumpApp(tester);
    router.go(AppRoutes.deleteAccount);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('delete-start')), findsOneWidget);
  });
}
