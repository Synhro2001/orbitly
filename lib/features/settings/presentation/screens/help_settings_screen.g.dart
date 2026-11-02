// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'help_settings_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// "1.0.0 (1)", or empty where the platform cannot tell.

@ProviderFor(appVersion)
final appVersionProvider = AppVersionProvider._();

/// "1.0.0 (1)", or empty where the platform cannot tell.

final class AppVersionProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  /// "1.0.0 (1)", or empty where the platform cannot tell.
  AppVersionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appVersionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appVersionHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return appVersion(ref);
  }
}

String _$appVersionHash() => r'932ac63565bd3ca1e04c539e2b3a3a1a2a4b5de6';

/// Phone model and system, to help reproduce a reported problem.

@ProviderFor(deviceDescription)
final deviceDescriptionProvider = DeviceDescriptionProvider._();

/// Phone model and system, to help reproduce a reported problem.

final class DeviceDescriptionProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  /// Phone model and system, to help reproduce a reported problem.
  DeviceDescriptionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceDescriptionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceDescriptionHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return deviceDescription(ref);
  }
}

String _$deviceDescriptionHash() => r'2f4aba2b8c7a1018d267d1f52194abccb58deb2b';
