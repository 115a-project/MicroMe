
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: 
            Column(
              children: <Widget> [
                // @Niko I made a place for you to put motivational messages here :)
                Container(
                  
                ),
                // Statistics entries //
                Container( 
                  margin: const EdgeInsets.all(30),
                  child: const Text("Water Statistics "),
                ),
                Container( 
                  margin: const EdgeInsets.all(30),
                  child: const Text("Step Statistics "),
                ),
                Container( 
                  margin: const EdgeInsets.all(30),
                  child: const Text("Your Week Long Streak "),
                ),
                
              ],
          ),

        )
      ),
    );
  }
}
