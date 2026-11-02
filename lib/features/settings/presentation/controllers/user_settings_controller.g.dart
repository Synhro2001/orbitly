// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'user_settings_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Account settings. Changes apply at once, without a "Save" button.

@ProviderFor(UserSettingsController)
final userSettingsControllerProvider = UserSettingsControllerProvider._();

/// Account settings. Changes apply at once, without a "Save" button.
final class UserSettingsControllerProvider
    extends $AsyncNotifierProvider<UserSettingsController, UserSettings> {
  /// Account settings. Changes apply at once, without a "Save" button.
  UserSettingsControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userSettingsControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userSettingsControllerHash();

  @$internal
  @override
  UserSettingsController create() => UserSettingsController();
}

String _$userSettingsControllerHash() =>
    r'6aa89fa86de8f7f32ff6e1b967d7cd9e90b51854';

/// Account settings. Changes apply at once, without a "Save" button.

abstract class _$UserSettingsController extends $AsyncNotifier<UserSettings> {
  FutureOr<UserSettings> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UserSettings>, UserSettings>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserSettings>, UserSettings>,
              AsyncValue<UserSettings>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
