import 'package:dots_in/src/core/theme/dark_theme.dart';
import 'package:dots_in/src/core/theme/light_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => buildLightTheme();
  static ThemeData get darkTheme => buildDarkTheme();
}
