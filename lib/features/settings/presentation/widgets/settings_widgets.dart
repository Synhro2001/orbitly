import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/async_view.dart';
import 'package:orbitly/core/widgets/starfield_background.dart';
import 'package:orbitly/features/settings/domain/entities/user_settings.dart';
import 'package:orbitly/features/settings/presentation/controllers/user_settings_controller.dart';

/// One settings screen: title, space background, a scrolling list.
class SettingsPage extends StatelessWidget {
  const SettingsPage({required this.title, required this.children, super.key});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      extendBodyBehindAppBar: true,
      body: StarfieldBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.l),
            children: children,
          ),
        ),
      ),
    );
  }
}

/// A settings screen that needs the account settings: waits for them and
/// offers a retry if they did not load.
class UserSettingsPage extends ConsumerWidget {
  const UserSettingsPage({
    required this.title,
    required this.builder,
    super.key,
  });

  final String title;
  final List<Widget> Function(UserSettings settings) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      extendBodyBehindAppBar: true,
      body: StarfieldBackground(
        child: SafeArea(
          child: AsyncView(
            value: ref.watch(userSettingsControllerProvider),
            onRetry: () => ref.invalidate(userSettingsControllerProvider),
            builder: (settings) => ListView(
              padding: const EdgeInsets.all(AppSpacing.l),
              children: builder(settings),
            ),
          ),
        ),
      ),
    );
  }
}

/// Saves a change of the account settings; if it fails, the switch goes
/// back and a message says why.
void applySetting(
  BuildContext context,
  WidgetRef ref,
  UserSettings Function(UserSettings settings) update,
) {
  final messenger = ScaffoldMessenger.of(context);
  final failed = context.l10n.settingsSaveFailed;
  unawaited(
    ref.read(userSettingsControllerProvider.notifier).change(update).catchError(
      (Object _) {
        messenger.showSnackBar(SnackBar(content: Text(failed)));
      },
    ),
  );
}

class SettingsSection extends StatelessWidget {
  const SettingsSection({required this.children, this.title, super.key});

  final String? title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final title = this.title;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ...children,
        ],
      ),
    );
  }
}

/// A row that opens another screen or does something.
class SettingsLink extends StatelessWidget {
  const SettingsLink({
    required this.title,
    required this.onTap,
    this.icon,
    this.subtitle,
    this.color,
    super.key,
  });

  final IconData? icon;
  final String title;
  final String? subtitle;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final subtitle = this.subtitle;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: icon == null ? null : Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color)),
      subtitle: subtitle == null ? null : Text(subtitle),
      trailing: onTap == null
          ? null
          : const Icon(
              Icons.chevron_right_rounded,
              color: AppColors.textSecondary,
            ),
      onTap: onTap,
    );
  }
}

class SettingsSwitch extends StatelessWidget {
  const SettingsSwitch({
    required this.title,
    required this.value,
    required this.onChanged,
    this.subtitle,
    super.key,
  });

  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final subtitle = this.subtitle;
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle),
      value: value,
      onChanged: onChanged,
    );
  }
}

/// A row with the current choice; tapping opens the list of options.
class SettingsChoice<T> extends StatelessWidget {
  const SettingsChoice({
    required this.title,
    required this.value,
    required this.options,
    required this.label,
    required this.onChanged,
    this.subtitle,
    super.key,
  });

  final String title;
  final String? subtitle;
  final T value;
  final List<T> options;
  final String Function(T option) label;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: Text(
        subtitle == null ? label(value) : '${label(value)}\n$subtitle',
      ),
      isThreeLine: subtitle != null,
      trailing: const Icon(
        Icons.expand_more_rounded,
        color: AppColors.textSecondary,
      ),
      onTap: () => _pick(context),
    );
  }

  Future<void> _pick(BuildContext context) async {
    final picked = await showModalBottomSheet<T>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          child: RadioGroup<T>(
            groupValue: value,
            onChanged: (option) => Navigator.pop(context, option),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.l),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                for (final option in options)
                  RadioListTile<T>(value: option, title: Text(label(option))),
              ],
            ),
          ),
        ),
      ),
    );
    if (picked != null && picked != value) onChanged(picked);
  }
}
