import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.grey[100],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.blueAccent,
      surface: Colors.white,
      onSurface: Colors.black87,
      error: Colors.redAccent,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87, fontSize: 18),
      bodyMedium: TextStyle(color: Colors.black54, fontSize: 16),
      titleLarge: TextStyle(color: Colors.black87, fontSize: 24, fontWeight: FontWeight.bold),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.teal,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[850],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.teal,
      secondary: Colors.tealAccent,
      surface: Colors.grey[800]!,
      onSurface: Colors.white70,
      error: Colors.red[300]!,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white, fontSize: 18),
      bodyMedium: TextStyle(color: Colors.white70, fontSize: 16),
      titleLarge: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
    ),
    cardTheme: CardThemeData(
      color: Colors.grey[850],
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
