import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/features/auth/presentation/controllers/auth_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'account_controller.g.dart';

/// Signing in again within 7 days cancels a requested deletion. True when
/// that has just happened, so the app can say so.
@Riverpod(keepAlive: true)
Future<bool> deletionCancelled(Ref ref) {
  final signedIn = ref.watch(signedInProvider).value ?? false;
  if (!signedIn) return Future.value(false);
  return ref.read(accountRepositoryProvider).cancelDeletion();
}

/// My data as a JSON file, handed to the system "Share" menu (save to
/// files, send to myself). On the web, the JSON text is shared instead.
Future<void> shareMyData(Map<String, Object?> data) async {
  final json = const JsonEncoder.withIndent('  ').convert(data);
  if (kIsWeb) {
    await SharePlus.instance.share(ShareParams(text: json));
    return;
  }
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/orbitly-my-data.json');
  await file.writeAsString(json);
  await SharePlus.instance.share(
    ShareParams(
      files: [XFile(file.path, mimeType: 'application/json')],
      subject: 'Orbitly',
    ),
  );
}
