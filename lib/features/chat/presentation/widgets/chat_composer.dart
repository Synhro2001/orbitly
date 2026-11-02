import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/features/chat/domain/message_rules.dart';

/// Поле ввода: камера, текст, капсула времени, отправка и подсказки
/// «С чего начать?».
class ChatComposer extends StatefulWidget {
  const ChatComposer({
    required this.starters,
    required this.onSend,
    required this.onSendCapsule,
    required this.onCamera,
    super.key,
  });

  final List<String> starters;
  final Future<void> Function(String text) onSend;
  final Future<void> Function(String text, Duration delay) onSendCapsule;
  final VoidCallback onCamera;

  @override
  State<ChatComposer> createState() => _ChatComposerState();
}

class _ChatComposerState extends State<ChatComposer> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final text = _controller.text;
    if (text.trim().isEmpty) return;
    _controller.clear();
    unawaited(HapticFeedback.lightImpact());
    await _deliver(text, () => widget.onSend(text));
  }

  /// Поле очищается сразу — так отправка ощущается мгновенной. Если сеть
  /// подвела, текст возвращается в поле, а не пропадает молча.
  Future<void> _deliver(String text, Future<void> Function() send) async {
    try {
      await send();
    } on Object {
      if (!mounted) return;
      if (_controller.text.isEmpty) {
        _controller
          ..text = text
          ..selection = TextSelection.collapsed(offset: text.length);
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.chatSendFailed)));
    }
  }

  Future<void> _sendCapsule() async {
    final text = _controller.text;
    if (text.trim().isEmpty) return;
    final delay = await showModalBottomSheet<Duration>(
      context: context,
      backgroundColor: AppColors.surface,
      showDragHandle: true,
      builder: (_) => const _CapsuleDelaySheet(),
    );
    if (delay == null) return;
    _controller.clear();
    unawaited(HapticFeedback.mediumImpact());
    await _deliver(text, () => widget.onSendCapsule(text, delay));
  }

  /// Подставляем подсказку в поле, а не отправляем: её можно дописать.
  void _useStarter(String starter) => _controller
    ..text = starter
    ..selection = TextSelection.collapsed(offset: starter.length);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.s),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.starters.isNotEmpty)
              _StarterChips(starters: widget.starters, onTap: _useStarter),
            Row(
              children: [
                IconButton(
                  tooltip: l10n.navCamera,
                  onPressed: widget.onCamera,
                  icon: const Icon(Icons.photo_camera_rounded),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    maxLength: MessageRules.maxLength,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _send(),
                    decoration: InputDecoration(
                      hintText: l10n.chatMessageHint,
                      // Счётчик не нужен: лимит большой, ввод просто
                      // остановится на нём.
                      counterText: '',
                    ),
                  ),
                ),
                // Кнопки активны, только когда есть что отправить.
                ValueListenableBuilder(
                  valueListenable: _controller,
                  builder: (context, value, _) {
                    final hasText = value.text.trim().isNotEmpty;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: l10n.chatCapsule,
                          onPressed: hasText ? _sendCapsule : null,
                          color: AppColors.sun,
                          icon: const Icon(Icons.hourglass_top_rounded),
                        ),
                        IconButton(
                          tooltip: l10n.chatSend,
                          onPressed: hasText ? _send : null,
                          color: AppColors.sun,
                          icon: const Icon(Icons.send_rounded),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// «С чего начать?» — первые фразы для затихшего разговора.
class _StarterChips extends StatelessWidget {
  const _StarterChips({required this.starters, required this.onTap});

  final List<String> starters;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.s),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
            child: Text(
              context.l10n.chatStartersTitle,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.s),
            child: Row(
              children: [
                for (final starter in starters)
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.s),
                    child: ActionChip(
                      label: Text(starter),
                      onPressed: () => onTap(starter),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Когда откроется капсула.
class _CapsuleDelaySheet extends StatelessWidget {
  const _CapsuleDelaySheet();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final options = [
      (l10n.chatCapsuleTomorrow, const Duration(days: 1)),
      (l10n.chatCapsuleWeek, const Duration(days: 7)),
      (l10n.chatCapsuleMonth, const Duration(days: 30)),
      (l10n.chatCapsuleYear, const Duration(days: 365)),
    ];
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Text(
              l10n.chatCapsuleSheetTitle,
              style: textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.xs,
              AppSpacing.xl,
              AppSpacing.s,
            ),
            child: Text(
              l10n.chatCapsuleSheetSubtitle,
              style: textTheme.bodySmall,
            ),
          ),
          for (final (label, delay) in options)
            ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.xl,
              ),
              leading: const Icon(
                Icons.hourglass_top_rounded,
                color: AppColors.sun,
              ),
              title: Text(label),
              onTap: () => Navigator.of(context).pop(delay),
            ),
          const SizedBox(height: AppSpacing.s),
        ],
      ),
    );
  }
}
