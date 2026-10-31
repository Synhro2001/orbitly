import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/friend.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/async_view.dart';
import 'package:orbitly/core/widgets/content_viewer.dart';
import 'package:orbitly/core/widgets/planet_view.dart';
import 'package:orbitly/core/widgets/streak_badge.dart';
import 'package:orbitly/features/chat/domain/entities/chat.dart';
import 'package:orbitly/features/chat/domain/entities/message.dart';
import 'package:orbitly/features/chat/presentation/controllers/chat_controller.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({required this.friendId, super.key});

  final String friendId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = chatControllerProvider(friendId);
    return Scaffold(
      appBar: AppBar(),
      body: AsyncView(
        value: ref.watch(provider),
        onRetry: () => ref.invalidate(provider),
        builder: (thread) => Column(
          children: [
            _ChatHeader(friend: thread.friend, trophies: thread.sharedTrophies),
            const Divider(height: 1),
            Expanded(child: _MessageList(thread: thread)),
            _Composer(
              onSend: ref.read(provider.notifier).send,
              onCamera: () => context.push(AppRoutes.camera),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  const _ChatHeader({required this.friend, required this.trophies});

  final Friend friend;
  final List<Award> trophies;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.l,
        0,
        AppSpacing.l,
        AppSpacing.m,
      ),
      child: Column(
        children: [
          PlanetView(
            appearance: friend.appearance,
            size: AppSizes.chatHeaderPlanet,
          ),
          Text(
            '${friend.name} ${friend.mood.emoji()}',
            style: textTheme.titleLarge,
          ),
          Text('@${friend.handle}', style: textTheme.bodySmall),
          const SizedBox(height: AppSpacing.s),
          StreakBadge(streak: friend.streak),
          if (trophies.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.m),
            Text(l10n.chatSharedTrophies, style: textTheme.labelSmall),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.s,
              children: [
                for (final trophy in trophies)
                  Tooltip(
                    message: trophy.title,
                    child: Text(trophy.emoji, style: textTheme.titleLarge),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _MessageList extends ConsumerWidget {
  const _MessageList({required this.thread});

  final ChatThread thread;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = thread.messages.reversed.toList();
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.all(AppSpacing.l),
      itemCount: messages.length,
      itemBuilder: (context, i) => switch (messages[i]) {
        final TextMessage m => _TextBubble(m),
        final SnapMessage m => _SnapTile(
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
      },
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.isMine,
    required this.child,
    this.color,
    this.border,
  });

  final bool isMine;
  final Widget child;
  final Color? color;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.75,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.m,
            vertical: AppSpacing.s,
          ),
          decoration: BoxDecoration(
            color: color,
            border: border,
            borderRadius: BorderRadius.circular(AppRadii.l),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _TextBubble extends StatelessWidget {
  const _TextBubble(this.message);

  final TextMessage message;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium;
    return _Bubble(
      isMine: message.isMine,
      color: message.isMine ? AppColors.sun : AppColors.surfaceHigh,
      child: Text(
        message.text,
        style: message.isMine ? style?.copyWith(color: AppColors.onSun) : style,
      ),
    );
  }
}

class _SnapTile extends StatelessWidget {
  const _SnapTile({required this.message, required this.onOpen});

  final SnapMessage message;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final canOpen = !message.isMine && !message.opened;
    final (icon, label, color) = switch ((message.isMine, message.opened)) {
      (true, _) => (Icons.send_rounded, l10n.chatSnapSent, AppColors.textMuted),
      (false, true) => (
        Icons.crop_square_rounded,
        l10n.chatSnapOpened,
        AppColors.textMuted,
      ),
      (false, false) => (
        Icons.square_rounded,
        l10n.chatSnapTapToView,
        AppColors.mint,
      ),
    };
    return _Bubble(
      isMine: message.isMine,
      border: Border.all(color: color),
      child: InkWell(
        onTap: canOpen ? onOpen : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: AppSpacing.l, color: color),
            const SizedBox(width: AppSpacing.s),
            Flexible(
              child: Text(
                label,
                style: textTheme.labelLarge?.copyWith(color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Composer extends StatefulWidget {
  const _Composer({required this.onSend, required this.onCamera});

  final Future<void> Function(String text) onSend;
  final VoidCallback onCamera;

  @override
  State<_Composer> createState() => _ComposerState();
}

class _ComposerState extends State<_Composer> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _controller.text;
    if (text.trim().isEmpty) return;
    _controller.clear();
    await widget.onSend(text);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s),
        child: Row(
          children: [
            IconButton(
              tooltip: l10n.navCamera,
              onPressed: widget.onCamera,
              icon: const Icon(Icons.photo_camera_rounded),
            ),
            Expanded(
              child: TextField(
                controller: _controller,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _send(),
                decoration: InputDecoration(hintText: l10n.chatMessageHint),
              ),
            ),
            IconButton(
              tooltip: l10n.chatSend,
              onPressed: _send,
              color: AppColors.sun,
              icon: const Icon(Icons.send_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
