// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'account_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Signing in again within 7 days cancels a requested deletion. True when
/// that has just happened, so the app can say so.

@ProviderFor(deletionCancelled)
final deletionCancelledProvider = DeletionCancelledProvider._();

/// Signing in again within 7 days cancels a requested deletion. True when
/// that has just happened, so the app can say so.

final class DeletionCancelledProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  /// Signing in again within 7 days cancels a requested deletion. True when
  /// that has just happened, so the app can say so.
  DeletionCancelledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'deletionCancelledProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$deletionCancelledHash();

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    return deletionCancelled(ref);
  }
}

String _$deletionCancelledHash() => r'9f9e03a1e2c21b30ebdff25996e43f0eea350877';
