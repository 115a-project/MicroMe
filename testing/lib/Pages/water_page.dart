
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';   // in pubspec.yaml dependecies  pie_chart: ^5.1.0
// import 'package:testing/Pages/PastWaterEntry.dart';
// import 'package:testing/lib/Pages/PastWaterEntry.dart';


// ****************** Structure *************************
// 
//                                COLUMN
// Container   |------------------------------------------------|  
//             |  WATER PAGE                                    |
//             |------------------------------------------------|
//             |                Title                           |
//             |             PIECHART                           |  @https://www.youtube.com/watch?v=NvTQAzGCh5U
//             | Change Goal option
//             | History: 
//             |     (trash) List Tile 1                        |  @https://www.youtube.com/watch?v=XBeYlgjZbms
//             |             List Tile 2 
//             |                 ...
//             __________________________________________________




// ****************** PIE CHART *************************
// Function that builds the pie chart for water tracking
// https://www.youtube.com/watch?v=rZx_isqXrhg

// *************************************************


//******************* Water Class *******************
class WaterPage extends StatefulWidget {
  const WaterPage({Key? key}) : super(key: key);

  @override
  _WaterPageState createState() => _WaterPageState();
}
class _WaterPageState extends State<WaterPage> {
  // Controllers for goal and added amounts
  late TextEditingController controller;
  String amount = '0';
  String total = '0';
  String goal = '2500';
  TimeOfDay time = TimeOfDay.now();
  // double amount_d = double.parse(amount);
  // double total_d = double.parse(total);
  // double goal_d = double.parse(goal);
  double percentageDrank = 0;

  // Piechart set to UI displaying amount drank
  Map<String, double> dataMap = {
    "left to drink " : 100,
    "drank "         : 0,
  };

  // Color list to control color of our piechart
  List<Color> pieChartColorList = [
    Color.fromARGB(60, 104, 104, 176),
    Color.fromARGB(255, 91, 121, 192),
    
  ];

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }
  
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    const maxWaterPerDay = 30;

    return Scaffold(
      body: Column(
        // child: Text(amount + '2500ml'),
        children:<Widget> [
          Container(
            margin: EdgeInsets.all(30),
            child: Text('Daily Water Intake',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                    ),
          ),
          Container(
            child: FlatButton(  
              child: Text('Change Goal', style: TextStyle(fontSize: 15.0),),  
              onPressed: () async {
                final goal = await openDialog();
                if ( goal == null || goal.isEmpty ) return;    // TODO: Toss out invalid values
                setState(
                  () => this.goal = goal 
                ); 
                var percentageDrank = double.parse(total) / double.parse(goal);
                var remainder = 100 - (percentageDrank*100);

                dataMap.update("left to drink ", (value) => remainder);
                dataMap.update("drank ", (value) => percentageDrank*100);
              } // on pressed for goal amounts
            ),
          ),
          Container(
            margin: EdgeInsets.all(30),
            alignment: Alignment.center,
            child: PieChart(
                  dataMap: dataMap,
                  colorList: pieChartColorList,
                  chartRadius: MediaQuery.of(context).size.width / 2,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 24,
                  animationDuration: Duration(seconds: 2),
                  centerText: total + " / " + goal + " ml",
                  chartValuesOptions: ChartValuesOptions( showChartValues: false ),
                  legendOptions: LegendOptions( showLegends: false,),
                ), 
          ),
          SingleChildScrollView(
            child: Container(
              child: Column(
                children:<Widget> [ 
                  const Text("Past Entries: "),
                  Text("Added " + amount + 'ml ' + " at " + time.toString()),
                ],
              ),
            ),
          ),
        ]
      ),
      floatingActionButton: buildNavigateButton(),
    );
  }

  //Button to control adding more water
  //Expected: opens a text entry where user submits
  // a new value that changes the pi chart
  Widget buildNavigateButton() => FloatingActionButton(
    child:Text("+",
      style: TextStyle(
        fontSize: 20,
       ),
    ),
    onPressed: () async {
      final amount = await openDialog();
      if ( amount == null || amount.isEmpty ) return;    // Toss out invalid values
      setState(
        () => this.amount = amount ,
      ); 
      var amountDouble = double.parse(amount) + double.parse(total);
      total = amountDouble.toString();
      var percentageDrank = double.parse(total) / double.parse(goal);
      var remainder = 100 - (percentageDrank*100);

      dataMap.update("left to drink ", (value) => remainder);
      dataMap.update("drank ", (value) => percentageDrank*100);
    }
  );

  /*
   * Updates Controller by allowing floating button to add water.
   * Returns a string that is amount of water inputted by user
   * https://www.youtube.com/watch?v=D6icsXS8NeA
   */
  Future<String?> openDialog() => showDialog<String>(
  context: context, builder: (context) => AlertDialog(
      title: Text('Enter Amount Drank: '),
      content: TextField(
        autofocus: true,                                              // keeps the keyboard open
        decoration: InputDecoration(hintText: '200 ml'),
        controller: controller,
      ), // Text Pop Up
      actions: [
        TextButton(
          child: Text('SUBMIT'),
          onPressed: submit,
        ),
      ]
    ) // AlertDialog
  );

  // Closes the input pop up and passes controller.text back to body
  void submit () {
    Navigator.of(context).pop(controller.text);
  }

} // water

/*
  ********************************
  List section
  ********************************
*/ 


// Pie chart for water widget builder List Tile 1 child: WaterPieChartWidget(),
// class WaterPieChartWidget extends StatefulWidget {
//   @override
//   _WaterPieChartWidgetState createState() => _WaterPieChartWidgetState();
// }

// class _WaterPieChartWidgetState extends State<WaterPieChartWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Chart(dataSet: dataSet, dataRec: dataRec);
//   }
// }
