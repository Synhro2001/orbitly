import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/clock.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/utils/time.dart';
import 'package:orbitly/features/chat/domain/entities/message.dart';

class _Bubble extends StatelessWidget {
  const _Bubble({
    required this.isMine,
    required this.child,
    this.color,
    this.border,
  });

  final bool isMine;
  final Widget child;
  final Color? color;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.75,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.m,
            vertical: AppSpacing.s,
          ),
          decoration: BoxDecoration(
            color: color,
            border: border,
            borderRadius: BorderRadius.circular(AppRadii.l),
          ),
          child: child,
        ),
      ),
    );
  }
}

class TextBubble extends StatelessWidget {
  const TextBubble(this.message, {super.key});

  final TextMessage message;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium;
    return _Bubble(
      isMine: message.isMine,
      color: message.isMine ? AppColors.sun : AppColors.surfaceHigh,
      child: Text(
        message.text,
        style: message.isMine ? style?.copyWith(color: AppColors.onSun) : style,
      ),
    );
  }
}

class SnapTile extends StatelessWidget {
  const SnapTile({required this.message, required this.onOpen, super.key});

  final SnapMessage message;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final canOpen = !message.isMine && !message.opened;
    final (icon, label, color) = switch ((message.isMine, message.opened)) {
      (true, _) => (Icons.send_rounded, l10n.chatSnapSent, AppColors.textMuted),
      (false, true) => (
        Icons.crop_square_rounded,
        l10n.chatSnapOpened,
        AppColors.textMuted,
      ),
      (false, false) => (
        Icons.square_rounded,
        l10n.chatSnapTapToView,
        AppColors.mint,
      ),
    };
    return _Bubble(
      isMine: message.isMine,
      border: Border.all(color: color),
      child: InkWell(
        onTap: canOpen ? onOpen : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: AppSpacing.l, color: color),
            const SizedBox(width: AppSpacing.s),
            Flexible(
              child: Text(
                label,
                style: textTheme.labelLarge?.copyWith(color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Капсула времени. Получатель видит текст только после срока, отправитель
/// — сразу, с отметкой, когда капсула откроется.
class CapsuleBubble extends ConsumerWidget {
  const CapsuleBubble(this.message, {super.key});

  final CapsuleMessage message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final now = ref.watch(clockProvider)();
    final open = message.isOpenAt(now);
    final daysLeft = daysUntil(message.opensAt, now: now);
    final showText = open || message.isMine;
    return _Bubble(
      isMine: message.isMine,
      color: AppColors.surfaceHigh,
      border: Border.all(color: open ? AppColors.sun : AppColors.outline),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                open ? Icons.hourglass_bottom_rounded : Icons.lock_clock,
                size: AppSpacing.l,
                color: AppColors.sun,
              ),
              const SizedBox(width: AppSpacing.s),
              Flexible(
                child: Text(
                  open ? l10n.chatCapsule : l10n.chatCapsuleOpensIn(daysLeft),
                  style: textTheme.labelMedium?.copyWith(color: AppColors.sun),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            showText ? message.text : l10n.chatCapsuleSealed,
            style: showText
                ? textTheme.bodyMedium
                : textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
          ),
        ],
      ),
    );
  }
}
