import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/clock.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/async_view.dart';
import 'package:orbitly/features/friends/presentation/controllers/friends_controller.dart';
import 'package:orbitly/features/planet/domain/entities/my_planet.dart';
import 'package:orbitly/features/planet/presentation/controllers/my_planet_controller.dart';
import 'package:orbitly/features/settings/domain/repositories/profile_repository.dart';
import 'package:orbitly/features/settings/presentation/widgets/settings_widgets.dart';
import 'package:orbitly/l10n/app_localizations.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

/// Name, planet name, handle, and my invite link with its QR code.
class ProfileSettingsScreen extends ConsumerWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsProfile)),
      body: AsyncView(
        value: ref.watch(myPlanetControllerProvider),
        onRetry: () => ref.invalidate(myPlanetControllerProvider),
        builder: (planet) => _ProfileList(planet: planet),
      ),
    );
  }
}

class _ProfileList extends ConsumerWidget {
  const _ProfileList({required this.planet});

  final MyPlanet planet;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final next = planet.nextHandleChangeAt(ref.watch(clockProvider)());
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.l),
      children: [
        SettingsSection(
          children: [
            SettingsLink(
              key: const Key('profile-name'),
              title: l10n.profileName,
              subtitle: planet.displayName,
              onTap: () => _rename(
                context,
                ref,
                title: l10n.profileName,
                initial: planet.displayName,
                minLength: 1,
                maxLength: 40,
                save: (value) => ref
                    .read(profileRepositoryProvider)
                    .rename(displayName: value),
              ),
            ),
            SettingsLink(
              key: const Key('profile-planet-name'),
              title: l10n.profilePlanetName,
              subtitle: planet.name,
              onTap: () => _rename(
                context,
                ref,
                title: l10n.profilePlanetName,
                initial: planet.name,
                minLength: 2,
                maxLength: 20,
                save: (value) => ref
                    .read(profileRepositoryProvider)
                    .rename(planetName: value),
              ),
            ),
            SettingsLink(
              key: const Key('profile-handle'),
              title: l10n.profileHandle,
              subtitle: next == null
                  ? '@${planet.handle} · ${l10n.profileHandleRule}'
                  : '@${planet.handle} · ${l10n.profileHandleNextChange(next)}',
              onTap: next != null
                  ? null
                  : () => _changeHandle(context, ref, planet.handle),
            ),
          ],
        ),
        SettingsSection(
          title: l10n.profileInvite,
          children: const [_InviteCard()],
        ),
      ],
    );
  }

  Future<void> _rename(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String initial,
    required int minLength,
    required int maxLength,
    required Future<void> Function(String value) save,
  }) async {
    final messenger = ScaffoldMessenger.of(context);
    final failed = context.l10n.settingsSaveFailed;
    final value = await showDialog<String>(
      context: context,
      builder: (_) => _TextDialog(
        title: title,
        initial: initial,
        minLength: minLength,
        maxLength: maxLength,
      ),
    );
    if (value == null || value.trim() == initial) return;
    try {
      await save(value);
      ref.invalidate(myPlanetControllerProvider);
    } on Object {
      messenger.showSnackBar(SnackBar(content: Text(failed)));
    }
  }

  Future<void> _changeHandle(
    BuildContext context,
    WidgetRef ref,
    String current,
  ) async {
    final changed = await showDialog<bool>(
      context: context,
      builder: (_) => _HandleDialog(current: current),
    );
    if (changed ?? false) ref.invalidate(myPlanetControllerProvider);
  }
}

/// One text field with a length limit.
class _TextDialog extends StatefulWidget {
  const _TextDialog({
    required this.title,
    required this.initial,
    required this.minLength,
    required this.maxLength,
  });

  final String title;
  final String initial;
  final int minLength;
  final int maxLength;

  @override
  State<_TextDialog> createState() => _TextDialogState();
}

