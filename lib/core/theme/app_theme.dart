import 'package:flutter/material.dart';
import 'package:orbitly/core/theme/app_colors.dart';
import 'package:orbitly/core/theme/app_dimens.dart';

abstract final class AppFonts {
  static const text = 'GolosText';
  static const display = 'Unbounded';
}

/// Variable fonts: weight is set both via `fontWeight` and the `wght` axis.
TextStyle _style(
  String family,
  double size,
  int weight, {
  double? height,
  double? letterSpacing,
  Color color = AppColors.textPrimary,
}) => TextStyle(
  fontFamily: family,
  fontSize: size,
  fontWeight: FontWeight.values[(weight ~/ 100) - 1],
  fontVariations: [FontVariation.weight(weight.toDouble())],
  height: height,
  letterSpacing: letterSpacing,
  color: color,
);

TextTheme _textTheme() => TextTheme(
  displaySmall: _style(AppFonts.display, 32, 700, height: 1.15),
  headlineMedium: _style(AppFonts.display, 24, 700, height: 1.2),
  headlineSmall: _style(AppFonts.display, 20, 600, height: 1.25),
  titleLarge: _style(AppFonts.display, 18, 600),
  titleMedium: _style(AppFonts.text, 16, 600),
  titleSmall: _style(AppFonts.text, 14, 600),
  bodyLarge: _style(AppFonts.text, 16, 400, height: 1.4),
  bodyMedium: _style(AppFonts.text, 14, 400, height: 1.4),
  bodySmall: _style(
    AppFonts.text,
    12,
    400,
    height: 1.35,
    color: AppColors.textSecondary,
  ),
  labelLarge: _style(AppFonts.text, 15, 600),
  labelMedium: _style(AppFonts.text, 12, 600),
  labelSmall: _style(
    AppFonts.text,
    11,
    500,
    letterSpacing: 0.2,
    color: AppColors.textSecondary,
  ),
);

ThemeData buildAppTheme() {
  const scheme = ColorScheme.dark(
    primary: AppColors.sun,
    onPrimary: AppColors.onSun,
    secondary: AppColors.mint,
    onSecondary: AppColors.onMint,
    surface: AppColors.surface,
    surfaceContainerHigh: AppColors.surfaceHigh,
    onSurface: AppColors.textPrimary,
    onSurfaceVariant: AppColors.textSecondary,
    outline: AppColors.outline,
    error: AppColors.danger,
  );
  final textTheme = _textTheme();
  final pillShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(AppRadii.pill),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: scheme,
    scaffoldBackgroundColor: AppColors.spaceDeep,
    fontFamily: AppFonts.text,
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: textTheme.titleLarge,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.spaceMid,
      indicatorColor: AppColors.surfaceHigh,
      labelTextStyle: WidgetStatePropertyAll(textTheme.labelMedium),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          color: states.contains(WidgetState.selected)
              ? AppColors.sun
              : AppColors.textSecondary,
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        shape: pillShape,
        textStyle: textTheme.labelLarge,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.m,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: pillShape,
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.outline),
        textStyle: textTheme.labelLarge,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceHigh,
      hintStyle: textTheme.bodyMedium?.copyWith(color: AppColors.textMuted),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.l,
        vertical: AppSpacing.m,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadii.pill),
        borderSide: BorderSide.none,
      ),
    ),
    cardTheme: CardThemeData(
      color: AppColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadii.l),
      ),
    ),
    sliderTheme: const SliderThemeData(
      activeTrackColor: AppColors.sun,
      thumbColor: AppColors.sun,
      inactiveTrackColor: AppColors.surfaceHigh,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.surfaceHigh,
      contentTextStyle: textTheme.bodyMedium,
      behavior: SnackBarBehavior.floating,
    ),
    dividerTheme: const DividerThemeData(color: AppColors.outline),
  );
}
