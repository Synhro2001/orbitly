// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'di.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(useMocks)
final useMocksProvider = UseMocksProvider._();

final class UseMocksProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  UseMocksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'useMocksProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$useMocksHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return useMocks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$useMocksHash() => r'ba5eaef9fc0aff0a44ed4dfb10656b3d9d6b5dc7';

@ProviderFor(mockStore)
final mockStoreProvider = MockStoreProvider._();

final class MockStoreProvider
    extends $FunctionalProvider<MockStore, MockStore, MockStore>
    with $Provider<MockStore> {
  MockStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mockStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mockStoreHash();

  @$internal
  @override
  $ProviderElement<MockStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MockStore create(Ref ref) {
    return mockStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MockStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MockStore>(value),
    );
  }
}

String _$mockStoreHash() => r'9725d5bc98b824a97fedb9f4d399c8a80b8fb584';

/// Settings on this phone. main() puts in the real storage; tests keep them
/// in memory.

@ProviderFor(settingsRepository)
final settingsRepositoryProvider = SettingsRepositoryProvider._();

/// Settings on this phone. main() puts in the real storage; tests keep them
/// in memory.

final class SettingsRepositoryProvider
    extends
        $FunctionalProvider<
          SettingsRepository,
          SettingsRepository,
          SettingsRepository
        >
    with $Provider<SettingsRepository> {
  /// Settings on this phone. main() puts in the real storage; tests keep them
  /// in memory.
  SettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<SettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SettingsRepository create(Ref ref) {
    return settingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsRepository>(value),
    );
  }
}

String _$settingsRepositoryHash() =>
    r'bf3155f3ce75bc1dda9c23c339687fc3500504c1';

@ProviderFor(safetyRepository)
final safetyRepositoryProvider = SafetyRepositoryProvider._();

final class SafetyRepositoryProvider
    extends
        $FunctionalProvider<
          SafetyRepository,
          SafetyRepository,
          SafetyRepository
        >
    with $Provider<SafetyRepository> {
  SafetyRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'safetyRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$safetyRepositoryHash();

  @$internal
  @override
  $ProviderElement<SafetyRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SafetyRepository create(Ref ref) {
    return safetyRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SafetyRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SafetyRepository>(value),
    );
  }
}

String _$safetyRepositoryHash() => r'ff740b031e8a22b35cdcd97e131e31232e3afc6b';

@ProviderFor(profileRepository)
final profileRepositoryProvider = ProfileRepositoryProvider._();

final class ProfileRepositoryProvider
    extends
        $FunctionalProvider<
          ProfileRepository,
          ProfileRepository,
          ProfileRepository
        >
    with $Provider<ProfileRepository> {
  ProfileRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'profileRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$profileRepositoryHash();

  @$internal
  @override
  $ProviderElement<ProfileRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ProfileRepository create(Ref ref) {
    return profileRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ProfileRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ProfileRepository>(value),
    );
  }
}

String _$profileRepositoryHash() => r'd722c3789df40bfcaa895f7fcd23630067611fe4';

@ProviderFor(accountRepository)
final accountRepositoryProvider = AccountRepositoryProvider._();

final class AccountRepositoryProvider
    extends
        $FunctionalProvider<
          AccountRepository,
          AccountRepository,
          AccountRepository
        >
    with $Provider<AccountRepository> {
  AccountRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountRepositoryHash();

  @$internal
  @override
  $ProviderElement<AccountRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AccountRepository create(Ref ref) {
    return accountRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AccountRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AccountRepository>(value),
    );
  }
}

String _$accountRepositoryHash() => r'b51100dd2bb8c36a7aeba99cc38f2dac776995a1';

@ProviderFor(feedbackRepository)
final feedbackRepositoryProvider = FeedbackRepositoryProvider._();

final class FeedbackRepositoryProvider
    extends
        $FunctionalProvider<
          FeedbackRepository,
          FeedbackRepository,
          FeedbackRepository
        >
    with $Provider<FeedbackRepository> {
  FeedbackRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'feedbackRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$feedbackRepositoryHash();

  @$internal
  @override
  $ProviderElement<FeedbackRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FeedbackRepository create(Ref ref) {
    return feedbackRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FeedbackRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FeedbackRepository>(value),
    );
  }
}

String _$feedbackRepositoryHash() =>
    r'1416e4833e78e7b5533e9f9fa556a05541510e68';

/// Account settings on the server.

@ProviderFor(userSettingsRepository)
final userSettingsRepositoryProvider = UserSettingsRepositoryProvider._();

/// Account settings on the server.

final class UserSettingsRepositoryProvider
    extends
        $FunctionalProvider<
          UserSettingsRepository,
          UserSettingsRepository,
          UserSettingsRepository
        >
    with $Provider<UserSettingsRepository> {
  /// Account settings on the server.
  UserSettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userSettingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userSettingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<UserSettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  UserSettingsRepository create(Ref ref) {
    return userSettingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserSettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserSettingsRepository>(value),
    );
  }
}

String _$userSettingsRepositoryHash() =>
    r'85973be394cf5d6c0b50696b3d88be3a7fe7f651';

/// Supabase client. Initialised in main() only when mocks are off.

