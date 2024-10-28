import 'package:caspro_enterprises/Utils/app_constants.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static final lightTheme = ThemeData(
      primarySwatch: Palette.kToDark,
      cardTheme:
          const CardTheme(color: whiteColor, shape: RoundedRectangleBorder()),
      appBarTheme: const AppBarTheme(backgroundColor: primaryColor),
      scaffoldBackgroundColor: whiteColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)))));
}

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xFF007AFF, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(0xFF070961),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );
}
