// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'safety_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(blockedUsers)
final blockedUsersProvider = BlockedUsersProvider._();

final class BlockedUsersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UserSummary>>,
          List<UserSummary>,
          FutureOr<List<UserSummary>>
        >
    with
        $FutureModifier<List<UserSummary>>,
        $FutureProvider<List<UserSummary>> {
  BlockedUsersProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'blockedUsersProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$blockedUsersHash();

  @$internal
  @override
  $FutureProviderElement<List<UserSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UserSummary>> create(Ref ref) {
    return blockedUsers(ref);
  }
}

String _$blockedUsersHash() => r'3c45bfb1db54eacd8fc1ddcb5edaa5bcd5876a09';

@ProviderFor(mutedFriends)
final mutedFriendsProvider = MutedFriendsProvider._();

final class MutedFriendsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UserSummary>>,
          List<UserSummary>,
          FutureOr<List<UserSummary>>
        >
    with
        $FutureModifier<List<UserSummary>>,
        $FutureProvider<List<UserSummary>> {
  MutedFriendsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mutedFriendsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mutedFriendsHash();

  @$internal
  @override
  $FutureProviderElement<List<UserSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UserSummary>> create(Ref ref) {
    return mutedFriends(ref);
  }
}

String _$mutedFriendsHash() => r'0029fe7ebe20e62b8a54a5074b7403c741444723';

/// Block, quiet orbit and reports, with the lists and screens they change
/// reloaded afterwards. Kept alive: nothing watches it, and an action must
/// not lose its ref halfway.

@ProviderFor(SafetyActions)
final safetyActionsProvider = SafetyActionsProvider._();

/// Block, quiet orbit and reports, with the lists and screens they change
/// reloaded afterwards. Kept alive: nothing watches it, and an action must
/// not lose its ref halfway.
final class SafetyActionsProvider
    extends $NotifierProvider<SafetyActions, void> {
  /// Block, quiet orbit and reports, with the lists and screens they change
  /// reloaded afterwards. Kept alive: nothing watches it, and an action must
  /// not lose its ref halfway.
  SafetyActionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'safetyActionsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$safetyActionsHash();

  @$internal
  @override
  SafetyActions create() => SafetyActions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$safetyActionsHash() => r'93b10f8e0479e6532e7a5f397547403e17125243';

/// Block, quiet orbit and reports, with the lists and screens they change
/// reloaded afterwards. Kept alive: nothing watches it, and an action must
/// not lose its ref halfway.

abstract class _$SafetyActions extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
