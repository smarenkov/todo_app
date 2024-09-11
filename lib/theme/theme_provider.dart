import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/theme/theme_type.dart';
import 'package:todo_app/theme/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = lightTheme;
  ThemeData get theme => _theme;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> setTheme(ThemeType type) async {
    _theme = type.theme;
    await _saveTheme(type);

    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final preferences = await SharedPreferences.getInstance();
    final themeType = preferences.getString('theme_type');

    if (themeType != null) {
      _theme = ThemeType.fromJson(themeType).theme;

      notifyListeners();
    }
  }

  Future<void> _saveTheme(ThemeType type) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('theme_type', type.name);
  }
}
