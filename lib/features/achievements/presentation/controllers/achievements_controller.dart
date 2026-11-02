import 'package:orbitly/app/di.dart';
import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/cosmetic.dart';
import 'package:orbitly/core/utils/clock.dart';
import 'package:orbitly/features/auth/presentation/controllers/auth_controller.dart';
import 'package:orbitly/features/planet/presentation/controllers/my_planet_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'achievements_controller.g.dart';

@Riverpod(keepAlive: true)
class AchievementsController extends _$AchievementsController {
  @override
  Future<List<Award>> build() =>
      ref.watch(achievementsRepositoryProvider).getAchievements();

  /// The unlock animation has been shown; do not show it again.
  Future<void> markSeen(String achievementId) async {
    final now = ref.read(clockProvider)();
    final current = state.value;
    if (current != null) {
      state = AsyncData([
        for (final a in current)
          if (a.id == achievementId) a.copyWith(seenAt: now) else a,
      ]);
    }
    await ref.read(achievementsRepositoryProvider).markSeen(achievementId);
  }
}

/// Unlocked but not yet shown achievements: the unlock animation queue.
@riverpod
List<Award> pendingUnlocks(Ref ref) => [
  for (final award
      in ref.watch(achievementsControllerProvider).value ?? const <Award>[])
    if (award.isNew) award,
];

@Riverpod(keepAlive: true)
class OwnedCosmetics extends _$OwnedCosmetics {
  @override
  Future<List<Cosmetic>> build() =>
      ref.watch(achievementsRepositoryProvider).getOwnedCosmetics();

  Future<void> equip(String cosmeticId) async {
    await ref.read(achievementsRepositoryProvider).equip(cosmeticId);
    _refresh();
  }

  Future<void> unequip(CosmeticKind kind) async {
    await ref.read(achievementsRepositoryProvider).unequip(kind);
    _refresh();
  }

  /// What is worn changes the planet's look, so reload the planet too.
  void _refresh() {
    if (!ref.mounted) return;
    ref
      ..invalidateSelf()
      ..invalidate(myPlanetControllerProvider);
  }
}

/// New unlocks from the server (Realtime). The listener reloads the
/// catalogue, cosmetics and planet, which feed the animation queue.
///
/// The subscription is tied to the user: after signing in again (expired
/// session, another account) it reconnects instead of going silent.
@Riverpod(keepAlive: true)
Stream<String> achievementUnlocks(Ref ref) {
  ref.watch(signedInProvider);
  return ref.watch(achievementsRepositoryProvider).watchUnlocks();
}
