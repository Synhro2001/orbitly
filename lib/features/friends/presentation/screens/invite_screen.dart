import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/async_view.dart';
import 'package:orbitly/core/widgets/planet_view.dart';
import 'package:orbitly/core/widgets/starfield_background.dart';
import 'package:orbitly/features/friends/domain/entities/friends_entities.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'invite_screen.g.dart';

@riverpod
Future<UserSummary?> invite(Ref ref, String code) =>
    ref.watch(friendsRepositoryProvider).getInvite(code);

/// Opened from someone's invite link or QR code: shows who invites and
/// sends them a request, whatever their privacy settings say.
class InviteScreen extends ConsumerStatefulWidget {
  const InviteScreen({required this.code, super.key});

  final String code;

  @override
  ConsumerState<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends ConsumerState<InviteScreen> {
  bool _busy = false;
  bool _sent = false;

  Future<void> _accept() async {
    final messenger = ScaffoldMessenger.of(context);
    final failed = context.l10n.inviteUnknown;
    setState(() => _busy = true);
    try {
      await ref
          .read(friendsRepositoryProvider)
          .sendRequestByInvite(widget.code);
      if (mounted) setState(() => _sent = true);
    } on Object {
      messenger.showSnackBar(SnackBar(content: Text(failed)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.inviteTitle)),
      extendBodyBehindAppBar: true,
      body: StarfieldBackground(
        child: SafeArea(
          child: AsyncView(
            value: ref.watch(inviteProvider(widget.code)),
            onRetry: () => ref.invalidate(inviteProvider(widget.code)),
            builder: (inviter) => ListView(
              padding: const EdgeInsets.all(AppSpacing.xl),
              children: [
                if (inviter == null)
                  Text(l10n.inviteUnknown, style: textTheme.bodyLarge)
                else ...[
                  Center(
                    child: PlanetView(
                      appearance: inviter.appearance,
                      size: AppSizes.chatHeaderPlanet,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.l),
                  Text(
                    l10n.inviteFrom(inviter.name),
                    style: textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '@${inviter.handle}',
                    style: textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  FilledButton(
                    key: const Key('invite-accept'),
                    onPressed: _busy || _sent ? null : _accept,
                    child: Text(_sent ? l10n.inviteSent : l10n.inviteAccept),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
