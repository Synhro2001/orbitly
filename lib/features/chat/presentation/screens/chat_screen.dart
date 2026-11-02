import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/domain/entities/friend.dart';
import 'package:orbitly/core/domain/entities/shadow.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/async_view.dart';
import 'package:orbitly/core/widgets/content_viewer.dart';
import 'package:orbitly/core/widgets/planet_disc.dart';
import 'package:orbitly/core/widgets/streak_badge.dart';
import 'package:orbitly/features/chat/domain/entities/chat.dart';
import 'package:orbitly/features/chat/domain/entities/message.dart';
import 'package:orbitly/features/chat/presentation/controllers/chat_controller.dart';
import 'package:orbitly/features/chat/presentation/widgets/chat_composer.dart';
import 'package:orbitly/features/chat/presentation/widgets/chat_header.dart';
import 'package:orbitly/features/chat/presentation/widgets/conversation_openers.dart';
import 'package:orbitly/features/chat/presentation/widgets/message_bubbles.dart';
import 'package:orbitly/features/planet/presentation/controllers/my_planet_controller.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({required this.friendId, super.key});

  final String friendId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = chatControllerProvider(friendId);
    final controller = ref.read(provider.notifier);
    final myShadow = ref.watch(myShadowProvider);
    final thread = ref.watch(provider);
    final friend = thread.value?.friend;
    final shadows = [?friend?.shadow, ?myShadow];

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: friend == null
            ? null
            : _AppBarTitle(friend: friend, shadows: shadows),
      ),
      body: AsyncView(
        value: thread,
        onRetry: () => ref.invalidate(provider),
        builder: (thread) => Column(
          children: [
            Expanded(
              child: _MessageList(thread: thread, shadows: shadows),
            ),
            ChatComposer(
              starters: thread.suggestOpeners
                  ? conversationOpeners(context.l10n, thread.friend.name)
                  : const [],
              onSend: controller.send,
              onSendCapsule: controller.sendCapsule,
              onCamera: () => context.push(AppRoutes.camera),
            ),
          ],
        ),
      ),
    );
  }
}

/// Compact header: you always see who you are talking to, even after the
/// friend card has scrolled up with the history.
class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle({required this.friend, required this.shadows});

  final Friend friend;
  final List<Shadow> shadows;

  static const _planetSize = 36.0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      children: [
        PlanetDisc(appearance: friend.appearance, diameter: _planetSize),
        const SizedBox(width: AppSpacing.m),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${friend.name} ${friend.mood?.emoji() ?? ''}'.trim(),
                style: textTheme.titleMedium,
                overflow: TextOverflow.ellipsis,
              ),
              StreakBadge(
                streak: friend.streak,
                shadows: shadows,
                compact: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Conversation from the bottom up; the topmost item is the friend card.
class _MessageList extends ConsumerWidget {
  const _MessageList({required this.thread, required this.shadows});

  final ChatThread thread;
  final List<Shadow> shadows;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = thread.messages.reversed.toList();
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.all(AppSpacing.l),
      itemCount: messages.length + 1,
      itemBuilder: (context, i) {
        if (i == messages.length) {
          return ChatHeader(
            friend: thread.friend,
            trophies: thread.sharedTrophies,
            shadows: shadows,
          );
        }
        return switch (messages[i]) {
          final TextMessage m => TextBubble(m),
          final SnapMessage m => SnapTile(
            message: m,
            onOpen: () async {
              final l10n = context.l10n;
              final controller = ref.read(
                chatControllerProvider(thread.friend.id).notifier,
              );
              await showContentViewer(
                context,
                title: l10n.chatSnapFrom(thread.friend.name),
              );
              await controller.openSnap(m.id);
            },
          ),
          final CapsuleMessage m => CapsuleBubble(m),
        };
      },
    );
  }
}
