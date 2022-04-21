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
          brightness: Brightness.dark,
          primaryColor: Colors.yellow,
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false, // Open Homepage upon app launch
    );
  }
}

// class Screen2 extends StatefulWidget {
//   const Screen2({Key? key}) : super(key: key);
//
//   @override
//   _Screen2State createState() => _Screen2State();
// }
// class _Screen2State extends State<Screen2> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           title: const Text('Navigate to a new screen on Button click'),
//           leading: IconButton(
//             icon: const Icon(Icons.redo),
//             onPressed: () {
//               Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage()));
//             },
//           ),
//           flexibleSpace: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//                 colors: <Color>[
//                   Colors.blue,
//                   Colors.green
//                 ]
//               ),
//             ),
//           ),
//       ),
//     );
//   }
// }



