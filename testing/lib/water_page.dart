
import 'package:testing/_navigationBar.dart';
import 'package:flutter/material.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({Key? key}) : super(key: key);

  @override
  _WaterPageState createState() => _WaterPageState();
}
class _WaterPageState extends State<WaterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Navigate to a new screen on Button click'),
          leading: IconButton(
            icon: const Icon(Icons.redo),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const NavBar()));
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
      body: const Text("awowow"),
    );
  }
}
