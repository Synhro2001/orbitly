import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/async_view.dart';
import 'package:orbitly/core/widgets/planet_view.dart';
import 'package:orbitly/core/widgets/streak_badge.dart';
import 'package:orbitly/features/chat/domain/entities/chat.dart';
import 'package:orbitly/features/chat/domain/entities/message.dart';
import 'package:orbitly/features/chat/presentation/controllers/chat_controller.dart';

class ChatsScreen extends ConsumerWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: Text(l10n.chatsTitle)),
      body: AsyncView(
        value: ref.watch(chatsProvider),
        onRetry: () => ref.invalidate(chatsProvider),
        builder: (chats) => chats.isEmpty
            ? Center(child: Text(l10n.chatsEmpty))
            : ListView.builder(
                itemCount: chats.length,
                itemBuilder: (context, i) => _ChatTile(chats[i]),
              ),
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  const _ChatTile(this.chat);

  final ChatPreview chat;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final friend = chat.friend;
    final subtitle = switch (chat.lastMessage) {
      TextMessage(:final text) => text,
      SnapMessage() => l10n.chatsLastSnap,
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
        style: friend.hasUnreadSnaps
            ? textTheme.bodyMedium?.copyWith(color: AppColors.mint)
            : textTheme.bodySmall,
      ),
      trailing: StreakBadge(streak: friend.streak, compact: true),
    );
  }
}
