// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'camera_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The phone's cameras. Empty where there are none or the plugin is missing
/// (tests, some emulators); the camera screen then says so.

@ProviderFor(deviceCameras)
final deviceCamerasProvider = DeviceCamerasProvider._();

/// The phone's cameras. Empty where there are none or the plugin is missing
/// (tests, some emulators); the camera screen then says so.

final class DeviceCamerasProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CameraDescription>>,
          List<CameraDescription>,
          FutureOr<List<CameraDescription>>
        >
    with
        $FutureModifier<List<CameraDescription>>,
        $FutureProvider<List<CameraDescription>> {
  /// The phone's cameras. Empty where there are none or the plugin is missing
  /// (tests, some emulators); the camera screen then says so.
  DeviceCamerasProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceCamerasProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceCamerasHash();

  @$internal
  @override
  $FutureProviderElement<List<CameraDescription>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CameraDescription>> create(Ref ref) {
    return deviceCameras(ref);
  }
}

String _$deviceCamerasHash() => r'd86b2745eeefd626872fefb2235c4c00c04e0b30';
