import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/async_view.dart';
import 'package:orbitly/core/widgets/planet_view.dart';
import 'package:orbitly/features/friends/domain/entities/friends_entities.dart';
import 'package:orbitly/features/friends/domain/friend_search_rules.dart';
import 'package:orbitly/features/friends/presentation/controllers/friends_controller.dart';

class FriendsScreen extends ConsumerStatefulWidget {
  const FriendsScreen({super.key});

  @override
  ConsumerState<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends ConsumerState<FriendsScreen> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: Text(l10n.friendsTitle)),
      body: SafeArea(
        top: false,
        child: RefreshIndicator(
          onRefresh: () {
            ref.invalidate(inviteLinkProvider);
            return ref.refresh(incomingRequestsProvider.future);
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(AppSpacing.l),
            children: [
              TextField(
                maxLength: FriendSearchRules.maxQueryLength,
                onChanged: (value) => setState(() => _query = value),
                decoration: InputDecoration(
                  counterText: '',
                  hintText: l10n.friendsSearchHint,
                  prefixIcon: const Icon(Icons.search_rounded),
                ),
              ),
              if (_query.trim().isNotEmpty) _SearchResults(query: _query),
              const SizedBox(height: AppSpacing.xl),
              Text(
                l10n.friendsIncoming,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.s),
              const _IncomingRequests(),
              const SizedBox(height: AppSpacing.xl),
              const _InviteCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile({required this.user, required this.trailing});

  final UserSummary user;
  final Widget trailing;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: PlanetView(appearance: user.appearance, size: AppSizes.listAvatar),
    title: Text(user.name),
    subtitle: Text('@${user.handle}'),
    trailing: trailing,
  );
}

class _SearchResults extends ConsumerWidget {
  const _SearchResults({required this.query});

  final String query;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final sent = ref.watch(sentRequestsProvider);
    return AsyncView(
      value: ref.watch(userSearchProvider(query)),
      onRetry: () => ref.invalidate(userSearchProvider(query)),
      builder: (users) {
        if (users.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(AppSpacing.l),
            child: Text(l10n.friendsSearchEmpty),
          );
        }
        return Column(
          children: [
            for (final user in users)
              _UserTile(
                user: user,
                trailing: sent.contains(user.id)
                    ? Text(
                        l10n.friendsRequested,
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    : FilledButton.tonal(
                        onPressed: () => ref
                            .read(sentRequestsProvider.notifier)
                            .send(user.id),
                        child: Text(l10n.friendsAdd),
                      ),
              ),
          ],
        );
      },
    );
  }
}

class _IncomingRequests extends ConsumerWidget {
  const _IncomingRequests();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final notifier = ref.read(incomingRequestsProvider.notifier);
    return AsyncView(
      value: ref.watch(incomingRequestsProvider),
      onRetry: () => ref.invalidate(incomingRequestsProvider),
      builder: (requests) {
        if (requests.isEmpty) {
          return Text(
            l10n.friendsNoRequests,
            style: Theme.of(context).textTheme.bodySmall,
          );
        }
        return Column(
          children: [
            for (final request in requests)
              _UserTile(
                user: request.from,
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      tooltip: l10n.friendsDecline,
                      onPressed: () =>
                          notifier.respond(request.id, accept: false),
                      icon: const Icon(Icons.close_rounded),
                    ),
                    IconButton.filled(
                      tooltip: l10n.friendsAccept,
                      onPressed: () =>
                          notifier.respond(request.id, accept: true),
                      icon: const Icon(Icons.check_rounded),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

class _InviteCard extends ConsumerWidget {
  const _InviteCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final link = ref.watch(inviteLinkProvider).value;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.l),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.friendsInviteTitle, style: textTheme.titleLarge),
            const SizedBox(height: AppSpacing.xs),
            Text(l10n.friendsInviteSubtitle, style: textTheme.bodySmall),
            const SizedBox(height: AppSpacing.m),
            SelectableText(
              link ?? '',
              style: textTheme.bodyMedium?.copyWith(color: AppColors.mint),
            ),
            const SizedBox(height: AppSpacing.m),
            OutlinedButton.icon(
              onPressed: link == null
                  ? null
                  : () async {
                      final messenger = ScaffoldMessenger.of(context);
                      await Clipboard.setData(ClipboardData(text: link));
                      messenger.showSnackBar(
                        SnackBar(content: Text(l10n.friendsLinkCopied)),
                      );
                    },
              icon: const Icon(Icons.link_rounded),
              label: Text(l10n.friendsCopyLink),
            ),
          ],
        ),
      ),
    );
  }
}
