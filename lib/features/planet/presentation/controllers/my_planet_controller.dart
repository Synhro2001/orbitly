import 'package:orbitly/app/di.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/domain/entities/shadow.dart';
import 'package:orbitly/core/utils/clock.dart';
import 'package:orbitly/features/planet/domain/entities/my_planet.dart';
import 'package:orbitly/features/planet/domain/repositories/planet_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_planet_controller.g.dart';

/// Создана ли у пользователя планета. От этого зависит, куда ведёт роутер.
@Riverpod(keepAlive: true)
Future<bool> hasPlanet(Ref ref) =>
    ref.watch(planetRepositoryProvider).hasPlanet();

/// Моя тень — нужна везде, где считается серия с другом.
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
    return _setShadow(Shadow(from: now, until: now.add(duration)));
  }

  /// Тень не стирается, а заканчивается сейчас: серии, которые она
  /// держала, получают свежие сутки, а не сгорают сразу.
  Future<void> leaveShadow() async {
    final shadow = state.value?.shadow;
    if (shadow == null) return;
    await _setShadow(shadow.copyWith(until: ref.read(clockProvider)()));
  }

  Future<void> _setShadow(Shadow? shadow) => _optimistic(
    (planet) => planet.copyWith(shadow: shadow),
    (repository) => repository.setShadow(shadow),
  );

  /// Меняем экран сразу, не дожидаясь сервера; при ошибке сети откатываем.
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
