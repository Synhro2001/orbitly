import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/app/routes.dart';

import '../helpers/pump_app.dart';

void main() {
  testWidgets('a deep link to a stranger shows an error, not a crash', (
    tester,
  ) async {
    final router = await pumpApp(tester);
    router.go(AppRoutes.chat('not-a-friend'));
    await tester.pumpAndSettle();

    expect(find.text('Что-то пошло не так'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
