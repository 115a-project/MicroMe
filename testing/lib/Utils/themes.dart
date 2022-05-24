import 'package:flutter/material.dart';

class Themes {
  static ThemeData darkMode() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.redAccent,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.black38,
        selectedItemColor: Colors.redAccent,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        showUnselectedLabels: false,
      ),
    );
  }

  static ThemeData lightMode() {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.purple,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueGrey,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        showUnselectedLabels: false,
      ),
    );
  }
}