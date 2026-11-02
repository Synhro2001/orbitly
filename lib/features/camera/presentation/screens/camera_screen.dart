import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/haptics.dart';
import 'package:orbitly/core/utils/l10n.dart';

/// Camera UI. A gradient placeholder instead of a preview; no capture yet.
class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool _flashOn = false;
  bool _frontCamera = false;
  bool _shutterFlash = false;

  /// Swipe-right velocity that closes the camera.
  static const _closeSwipeVelocity = 250.0;

  /// The camera may have been opened by a direct link, with nothing to pop.
  void _close() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.system);
    }
  }

  Future<void> _shoot() async {
    unawaited(AppHaptics.medium());
    if (MediaQuery.disableAnimationsOf(context)) return;
    setState(() => _shutterFlash = true);
    await Future<void>.delayed(AppDurations.fast);
    if (mounted) setState(() => _shutterFlash = false);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.spaceDeep,
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if ((details.primaryVelocity ?? 0) > _closeSwipeVelocity) {
            _close();
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedContainer(
              duration: AppDurations.medium,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: _frontCamera ? Alignment.topRight : Alignment.topLeft,
                  end: _frontCamera
                      ? Alignment.bottomLeft
                      : Alignment.bottomRight,
                  colors: AppColors.cameraGradient,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                l10n.cameraPreviewStub,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            IgnorePointer(
              child: AnimatedOpacity(
                opacity: _shutterFlash ? 0.8 : 0,
                duration: AppDurations.fast,
                child: const ColoredBox(color: AppColors.textPrimary),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.l),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _RoundButton(
                          tooltip: l10n.cameraClose,
                          icon: Icons.close_rounded,
                          onPressed: _close,
                        ),
                        const Spacer(),
                        _RoundButton(
                          tooltip: l10n.cameraFlash,
                          icon: _flashOn
                              ? Icons.flash_on_rounded
                              : Icons.flash_off_rounded,
                          selected: _flashOn,
                          onPressed: () => setState(() => _flashOn = !_flashOn),
                        ),
                        const SizedBox(width: AppSpacing.m),
                        _RoundButton(
                          tooltip: l10n.cameraFlip,
                          icon: Icons.cameraswitch_rounded,
                          onPressed: () =>
                              setState(() => _frontCamera = !_frontCamera),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Semantics(
                      button: true,
                      label: l10n.cameraShutter,
                      child: GestureDetector(
                        onTap: _shoot,
                        child: Container(
                          width: AppSizes.shutterButton,
                          height: AppSizes.shutterButton,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.textPrimary,
                              width: AppSpacing.xs + 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoundButton extends StatelessWidget {
  const _RoundButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
    this.selected = false,
  });

  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      iconSize: AppSizes.iconButton / 2,
      style: IconButton.styleFrom(
        backgroundColor: AppColors.scrim.withValues(alpha: 0.35),
        foregroundColor: selected ? AppColors.sun : AppColors.textPrimary,
        fixedSize: const Size.square(AppSizes.iconButton),
      ),
      icon: Icon(icon),
    );
  }
}
