import 'package:orbitly/app/env.dart';
import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/features/achievements/data/repositories/mock_achievements_repository.dart';
import 'package:orbitly/features/achievements/data/repositories/supabase_achievements_repository.dart';
import 'package:orbitly/features/achievements/domain/repositories/achievements_repository.dart';
import 'package:orbitly/features/auth/data/repositories/mock_auth_repository.dart';
import 'package:orbitly/features/auth/data/repositories/supabase_auth_repository.dart';
import 'package:orbitly/features/auth/domain/repositories/auth_repository.dart';
import 'package:orbitly/features/chat/data/repositories/mock_chat_repository.dart';
import 'package:orbitly/features/chat/data/repositories/supabase_chat_repository.dart';
import 'package:orbitly/features/chat/domain/repositories/chat_repository.dart';
import 'package:orbitly/features/friends/data/repositories/mock_friends_repository.dart';
import 'package:orbitly/features/friends/data/repositories/supabase_friends_repository.dart';
import 'package:orbitly/features/friends/domain/repositories/friends_repository.dart';
import 'package:orbitly/features/planet/data/repositories/mock_planet_repository.dart';
import 'package:orbitly/features/planet/data/repositories/supabase_planet_repository.dart';
import 'package:orbitly/features/planet/domain/repositories/planet_repository.dart';
import 'package:orbitly/features/report/data/repositories/mock_report_repository.dart';
import 'package:orbitly/features/report/domain/repositories/report_repository.dart';
import 'package:orbitly/features/settings/data/repositories/in_memory_settings_repository.dart';
import 'package:orbitly/features/settings/domain/repositories/settings_repository.dart';
import 'package:orbitly/features/system/data/repositories/mock_system_repository.dart';
import 'package:orbitly/features/system/data/repositories/supabase_system_repository.dart';
import 'package:orbitly/features/system/domain/repositories/system_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'di.g.dart';

// The only place where the UI is wired to repository implementations.
// USE_MOCKS (see env.dart) switches between mocks and Supabase. The weekly
// report is still mock-only: it needs data the server does not collect yet.

@Riverpod(keepAlive: true)
bool useMocks(Ref ref) => Env.useMocks;

@Riverpod(keepAlive: true)
MockStore mockStore(Ref ref) => MockStore(withNewUnlock: true);

/// Settings on this phone. main() puts in the real storage; tests keep them
/// in memory.
@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) => InMemorySettingsRepository();

/// Supabase client. Initialised in main() only when mocks are off.
@Riverpod(keepAlive: true)
SupabaseClient supabaseClient(Ref ref) => Supabase.instance.client;

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) => ref.watch(useMocksProvider)
    ? const MockAuthRepository()
    : SupabaseAuthRepository(ref.watch(supabaseClientProvider).auth);

@Riverpod(keepAlive: true)
SystemRepository systemRepository(Ref ref) => ref.watch(useMocksProvider)
    ? MockSystemRepository(ref.watch(mockStoreProvider))
    : SupabaseSystemRepository(ref.watch(supabaseClientProvider));

@Riverpod(keepAlive: true)
PlanetRepository planetRepository(Ref ref) => ref.watch(useMocksProvider)
    ? MockPlanetRepository(ref.watch(mockStoreProvider))
    : SupabasePlanetRepository(ref.watch(supabaseClientProvider));

@Riverpod(keepAlive: true)
FriendsRepository friendsRepository(Ref ref) => ref.watch(useMocksProvider)
    ? MockFriendsRepository(ref.watch(mockStoreProvider))
    : SupabaseFriendsRepository(ref.watch(supabaseClientProvider));

@Riverpod(keepAlive: true)
AchievementsRepository achievementsRepository(Ref ref) =>
    ref.watch(useMocksProvider)
    ? MockAchievementsRepository(ref.watch(mockStoreProvider))
    : SupabaseAchievementsRepository(ref.watch(supabaseClientProvider));

@Riverpod(keepAlive: true)
ChatRepository chatRepository(Ref ref) => ref.watch(useMocksProvider)
    ? MockChatRepository(ref.watch(mockStoreProvider))
    : SupabaseChatRepository(ref.watch(supabaseClientProvider));

@Riverpod(keepAlive: true)
ReportRepository reportRepository(Ref ref) =>
    MockReportRepository(ref.watch(mockStoreProvider));
