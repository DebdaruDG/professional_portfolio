import 'package:flutter/material.dart';
import 'package:personal_porfolio/constants/font_families.dart';
import '../colors/color_picker.dart';

class Themes {
  static const displayFontFamily = FontFamily.nunito;
  static const bodyFontFamily = FontFamily.spaceGrotesk;
  static final TextTheme baseTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: displayFontFamily.name,
      fontSize: 48,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontFamily: displayFontFamily.name,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontFamily: bodyFontFamily.name,
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(fontFamily: bodyFontFamily.name, fontSize: 18),
    bodyMedium: TextStyle(fontFamily: bodyFontFamily.name, fontSize: 16),
    bodySmall: TextStyle(fontFamily: bodyFontFamily.name, fontSize: 14),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ColorPicker.lightPrimary,
    scaffoldBackgroundColor: ColorPicker.lightBackground,
    cardColor: ColorPicker.lightCard,
    fontFamily: bodyFontFamily.name,
    textTheme: baseTextTheme,
    colorScheme: ColorScheme.light(
      primary: ColorPicker.lightPrimary,
      secondary: ColorPicker.lightSecondary,
      background: ColorPicker.lightBackground,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ColorPicker.darkPrimary,
    scaffoldBackgroundColor: ColorPicker.darkBackground,
    cardColor: ColorPicker.darkCard,
    fontFamily: bodyFontFamily.name,
    textTheme: baseTextTheme,
    colorScheme: ColorScheme.dark(
      primary: ColorPicker.darkPrimary,
      secondary: ColorPicker.darkSecondary,
      background: ColorPicker.darkBackground,
    ),
  );

  static ThemeData customTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ColorPicker.customPrimary,
    scaffoldBackgroundColor: ColorPicker.customBackground,
    cardColor: ColorPicker.customCard,
    fontFamily: bodyFontFamily.name,
    textTheme: baseTextTheme,
    colorScheme: ColorScheme.light(
      primary: ColorPicker.customPrimary,
      secondary: ColorPicker.customSecondary,
      background: ColorPicker.customBackground,
    ),
  );

  static ThemeData cyberFusionTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: ColorPicker.cyberYellow,
    scaffoldBackgroundColor: ColorPicker.cyberBlack,
    cardColor: ColorPicker.cyberCard,
    fontFamily: bodyFontFamily.name,
    textTheme: baseTextTheme,
    colorScheme: const ColorScheme.dark(
      primary: ColorPicker.cyberYellow,
      secondary: ColorPicker.cyberYellow,
      background: ColorPicker.cyberBlack,
    ),
  );
}
