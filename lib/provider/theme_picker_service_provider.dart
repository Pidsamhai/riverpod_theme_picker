import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theme_picker/widget/theme_picker_service_option.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themePickerServiceProvider = ChangeNotifierProvider<ThemeServiceProvider>(
    (_) => throw UnimplementedError());

class ThemeServiceProvider extends ChangeNotifier {
  static final ThemeServiceProvider _instance =
      ThemeServiceProvider._internal();

  static Future<ThemeServiceProvider> _getInstance(
    ThemePickerServiceOption opt,
  ) async {
    _instance._storage = await SharedPreferences.getInstance();
    _instance.option = opt;
    _instance.darkThemes = opt.schemes
        .map(
          (e) => ThemeMap(
            e.toString().split(".").last.capitalize,
            opt.darkThemeBuilder(e),
          ),
        )
        .toList();
    _instance.lightThemes = opt.schemes
        .map(
          (e) => ThemeMap(
            e.toString().split(".").last.capitalize,
            opt.lightThemeBuilder(e),
          ),
        )
        .toList();
    _instance.fonts = opt.fontfamilies
        ?.map(
          (e) => TextThemeMap(
            GoogleFonts.getFont(e),
            GoogleFonts.getTextTheme(e),
            GoogleFonts.getTextTheme(e, ThemeData.dark().textTheme),
          ),
        )
        .toList();
    return _instance;
  }

  static Future<Override> override([
    ThemePickerServiceOption opt = const ThemePickerServiceOption(),
  ]) async {
    final provider = await ThemeServiceProvider._getInstance(
      opt,
    );
    return themePickerServiceProvider.overrideWith(
      (ref) => provider,
    );
  }

  ThemeServiceProvider._internal();

  late final SharedPreferences _storage;
  late final ThemePickerServiceOption option;
  final storageKey = "theme_service_isDarkMode";
  final themeModeKey = "theme_service_themeModeKey";
  final themeIndexKey = "theme_service_themeindex";
  final fontIndexKey = "theme_service_fontindex";
  final defaultFont = GoogleFonts.k2dTextTheme();

  final themeModes = ThemeMode.values;

  ThemeMode get themeMode {
    return themeModes[_storage.getInt(themeModeKey) ??
        option.defaultThemeModeindex?.call(themeModes) ??
        1];
  }

  set themeMode(ThemeMode n) {
    _storage.setInt(themeModeKey, themeModes.indexOf(n));
    notifyListeners();
  }

  void saveThemeMode(bool isDarkMode) {
    _storage.setBool(storageKey, isDarkMode);
  }

  int get themeIndex =>
      _storage.getInt(themeIndexKey) ??
      option.defaultThemeIndex?.call(option.schemes) ??
      0;
  set themeIndex(int n) {
    _storage.setInt(themeIndexKey, n);
    notifyListeners();
  }

  late final List<TextThemeMap>? fonts;

  int get selectedFontIndex =>
      _storage.getInt(fontIndexKey) ??
      option.defaultFontFamilyIndex?.call(option.fontfamilies ?? []) ??
      0;

  set selectedFontIndex(int n) {
    _storage.setInt(fontIndexKey, n);
    notifyListeners();
  }

  late final List<ThemeMap> lightThemes;

  late final List<ThemeMap> darkThemes;

  TextTheme? get selectedTextThemeLight {
    try {
      return fonts?[selectedFontIndex].light;
    } catch (e) {
      return null;
    }
  }

  TextTheme? get selectedTextThemeDark {
    try {
      return fonts?[selectedFontIndex].dark;
    } catch (e) {
      return null;
    }
  }

  ThemeData get flexLightTheme {
    return lightThemes[themeIndex].theme.copyWith(
          textTheme: selectedTextThemeLight,
          navigationBarTheme: const NavigationBarThemeData(),
        );
  }

  ThemeData get flexDarkTheme {
    return darkThemes[themeIndex].theme.copyWith(
          textTheme: selectedTextThemeDark,
          navigationBarTheme: const NavigationBarThemeData(),
        );
  }
}

class ThemeMap {
  final String name;
  final ThemeData theme;
  ThemeMap(this.name, this.theme);
}

class TextThemeMap {
  final TextStyle style;
  final TextTheme light;
  final TextTheme dark;
  TextThemeMap(
    this.style,
    this.light,
    this.dark,
  );
}
