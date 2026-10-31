import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/features/chat/presentation/screens/chat_screen.dart';
import 'package:orbitly/features/system/presentation/screens/system_screen.dart';
import 'package:orbitly/features/system/presentation/widgets/orbit_system_view.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('opens on my system with friends on orbits', (tester) async {
    final semantics = tester.ensureSemantics();
    await pumpApp(tester);

    expect(find.byType(SystemScreen), findsOneWidget);
    expect(find.byType(OrbitSystemView), findsOneWidget);
    expect(find.text('Моя система'), findsOneWidget);
    expect(find.bySemanticsLabel('Планета Миша'), findsOneWidget);
    // У Димы непрочитанный снап — это видно и в подписи для скринридера.
    expect(
      find.bySemanticsLabel('Планета Дима, есть новый снап'),
      findsOneWidget,
    );
    expect(find.bySemanticsLabel('Момент: Лера'), findsOneWidget);
    semantics.dispose();
  });

  testWidgets('tapping a friend planet opens the chat', (tester) async {
    final semantics = tester.ensureSemantics();
    await pumpApp(tester);

    await tester.tap(find.bySemanticsLabel('Планета Дима, есть новый снап'));
    await tester.pumpAndSettle();

    expect(find.byType(ChatScreen), findsOneWidget);
    expect(find.text('Смотри, что нашёл'), findsOneWidget);
    semantics.dispose();
  });
}
