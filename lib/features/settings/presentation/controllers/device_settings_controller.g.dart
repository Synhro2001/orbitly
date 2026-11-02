// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'device_settings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Settings of this phone: haptics, motion, media.

@ProviderFor(DeviceSettingsController)
final deviceSettingsControllerProvider = DeviceSettingsControllerProvider._();

/// Settings of this phone: haptics, motion, media.
final class DeviceSettingsControllerProvider
    extends $NotifierProvider<DeviceSettingsController, DeviceSettings> {
  /// Settings of this phone: haptics, motion, media.
  DeviceSettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deviceSettingsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deviceSettingsControllerHash();

  @$internal
  @override
  DeviceSettingsController create() => DeviceSettingsController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DeviceSettings value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DeviceSettings>(value),
    );
  }
}

String _$deviceSettingsControllerHash() =>
    r'93644fae4a642cffd707dccfb1a16979af420bb6';

/// Settings of this phone: haptics, motion, media.

abstract class _$DeviceSettingsController extends $Notifier<DeviceSettings> {
  DeviceSettings build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<DeviceSettings, DeviceSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DeviceSettings, DeviceSettings>,
              DeviceSettings,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
