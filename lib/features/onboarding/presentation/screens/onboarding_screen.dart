import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/theme/app_dimens.dart';
import 'package:orbitly/core/utils/l10n.dart';
import 'package:orbitly/core/widgets/planet_view.dart';
import 'package:orbitly/core/widgets/starfield_background.dart';
import 'package:orbitly/features/onboarding/presentation/controllers/onboarding_controller.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  bool _nameTouched = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final draft = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);

    return Scaffold(
      body: StarfieldBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            children: [
              Text(l10n.onboardingTitle, style: textTheme.displaySmall),
              const SizedBox(height: AppSpacing.s),
              Text(l10n.onboardingSubtitle, style: textTheme.bodyMedium),
              Center(
                child: PlanetView(
                  appearance: draft.appearance,
                  size: AppSizes.onboardingPreview,
                  live: true,
                ),
              ),
              _Label(l10n.onboardingTypeLabel),
              Wrap(
                spacing: AppSpacing.s,
                runSpacing: AppSpacing.s,
                children: [
                  for (final type in PlanetType.base)
                    ChoiceChip(
                      label: Text(type.label(l10n)),
                      selected: draft.appearance.type == type,
                      onSelected: (_) => controller.setType(type),
                    ),
                ],
              ),
              _Label(l10n.onboardingHueLabel),
              Slider(
                value: draft.appearance.hue,
                max: 359,
                label: l10n.onboardingHueLabel,
                onChanged: controller.setHue,
              ),
              _Label(l10n.onboardingNameLabel),
              TextField(
                maxLength: OnboardingDraft.nameMaxLength,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: l10n.onboardingNameHint,
                  errorText: _nameTouched && !draft.isNameValid
                      ? l10n.onboardingNameError
                      : null,
                ),
                onChanged: (value) {
                  setState(() => _nameTouched = true);
                  controller.setName(value);
                },
              ),
              _Label(l10n.onboardingDisplayNameLabel),
              TextField(
                key: const Key('onboarding-display-name'),
                maxLength: OnboardingDraft.displayNameMaxLength,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  hintText: l10n.onboardingDisplayNameHint,
                  counterText: '',
                ),
                onChanged: controller.setDisplayName,
                onSubmitted: (_) => controller.create(),
              ),
              CheckboxListTile(
                key: const Key('onboarding-adult'),
                contentPadding: EdgeInsets.zero,
                controlAffinity: ListTileControlAffinity.leading,
                value: draft.isAdult,
                onChanged: (value) =>
                    controller.setAdult(value: value ?? false),
                title: Text(l10n.onboardingAdult),
                subtitle: Text(l10n.onboardingAdultHint),
              ),
              const SizedBox(height: AppSpacing.s),
              FilledButton(
                onPressed: draft.canSubmit ? controller.create : null,
                child: draft.isSubmitting
                    ? const SizedBox.square(
                        dimension: AppSpacing.l,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l10n.onboardingCreate),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: AppSpacing.l, bottom: AppSpacing.s),
    child: Text(text, style: Theme.of(context).textTheme.titleSmall),
  );
}
