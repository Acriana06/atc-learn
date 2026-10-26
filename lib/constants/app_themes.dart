import 'package:flutter/material.dart';

class AppTheme {
  static const Color navyElectric = Color(0xFF090C9B);
  static const Color royalAzure = Color(0xFF3D52D5);
  static const Color cyanAccent = Color(0xFF00E5FF);
  static const Color darkBackground = Color(0xFF0A0D1E);
  static const Color darkCard = Color(0xFF141936);

  static ThemeData get darkAviationTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: darkBackground,
      primaryColor: royalAzure,
      colorScheme: const ColorScheme.dark(
        primary: royalAzure,
        secondary: cyanAccent,
        surface: darkCard,
        background: darkBackground,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: navyElectric,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      cardTheme: CardTheme(
        color: darkCard,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: royalAzure.withOpacity(0.3)),
        ),
      ),
    );
  }

  static ThemeData get lightAviationTheme {
    return ThemeData.light().copyWith(
      scaffoldBackgroundColor: const Color(0xFFF4F6FC),
      primaryColor: royalAzure,
      colorScheme: const ColorScheme.light(
        primary: royalAzure,
        secondary: royalAzure,
        surface: Colors.white,
        background: Color(0xFFF4F6FC),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: navyElectric,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: Color(0xFFE0E5F2)),
        ),
      ),
    );
  }
}