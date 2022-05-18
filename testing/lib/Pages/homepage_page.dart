import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing/Utils/quote.dart';


Random random = Random();
int randomNumber = random.nextInt(1642);

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {

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
      body: FutureBuilder(
        future: fetchAllQuotes(), // Tells what asynchronous computation to connect
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) { // If future finishes
            return ListTile( // Creates a list tile with the index
              title: Text(
                snapshot.data[randomNumber].author,
                style:  const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(snapshot.data[randomNumber].text),
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(
                  color: Color(0xffFF8C32),
                ));
          }
        },
      ),
    );
  }
}


Future fetchAllQuotes() async {
  final response = await http.get(Uri.parse('https://type.fit/api/quotes'));
  if (response.statusCode == 200) {
    var jsonData = jsonDecode(response.body);
    var quotes = [];
    for (var aQuote in jsonData) {
      Quote quote =
      Quote(text: aQuote['text'], author: aQuote['author'] ?? "unknown");
      quotes.add(quote);
    }
    return quotes;
  } else {
    throw Exception('Failed to fetch posts');
  }
}
