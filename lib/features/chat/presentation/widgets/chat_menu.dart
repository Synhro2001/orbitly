import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/domain/entities/friend.dart';
import 'package:orbitly/core/domain/entities/message_retention.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/features/chat/presentation/controllers/chat_controller.dart';
import 'package:orbitly/features/chat/presentation/widgets/chat_header.dart';
import 'package:orbitly/features/friends/domain/repositories/safety_repository.dart';
import 'package:orbitly/features/friends/presentation/controllers/safety_controller.dart';
import 'package:orbitly/l10n/app_localizations.dart';

enum _Action { retention, mute, unmute, report, block }

/// The chat's "⋮" menu: quiet orbit, report, block.
class ChatMenu extends ConsumerWidget {
  const ChatMenu({required this.friend, super.key});

  final Friend friend;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return PopupMenuButton<_Action>(
      key: const Key('chat-menu'),
      tooltip: l10n.chatMenu,
      onSelected: (action) => switch (action) {
        _Action.retention => _changeRetention(context, ref),
        _Action.mute || _Action.unmute => _toggleMute(context, ref),
        _Action.report => _report(context, ref),
        _Action.block => _block(context, ref),
      },
      itemBuilder: (_) => [
        PopupMenuItem(
          value: _Action.retention,
          child: Text(l10n.chatRetention),
        ),
        if (friend.muted)
          PopupMenuItem(value: _Action.unmute, child: Text(l10n.chatUnmute))
        else
          PopupMenuItem(value: _Action.mute, child: Text(l10n.chatMute)),
        PopupMenuItem(value: _Action.report, child: Text(l10n.chatReport)),
        PopupMenuItem(
          value: _Action.block,
          child: Text(
            l10n.chatBlock,
            style: const TextStyle(color: AppColors.danger),
          ),
        ),
      ],
    );
  }

  Future<void> _changeRetention(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final messenger = ScaffoldMessenger.of(context);
    final picked = await showModalBottomSheet<MessageRetention>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: RadioGroup<MessageRetention>(
          groupValue: friend.messageRetention,
          onChanged: (value) => Navigator.pop(context, value),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
                child: Text(
                  l10n.chatRetentionHint,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              for (final option in MessageRetention.values)
                RadioListTile<MessageRetention>(
                  key: Key('retention-${option.name}'),
                  value: option,
                  title: Text(retentionLabel(option, l10n)),
                ),
            ],
          ),
        ),
      ),
    );
    if (picked == null || picked == friend.messageRetention) return;
    try {
      await ref.read(chatRepositoryProvider).setRetention(friend.id, picked);
      ref.invalidate(chatControllerProvider(friend.id));
    } on Object {
      messenger.showSnackBar(SnackBar(content: Text(l10n.settingsSaveFailed)));
    }
  }

  Future<void> _toggleMute(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    final actions = ref.read(safetyActionsProvider.notifier);
    await (friend.muted ? actions.unmute(friend.id) : actions.mute(friend.id));
    ref.invalidate(chatControllerProvider(friend.id));
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          friend.muted ? l10n.chatUnmuted : l10n.chatMuted(friend.name),
        ),
      ),
    );
  }

  Future<void> _block(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.blockConfirmTitle(friend.name)),
        content: Text(l10n.blockConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              l10n.actionCancel,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            key: const Key('block-confirm'),
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              l10n.chatBlock,
              style: const TextStyle(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
    if (!(confirmed ?? false)) return;
    await ref.read(safetyActionsProvider.notifier).block(friend.id);
    if (context.mounted) context.go(AppRoutes.chats);
  }

  Future<void> _report(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = context.l10n;
    final report = await showModalBottomSheet<(ReportReason, String)>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => const _ReportSheet(),
    );
    if (report == null) return;
    final (reason, details) = report;
    try {
      await ref
          .read(safetyActionsProvider.notifier)
          .report(friend.id, reason, details: details);
      messenger.showSnackBar(SnackBar(content: Text(l10n.abuseSent)));
    } on Object {
      messenger.showSnackBar(SnackBar(content: Text(l10n.abuseFailed)));
    }
  }
}

/// Reason plus optional details.
class _ReportSheet extends StatefulWidget {
  const _ReportSheet();

  @override
  State<_ReportSheet> createState() => _ReportSheetState();
}

class _ReportSheetState extends State<_ReportSheet> {
  ReportReason? _reason;
  final _details = TextEditingController();

  @override
  void dispose() {
    _details.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.abuseTitle,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              RadioGroup<ReportReason>(
                groupValue: _reason,
                onChanged: (reason) => setState(() => _reason = reason),
                child: Column(
                  children: [
                    for (final reason in ReportReason.values)
                      RadioListTile<ReportReason>(
                        key: Key('report-${reason.name}'),
                        value: reason,
                        contentPadding: EdgeInsets.zero,
                        title: Text(reportReasonLabel(reason, l10n)),
                      ),
                  ],
                ),
              ),
              TextField(
                controller: _details,
                maxLength: 1000,
                maxLines: 3,
                minLines: 1,
                decoration: InputDecoration(hintText: l10n.abuseDetailsHint),
              ),
              const SizedBox(height: AppSpacing.s),
              FilledButton(
                key: const Key('report-send'),
                onPressed: _reason == null
                    ? null
                    : () => Navigator.pop(context, (_reason!, _details.text)),
                child: Text(l10n.abuseSend),
              ),
              const SizedBox(height: AppSpacing.l),
            ],
          ),
        ),
      ),
    );
  }
}

String reportReasonLabel(ReportReason reason, AppLocalizations l10n) =>
    switch (reason) {
      ReportReason.spam => l10n.abuseSpam,
      ReportReason.harassment => l10n.abuseHarassment,
      ReportReason.inappropriate => l10n.abuseInappropriate,
      ReportReason.impersonation => l10n.abuseImpersonation,
      ReportReason.underage => l10n.abuseUnderage,
      ReportReason.other => l10n.abuseOther,
    };
