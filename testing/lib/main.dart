import 'package:flutter/material.dart';
import 'package:testing/homepage.dart';

// main to run
void main() {
  runApp(const MyApp());
}

/*
 MyApp Class
 Class app launches from. Builds Material UI
 */

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.yellow,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.deepPurpleAccent,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          showUnselectedLabels: false,
        )
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
      ),
      themeMode: ThemeMode.system,
      home: const HomePage(),
      debugShowCheckedModeBanner: false, // Open Homepage upon app launch
    );
  }
}