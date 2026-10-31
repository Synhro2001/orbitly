import 'package:orbitly/app/di.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/features/planet/domain/entities/my_planet.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_planet_controller.g.dart';

/// Создана ли у пользователя планета. От этого зависит, куда ведёт роутер.
@Riverpod(keepAlive: true)
Future<bool> hasPlanet(Ref ref) =>
    ref.watch(planetRepositoryProvider).hasPlanet();

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
}
