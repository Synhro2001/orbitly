import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/utils/clock.dart';
import 'package:orbitly/features/planet/presentation/controllers/my_planet_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_controller.freezed.dart';
part 'onboarding_controller.g.dart';

@freezed
abstract class OnboardingDraft with _$OnboardingDraft {
  const factory OnboardingDraft({
    required PlanetAppearance appearance,
    @Default('') String name,
    @Default(false) bool isSubmitting,
  }) = _OnboardingDraft;

  const OnboardingDraft._();

  static const nameMinLength = 2;
  static const nameMaxLength = 20;

  bool get isNameValid {
    final length = name.trim().length;
    return length >= nameMinLength && length <= nameMaxLength;
  }
}

@riverpod
class OnboardingController extends _$OnboardingController {
  @override
  OnboardingDraft build() {
    final seed = ref.read(clockProvider)().microsecondsSinceEpoch & 0xFFFFFF;
    return OnboardingDraft(
      appearance: PlanetAppearance(
        type: PlanetType.ocean,
        seed: seed,
        hue: 200,
        moons: 1,
      ),
    );
  }

  void setType(PlanetType type) =>
      state = state.copyWith(appearance: state.appearance.copyWith(type: type));

  void setHue(double hue) =>
      state = state.copyWith(appearance: state.appearance.copyWith(hue: hue));

  void setName(String name) => state = state.copyWith(name: name);

  Future<void> create() async {
    if (!state.isNameValid || state.isSubmitting) return;
    state = state.copyWith(isSubmitting: true);
    try {
      await ref
          .read(planetRepositoryProvider)
          .createPlanet(name: state.name.trim(), appearance: state.appearance);
      // Роутер увидит, что планета есть, и откроет систему.
      ref.invalidate(hasPlanetProvider);
    } finally {
      if (ref.mounted) state = state.copyWith(isSubmitting: false);
    }
  }
}
