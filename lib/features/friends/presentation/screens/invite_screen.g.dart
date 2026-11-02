// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'invite_screen.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(invite)
final inviteProvider = InviteFamily._();

final class InviteProvider
    extends
        $FunctionalProvider<
          AsyncValue<UserSummary?>,
          UserSummary?,
          FutureOr<UserSummary?>
        >
    with $FutureModifier<UserSummary?>, $FutureProvider<UserSummary?> {
  InviteProvider._({
    required InviteFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'inviteProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$inviteHash();

  @override
  String toString() {
    return r'inviteProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<UserSummary?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<UserSummary?> create(Ref ref) {
    final argument = this.argument as String;
    return invite(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is InviteProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$inviteHash() => r'6197cb9d113e65261730962b5edef9fc40d3f239';

final class InviteFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<UserSummary?>, String> {
  InviteFamily._()
    : super(
        retry: null,
        name: r'inviteProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  InviteProvider call(String code) =>
      InviteProvider._(argument: code, from: this);

  @override
  String toString() => r'inviteProvider';
}
