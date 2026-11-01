// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'achievements_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AchievementsController)
final achievementsControllerProvider = AchievementsControllerProvider._();

final class AchievementsControllerProvider
    extends $AsyncNotifierProvider<AchievementsController, List<Award>> {
  AchievementsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'achievementsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$achievementsControllerHash();

  @$internal
  @override
  AchievementsController create() => AchievementsController();
}

String _$achievementsControllerHash() =>
    r'd36254de24d7bbed33e54ba9b24dd043aeca956d';

abstract class _$AchievementsController extends $AsyncNotifier<List<Award>> {
  FutureOr<List<Award>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Award>>, List<Award>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Award>>, List<Award>>,
              AsyncValue<List<Award>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Открытые, но ещё не показанные достижения — очередь анимаций открытия.

@ProviderFor(pendingUnlocks)
final pendingUnlocksProvider = PendingUnlocksProvider._();

/// Открытые, но ещё не показанные достижения — очередь анимаций открытия.

final class PendingUnlocksProvider
    extends $FunctionalProvider<List<Award>, List<Award>, List<Award>>
    with $Provider<List<Award>> {
  /// Открытые, но ещё не показанные достижения — очередь анимаций открытия.
  PendingUnlocksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pendingUnlocksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pendingUnlocksHash();

  @$internal
  @override
  $ProviderElement<List<Award>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Award> create(Ref ref) {
    return pendingUnlocks(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Award> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Award>>(value),
    );
  }
}

String _$pendingUnlocksHash() => r'b214740a4e2512a82a8bc2427e7a13692ec1831f';

@ProviderFor(OwnedCosmetics)
final ownedCosmeticsProvider = OwnedCosmeticsProvider._();

final class OwnedCosmeticsProvider
    extends $AsyncNotifierProvider<OwnedCosmetics, List<Cosmetic>> {
  OwnedCosmeticsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ownedCosmeticsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ownedCosmeticsHash();

  @$internal
  @override
  OwnedCosmetics create() => OwnedCosmetics();
}

String _$ownedCosmeticsHash() => r'2aafb4c9db082a973877d41d8a6f39024e6c6f05';

abstract class _$OwnedCosmetics extends $AsyncNotifier<List<Cosmetic>> {
  FutureOr<List<Cosmetic>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Cosmetic>>, List<Cosmetic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Cosmetic>>, List<Cosmetic>>,
              AsyncValue<List<Cosmetic>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Новые открытия с сервера (Realtime). Слушатель перечитывает каталог,
/// косметику и планету — из них и складывается очередь анимаций.

@ProviderFor(achievementUnlocks)
final achievementUnlocksProvider = AchievementUnlocksProvider._();

/// Новые открытия с сервера (Realtime). Слушатель перечитывает каталог,
/// косметику и планету — из них и складывается очередь анимаций.

final class AchievementUnlocksProvider
    extends $FunctionalProvider<AsyncValue<String>, String, Stream<String>>
    with $FutureModifier<String>, $StreamProvider<String> {
  /// Новые открытия с сервера (Realtime). Слушатель перечитывает каталог,
  /// косметику и планету — из них и складывается очередь анимаций.
  AchievementUnlocksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'achievementUnlocksProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$achievementUnlocksHash();

  @$internal
  @override
  $StreamProviderElement<String> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<String> create(Ref ref) {
    return achievementUnlocks(ref);
  }
}

String _$achievementUnlocksHash() =>
    r'860d4a78019fc7d12f123349e844ca2f73028b84';
