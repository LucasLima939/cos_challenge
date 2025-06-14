import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFfcbf23);
  static const Color secondaryColor = Color(0xFF262626);
  static const Color backgroundColor = Color(0xFFf5f5f5);
  static ThemeData get light => ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    scaffoldBackgroundColor: backgroundColor,
    appBarTheme: AppBarTheme(backgroundColor: backgroundColor, elevation: 0),
  );
}
