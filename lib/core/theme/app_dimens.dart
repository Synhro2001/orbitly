/// Spacing, radii, sizes and durations: design system tokens.
abstract final class AppSpacing {
  static const xs = 4.0;
  static const s = 8.0;
  static const m = 12.0;
  static const l = 16.0;
  static const xl = 24.0;
  static const xxl = 32.0;
}

abstract final class AppRadii {
  static const s = 8.0;
  static const m = 14.0;
  static const l = 22.0;
  static const pill = 999.0;
}

abstract final class AppSizes {
  static const myPlanetInSystem = 132.0;
  static const friendPlanetMin = 52.0;
  static const friendPlanetMax = 72.0;
  static const momentAvatar = 52.0;
  static const listAvatar = 48.0;
  static const chatHeaderPlanet = 96.0;
  static const myPlanetHero = 240.0;
  static const wardrobePreview = 200.0;
  static const unlockPlanet = 220.0;
  static const onboardingPreview = 260.0;
  static const shutterButton = 78.0;
  static const iconButton = 44.0;
  static const edgeSwipeZone = 28.0;

  /// Minimum touch target (Material / Apple HIG).
  static const minTapTarget = 48.0;

  // Floating bottom bar.
  static const navBarHeight = 64.0;
  static const navCenterButton = 58.0;

  /// Dust disk particles around the system.
  static const dustParticles = 700;

  /// The dust disk reaches this multiple of the outermost friend orbit.
  static const dustOuterFactor = 2.8;

  /// Planet sizes in the system are set for this screen side; on smaller
  /// screens they shrink, but by no more than [systemMinScale].
  static const systemReferenceSide = 480.0;
  static const systemMinScale = 0.7;

  /// Vertical squash of the orbits (the tilt of the system plane) depends
  /// on the screen ratio: height / width × factor, clamped to min–max.
  static const orbitTiltPerAspect = 0.55;
  static const orbitTiltMin = 0.5;
  static const orbitTiltMax = 0.85;
}

abstract final class AppDurations {
  static const fast = Duration(milliseconds: 180);
  static const medium = Duration(milliseconds: 320);

  /// One full system animation cycle; orbit speeds derive from it.
  static const systemCycle = Duration(seconds: 120);
  static const viewerAutoClose = Duration(seconds: 5);

  /// How long the gesture hint stays if nobody dismisses it with a touch.
  static const gestureHint = Duration(seconds: 6);

  /// The flash and planet entrance when an achievement unlocks.
  static const unlock = Duration(milliseconds: 900);
}
