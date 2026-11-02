// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'language_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The language the user picked in the settings.

@ProviderFor(LanguageController)
final languageControllerProvider = LanguageControllerProvider._();

/// The language the user picked in the settings.
final class LanguageControllerProvider
    extends $NotifierProvider<LanguageController, AppLanguage> {
  /// The language the user picked in the settings.
  LanguageControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'languageControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$languageControllerHash();

  @$internal
  @override
  LanguageController create() => LanguageController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLanguage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLanguage>(value),
    );
  }
}

String _$languageControllerHash() =>
    r'1e2fa53d2249274ab8ba3a2db9c6192457957ac9';

/// The language the user picked in the settings.

abstract class _$LanguageController extends $Notifier<AppLanguage> {
  AppLanguage build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AppLanguage, AppLanguage>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AppLanguage, AppLanguage>,
              AppLanguage,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The phone's languages, most wanted first. OrbitlyApp refreshes this when
/// they change in the system settings.

@ProviderFor(phoneLanguages)
final phoneLanguagesProvider = PhoneLanguagesProvider._();

/// The phone's languages, most wanted first. OrbitlyApp refreshes this when
/// they change in the system settings.

final class PhoneLanguagesProvider
    extends $FunctionalProvider<List<String>, List<String>, List<String>>
    with $Provider<List<String>> {
  /// The phone's languages, most wanted first. OrbitlyApp refreshes this when
  /// they change in the system settings.
  PhoneLanguagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'phoneLanguagesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$phoneLanguagesHash();

  @$internal
  @override
  $ProviderElement<List<String>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<String> create(Ref ref) {
    return phoneLanguages(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$phoneLanguagesHash() => r'aefcdb0291e324602b6041773e1d4a1923759620';

/// The language the app is shown in: the user's pick, or the phone's.
/// The one place that decides it.

@ProviderFor(appLanguage)
final appLanguageProvider = AppLanguageProvider._();

/// The language the app is shown in: the user's pick, or the phone's.
/// The one place that decides it.

final class AppLanguageProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// The language the app is shown in: the user's pick, or the phone's.
  /// The one place that decides it.
  AppLanguageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLanguageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLanguageHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return appLanguage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$appLanguageHash() => r'4c577736ac7dc620dc8fc2054e885a880ad3ac8d';

/// Saves the app language on the account, so sign-in emails come in it.
/// Runs on sign-in and on every language change.

@ProviderFor(accountLanguageSync)
final accountLanguageSyncProvider = AccountLanguageSyncProvider._();

/// Saves the app language on the account, so sign-in emails come in it.
/// Runs on sign-in and on every language change.

final class AccountLanguageSyncProvider
    extends $FunctionalProvider<AsyncValue<void>, void, FutureOr<void>>
    with $FutureModifier<void>, $FutureProvider<void> {
  /// Saves the app language on the account, so sign-in emails come in it.
  /// Runs on sign-in and on every language change.
  AccountLanguageSyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'accountLanguageSyncProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$accountLanguageSyncHash();

  @$internal
  @override
  $FutureProviderElement<void> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<void> create(Ref ref) {
    return accountLanguageSync(ref);
  }
}

String _$accountLanguageSyncHash() =>
    r'e6b5ea07d3660af50a5bd7d58dba9d138b7733f6';
