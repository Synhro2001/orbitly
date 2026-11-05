import 'package:flutter/widgets.dart';
import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/cosmetic.dart';
import 'package:orbitly/core/domain/entities/localized_text.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/l10n/app_localizations.dart';

extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

/// Server content in the language on screen.
extension LocalizedTextL10n on LocalizedText {
  String of(BuildContext context) =>
      inLanguage(Localizations.localeOf(context).languageCode);
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
    PlanetType.nebula => l10n.planetTypeNebula,
    PlanetType.blackHole => l10n.planetTypeBlackHole,
    PlanetType.aurora => l10n.planetTypeAurora,
    PlanetType.solarCorona => l10n.planetTypeSolarCorona,
    PlanetType.gemini => l10n.planetTypeGemini,
    PlanetType.ringWorld => l10n.planetTypeRingWorld,
  };
}

/// Short "time ago" for lists, e.g. "now", "15 min", "3 h", "2 d".
String formatTimeAgo(
  AppLocalizations l10n,
  DateTime time, {
  required DateTime now,
}) {
  final passed = now.difference(time);
  if (passed.inMinutes < 1) return l10n.timeNow;
  if (passed.inHours < 1) return l10n.timeMinutes(passed.inMinutes);
  if (passed.inDays < 1) return l10n.timeHours(passed.inHours);
  return l10n.timeDays(passed.inDays);
}

extension RarityL10n on Rarity {
  String label(AppLocalizations l10n) => switch (this) {
    Rarity.common => l10n.rarityCommon,
    Rarity.rare => l10n.rarityRare,
    Rarity.epic => l10n.rarityEpic,
    Rarity.legendary => l10n.rarityLegendary,
  };
}

extension AwardCategoryL10n on AwardCategory {
  String label(AppLocalizations l10n) => switch (this) {
    AwardCategory.friendship => l10n.categoryFriendship,
    AwardCategory.streak => l10n.categoryStreak,
    AwardCategory.closeness => l10n.categoryCloseness,
    AwardCategory.collection => l10n.categoryCollection,
    AwardCategory.secret => l10n.categorySecret,
    AwardCategory.photo => l10n.categoryPhoto,
  };
}

extension CosmeticKindL10n on CosmeticKind {
  String label(AppLocalizations l10n) => switch (this) {
    CosmeticKind.planetType => l10n.cosmeticKindPlanetType,
    CosmeticKind.moon => l10n.cosmeticKindMoon,
    CosmeticKind.ring => l10n.cosmeticKindRing,
    CosmeticKind.glow => l10n.cosmeticKindGlow,
    CosmeticKind.cometTrail => l10n.cosmeticKindCometTrail,
  };
}
