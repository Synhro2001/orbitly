// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'my_planet_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Создана ли у пользователя планета. От этого зависит, куда ведёт роутер.
/// Пересчитывается при входе и выходе.

@ProviderFor(hasPlanet)
final hasPlanetProvider = HasPlanetProvider._();

/// Создана ли у пользователя планета. От этого зависит, куда ведёт роутер.
/// Пересчитывается при входе и выходе.

final class HasPlanetProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Создана ли у пользователя планета. От этого зависит, куда ведёт роутер.
  /// Пересчитывается при входе и выходе.
  HasPlanetProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'hasPlanetProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$hasPlanetHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return hasPlanet(ref);
  }
}

String _$hasPlanetHash() => r'918f2e3b7409ec3bc21c392b2dd645b441812801';

/// Моя тень — нужна везде, где считается серия с другом.

@ProviderFor(myShadow)
final myShadowProvider = MyShadowProvider._();

/// Моя тень — нужна везде, где считается серия с другом.

final class MyShadowProvider
    extends $FunctionalProvider<Shadow?, Shadow?, Shadow?>
    with $Provider<Shadow?> {
  /// Моя тень — нужна везде, где считается серия с другом.
  MyShadowProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myShadowProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myShadowHash();

  @$internal
  @override
  $ProviderElement<Shadow?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Shadow? create(Ref ref) {
    return myShadow(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Shadow? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Shadow?>(value),
    );
  }
}

String _$myShadowHash() => r'aaac8cab4988dddcfae543b42ec4d751831a8b6f';

@ProviderFor(MyPlanetController)
final myPlanetControllerProvider = MyPlanetControllerProvider._();

final class MyPlanetControllerProvider
    extends $AsyncNotifierProvider<MyPlanetController, MyPlanet> {
  MyPlanetControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myPlanetControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myPlanetControllerHash();

  @$internal
  @override
  MyPlanetController create() => MyPlanetController();
}

String _$myPlanetControllerHash() =>
    r'57490821fb830f262163c82522d1fc77645d7338';

abstract class _$MyPlanetController extends $AsyncNotifier<MyPlanet> {
  FutureOr<MyPlanet> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<MyPlanet>, MyPlanet>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<MyPlanet>, MyPlanet>,
              AsyncValue<MyPlanet>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
