
import 'package:flutter/material.dart';


// import 'package:flutter_icons/flutter_icons.dart';

// ****************** Structure *************************
// *GOAL* :            XXX  Fl Oz
//                                COLUMN
// ROWS  |------------------------------------------------|  
//       |  WATER PAGE                                    |
//       |------------------------------------------------|
//       |      STATS         |         PIECHART          |
//       |                    |                           |
//       __________________________________________________




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
  late TextEditingController controller;
  String amount = '0';
  String goal = '2500';

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
            child: Row(
              children:<Widget> [
                Text('Goal ' + goal + 'ml'),
                FlatButton(  
                child: Text('Change Goal', style: TextStyle(fontSize: 15.0),),  
                onPressed: () {},  
              ),
              ],
            ),
          ),
          Container(
            child: Text(amount + ' / 25000ml '),
            margin: EdgeInsets.all(100.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
          SingleChildScrollView(
            child: Container(
              child: Text("Past Entries: "),
              // child: myListView(),
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
    child:Text("+"),
    onPressed: () async {
      final amount = await openDialog();
      if ( amount == null || amount.isEmpty ) return;    // Toss out invalid values
      setState(
        () => this.amount = amount 
      ); 
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
        decoration: InputDecoration(hintText: '12 fl oz.'),
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

  // Widget log to view past water enteries with ability to delete them later
  // should show up on bottom and be scrollabale
  // Widget myListView() {
  //   // backing data
  //   var pastWaterLog = ['Drank ' + amount + 'ml', ]; 

  //   return ListView.builder(
  //     itemCount: pastWaterLog.length,
  //     itemBuilder: (context, index) {
  //       return ListTile(
  //         title: Text(pastWaterLog[index]),
  //       );
  //     },
  //   );
 
  // } // widget
  
} // water

// ********************************