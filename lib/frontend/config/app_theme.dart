import 'package:flutter/material.dart';

class AppTheme {
  // static final ThemeData darkTheme = ThemeData(
  //   useMaterial3: true,
  //   brightness: Brightness.dark,
  //   colorScheme: const ColorScheme(
  //     brightness: Brightness.dark,
  //     primary: Color(0xFFDDDDDD),
  //     onPrimary: Color(0xFF9E9E9E),
  //     secondary: Color(0xFF000000),
  //     onSecondary: Color(0xFF9E9E9E),
  //     error: Colors.red,
  //     onError: Colors.white,
  //     surface: Colors.black,
  //     surfaceDim: Colors.black87,
  //     onSurface: Color(0xFFF5F5F5),
  //     outline: Color(0x0DFFFFFF),
  //   ),
  //   cardTheme: CardThemeData(
  //     color: Colors.grey.shade800,
  //     shape: const RoundedSuperellipseBorder(
  //       borderRadius: BorderRadius.all(Radius.circular(12)),
  //       side: BorderSide(color: Color(0xFFDDDDDD), style: BorderStyle.solid),
  //     ),
  //     elevation: 5,
  //     shadowColor: Colors.white54,
  //   ),
  //   appBarTheme: AppBarThemeData(
  //     elevation: 5,
  //     shadowColor: Colors.white54,
  //     backgroundColor: Colors.grey.shade800,
  //   ),
  // );

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,

    // ColorScheme
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF3366CC),
      onPrimary: Color(0xFFF5F5F5),
      secondary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFF000000),
      secondaryFixed: Color(0xFF636060),
      tertiary: Color(0xFF3366CC),
      onTertiary: Color(0xFF807474),
      primaryContainer: Color(0xFF96D5FD),
      onPrimaryContainer: Color(0xFF27A3FA),
      secondaryContainer: Color(0xFFEFE7E7),
      onSecondaryContainer: Color(0xFFC1BFBF),
      tertiaryContainer: Colors.redAccent,
      onTertiaryContainer: Color(0xfff1f2f7),
      error: Colors.red,
      onError: Colors.white,
      surface: Colors.white,
      surfaceDim: Colors.white70,
      onSurface: Color(0xff454746),
      surfaceContainer: Color(0xffeceff1),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(color: Color(0xFF000000)),
      displayMedium: TextStyle(color: Color(0xFF000000)),
    ),

    // Card
    cardTheme: CardThemeData(
      color: Colors.grey.shade100,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        side: BorderSide(color: Color(0xFF8C8C8C), style: BorderStyle.solid),
      ),
      shadowColor: const Color(0xFF8C8C8C),
      elevation: 5,
    ),

    // App Bar
    appBarTheme: const AppBarThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
    ),

    // Input Decoration
    inputDecorationTheme: InputDecorationThemeData(
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),

    // Elevated Button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF3366CC),
      foregroundColor: Colors.white,
    ),
  );
}
