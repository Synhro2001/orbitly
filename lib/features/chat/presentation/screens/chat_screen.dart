import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/friend.dart';
import 'package:orbitly/core/domain/entities/shadow.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/clock.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/async_view.dart';
import 'package:orbitly/core/widgets/content_viewer.dart';
import 'package:orbitly/core/widgets/planet_view.dart';
import 'package:orbitly/core/widgets/streak_badge.dart';
import 'package:orbitly/features/chat/domain/entities/chat.dart';
import 'package:orbitly/features/chat/domain/entities/message.dart';
import 'package:orbitly/features/chat/presentation/controllers/chat_controller.dart';
import 'package:orbitly/features/planet/presentation/controllers/my_planet_controller.dart';

class ChatScreen extends ConsumerWidget {
  const ChatScreen({required this.friendId, super.key});

  final String friendId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = chatControllerProvider(friendId);
    final myShadow = ref.watch(myShadowProvider);
    final controller = ref.read(provider.notifier);
    return Scaffold(
      appBar: AppBar(),
      body: AsyncView(
        value: ref.watch(provider),
        onRetry: () => ref.invalidate(provider),
        builder: (thread) => Column(
          children: [
            _ChatHeader(
              friend: thread.friend,
              trophies: thread.sharedTrophies,
              shadows: [?thread.friend.shadow, ?myShadow],
            ),
            const Divider(height: 1),
            Expanded(child: _MessageList(thread: thread)),
            _Composer(
              starters: thread.conversationStarters,
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

class _ChatHeader extends StatelessWidget {
  const _ChatHeader({
    required this.friend,
    required this.trophies,
    required this.shadows,
  });

  final Friend friend;
  final List<Award> trophies;
  final List<Shadow> shadows;

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
          StreakBadge(streak: friend.streak, shadows: shadows),
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
        final CapsuleMessage m => _CapsuleBubble(m),
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

/// Капсула времени. Получатель видит текст только после срока, отправитель
/// — сразу, с отметкой, когда капсула откроется.
class _CapsuleBubble extends ConsumerWidget {
  const _CapsuleBubble(this.message);

  final CapsuleMessage message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final now = ref.watch(clockProvider)();
    final open = message.isOpenAt(now);
    final daysLeft = (message.opensAt.difference(now).inMinutes / (24 * 60))
        .ceil();
    final showText = open || message.isMine;
    return _Bubble(
      isMine: message.isMine,
      color: AppColors.surfaceHigh,
      border: Border.all(color: open ? AppColors.sun : AppColors.outline),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                open ? Icons.hourglass_bottom_rounded : Icons.lock_clock,
                size: AppSpacing.l,
                color: AppColors.sun,
              ),
              const SizedBox(width: AppSpacing.s),
              Flexible(
                child: Text(
                  open ? l10n.chatCapsule : l10n.chatCapsuleOpensIn(daysLeft),
                  style: textTheme.labelMedium?.copyWith(color: AppColors.sun),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            showText ? message.text : l10n.chatCapsuleSealed,
            style: showText
                ? textTheme.bodyMedium
                : textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}

class _Composer extends StatefulWidget {
  const _Composer({
    required this.starters,
    required this.onSend,
    required this.onSendCapsule,
    required this.onCamera,
  });

  final List<String> starters;
  final Future<void> Function(String text) onSend;
  final Future<void> Function(String text, Duration delay) onSendCapsule;
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

  Future<void> _sendCapsule() async {
    final text = _controller.text;
    if (text.trim().isEmpty) return;
    final delay = await showModalBottomSheet<Duration>(
      context: context,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      builder: (_) => const _CapsuleDelaySheet(),
    );
    if (delay == null) return;
    _controller.clear();
    await widget.onSendCapsule(text, delay);
  }

  /// Подставляем подсказку в поле, а не отправляем: её можно дописать.
  void _useStarter(String starter) => _controller
    ..text = starter
    ..selection = TextSelection.collapsed(offset: starter.length);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.starters.isNotEmpty)
              _StarterChips(starters: widget.starters, onTap: _useStarter),
            Row(
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
                // Кнопки активны, только когда есть что отправить.
                ValueListenableBuilder(
                  valueListenable: _controller,
                  builder: (context, value, _) {
                    final hasText = value.text.trim().isNotEmpty;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: l10n.chatCapsule,
                          onPressed: hasText ? _sendCapsule : null,
                          color: AppColors.sun,
                          icon: const Icon(Icons.hourglass_top_rounded),
                        ),
                        IconButton(
                          tooltip: l10n.chatSend,
                          onPressed: hasText ? _send : null,
                          color: AppColors.sun,
                          icon: const Icon(Icons.send_rounded),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// «С чего начать?» — первые фразы для затихшего разговора.
class _StarterChips extends StatelessWidget {
  const _StarterChips({required this.starters, required this.onTap});

  final List<String> starters;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
            child: Text(
              context.l10n.chatStartersTitle,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
            child: Row(
              children: [
                for (final starter in starters)
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.s),
                    child: ActionChip(
                      label: Text(starter),
                      onPressed: () => onTap(starter),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Когда откроется капсула.
class _CapsuleDelaySheet extends StatelessWidget {
  const _CapsuleDelaySheet();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final options = [
      (l10n.chatCapsuleTomorrow, const Duration(days: 1)),
      (l10n.chatCapsuleWeek, const Duration(days: 7)),
      (l10n.chatCapsuleMonth, const Duration(days: 30)),
      (l10n.chatCapsuleYear, const Duration(days: 365)),
    ];
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Text(
              l10n.chatCapsuleSheetTitle,
              style: textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.xs,
              AppSpacing.xl,
              AppSpacing.s,
            ),
            child: Text(
              l10n.chatCapsuleSheetSubtitle,
              style: textTheme.bodySmall,
            ),
          ),
          for (final (label, delay) in options)
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
              ),
              leading: const Icon(
                Icons.hourglass_top_rounded,
                color: AppColors.sun,
              ),
              title: Text(label),
              onTap: () => Navigator.of(context).pop(delay),
            ),
          const SizedBox(height: AppSpacing.s),
        ],
      ),
    );
  }
}
