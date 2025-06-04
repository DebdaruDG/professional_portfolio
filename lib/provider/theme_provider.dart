import 'package:flutter/material.dart';

import '../themes/theme_data.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = Themes.cyberFusionTheme;

  ThemeData get theme => _themeData;

  void setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  void toggleDarkMode() {
    _themeData =
        (_themeData == Themes.darkTheme) ? Themes.lightTheme : Themes.darkTheme;
    notifyListeners();
  }
}
