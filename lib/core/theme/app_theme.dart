import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFfcbf23);
  static const Color secondaryColor = Color(0xFF262626);
  static const Color backgroundColor = Color(0xFFf5f5f5);
  static ThemeData get light => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(backgroundColor: backgroundColor, elevation: 0),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: secondaryColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderSide: BorderSide(color: secondaryColor)),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: secondaryColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
    ),
  );
}
