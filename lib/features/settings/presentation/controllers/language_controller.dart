import 'package:flutter/widgets.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/features/auth/presentation/controllers/auth_controller.dart';
import 'package:orbitly/features/settings/domain/app_language.dart';
import 'package:orbitly/l10n/app_localizations.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'language_controller.g.dart';

/// The language the user picked in the settings.
@Riverpod(keepAlive: true)
class LanguageController extends _$LanguageController {
  @override
  AppLanguage build() => ref.watch(settingsRepositoryProvider).language;

  Future<void> select(AppLanguage language) async {
    state = language;
    await ref.read(settingsRepositoryProvider).setLanguage(language);
  }
}

/// The phone's languages, most wanted first. OrbitlyApp refreshes this when
/// they change in the system settings.
@Riverpod(keepAlive: true)
List<String> phoneLanguages(Ref ref) => [
  for (final locale in WidgetsBinding.instance.platformDispatcher.locales)
    locale.languageCode,
];

/// The language the app is shown in: the user's pick, or the phone's.
/// The one place that decides it.
@Riverpod(keepAlive: true)
String appLanguage(Ref ref) =>
    ref.watch(languageControllerProvider).code ??
    resolveLanguage(ref.watch(phoneLanguagesProvider), {
      for (final locale in AppLocalizations.supportedLocales)
        locale.languageCode,
    });

/// Saves the app language on the account, so sign-in emails come in it.
/// Runs on sign-in and on every language change.
@Riverpod(keepAlive: true)
Future<void> accountLanguageSync(Ref ref) async {
  final signedIn = ref.watch(signedInProvider).value ?? false;
  final language = ref.watch(appLanguageProvider);
  if (signedIn) {
    await ref.read(authRepositoryProvider).saveLanguage(language);
  }
}
