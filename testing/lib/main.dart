import 'package:flutter/material.dart';
import 'package:testing/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:testing/themes.dart';

/*
  main function
  Needed to run the app
  Changes for Firebase 4/25/2022
  Had to make the function asynchronous to allow
  the app to wait on firebase to initialize.
 */
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
    return GetMaterialApp(
      theme: Themes.lightMode(),
      darkTheme: Themes.darkMode(),
      themeMode: ThemeMode.system,
      home: const HomePage(),
      debugShowCheckedModeBanner: false, // Open Homepage upon app launch
    );
  }
}