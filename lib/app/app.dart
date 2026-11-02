import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/app/router.dart';
import 'package:orbitly/core/theme/app_theme.dart';
import 'package:orbitly/features/settings/presentation/controllers/language_controller.dart';
import 'package:orbitly/l10n/app_localizations.dart';

class OrbitlyApp extends ConsumerStatefulWidget {
  const OrbitlyApp({super.key});

  @override
  ConsumerState<OrbitlyApp> createState() => _OrbitlyAppState();
}

class _OrbitlyAppState extends ConsumerState<OrbitlyApp>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// The user changed the phone's languages while the app was open.
  @override
  void didChangeLocales(List<Locale>? locales) =>
      ref.invalidate(phoneLanguagesProvider);

  @override
  Widget build(BuildContext context) {
    // Keeps the account language in step; errors are not fatal here.
    ref.listen(accountLanguageSyncProvider, (_, _) {});
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      routerConfig: ref.watch(routerProvider),
      locale: Locale(ref.watch(appLanguageProvider)),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
