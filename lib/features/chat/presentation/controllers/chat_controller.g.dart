// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'chat_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(chats)
final chatsProvider = ChatsProvider._();

final class ChatsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ChatPreview>>,
          List<ChatPreview>,
          FutureOr<List<ChatPreview>>
        >
    with
        $FutureModifier<List<ChatPreview>>,
        $FutureProvider<List<ChatPreview>> {
  ChatsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatsHash();

  @$internal
  @override
  $FutureProviderElement<List<ChatPreview>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ChatPreview>> create(Ref ref) {
    return chats(ref);
  }
}

String _$chatsHash() => r'1275409f18af9e1ca58e97f4a72da3c0f7ec7cd9';

@ProviderFor(ChatController)
final chatControllerProvider = ChatControllerFamily._();

final class ChatControllerProvider
    extends $AsyncNotifierProvider<ChatController, ChatThread> {
  ChatControllerProvider._({
    required ChatControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'chatControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$chatControllerHash();

  @override
  String toString() {
    return r'chatControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChatController create() => ChatController();

  @override
  bool operator ==(Object other) {
    return other is ChatControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$chatControllerHash() => r'6653fba42770364acff3c1089c6d2aa901ffabbb';

final class ChatControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ChatController,
          AsyncValue<ChatThread>,
          ChatThread,
          FutureOr<ChatThread>,
          String
        > {
  ChatControllerFamily._()
    : super(
        retry: null,
        name: r'chatControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ChatControllerProvider call(String friendId) =>
      ChatControllerProvider._(argument: friendId, from: this);

  @override
  String toString() => r'chatControllerProvider';
}

abstract class _$ChatController extends $AsyncNotifier<ChatThread> {
  late final _$args = ref.$arg as String;
  String get friendId => _$args;

  FutureOr<ChatThread> build(String friendId);
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ChatThread>, ChatThread>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ChatThread>, ChatThread>,
              AsyncValue<ChatThread>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, () => build(_$args));
  }
}