@ProviderFor(supabaseClient)
final supabaseClientProvider = SupabaseClientProvider._();

/// Supabase client. Initialised in main() only when mocks are off.

final class SupabaseClientProvider
    extends $FunctionalProvider<SupabaseClient, SupabaseClient, SupabaseClient>
    with $Provider<SupabaseClient> {
  /// Supabase client. Initialised in main() only when mocks are off.
  SupabaseClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supabaseClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supabaseClientHash();

  @$internal
  @override
  $ProviderElement<SupabaseClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SupabaseClient create(Ref ref) {
    return supabaseClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupabaseClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupabaseClient>(value),
    );
  }
}

String _$supabaseClientHash() => r'3db2a4c212c7f24cea9810e376225aa1a6cab012';

@ProviderFor(authRepository)
final authRepositoryProvider = AuthRepositoryProvider._();

final class AuthRepositoryProvider
    extends $FunctionalProvider<AuthRepository, AuthRepository, AuthRepository>
    with $Provider<AuthRepository> {
  AuthRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authRepositoryHash();

  @$internal
  @override
  $ProviderElement<AuthRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthRepository create(Ref ref) {
    return authRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthRepository>(value),
    );
  }
}

String _$authRepositoryHash() => r'a601503a3b07f41bb0515cfb23c8047b5a33e01f';

@ProviderFor(systemRepository)
final systemRepositoryProvider = SystemRepositoryProvider._();

final class SystemRepositoryProvider
    extends
        $FunctionalProvider<
          SystemRepository,
          SystemRepository,
          SystemRepository
        >
    with $Provider<SystemRepository> {
  SystemRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'systemRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$systemRepositoryHash();

  @$internal
  @override
  $ProviderElement<SystemRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SystemRepository create(Ref ref) {
    return systemRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SystemRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SystemRepository>(value),
    );
  }
}

String _$systemRepositoryHash() => r'8398783b6d1e4205c0c1486b8557a55fc48e346b';

@ProviderFor(planetRepository)
final planetRepositoryProvider = PlanetRepositoryProvider._();

final class PlanetRepositoryProvider
    extends
        $FunctionalProvider<
          PlanetRepository,
          PlanetRepository,
          PlanetRepository
        >
    with $Provider<PlanetRepository> {
  PlanetRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'planetRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$planetRepositoryHash();

  @$internal
  @override
  $ProviderElement<PlanetRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PlanetRepository create(Ref ref) {
    return planetRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlanetRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlanetRepository>(value),
    );
  }
}

String _$planetRepositoryHash() => r'e0ce7f67112f4ae72f4ad451ba6ecf118212ebfd';

@ProviderFor(friendsRepository)
final friendsRepositoryProvider = FriendsRepositoryProvider._();

final class FriendsRepositoryProvider
    extends
        $FunctionalProvider<
          FriendsRepository,
          FriendsRepository,
          FriendsRepository
        >
    with $Provider<FriendsRepository> {
  FriendsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'friendsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$friendsRepositoryHash();

  @$internal
  @override
  $ProviderElement<FriendsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FriendsRepository create(Ref ref) {
    return friendsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FriendsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FriendsRepository>(value),
    );
  }
}

String _$friendsRepositoryHash() => r'b4c4a39f96cda2aece5544d1dd67ff37a7ff47d6';

@ProviderFor(achievementsRepository)
final achievementsRepositoryProvider = AchievementsRepositoryProvider._();

final class AchievementsRepositoryProvider
    extends
        $FunctionalProvider<
          AchievementsRepository,
          AchievementsRepository,
          AchievementsRepository
        >
    with $Provider<AchievementsRepository> {
  AchievementsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'achievementsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$achievementsRepositoryHash();

  @$internal
  @override
  $ProviderElement<AchievementsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AchievementsRepository create(Ref ref) {
    return achievementsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AchievementsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AchievementsRepository>(value),
    );
  }
}

String _$achievementsRepositoryHash() =>
    r'ca613b0a19a27abe56ae58c1436be3a7f5bd2f93';

@ProviderFor(chatRepository)
final chatRepositoryProvider = ChatRepositoryProvider._();

final class ChatRepositoryProvider
    extends $FunctionalProvider<ChatRepository, ChatRepository, ChatRepository>
    with $Provider<ChatRepository> {
  ChatRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatRepositoryHash();

  @$internal
  @override
  $ProviderElement<ChatRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ChatRepository create(Ref ref) {
    return chatRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatRepository>(value),
    );
  }
}

String _$chatRepositoryHash() => r'cb9e20819cfec36a27863044b763c6af302bc535';

@ProviderFor(reportRepository)
final reportRepositoryProvider = ReportRepositoryProvider._();

final class ReportRepositoryProvider
    extends
        $FunctionalProvider<
          ReportRepository,
          ReportRepository,
          ReportRepository
        >
    with $Provider<ReportRepository> {
  ReportRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'reportRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$reportRepositoryHash();

  @$internal
  @override
  $ProviderElement<ReportRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ReportRepository create(Ref ref) {
    return reportRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ReportRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ReportRepository>(value),
    );
  }
}

String _$reportRepositoryHash() => r'8c46c4c354ffdbd027e6eaa6e149a0c99489f067';
