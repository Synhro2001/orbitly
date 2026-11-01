import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/app/app.dart';
import 'package:orbitly/app/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  if (!Env.useMocks) {
    WidgetsFlutterBinding.ensureInitialized();
    await Supabase.initialize(
      url: Env.supabaseUrl,
      publishableKey: Env.supabasePublishableKey,
    );
  }
  runApp(const ProviderScope(child: OrbitlyApp()));
}
