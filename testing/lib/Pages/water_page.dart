import 'package:testing/lib/homepage.dart';
import 'package:flutter/material.dart';

class WaterPage extends StatefulWidget {
  const WaterPage({Key? key}) : super(key: key);

  @override
  _WaterPageState createState() => _WaterPageState();
}
class _WaterPageState extends State<WaterPage> {
  late TextEditingController controller;
  String amount = '0';

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
    return Scaffold(
      body: Text(amount),
      floatingActionButton: buildNavigateButton(),
    );
  }

  Widget buildNavigateButton() => FloatingActionButton(
    onPressed: () async {
          final amount = await openDialog();
          if ( amount == null || amount.isEmpty ) return;    // Toss out invalid values
        },
  );

  /*
   * Updates Controller by allowing floating button to add water.
   * Returns a string that is amount of water inputted by user
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
}

