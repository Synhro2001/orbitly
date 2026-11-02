import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:orbitly/app/app.dart';
import 'package:orbitly/app/env.dart';
import 'package:orbitly/core/data/network/timeout_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  if (!Env.useMocks) {
    WidgetsFlutterBinding.ensureInitialized();
    await Supabase.initialize(
      url: Env.supabaseUrl,
      publishableKey: Env.supabasePublishableKey,
      httpClient: TimeoutClient(http.Client()),
    );
  }
  runApp(const ProviderScope(child: OrbitlyApp()));
}
