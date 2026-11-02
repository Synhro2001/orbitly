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
    @Default('') String displayName,

    /// "I am 18 or older": Orbitly is for adults.
    @Default(false) bool isAdult,
    @Default(false) bool isSubmitting,
  }) = _OnboardingDraft;

  const OnboardingDraft._();

  static const nameMinLength = 2;
  static const nameMaxLength = 20;

  static const displayNameMaxLength = 40;

  bool get isNameValid {
    final length = name.trim().length;
    return length >= nameMinLength && length <= nameMaxLength;
  }

  bool get isDisplayNameValid {
    final length = displayName.trim().length;
    return length >= 1 && length <= displayNameMaxLength;
  }

  bool get canSubmit =>
      isNameValid && isDisplayNameValid && isAdult && !isSubmitting;
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
      ),
    );
  }

  void setType(PlanetType type) =>
      state = state.copyWith(appearance: state.appearance.copyWith(type: type));

  void setHue(double hue) =>
      state = state.copyWith(appearance: state.appearance.copyWith(hue: hue));

  void setName(String name) => state = state.copyWith(name: name);

  void setDisplayName(String value) =>
      state = state.copyWith(displayName: value);

  void setAdult({required bool value}) =>
      state = state.copyWith(isAdult: value);

  Future<void> create() async {
    if (!state.canSubmit) return;
    state = state.copyWith(isSubmitting: true);
    try {
      await ref
          .read(planetRepositoryProvider)
          .createPlanet(
            displayName: state.displayName.trim(),
            name: state.name.trim(),
            appearance: state.appearance,
            isAdult: state.isAdult,
          );
      // The router sees the planet exists and opens the system.
      ref.invalidate(hasPlanetProvider);
    } finally {
      if (ref.mounted) state = state.copyWith(isSubmitting: false);
    }
  }
}
