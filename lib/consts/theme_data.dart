import 'package:flutter/material.dart';

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme ? Colors.black26 : Colors.white,
      colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          primary: Colors.cyan[50],
          secondary: Colors.cyan[100]),
      useMaterial3: true,
    );
  }
}
