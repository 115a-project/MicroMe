
// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:testing/Pages/charts/bar_chart_widget.dart';


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
                const Padding(
                  padding: EdgeInsets.fromLTRB(20,10,20,10),
                  child: SizedBox(
                    height: 200,
                    child: BarChartWidget(),
                  ),
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
