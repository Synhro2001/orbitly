import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:orbitly/app/app.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/app/env.dart';
import 'package:orbitly/core/data/network/timeout_client.dart';
import 'package:orbitly/features/settings/data/repositories/prefs_settings_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final settings = await PrefsSettingsRepository.open();
  if (!Env.useMocks) {
    await Supabase.initialize(
      url: Env.supabaseUrl,
      publishableKey: Env.supabasePublishableKey,
      httpClient: TimeoutClient(http.Client()),
    );
  }
  runApp(
    ProviderScope(
      overrides: [settingsRepositoryProvider.overrideWithValue(settings)],
      child: const OrbitlyApp(),
    ),
  );
}
