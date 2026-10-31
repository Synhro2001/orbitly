/// Отступы, радиусы, размеры и длительности — токены дизайн-системы.
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
  static const onboardingPreview = 260.0;
  static const shutterButton = 78.0;
  static const iconButton = 44.0;
  static const edgeSwipeZone = 28.0;
  static const awardTile = 96.0;
  static const awardTileHeight = 104.0;

  /// Минимальная зона касания (Material / Apple HIG).
  static const minTapTarget = 48.0;

  // Плавающая нижняя панель.
  static const navBarHeight = 64.0;
  static const navCenterButton = 58.0;

  /// Частицы пылевого диска вокруг системы.
  static const dustParticles = 700;

  /// Пылевой диск тянется до этого множителя от внешней орбиты друзей.
  static const dustOuterFactor = 2.8;

  /// Размеры планет в системе заданы для этой стороны экрана; на меньших
  /// экранах они уменьшаются, но не меньше чем в [systemMinScale] раз.
  static const systemReferenceSide = 480.0;
  static const systemMinScale = 0.7;

  /// Сжатие орбит по вертикали (наклон плоскости системы) зависит от
  /// пропорций экрана: высота / ширина × коэффициент, в пределах min–max.
  static const orbitTiltPerAspect = 0.55;
  static const orbitTiltMin = 0.5;
  static const orbitTiltMax = 0.85;
}

abstract final class AppDurations {
  static const fast = Duration(milliseconds: 180);
  static const medium = Duration(milliseconds: 320);

  /// Полный цикл анимации системы; скорости орбит считаются от него.
  static const systemCycle = Duration(seconds: 120);
  static const viewerAutoClose = Duration(seconds: 5);

  /// Сколько висит подсказка про жесты, если её не закрыли касанием.
  static const gestureHint = Duration(seconds: 6);
}
