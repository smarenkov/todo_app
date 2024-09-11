import 'package:flutter/material.dart';
import 'package:todo_app/theme/themes.dart';

enum ThemeType {
  light,
  dark;

  static ThemeType fromJson(String json) {
    return ThemeType.values.firstWhere(
      (e) => e.name == json,
      orElse: () => throw ArgumentError('Invalid theme type: $json'),
    );
  }

  ThemeData get theme {
    switch (this) {
      case ThemeType.light:
        return lightTheme;
      case ThemeType.dark:
        return darkTheme;
    }
  }
}
