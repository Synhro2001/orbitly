// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: document_ignores, lines_longer_than_80_chars, unnecessary_null_checks, specify_nonobvious_property_types

part of 'chat_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// От кого только что пришло сообщение (Realtime). Подписка привязана к
/// пользователю и переподключается после повторного входа.

@ProviderFor(incomingMessages)
final incomingMessagesProvider = IncomingMessagesProvider._();

/// От кого только что пришло сообщение (Realtime). Подписка привязана к
/// пользователю и переподключается после повторного входа.

final class IncomingMessagesProvider
    extends $FunctionalProvider<AsyncValue<String>, String, Stream<String>>
    with $FutureModifier<String>, $StreamProvider<String> {
  /// От кого только что пришло сообщение (Realtime). Подписка привязана к
  /// пользователю и переподключается после повторного входа.
  IncomingMessagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'incomingMessagesProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$incomingMessagesHash();

  @$internal
  @override
  $StreamProviderElement<String> $createElement($ProviderPointer pointer) =>
      $StreamProviderElement(pointer);

  @override
  Stream<String> create(Ref ref) {
    return incomingMessages(ref);
  }
}

String _$incomingMessagesHash() => r'f2121897ecf2f601dc8ec70017f7a2cee1aa4dbe';

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

String _$chatsHash() => r'29f1980a6d684b5f6265a8502cceb05e7c74be00';

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

String _$chatControllerHash() => r'6d31b7e2cd3ac6f8423cbfd3384e0a667dbab3a9';

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
