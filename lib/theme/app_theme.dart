
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1826F8),
    scaffoldBackgroundColor: const Color(0xFF000000),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF1826F8),
      surface: Color(0xFF2C2C2C),
      background: Color(0xFF000000),
    ),
    // Define other theme properties here
  );
}
