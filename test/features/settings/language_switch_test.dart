import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/features/auth/domain/repositories/auth_repository.dart';
import 'package:orbitly/features/settings/data/repositories/in_memory_settings_repository.dart';
import 'package:orbitly/features/settings/domain/app_language.dart';

import '../../helpers/pump_app.dart';

/// Signed in; records what the app tells the account.
class _RecordingAuth implements AuthRepository {
  final savedLanguages = <String>[];
  bool signedOut = false;

  @override
  Stream<bool> watchSignedIn() => Stream.value(true);

  @override
  Future<void> saveLanguage(String language) async =>
      savedLanguages.add(language);

  @override
  Future<void> signOut() async => signedOut = true;

  @override
  Future<void> sendCode(String email, {required String language}) async {}

  @override
  Future<void> verifyCode({
    required String email,
    required String code,
  }) async {}
}

void main() {
  testWidgets('follows the phone: English phone, English app and content', (
    tester,
  ) async {
    final router = await pumpApp(
      tester,
      phoneLanguages: const [Locale('en', 'US')],
    );
    expect(find.text('Chats'), findsOneWidget);

    router.go(AppRoutes.collection);
    await tester.pumpAndSettle();
    // A title from the server catalogue, in English.
    expect(find.text('First contact'), findsOneWidget);
    expect(find.text('Первый контакт'), findsNothing);
  });

  testWidgets('a phone language the app lacks falls back to English', (
    tester,
  ) async {
    await pumpApp(tester, phoneLanguages: const [Locale('de')]);
    expect(find.text('Chats'), findsOneWidget);
  });

  testWidgets('picking a language switches at once and is remembered', (
    tester,
  ) async {
    final settings = InMemorySettingsRepository();
    final router = await pumpApp(
      tester,
      phoneLanguages: const [Locale('en')],
      settings: settings,
    );
    router.go(AppRoutes.settingsAppearance);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('language-russian')));
    await tester.pumpAndSettle();

    expect(find.text('Оформление'), findsOneWidget);
    expect(settings.language, AppLanguage.russian);
  });

  testWidgets('a remembered language wins over the phone', (tester) async {
    await pumpApp(
      tester,
      phoneLanguages: const [Locale('en')],
      settings: InMemorySettingsRepository(AppLanguage.russian),
    );
    expect(find.text('Чаты'), findsOneWidget);
  });

  testWidgets('conversation openers come in the app language', (tester) async {
    final router = await pumpApp(tester, phoneLanguages: const [Locale('en')]);
    // Pasha (friend-7) is drifting away.
    router.go(AppRoutes.chat('friend-7'));
    await tester.pumpAndSettle();
    expect(find.text("Hi Паша! It's been a while — how are you?"), findsOne);
  });

  testWidgets('the account learns the language, and every change of it', (
    tester,
  ) async {
    final auth = _RecordingAuth();
    final router = await pumpApp(
      tester,
      overrides: [authRepositoryProvider.overrideWithValue(auth)],
    );
    expect(auth.savedLanguages, ['ru']);

    router.go(AppRoutes.settingsAppearance);
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('language-english')));
    await tester.pumpAndSettle();
    expect(auth.savedLanguages, ['ru', 'en']);
  });

  testWidgets('settings open from my planet', (tester) async {
    final router = await pumpApp(tester);
    router.go(AppRoutes.planet);
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Настройки'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('settings-appearance')), findsOneWidget);
  });

  testWidgets('sign out asks first', (tester) async {
    final auth = _RecordingAuth();
    final router = await pumpApp(
      tester,
      overrides: [authRepositoryProvider.overrideWithValue(auth)],
    );
    router.go(AppRoutes.settingsAccount);
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('sign-out')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Отмена'));
    await tester.pumpAndSettle();
    expect(auth.signedOut, isFalse);

    await tester.tap(find.byKey(const Key('sign-out')));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Выйти'));
    await tester.pumpAndSettle();
    expect(auth.signedOut, isTrue);
  });
}
