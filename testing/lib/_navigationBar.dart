
import 'package:flutter/material.dart';
import 'package:flutter_application_1/_navigationBar.dart';

// main to run 
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Welcome to Flutter!',
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Welcome to the Homepage'),
          actions: <Widget> [
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {},
            ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Return to homepage',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Screen2()));
            },
          )
        ),

        body: const Center(
          child: Text('Welcome!')
        ),
        bottomNavigationBar: bottom_nav_bar(),
    );
  }
}

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  _Screen2State createState() => _Screen2State();
}
class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Navigate to a new screen on Button click'),
          leading: IconButton(
            icon: const Icon(Icons.redo),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage()));
            },
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Colors.blue,
                  Colors.green
                ]
              ),
            ),
          ),
      ),
    );
  }
}