class _TextDialogState extends State<_TextDialog> {
  late final _text = TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  bool get _valid {
    final length = _text.text.trim().length;
    return length >= widget.minLength && length <= widget.maxLength;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        key: const Key('profile-text-field'),
        controller: _text,
        autofocus: true,
        maxLength: widget.maxLength,
        onChanged: (_) => setState(() {}),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            l10n.actionCancel,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
        TextButton(
          key: const Key('profile-save'),
          onPressed: _valid ? () => Navigator.pop(context, _text.text) : null,
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}

/// New handle with a live check while typing.
class _HandleDialog extends ConsumerStatefulWidget {
  const _HandleDialog({required this.current});

  final String current;

  @override
  ConsumerState<_HandleDialog> createState() => _HandleDialogState();
}

class _HandleDialogState extends ConsumerState<_HandleDialog> {
  late final _text = TextEditingController(text: widget.current);
  Timer? _debounce;
  HandleStatus? _status = HandleStatus.mine;
  bool _saving = false;

  @override
  void dispose() {
    _debounce?.cancel();
    _text.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    final handle = normalizeHandle(value);
    if (!handlePattern.hasMatch(handle)) {
      setState(() => _status = HandleStatus.invalid);
      return;
    }
    setState(() => _status = null);
    _debounce = Timer(const Duration(milliseconds: 400), () async {
      final status = await ref
          .read(profileRepositoryProvider)
          .checkHandle(handle);
      // Ignore an answer for text that has changed since.
      if (mounted && normalizeHandle(_text.text) == handle) {
        setState(() => _status = status);
      }
    });
  }

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await ref.read(profileRepositoryProvider).changeHandle(_text.text);
      if (mounted) Navigator.pop(context, true);
    } on HandleChangeException catch (e) {
      if (mounted) setState(() => _status = e.status);
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.settingsSaveFailed)),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final status = _status;
    final (message, color) = switch (status) {
      null => (l10n.profileHandleChecking, AppColors.textSecondary),
      HandleStatus.ok => (l10n.profileHandleOk, AppColors.mint),
      HandleStatus.mine => (l10n.profileHandleMine, AppColors.textSecondary),
      HandleStatus.taken => (l10n.profileHandleTaken, AppColors.danger),
      HandleStatus.invalid => (l10n.profileHandleInvalid, AppColors.danger),
      HandleStatus.tooSoon => (l10n.profileHandleTooSoon, AppColors.danger),
    };
    return AlertDialog(
      title: Text(l10n.profileHandle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            key: const Key('profile-handle-field'),
            controller: _text,
            autofocus: true,
            maxLength: 32,
            autocorrect: false,
            decoration: const InputDecoration(prefixText: '@'),
            onChanged: _onChanged,
          ),
          Text(
            message,
            key: const Key('profile-handle-status'),
            style: TextStyle(color: color),
          ),
          const SizedBox(height: AppSpacing.s),
          Text(
            l10n.profileHandleWarning,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(
            l10n.actionCancel,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ),
        TextButton(
          key: const Key('profile-handle-save'),
          onPressed: status == HandleStatus.ok && !_saving ? _save : null,
          child: Text(l10n.actionSave),
        ),
      ],
    );
  }
}

/// My invite link as a QR code, to copy, share or replace.
class _InviteCard extends ConsumerWidget {
  const _InviteCard();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final link = ref.watch(inviteLinkProvider).value;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.profileInviteHint,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: AppSpacing.m),
        if (link == null)
          const Center(child: CircularProgressIndicator())
        else ...[
          Center(
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.m),
              decoration: BoxDecoration(
                // A light background: phone cameras read dark-on-light best.
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppRadii.l),
              ),
              child: QrImageView(
                key: const Key('profile-qr'),
                data: link,
                size: AppSizes.inviteQr,
                semanticsLabel: l10n.profileQrLabel,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.s),
          SelectableText(link, textAlign: TextAlign.center),
          const SizedBox(height: AppSpacing.s),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: AppSpacing.s,
            children: [
              OutlinedButton.icon(
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  await Clipboard.setData(ClipboardData(text: link));
                  messenger.showSnackBar(
                    SnackBar(content: Text(l10n.friendsLinkCopied)),
                  );
                },
                icon: const Icon(Icons.copy_rounded),
                label: Text(l10n.friendsCopyLink),
              ),
              OutlinedButton.icon(
                onPressed: () => SharePlus.instance.share(
                  ShareParams(text: l10n.profileInviteShareText(link)),
                ),
                icon: const Icon(Icons.share_rounded),
                label: Text(l10n.profileShare),
              ),
              TextButton(
                key: const Key('profile-new-link'),
                onPressed: () => _renew(context, ref, l10n),
                child: Text(l10n.profileNewLink),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Future<void> _renew(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.profileNewLinkConfirm),
        content: Text(l10n.profileNewLinkBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              l10n.actionCancel,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            key: const Key('profile-new-link-confirm'),
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.profileNewLink),
          ),
        ],
      ),
    );
    if (!(confirmed ?? false)) return;
    await ref.read(friendsRepositoryProvider).renewInviteLink();
    ref.invalidate(inviteLinkProvider);
  }
}
