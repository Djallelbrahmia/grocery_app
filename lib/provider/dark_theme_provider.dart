import 'package:flutter/material.dart';
import 'package:grocery_app/services/dark_theme_prefs.dart';

class DarkThemeProvider with ChangeNotifier {
  DartkThemePrefs dartThemePrefs = DartkThemePrefs();
  bool _darkTheme = false;
  bool get getDarkTheme => _darkTheme;
  set setDarkTheme(bool value) {
    _darkTheme = value;
    dartThemePrefs.setDartTheme(value);
    notifyListeners();
  }
}
