import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/core/data/supabase/secure_session_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Where earlier versions kept the session (app preferences).
class _OldStorage extends LocalStorage {
  _OldStorage([this.session]);

  String? session;

  @override
  Future<void> initialize() async {}

  @override
  Future<bool> hasAccessToken() async => session != null;

  @override
  Future<String?> accessToken() async => session;

  @override
  Future<void> removePersistedSession() async => session = null;

  @override
  Future<void> persistSession(String persistSessionString) async =>
      session = persistSessionString;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const key = 'sb-orbitly-auth-token';

  setUp(() => FlutterSecureStorage.setMockInitialValues({}));

  test('the key matches the one Supabase uses', () {
    expect(
      SecureSessionStorage.keyFor('https://abcd1234.supabase.co'),
      'sb-abcd1234-auth-token',
    );
  });

  test('a session from an earlier version moves over once', () async {
    final old = _OldStorage('{"access_token":"a"}');
    final storage = SecureSessionStorage(key: key, legacy: old);
    await storage.initialize();

    expect(await storage.accessToken(), '{"access_token":"a"}');
    // Gone from the plain storage, so it is not readable there any more.
    expect(old.session, isNull);
  });

  test('a newer secure session is not overwritten by an old one', () async {
    FlutterSecureStorage.setMockInitialValues({key: 'new'});
    final old = _OldStorage('old');
    final storage = SecureSessionStorage(key: key, legacy: old);
    await storage.initialize();

    expect(await storage.accessToken(), 'new');
    expect(old.session, isNull);
  });

  test('saves, reads and removes the session', () async {
    final storage = SecureSessionStorage(key: key);
    await storage.initialize();
    expect(await storage.hasAccessToken(), isFalse);

    await storage.persistSession('session');
    expect(await storage.hasAccessToken(), isTrue);
    expect(await storage.accessToken(), 'session');

    await storage.removePersistedSession();
    expect(await storage.hasAccessToken(), isFalse);
  });
}
