import 'package:flutter/material.dart';

class AppTheme {
  // Prevent instantiation
  AppTheme._();

  //  Centralized Colors
  static const Color _primaryColor = Color(0xFF1826F8);
  static const Color _backgroundColor = Color(0xFF000000);
  static const Color _surfaceColor = Color(0xFF2C2C2C);
  static const Color _textColor = Colors.white;

  //  Dark Theme
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // Main Colors
    primaryColor: _primaryColor,
    scaffoldBackgroundColor: _backgroundColor,

    // Color Scheme
    colorScheme: const ColorScheme.dark(
      primary: _primaryColor,
      background: _backgroundColor,
      surface: _surfaceColor,
      onPrimary: _textColor,
      onBackground: _textColor,
      onSurface: _textColor,
    ),

    // AppBar Theme
    appBarTheme: const AppBarTheme(
      backgroundColor: _backgroundColor,
      foregroundColor: _textColor,
      elevation: 0,
      centerTitle: true,
    ),

    // Text Theme
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: _textColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: _textColor,
      ),
    ),

    // Button Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _primaryColor,
        foregroundColor: _textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
      ),
    ),

    // Input Field Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: _surfaceColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),

    // Card Theme
    cardTheme: const CardTheme(
      color: _surfaceColor,
      elevation: 3,
      margin: EdgeInsets.all(8),
    ),
  );
}
