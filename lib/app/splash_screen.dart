import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/core/widgets/async_view.dart';
import 'package:orbitly/core/widgets/starfield_background.dart';
import 'package:orbitly/features/planet/presentation/controllers/my_planet_controller.dart';

/// Shown while we find out whether the user has a planet.
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: StarfieldBackground(
        child: AsyncView(
          value: ref.watch(hasPlanetProvider),
          onRetry: () => ref.invalidate(hasPlanetProvider),
          // As soon as the answer is known, the router leaves this screen.
          builder: (_) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}
