import 'package:orbitly/app/di.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/domain/entities/shadow.dart';
import 'package:orbitly/core/utils/clock.dart';
import 'package:orbitly/features/auth/presentation/controllers/auth_controller.dart';
import 'package:orbitly/features/planet/domain/entities/my_planet.dart';
import 'package:orbitly/features/planet/domain/repositories/planet_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_planet_controller.g.dart';

/// Whether the user has created a planet; decides where the router goes.
/// Recomputed on sign-in and sign-out.
@Riverpod(keepAlive: true)
Future<bool> hasPlanet(Ref ref) async {
  final signedIn = await ref.watch(signedInProvider.future);
  if (!signedIn) return false;
  return await ref.watch(planetRepositoryProvider).hasPlanet();
}

/// My shadow: needed wherever a streak with a friend is evaluated.
@riverpod
Shadow? myShadow(Ref ref) =>
    ref.watch(myPlanetControllerProvider).value?.shadow;

@riverpod
class MyPlanetController extends _$MyPlanetController {
  @override
  Future<MyPlanet> build() => ref.watch(planetRepositoryProvider).getMyPlanet();

  Future<void> setMood(Mood mood) async {
    if (state.value?.mood == mood) return;
    await _optimistic(
      (planet) => planet.copyWith(mood: mood),
      (repository) => repository.setMood(mood),
    );
  }

  Future<void> enterShadow(Duration duration) {
    final now = ref.read(clockProvider)();
    return _optimistic(
      (planet) => planet.copyWith(
        shadow: Shadow(from: now, until: now.add(duration)),
      ),
      (repository) => repository.enterShadow(duration),
    );
  }

  /// The shadow is not erased but ends now: the streaks it held get a fresh
  /// day instead of burning out at once.
  Future<void> leaveShadow() async {
    final shadow = state.value?.shadow;
    if (shadow == null) return;
    final now = ref.read(clockProvider)();
    await _optimistic(
      (planet) => planet.copyWith(shadow: shadow.copyWith(until: now)),
      (repository) => repository.leaveShadow(),
    );
  }

  /// Update the screen at once without waiting for the server; roll back on
  /// a network error.
  Future<void> _optimistic(
    MyPlanet Function(MyPlanet planet) update,
    Future<void> Function(PlanetRepository repository) save,
  ) async {
    final previous = state.value;
    if (previous == null) return;
    state = AsyncData(update(previous));
    try {
      await save(ref.read(planetRepositoryProvider));
    } on Object {
      if (ref.mounted) state = AsyncData(previous);
      rethrow;
    }
  }
}
