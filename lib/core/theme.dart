import 'package:flutter/material.dart';

/// Themes of the app
abstract class AppTheme {
  /// Default gold color of the app
  static const Color goldColor = Color(0xffe6ae42);

  /// Light theme of the app
  static ThemeData get lightTheme => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: Brightness.light,
          primary: const Color(0xFF442713),
          secondary: const Color(0xff6f4e37),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      );

  /// Dark theme of the app
  static ThemeData get darkTheme => ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.grey.shade900,
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: Brightness.dark,
          primary: const Color(0xFFBE977C),
          secondary: const Color(0xFFEFD8C8),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      );
}
