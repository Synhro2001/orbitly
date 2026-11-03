import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:orbitly/app/app.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/app/env.dart';
import 'package:orbitly/core/data/network/timeout_client.dart';
import 'package:orbitly/core/data/supabase/secure_session_storage.dart';
import 'package:orbitly/features/settings/data/repositories/prefs_settings_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = await PrefsSettingsRepository.open();
  if (!Env.useMocks) {
    final sessionKey = SecureSessionStorage.keyFor(Env.supabaseUrl);
    await Supabase.initialize(
      url: Env.supabaseUrl,
      publishableKey: Env.supabasePublishableKey,
      httpClient: TimeoutClient(http.Client()),
      // Phones keep the session in Keystore / Keychain. The web has no such
      // storage, so it keeps Supabase's default.
      authOptions: kIsWeb
          ? const FlutterAuthClientOptions()
          : FlutterAuthClientOptions(
              localStorage: SecureSessionStorage(
                key: sessionKey,
                legacy: SharedPreferencesLocalStorage(
                  persistSessionKey: sessionKey,
                ),
              ),
            ),
    );
  }
  runApp(
    ProviderScope(
      overrides: [settingsRepositoryProvider.overrideWithValue(settings)],
      child: const OrbitlyApp(),
    ),
  );
}
