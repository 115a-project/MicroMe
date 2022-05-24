
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';   // in pubspec.yaml dependencies  pie_chart: ^5.1.0 //
import 'package:flutter/services.dart';

// ****************** Structure *************************
// 
//                                COLUMN
// Container   |------------------------------------------------|  
//             |  WATER PAGE                                    |
//             |------------------------------------------------|
//             |                Title                           |
//             |             PIE-CHART                           |  @https://www.youtube.com/watch?v=NvTQAzGCh5U
//             | Change Goal option
//             | History: 
//             |     (trash) List Tile 1                        |  @https://www.youtube.com/watch?v=XBeYlgjZbms
//             |             List Tile 2 
//             |                 ...
//             __________________________________________________




//******************* Water Class *******************
class WaterPage extends StatefulWidget {
  const WaterPage({Key? key}) : super(key: key);

  @override
  _WaterPageState createState() => _WaterPageState();
}
class _WaterPageState extends State<WaterPage> {
  // Controllers for goal and added amounts //
  late TextEditingController controller;
  String amount = '0';                        // amount user has drank
  String total = '0';                         // total amount user has drank
  String goal = '2500';                       // user's set goal
  TimeOfDay time = TimeOfDay.now();           // Time user has added new water entry

  double percentageDrank = 0;

  // Pie chart set to UI displaying amount drank //
  Map<String, double> dataMap = {
    "left to drink " : 100,
    "drank "         : 0,
  };

  // Color list to control color of our pie chart //
  List<Color> pieChartColorList = [
    const Color.fromARGB(60, 104, 104, 176),
    const Color.fromARGB(255, 91, 121, 192),
    
  ];

  // initiate controller to access submit entries for new water and new goal settings //
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }
  
  // clean up the controller after updating entries //
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:<Widget> [
          Container(
            margin: const EdgeInsets.all(30),
            child: const Text('Daily Water Intake',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35),
                    ),
          ),
          // Goal Setting Container, Allows user to change their goal //
          FlatButton(
            child: const Text('Change Goal', style: TextStyle(fontSize: 15.0),),
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
          // Pie Chart UI Container //
          Container(
            margin: const EdgeInsets.all(30),
            alignment: Alignment.center,
            child: PieChart(
                  dataMap: dataMap,
                  colorList: pieChartColorList,
                  chartRadius: MediaQuery.of(context).size.width / 2,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 24,
                  animationDuration: const Duration(seconds: 2),
                  centerText: total + " / " + goal + " ml",
                  chartValuesOptions: const ChartValuesOptions( showChartValues: false ),
                  legendOptions: const LegendOptions( showLegends: false,),
                ), 
          ),
          // Past Entry List View, Allows User to delete mistake entries and view history log for water //
          SingleChildScrollView(
            child: Column(
              children:<Widget> [
                const Text("Past Entries: "),
                Text("Added " + amount + 'ml ' + " at " + time.toString()),
              ],
            ),
          ),
        ]
      ),
      // Allows user to add new water //
      floatingActionButton: buildNavigateButton(),
    );
  }

  //Button to control adding more water
  //Expected: opens a text entry where user submits a new value that changes the pi chart
  Widget buildNavigateButton() => FloatingActionButton(
    child:const Text("+",
      style: TextStyle(
        fontSize: 20,
       ),
    ),
    // When pressed updates the (dataMap) map for pie chart to allow values to change // 
    onPressed: () async {
      final amount = await openDialog();
      if ( amount == null || amount.isEmpty ) return;        // Toss out invalid values, TODO: make sure it is an int
      setState(
        () => this.amount = amount ,
      ); 
      var amountDouble = double.parse(amount) + double.parse(total);
      total = amountDouble.toString();
      var percentageDrank = double.parse(total) / double.parse(goal);
      var remainder = 100 - (percentageDrank*100);

      // Update values for pie chart so it changes //
      dataMap.update("left to drink ", (value) => remainder);
      dataMap.update("drank ", (value) => percentageDrank*100);
    }
  );


  // Updates Controller by allowing floating button to add water.
  // Returns a string that is amount of water inputted by user
  // https://www.youtube.com/watch?v=D6icsXS8NeA
  Future<String?> openDialog() => showDialog<String>(
  context: context, builder: (context) => AlertDialog(
      title: const Text('Enter Amount Drank: '),
      content: TextField(
        autofocus: true,                                              // keeps the keyboard open
        decoration: const InputDecoration(hintText: '200 ml'),
        controller: controller,
        keyboardType: TextInputType.number, // Set keyboard to number keypad
        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"))], // Only integers allowed
      ), // Text Pop Up
      actions: [
        TextButton(
          child: const Text('SUBMIT'),
          onPressed: submit,
        ),
      ]
    ) // AlertDialog
  );

  // Closes the input pop up and passes controller.text back to body //
  void submit () {
    Navigator.of(context).pop(controller.text);
  }

} // water
