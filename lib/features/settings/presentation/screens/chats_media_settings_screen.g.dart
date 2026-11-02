// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'chats_media_settings_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Bytes the app keeps that can be thrown away: rendered planets and the
/// temporary folder.

@ProviderFor(cacheSize)
final cacheSizeProvider = CacheSizeProvider._();

/// Bytes the app keeps that can be thrown away: rendered planets and the
/// temporary folder.

final class CacheSizeProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Bytes the app keeps that can be thrown away: rendered planets and the
  /// temporary folder.
  CacheSizeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cacheSizeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cacheSizeHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return cacheSize(ref);
  }
}

String _$cacheSizeHash() => r'73d13b68f9c276a5ae2436568ad9a9b22ca8efcc';
