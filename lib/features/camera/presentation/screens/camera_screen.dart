import 'dart:async';
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/haptics.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/features/camera/presentation/controllers/camera_providers.dart';

enum _Status { loading, ready, denied, unavailable }

/// The in-app camera. Only it can take photos for photo achievements: there
/// is no gallery picker. The photo stays on the phone and is deleted when
/// the screen closes; the server only learns that a photo was taken.
class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? _controller;
  _Status _status = _Status.loading;
  List<CameraDescription> _cameras = const [];
  bool _frontCamera = false;
  bool _flashOn = false;
  bool _shutterFlash = false;
  bool _busy = false;

  /// The photo just taken, shown until "Retake" or "Done".
  XFile? _shot;

  /// Swipe-right velocity that closes the camera.
  static const _closeSwipeVelocity = 250.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    unawaited(_start());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    unawaited(_controller?.dispose());
    _deleteShot();
    super.dispose();
  }

  /// Open the camera again on return: it was released in the background, or
  /// the user went to settings to allow it. Nothing else restarts it: the
  /// permission dialog itself pauses the app, and restarting then would ask
  /// a second time right after "Don't allow".
  bool _restartOnResume = false;

  /// _start() is running; a second call would open the camera twice.
  bool _starting = false;

  /// The camera is released in the background, as the plugin requires.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      final controller = _controller;
      if (controller == null) return;
      _controller = null;
      _restartOnResume = true;
      unawaited(controller.dispose());
    } else if (state == AppLifecycleState.resumed && _restartOnResume) {
      _restartOnResume = false;
      unawaited(_start());
    }
  }

  Future<void> _openSettings() async {
    _restartOnResume = true;
    await AppSettings.openAppSettings();
  }

  Future<void> _start() async {
    if (_starting) return;
    _starting = true;
    try {
      await _open();
    } finally {
      _starting = false;
    }
  }

  Future<void> _open() async {
    _cameras = await ref.read(deviceCamerasProvider.future);
    if (!mounted) return;
    final direction = _frontCamera
        ? CameraLensDirection.front
        : CameraLensDirection.back;
    final camera =
        _cameras.where((c) => c.lensDirection == direction).firstOrNull ??
        _cameras.firstOrNull;
    if (camera == null) {
      setState(() => _status = _Status.unavailable);
      return;
    }

    final controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );
    try {
      await controller.initialize();
      await controller.setFlashMode(
        _flashOn ? FlashMode.always : FlashMode.off,
      );
    } on CameraException catch (e) {
      await controller.dispose();
      if (!mounted) return;
      setState(() {
        _status = e.code.startsWith('CameraAccess')
            ? _Status.denied
            : _Status.unavailable;
      });
      return;
    }
    if (!mounted) {
      await controller.dispose();
      return;
    }
    final old = _controller;
    setState(() {
      _controller = controller;
      _status = _Status.ready;
    });
    await old?.dispose();
  }

  /// The camera may have been opened by a direct link, with nothing to pop.
  void _close() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.system);
    }
  }

  Future<void> _flip() async {
    setState(() => _frontCamera = !_frontCamera);
    await _start();
  }

  Future<void> _toggleFlash() async {
    setState(() => _flashOn = !_flashOn);
    try {
      await _controller?.setFlashMode(
        _flashOn ? FlashMode.always : FlashMode.off,
      );
    } on CameraException {
      // The front camera usually has no flash; the button just shows intent.
    }
  }

  Future<void> _shoot() async {
    final controller = _controller;
    if (_busy || controller == null || !controller.value.isInitialized) return;
    _busy = true;
    unawaited(AppHaptics.medium());
    if (!MediaQuery.disableAnimationsOf(context)) {
      setState(() => _shutterFlash = true);
      unawaited(
        Future<void>.delayed(AppDurations.fast, () {
          if (mounted) setState(() => _shutterFlash = false);
        }),
      );
    }
    try {
      final shot = await controller.takePicture();
      if (!mounted) {
        _deleteFile(shot);
        return;
      }
      setState(() => _shot = shot);
      unawaited(_record());
    } on CameraException {
      // Nothing to show: the shutter simply did not fire.
    } finally {
      _busy = false;
    }
  }

  /// Tells the server a photo was taken. A failure only means no progress
  /// this time, so it is not shown.
  Future<void> _record() async {
    try {
      await ref.read(captureRepositoryProvider).recordCapture();
    } on Object catch (e) {
      debugPrint('recordCapture failed: $e');
    }
  }

  void _retake() {
    _deleteShot();
    setState(() {});
  }

  void _done() {
    _deleteShot();
    _close();
  }

  void _deleteShot() {
    final shot = _shot;
    _shot = null;
    if (shot != null) _deleteFile(shot);
  }

  static void _deleteFile(XFile file) {
    if (kIsWeb) return;
    unawaited(File(file.path).delete().then((_) {}, onError: (_) {}));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final shot = _shot;
    final controller = _controller;
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
            if (shot != null)
              _ShotView(shot: shot)
            else if (_status == _Status.ready && controller != null)
              _Preview(controller: controller)
            else
              _Placeholder(status: _status, onOpenSettings: _openSettings),
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
                        if (shot == null && _status == _Status.ready) ...[
                          _RoundButton(
                            tooltip: l10n.cameraFlash,
                            icon: _flashOn
                                ? Icons.flash_on_rounded
                                : Icons.flash_off_rounded,
                            selected: _flashOn,
                            onPressed: _toggleFlash,
                          ),
                          if (_cameras.length > 1) ...[
                            const SizedBox(width: AppSpacing.m),
                            _RoundButton(
                              tooltip: l10n.cameraFlip,
                              icon: Icons.cameraswitch_rounded,
                              onPressed: _flip,
                            ),
                          ],
                        ],
                      ],
                    ),
                    const Spacer(),
                    if (shot != null)
                      _ShotActions(onRetake: _retake, onDone: _done)
                    else if (_status == _Status.ready)
                      _Shutter(onTap: _shoot),
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

