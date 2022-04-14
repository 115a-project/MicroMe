import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
var r = Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

  children: [
  Icon(Icons.water_drop, color: Colors.red[500]),
  Icon(Icons.run_circle_outlined, color: Colors.red[500]),
  Icon(Icons.book, color: Colors.red[500]),
],


);
var c = Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
  Icon(Icons.water_drop, color: Colors.red[500]),
  Icon(Icons.run_circle_outlined, color: Colors.red[500]),
  Icon(Icons.book, color: Colors.red[500]),
  // const Text('water'),
  // const Text('run'),
  // const Text('journal'),
],
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter!',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Welcome to the Homepage'),
          actions: <Widget> [
            IconButton(
              icon: Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {},
            ),
          ],
        ),
        body: Center(
          child: Text('Welcome!')
        ),
    );
  }
}


