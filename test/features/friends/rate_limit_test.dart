import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/features/friends/data/repositories/mock_friends_repository.dart';
import 'package:orbitly/features/friends/domain/entities/friends_entities.dart';
import 'package:orbitly/features/friends/domain/repositories/friends_repository.dart';

import '../../helpers/pump_app.dart';

/// The server's rate limit has been reached.
class _LimitedFriends extends MockFriendsRepository {
  _LimitedFriends(super._store);

  @override
  Future<List<UserSummary>> searchByHandle(String query) async =>
      throw const TooManyRequestsException();
}

void main() {
  testWidgets('over the search limit, the screen says to wait', (tester) async {
    final store = MockStore(latency: Duration.zero, withPlanet: true);
    final router = await pumpApp(
      tester,
      store: store,
      overrides: [
        friendsRepositoryProvider.overrideWithValue(_LimitedFriends(store)),
      ],
    );
    router.go(AppRoutes.friends);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, 'anya');
    await tester.pump(const Duration(milliseconds: 400));
    await tester.pumpAndSettle();

    expect(
      find.text(
        'Слишком много запросов подряд. Подожди немного и попробуй снова',
      ),
      findsOneWidget,
    );
    expect(find.text('Что-то пошло не так'), findsNothing);
  });
}
