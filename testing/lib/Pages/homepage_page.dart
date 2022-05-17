import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing/Utils/quote.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    fetchAllQuotes();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: fetchAllQuotes(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListTile(
              title: Text(
                snapshot.data[1].author,
                style:  const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(snapshot.data[1].text),
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