/// The live preview, filling the screen without stretching.
class _Preview extends StatelessWidget {
  const _Preview({required this.controller});

  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    // previewSize is landscape; the app is portrait.
    final size = controller.value.previewSize;
    if (size == null) return CameraPreview(controller);
    return ClipRect(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: size.height,
          height: size.width,
          child: CameraPreview(controller),
        ),
      ),
    );
  }
}

class _ShotView extends StatelessWidget {
  const _ShotView({required this.shot});

  final XFile shot;

  @override
  Widget build(BuildContext context) => kIsWeb
      ? Image.network(shot.path, fit: BoxFit.cover)
      : Image.file(File(shot.path), fit: BoxFit.cover);
}

/// Loading, no permission, or no camera.
class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.status, required this.onOpenSettings});

  final _Status status;
  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final text = switch (status) {
      _Status.denied => l10n.cameraPermissionDenied,
      _Status.unavailable => l10n.cameraUnavailable,
      _Status.loading || _Status.ready => null,
    };
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: AppColors.cameraGradient,
        ),
      ),
      child: Center(
        child: text == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(AppSpacing.xl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    if (status == _Status.denied) ...[
                      const SizedBox(height: AppSpacing.l),
                      FilledButton(
                        onPressed: onOpenSettings,
                        child: Text(l10n.cameraOpenSettings),
                      ),
                    ],
                  ],
                ),
              ),
      ),
    );
  }
}

class _Shutter extends StatelessWidget {
  const _Shutter({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: context.l10n.cameraShutter,
      child: GestureDetector(
        onTap: onTap,
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
    );
  }
}

class _ShotActions extends StatelessWidget {
  const _ShotActions({required this.onRetake, required this.onDone});

  final VoidCallback onRetake;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      children: [
        Text(
          l10n.cameraPhotoPrivate,
          // Readable on a bright photo too.
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.textPrimary,
            shadows: const [Shadow(color: AppColors.scrim, blurRadius: 6)],
          ),
        ),
        const SizedBox(height: AppSpacing.m),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: onRetake,
                child: Text(l10n.cameraRetake),
              ),
            ),
            const SizedBox(width: AppSpacing.m),
            Expanded(
              child: FilledButton(
                onPressed: onDone,
                child: Text(l10n.cameraDone),
              ),
            ),
          ],
        ),
      ],
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
