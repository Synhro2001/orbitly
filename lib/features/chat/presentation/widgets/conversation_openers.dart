import 'package:orbitly/l10n/app_localizations.dart';

/// First lines offered when a conversation has gone quiet. Tapping one puts
/// it in the input field, where it can be edited before sending.
List<String> conversationOpeners(AppLocalizations l10n, String friendName) => [
  l10n.chatOpenerMissYou(friendName),
  l10n.chatOpenerRemindedMe,
  l10n.chatOpenerStrangest,
  l10n.chatOpenerCall,
];
