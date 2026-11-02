import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/domain/entities/shadow.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/clock.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/async_view.dart';
import 'package:orbitly/core/widgets/planet_view.dart';
import 'package:orbitly/core/widgets/streak_badge.dart';
import 'package:orbitly/features/chat/domain/entities/chat.dart';
import 'package:orbitly/features/chat/domain/entities/message.dart';
import 'package:orbitly/features/chat/presentation/controllers/chat_controller.dart';
import 'package:orbitly/features/planet/presentation/controllers/my_planet_controller.dart';

class ChatsScreen extends ConsumerWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final myShadow = ref.watch(myShadowProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: Text(l10n.chatsTitle)),
      body: AsyncView(
        value: ref.watch(chatsProvider),
        onRetry: () => ref.invalidate(chatsProvider),
        builder: (chats) => RefreshIndicator(
          onRefresh: () => ref.refresh(chatsProvider.future),
          child: chats.isEmpty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(AppSpacing.xxl),
                      child: Center(child: Text(l10n.chatsEmpty)),
                    ),
                  ],
                )
              : ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: chats.length,
                  itemBuilder: (context, i) =>
                      _ChatTile(chats[i], myShadow: myShadow),
                ),
        ),
      ),
    );
  }
}

class _ChatTile extends ConsumerWidget {
  const _ChatTile(this.chat, {required this.myShadow});

  final ChatPreview chat;
  final Shadow? myShadow;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final friend = chat.friend;
    final unread = friend.hasUnreadSnaps;
    final sentAt = chat.lastMessage?.sentAt;
    final now = ref.watch(clockProvider)();
    final subtitle = switch (chat.lastMessage) {
      TextMessage(:final text) => text,
      SnapMessage() => l10n.chatsLastSnap,
      CapsuleMessage() => l10n.chatsLastCapsule,
      null => '',
    };
    return ListTile(
      onTap: () => context.push(AppRoutes.chat(friend.id)),
      leading: PlanetView(
        appearance: friend.appearance,
        size: AppSizes.listAvatar,
      ),
      title: Text(friend.name, style: textTheme.titleMedium),
      subtitle: Text(
        subtitle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: unread
            ? textTheme.bodyMedium?.copyWith(color: AppColors.mint)
            : textTheme.bodySmall,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (unread) ...[
                Semantics(
                  label: l10n.chatsUnread,
                  child: Container(
                    width: AppSpacing.s,
                    height: AppSpacing.s,
                    decoration: const BoxDecoration(
                      color: AppColors.mint,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
              ],
              if (sentAt != null)
                Text(
                  formatTimeAgo(l10n, sentAt, now: now),
                  style: textTheme.labelSmall?.copyWith(
                    color: unread ? AppColors.mint : null,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          StreakBadge(
            streak: friend.streak,
            shadows: [?friend.shadow, ?myShadow],
            compact: true,
          ),
        ],
      ),
    );
  }
}
