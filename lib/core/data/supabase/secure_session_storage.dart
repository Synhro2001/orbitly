import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Keeps the Supabase session (access and refresh tokens) in the phone's
/// secure storage: Keystore on Android, Keychain on iOS. The default storage
/// is plain app preferences, readable on a rooted phone.
///
/// [legacy] is where earlier versions kept the session. A session found
/// there is moved over once, so updating the app does not sign anyone out.
class SecureSessionStorage extends LocalStorage {
  SecureSessionStorage({
    required this.key,
    this.legacy,
    this.storage = const FlutterSecureStorage(),
  });

  final String key;
  final LocalStorage? legacy;
  final FlutterSecureStorage storage;

  /// The key Supabase itself uses for [url], so the legacy session is found.
  static String keyFor(String url) =>
      'sb-${Uri.parse(url).host.split('.').first}-auth-token';

  @override
  Future<void> initialize() async {
    final legacy = this.legacy;
    if (legacy == null) return;
    await legacy.initialize();
    final old = await legacy.accessToken();
    if (old == null) return;
    if (!await storage.containsKey(key: key)) {
      await storage.write(key: key, value: old);
    }
    await legacy.removePersistedSession();
  }

  @override
  Future<bool> hasAccessToken() => storage.containsKey(key: key);

  @override
  Future<String?> accessToken() => storage.read(key: key);

  @override
  Future<void> removePersistedSession() => storage.delete(key: key);

  @override
  Future<void> persistSession(String persistSessionString) =>
      storage.write(key: key, value: persistSessionString);
}
