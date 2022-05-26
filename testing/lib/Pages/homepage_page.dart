import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing/Utils/quote.dart';
import 'package:fl_chart/fl_chart.dart';

// import 'package:testing/Pages/charts/bar_chart_widget.dart';  // imports for statistics
import 'package:testing/Pages/charts/data.dart' ;

// Generate a random index into list of quotes to display
Random random = Random();
int randomNumber = random.nextInt(1642);

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {
  String water_total_amount = "100";
  Color water_color = Color(0xff19bfff);

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
  }
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
                  margin: const EdgeInsets.all(30),
                  child: const Text("Water Statistics "),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20,10,20,10),
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
                /* Statistics for steps */
                Container( 
                  margin: const EdgeInsets.all(30),
                  child: const Text("Step Statistics "),
                ),
                Container( 
                  margin: const EdgeInsets.all(30),
                  child: Card( 
                    elevation: 0.9,
                    child: Column(
                      children: <Widget> [ 
                        Container(
                          child: const Text(" Lifetime Total "),
                        ),
                        Container(
                          child: Text( water_total_amount + "oz", style: TextStyle(fontWeight: FontWeight.bold),),
                        )
                      ],
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
}

