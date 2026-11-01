// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'friends_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userSearch)
final userSearchProvider = UserSearchFamily._();

final class UserSearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<UserSummary>>,
          List<UserSummary>,
          FutureOr<List<UserSummary>>
        >
    with
        $FutureModifier<List<UserSummary>>,
        $FutureProvider<List<UserSummary>> {
  UserSearchProvider._({
    required UserSearchFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userSearchHash();

  @override
  String toString() {
    return r'userSearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<UserSummary>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<UserSummary>> create(Ref ref) {
    final argument = this.argument as String;
    return userSearch(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is UserSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userSearchHash() => r'05f97a856932f5c57659b5bec44c2650e5f4b60b';

final class UserSearchFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<UserSummary>>, String> {
  UserSearchFamily._()
    : super(
        retry: null,
        name: r'userSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserSearchProvider call(String query) =>
      UserSearchProvider._(argument: query, from: this);

  @override
  String toString() => r'userSearchProvider';
}

@ProviderFor(inviteLink)
final inviteLinkProvider = InviteLinkProvider._();

final class InviteLinkProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  InviteLinkProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'inviteLinkProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$inviteLinkHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return inviteLink(ref);
  }
}

String _$inviteLinkHash() => r'b794d678357d25a057f44c63219cf18915ffd7aa';

/// Кому из найденных уже отправлена заявка.

@ProviderFor(SentRequests)
final sentRequestsProvider = SentRequestsProvider._();

/// Кому из найденных уже отправлена заявка.
final class SentRequestsProvider
    extends $NotifierProvider<SentRequests, Set<String>> {
  /// Кому из найденных уже отправлена заявка.
  SentRequestsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sentRequestsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sentRequestsHash();

  @$internal
  @override
  SentRequests create() => SentRequests();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$sentRequestsHash() => r'b191a591fedd2d02cecd7734a5a3df106632644e';

/// Кому из найденных уже отправлена заявка.

abstract class _$SentRequests extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Set<String>, Set<String>>,
              Set<String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(IncomingRequests)
final incomingRequestsProvider = IncomingRequestsProvider._();

final class IncomingRequestsProvider
    extends $AsyncNotifierProvider<IncomingRequests, List<FriendRequest>> {
  IncomingRequestsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incomingRequestsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incomingRequestsHash();

  @$internal
  @override
  IncomingRequests create() => IncomingRequests();
}

String _$incomingRequestsHash() => r'61a79f70f8a786bf1e27a9930f4f171b360c698a';

abstract class _$IncomingRequests extends $AsyncNotifier<List<FriendRequest>> {
  FutureOr<List<FriendRequest>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<FriendRequest>>, List<FriendRequest>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FriendRequest>>, List<FriendRequest>>,
              AsyncValue<List<FriendRequest>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
