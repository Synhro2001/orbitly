import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/core/links.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/features/settings/presentation/widgets/settings_widgets.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';

part 'help_settings_screen.g.dart';

/// "1.0.0 (1)", or empty where the platform cannot tell.
@riverpod
Future<String> appVersion(Ref ref) async {
  final info = await PackageInfo.fromPlatform();
  return '${info.version} (${info.buildNumber})';
}

/// Phone model and system, to help reproduce a reported problem.
@riverpod
Future<String> deviceDescription(Ref ref) async {
  try {
    final plugin = DeviceInfoPlugin();
    if (kIsWeb) return (await plugin.webBrowserInfo).userAgent ?? 'web';
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => await plugin.androidInfo.then(
        (d) => '${d.manufacturer} ${d.model}, Android ${d.version.release}',
      ),
      TargetPlatform.iOS => await plugin.iosInfo.then(
        (d) => '${d.utsname.machine}, iOS ${d.systemVersion}',
      ),
      _ => defaultTargetPlatform.name,
    };
  } on Object {
    return 'unknown';
  }
}

/// Report a problem, rules and policies, licences, version.
class HelpSettingsScreen extends ConsumerWidget {
  const HelpSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final version = ref.watch(appVersionProvider).value;
    return SettingsPage(
      title: l10n.settingsHelp,
      children: [
        SettingsLink(
          key: const Key('help-feedback'),
          icon: Icons.bug_report_outlined,
          title: l10n.helpReportProblem,
          onTap: () => showDialog<void>(
            context: context,
            builder: (_) => _FeedbackDialog(appVersion: version ?? ''),
          ),
        ),
        SettingsLink(
          icon: Icons.groups_outlined,
          title: l10n.helpCommunityRules,
          onTap: () => launchUrl(AppLinks.communityRules),
        ),
        SettingsLink(
          icon: Icons.privacy_tip_outlined,
          title: l10n.helpPrivacyPolicy,
          onTap: () => launchUrl(AppLinks.privacyPolicy),
        ),
        SettingsLink(
          icon: Icons.description_outlined,
          title: l10n.helpTerms,
          onTap: () => launchUrl(AppLinks.terms),
        ),
        SettingsLink(
          icon: Icons.code_rounded,
          title: l10n.helpLicenses,
          onTap: () => showLicensePage(
            context: context,
            applicationName: l10n.appTitle,
            applicationVersion: version,
          ),
        ),
        SettingsLink(
          key: const Key('help-version'),
          icon: Icons.info_outline_rounded,
          title: l10n.helpVersion,
          subtitle: version,
          onTap: null,
        ),
      ],
    );
  }
}

class _FeedbackDialog extends ConsumerStatefulWidget {
  const _FeedbackDialog({required this.appVersion});

  final String appVersion;

  @override
  ConsumerState<_FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends ConsumerState<_FeedbackDialog> {
  final _text = TextEditingController();
  bool _busy = false;
  bool _failed = false;

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final messenger = ScaffoldMessenger.of(context);
    final thanks = context.l10n.helpThanks;
    setState(() {
      _busy = true;
      _failed = false;
    });
    try {
      await ref
          .read(feedbackRepositoryProvider)
          .submit(
            _text.text,
            appVersion: widget.appVersion,
            device: await ref.read(deviceDescriptionProvider.future),
          );
      if (!mounted) return;
      Navigator.pop(context);
      messenger.showSnackBar(SnackBar(content: Text(thanks)));
    } on Object {
      if (mounted) setState(() => _failed = true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AlertDialog(
      title: Text(l10n.helpReportProblem),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            key: const Key('feedback-text'),
            controller: _text,
            autofocus: true,
            minLines: 3,
            maxLines: 6,
            maxLength: 2000,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(hintText: l10n.helpReportHint),
          ),
          Text(
            l10n.helpReportIncludes,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (_failed)
            Text(
              l10n.settingsSaveFailed,
              style: const TextStyle(color: AppColors.danger),
            ),
        ],
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
          key: const Key('feedback-send'),
          onPressed: _busy || _text.text.trim().isEmpty ? null : _send,
          child: Text(l10n.chatSend),
        ),
      ],
    );
  }
}
