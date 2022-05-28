import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing/Utils/quote.dart';
import 'package:fl_chart/fl_chart.dart';

// imports for statistics
import 'package:testing/Pages/charts/data.dart' ;

// Database imports
import 'package:testing/Db/microme_db.dart';
import 'package:testing/Models/water_model.dart';

// Generate a random index into list of quotes to display
Random random = Random();
int randomNumber = random.nextInt(1642);
dynamic waterTotalAmount;
dynamic journalTotalEntries;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  int stepTotalAmount = 500000;
  Color waterColor = const Color(0xff19bfff);

  // data base entries
  late List<Water> waterList;
  bool isLoading = false;

  // Generate dummy data to feed the chart
  final List<Data> waterData = List.generate(
      30,
      (index) => Data(
            x: index,
            y1: Random().nextInt(40) + Random().nextDouble(),
          ));

  @override
  void initState() {
    super.initState();
    fetchAllQuotes(); // Populates the quote list upon initialization
    getAllWater().then((value){ if(value == null) {waterTotalAmount = 0;} else{waterTotalAmount = value;} });
    countAllEntries().then((value) {journalTotalEntries = value; });
  }

  /*
    Collects all water entires to display on the stats page
    Ensure the database is closed before doing this.
   */
  @override
  void dispose() {
    MicromeDatabase.instance.close();
    super.dispose();
  }

  // /*
  //   Collect all entries for water to allow statsitics to be created.
  //  */
  // Future refreshEntries() async {
  //   setState(() => isLoading = true);

  //   this.waterList = await MicromeDatabase.instance.readAllWater();
  //   print(await MicromeDatabase.instance.readAllWater());

  //   setState(() => isLoading = false);
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      FutureBuilder will build depending on the latest interaction with a
      snapshot from a future. In our case, this snapshot is the list returned
      from the fetchAllQuotes() method.
      */
      body: SingleChildScrollView(
        child:  Column(
              children: <Widget> [
                // // @Niko I made a place for you to put motivational messages here :
                // FutureBuilder(
                //     future: fetchAllQuotes(), // Tells what asynchronous computation to connect
                //     builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                //       if (snapshot.connectionState == ConnectionState.done) { // If future finishes
                //         return ListTile( // Creates a list tile with the index
                //           title: Text(
                //             snapshot.data[randomNumber].author, // Takes author of quote as title
                //             style:  const TextStyle(fontWeight: FontWeight.bold),
                //           ),
                //           // Obtain quote text from snapshot to use as the text
                //           subtitle: Text(snapshot.data[randomNumber].text),
                //         );
                //       } else {
                //         return const Center(
                //           // Indicate loading with a progress indicator
                //             child: CircularProgressIndicator(
                //               color: Color(0xffFF8C32),
                //             ));
                //       }
                //     },
                //   ),
                // Statistics entries //
                /* Statistics for Water */
                Container( 
                  // This container is used for padding purposes
                  margin: const EdgeInsets.all(10),
                ),
                Container( 
                  margin: const EdgeInsets.all(5),
                  child: const Text("Water Statistics ", style: TextStyle(color: Color.fromARGB(126, 1, 0, 0), fontWeight: FontWeight.bold, fontSize: 24),),
                ),
                /**
                 * Dynamic chart to track steps of water 
                 * counts the last 7 amount of water with data provided from waterData List
                 * inspired source for dynamic portion: https://www.kindacode.com/article/how-to-make-bar-charts-with-fl_chart-in-flutter/
                */
                Padding(
                  padding: const EdgeInsets.fromLTRB(20,10,20,10),
                  child: Card(
                    elevation: 0.9,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    child: SizedBox(
                            height: 250,
                            child: BarChart(BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              maxY: 100,
                              groupsSpace: MediaQuery.of(context).size.width * 0.05,
                              gridData: FlGridData(show: false),
                              borderData: FlBorderData(
                                  border: const Border(
                                top: BorderSide.none,
                                right: BorderSide.none,
                                left: BorderSide(width: 1),
                                bottom: BorderSide(width: 1),
                              )),
                              barGroups: waterData
                              .map((data) =>
                              BarChartGroupData(x: data.x, barRods: [
                                BarChartRodData(
                                    toY: data.y1,
                                    width: 5,
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6),
                                    ),
                                    ),
                              ]))
                          .toList())),
                    ),
                  ),
                ),
                /* Statistics for Steps */
                Container( 
                  margin: const EdgeInsets.all(20),
                  child: const Text("Step Statistics ", style: TextStyle(color: Color.fromARGB(126, 1, 0, 0), fontWeight: FontWeight.bold, fontSize: 24),),
                ),

                Container(
                  margin: const EdgeInsets.all(5),
                  child: const Text(" Total Lifetime Statistics ", style: TextStyle(color: Color.fromARGB(126, 1, 0, 0), fontWeight: FontWeight.bold, fontSize: 24), ),
                ),
                /*
                  Holds lifetime statistics 
                 */
                Container( 
                  margin: const EdgeInsets.all(5),
                  child: SizedBox(
                    width: double.infinity,
                    height: 120,
                    child: Card( 
                      elevation: 0.9,
                      child: GridView(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget> [  
                              Container(
                                margin: const EdgeInsets.all(5),
                                child: const Text(" Water Drank ",style: TextStyle(fontSize:11, fontWeight: FontWeight.bold, color: Colors.blue ),textAlign: TextAlign.center),
                              ),
                              Container(
                                child: Text( waterTotalAmount.toString() + " oz", style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center, ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget> [  
                              Container(
                                margin: const EdgeInsets.all(5),
                                child: const Text(" Steps Taken ",style: TextStyle(fontSize:11, fontWeight: FontWeight.bold, color: Colors.blue ), textAlign: TextAlign.center),
                              ),
                              Container(
                                child: Text( stepTotalAmount.toString() + " steps", style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center, ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget> [  
                              Container(
                                margin: const EdgeInsets.all(5),
                                child: const Text(" Entries Created ",style: TextStyle(fontSize:11, fontWeight: FontWeight.bold, color: Colors.blue ),textAlign: TextAlign.center),
                              ),
                              Container(
                                child: Text( journalTotalEntries.toString() + " entries", style: const TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center, )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
              ],  // widgets children
            ) // Column
          ) // SingleChildScrollView
        ); // Scaffold
  }

  /*
  Function that pulls json data from an api courteous of type.fit.
  The data is decoded. For each quote in the data, an instance of the quote class
  is made and added to a returned list of quotes.
  */
  Future fetchAllQuotes() async {
    final response = await http.get(Uri.parse('https://type.fit/api/quotes'));
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body); // Parses string to obtain json data
      var quotes = [];
      for (var aQuote in jsonData) { // For each quote in the jsonData
        Quote quote =
        Quote(text: aQuote['text'], author: aQuote['author'] ?? "unknown");
        // Takes the text and author of each quote and populates the fields
        // of a new quote instance. This is then added to the quotes list.
        quotes.add(quote);
      }
      return quotes;
    } else {
      throw Exception('Failed to fetch posts');
    }
  }

  /*
    Helper function that grabs all water from the database
   */
  Future getAllWater() async {
    
    // waterTotalAmount = 
    // print("$waterTotalAmount");
    return await MicromeDatabase.instance.returnTotalSum();
  }

  /*
    Helper function that counts all journal entries from the database
   */
  Future countAllEntries() async {
    journalTotalEntries = await MicromeDatabase.instance.countEntries();
    print("Jounrla entries: $journalTotalEntries");
    return journalTotalEntries;
  }
}

