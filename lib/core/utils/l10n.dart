import 'package:flutter/widgets.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/l10n/app_localizations.dart';

extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension MoodL10n on Mood {
  String emoji() => switch (this) {
    Mood.happy => '😊',
    Mood.calm => '😌',
    Mood.inLove => '🥰',
    Mood.excited => '🤩',
    Mood.tired => '😴',
    Mood.sad => '😔',
  };

  String label(AppLocalizations l10n) => switch (this) {
    Mood.happy => l10n.moodHappy,
    Mood.calm => l10n.moodCalm,
    Mood.inLove => l10n.moodInLove,
    Mood.excited => l10n.moodExcited,
    Mood.tired => l10n.moodTired,
    Mood.sad => l10n.moodSad,
  };
}

extension PlanetTypeL10n on PlanetType {
  String label(AppLocalizations l10n) => switch (this) {
    PlanetType.ocean => l10n.planetTypeOcean,
    PlanetType.lava => l10n.planetTypeLava,
    PlanetType.ice => l10n.planetTypeIce,
    PlanetType.jungle => l10n.planetTypeJungle,
    PlanetType.candy => l10n.planetTypeCandy,
    PlanetType.crystal => l10n.planetTypeCrystal,
    PlanetType.gas => l10n.planetTypeGas,
  };
}
