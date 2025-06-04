import 'package:flutter/material.dart';
import '../colors/color_picker.dart';

class Themes {
  static final TextTheme baseTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'BebasNeue',
      fontSize: 48,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      fontFamily: 'BebasNeue',
      fontSize: 36,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      fontFamily: 'PlayfairDisplaySC',
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: TextStyle(fontFamily: 'PlayfairDisplaySC', fontSize: 18),
    bodyMedium: TextStyle(fontFamily: 'PlayfairDisplaySC', fontSize: 16),
    bodySmall: TextStyle(fontFamily: 'PlayfairDisplaySC', fontSize: 14),
  );

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ColorPicker.lightPrimary,
    scaffoldBackgroundColor: ColorPicker.lightBackground,
    cardColor: ColorPicker.lightCard,
    fontFamily: 'PlayfairDisplaySC',
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
    fontFamily: 'PlayfairDisplaySC',
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
    fontFamily: 'PlayfairDisplaySC',
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
    fontFamily: 'PlayfairDisplaySC',
    textTheme: baseTextTheme,
    colorScheme: const ColorScheme.dark(
      primary: ColorPicker.cyberYellow,
      secondary: ColorPicker.cyberYellow,
      background: ColorPicker.cyberBlack,
    ),
  );
}
