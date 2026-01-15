import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color primary = Color(0xFF1DB954);
  static const Color background = Color(0xFF000000);
  static const Color surface = Color(0xFF121212);
  static const Color error = Color(0xFFE91429);

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        onPrimary: Colors.black,
        secondary: primary,
        onSecondary: Colors.black,
        surface: surface,
        onSurface: Colors.white,
        background: background,
        onBackground: Colors.white,
        error: error,
        onError: Colors.white,
      ),
      scaffoldBackgroundColor: background,
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
    );
  }
}
