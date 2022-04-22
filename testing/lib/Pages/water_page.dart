import 'package:testing/lib/Pages/homepage_page.dart';
import 'package:flutter/material.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({Key? key}) : super(key: key);

  @override
  _WaterPageState createState() => _WaterPageState();
}
class _WaterPageState extends State<WaterPage> {
  int i=0;
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Daily Intake: XXX "),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        // isExtended: true,
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
        
      ),
    );
  }
}
