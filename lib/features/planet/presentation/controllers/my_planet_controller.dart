import 'package:orbitly/app/di.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/domain/entities/shadow.dart';
import 'package:orbitly/core/utils/clock.dart';
import 'package:orbitly/features/planet/domain/entities/my_planet.dart';
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

  /// Меняем настроение сразу, при ошибке сети откатываем.
  Future<void> setMood(Mood mood) async {
    final previous = state.value;
    if (previous == null || previous.mood == mood) return;
    state = AsyncData(previous.copyWith(mood: mood));
    try {
      await ref.read(planetRepositoryProvider).setMood(mood);
    } on Object {
      if (ref.mounted) state = AsyncData(previous);
      rethrow;
    }
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

  Future<void> _setShadow(Shadow? shadow) async {
    final previous = state.value;
    if (previous == null) return;
    state = AsyncData(previous.copyWith(shadow: shadow));
    try {
      await ref.read(planetRepositoryProvider).setShadow(shadow);
    } on Object {
      if (ref.mounted) state = AsyncData(previous);
      rethrow;
    }
  }
}
