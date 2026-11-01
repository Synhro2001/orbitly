// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'system_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SystemController)
final systemControllerProvider = SystemControllerProvider._();

final class SystemControllerProvider
    extends $AsyncNotifierProvider<SystemController, SystemData> {
  SystemControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'systemControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$systemControllerHash();

  @$internal
  @override
  SystemController create() => SystemController();
}

String _$systemControllerHash() => r'78d35f28004d942913513402f898b566a0f5b9d8';

abstract class _$SystemController extends $AsyncNotifier<SystemData> {
  FutureOr<SystemData> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SystemData>, SystemData>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<SystemData>, SystemData>,
              AsyncValue<SystemData>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
