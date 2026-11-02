import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/core/planet_render/planet_image_cache.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/features/chat/presentation/widgets/chat_header.dart';
import 'package:orbitly/features/settings/domain/entities/device_settings.dart';
import 'package:orbitly/features/settings/domain/entities/user_settings.dart';
import 'package:orbitly/features/settings/presentation/controllers/device_settings_controller.dart';
import 'package:orbitly/features/settings/presentation/widgets/settings_widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chats_media_settings_screen.g.dart';

/// Bytes the app keeps that can be thrown away: rendered planets and the
/// temporary folder.
@riverpod
Future<int> cacheSize(Ref ref) async {
  var bytes = PlanetImageCache.instance.bytes;
  if (!kIsWeb) {
    final dir = await getTemporaryDirectory();
    if (dir.existsSync()) {
      await for (final entity in dir.list(recursive: true)) {
        if (entity is File) bytes += await entity.length();
      }
    }
  }
  return bytes;
}

Future<void> clearCache() async {
  PlanetImageCache.instance.clear();
  PaintingBinding.instance.imageCache.clear();
  if (kIsWeb) return;
  final dir = await getTemporaryDirectory();
  if (!dir.existsSync()) return;
  await for (final entity in dir.list()) {
    try {
      await entity.delete(recursive: true);
    } on FileSystemException {
      // A file in use stays; the rest is cleared.
    }
  }
}

/// The rule for new chats, media downloads, data saving, cache.
class ChatsMediaSettingsScreen extends ConsumerWidget {
  const ChatsMediaSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final device = ref.watch(deviceSettingsControllerProvider);
    final devices = ref.read(deviceSettingsControllerProvider.notifier);
    final size = ref.watch(cacheSizeProvider).value;

    return UserSettingsPage(
      title: l10n.settingsChatsMedia,
      builder: (s) => [
        SettingsSection(
          children: [
            SettingsChoice<MessageRetention>(
              key: const Key('chats-retention'),
              title: l10n.chatsDefaultRetention,
              subtitle: l10n.chatsDefaultRetentionHint,
              value: s.messageRetention,
              options: MessageRetention.values,
              label: (v) => retentionLabel(v, l10n),
              onChanged: (v) => applySetting(
                context,
                ref,
                (s) => s.copyWith(messageRetention: v),
              ),
            ),
          ],
        ),
        SettingsSection(
          title: l10n.chatsMedia,
          children: [
            SettingsChoice<MediaAutoload>(
              title: l10n.mediaAutoload,
              value: device.mediaAutoload,
              options: MediaAutoload.values,
              label: (v) => switch (v) {
                MediaAutoload.always => l10n.mediaAlways,
                MediaAutoload.wifi => l10n.mediaWifi,
                MediaAutoload.never => l10n.mediaNever,
              },
              onChanged: (v) => unawaited(
                devices.change((d) => d.copyWith(mediaAutoload: v)),
              ),
            ),
            SettingsSwitch(
              title: l10n.dataSaver,
              subtitle: l10n.dataSaverHint,
              value: device.dataSaver,
              onChanged: (v) =>
                  unawaited(devices.change((d) => d.copyWith(dataSaver: v))),
            ),
            SettingsLink(
              key: const Key('clear-cache'),
              icon: Icons.cleaning_services_outlined,
              title: l10n.clearCache,
              subtitle: size == null ? null : l10n.cacheSize(_megabytes(size)),
              onTap: () async {
                final messenger = ScaffoldMessenger.of(context);
                final done = l10n.cacheCleared;
                await clearCache();
                ref.invalidate(cacheSizeProvider);
                messenger.showSnackBar(SnackBar(content: Text(done)));
              },
            ),
          ],
        ),
      ],
    );
  }

  static String _megabytes(int bytes) =>
      (bytes / (1024 * 1024)).toStringAsFixed(1);
}
