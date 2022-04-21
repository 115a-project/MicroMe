import 'package:testing/homepage.dart';
import 'package:flutter/material.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({Key? key}) : super(key: key);

  @override
  _WaterPageState createState() => _WaterPageState();
}
class _WaterPageState extends State<WaterPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Water Page"),
    );
  }
}
