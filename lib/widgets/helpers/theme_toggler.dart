import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_provider.dart';
import '../../themes/theme_data.dart';

Widget themeDropDown(BuildContext context) => DropdownButton<String>(
  value: "Light",
  items:
      ["Light", "Dark", "CyberFusion"].map((name) {
        return DropdownMenuItem(value: name, child: Text(name));
      }).toList(),
  onChanged: (selected) {
    final provider = Provider.of<ThemeProvider>(context, listen: false);
    switch (selected) {
      case "Light":
        provider.setTheme(Themes.lightTheme);
        break;
      case "Dark":
        provider.setTheme(Themes.darkTheme);
        break;
      case "CyberFusion":
        provider.setTheme(Themes.cyberFusionTheme);
        break;
    }
  },
);
