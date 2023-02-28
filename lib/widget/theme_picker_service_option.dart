import 'package:flutter/material.dart';

import '../riverpod_theme_picker.dart';

class ThemePickerServiceOption {
  final ThemePickerServiceOptionLabel label;
  final ThemeData Function(FlexScheme scheme) lightThemeBuilder;
  final ThemeData Function(FlexScheme scheme) darkThemeBuilder;
  // Google Font Family Name Case sensitive https://fonts.google.com/
  final List<String>? fontfamilies;
  const ThemePickerServiceOption({
    this.label = const ThemePickerServiceOptionLabel(),
    this.lightThemeBuilder = defaultLightThemeBuilder,
    this.darkThemeBuilder = defaultDarkThemeBuilder,
    this.fontfamilies,
  });

  static ThemeData defaultLightThemeBuilder(FlexScheme scheme) {
    return FlexThemeData.light(
      scheme: scheme,
      transparentStatusBar: false,
      appBarOpacity: 0.8,
      appBarStyle: FlexAppBarStyle.primary,
      tabBarStyle: FlexTabBarStyle.forBackground,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        blendOnColors: false,
        cardElevation: 1,
        dialogBackgroundSchemeColor: SchemeColor.background,
      ),
      keyColors: const FlexKeyColors(),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
    );
  }

  static ThemeData defaultDarkThemeBuilder(FlexScheme scheme) {
    return FlexThemeData.dark(
      scheme: scheme,
      surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
      transparentStatusBar: false,
      appBarOpacity: 0.8,
      appBarStyle: FlexAppBarStyle.primary,
      tabBarStyle: FlexTabBarStyle.forBackground,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 20,
        blendOnColors: false,
        cardElevation: 1,
        dialogBackgroundSchemeColor: SchemeColor.background,
      ),
      keyColors: const FlexKeyColors(),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
    );
  }
}

class ThemePickerServiceOptionLabel {
  final String title;
  final String theme;
  final String font;
  final String mode;
  final String fontExample;
  const ThemePickerServiceOptionLabel({
    this.title = "Select Theme",
    this.theme = "Theme",
    this.font = "Font",
    this.mode = "Mode",
    this.fontExample = "Hello, สวัสดี,",
  });
}
