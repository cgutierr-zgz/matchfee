import 'package:flutter/material.dart';

/// Themes of the app
abstract class AppTheme {
  /// Default gold color of the app
  static const Color goldColor = Color(0xffe6ae42);

  /// Light theme of the app
  static ThemeData get lightTheme => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xff6f4e37),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.grey,
          elevation: 0,
        ),
      );

  /// Dark theme of the app
  /// ...
}
