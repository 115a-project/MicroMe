import 'package:flutter/material.dart';

class Themes {
  static ThemeData darkMode() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.red,
    );
  }

  static ThemeData lightMode() {
    return ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.orange,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepPurpleAccent,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        showUnselectedLabels: false,
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.purpleAccent,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 25,
          )
      ),
    );
  }
}