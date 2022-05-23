// Steps Class
// create each bottom nav bar item as their own navigation route
// when pushing new page we push to new navigator stack in main stack.
/*

                                    MAIN
                                     |
                                     |
                       -----------------------------
                       |             |             |
                       |             |             |
                      Water     ***Steps***      Journal
                       |             |             |

*/
// sources: https://pub.dev/packages/pedometer/example
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

class StepsPage extends StatefulWidget {
  const StepsPage({Key? key}) : super(key: key);

  @override
  _StepsPageState createState() => _StepsPageState();
}
class _StepsPageState extends State<StepsPage> {
  // This line connects to the package for steps //
  late TextEditingController controller;
  late Stream<StepCount> _stepCountStream;
  String _steps = '?';
  double miles = 0;
  String _miles = '?';
  String goalVal = '0';
  @override
  //Will initiate the state of the application (Wrapper function)//
  void initState() {
    super.initState();
    initPlatformState();
    controller = TextEditingController();
  }
  //Function below updates step counter whenever a 'event' occurs //
  void onStepCount(StepCount event) {
      setState(() {
        _steps = event.steps.toString();
        miles = event.steps / 2000;
        // This function truncates the double 'miles' to two decimal places
        // while also turning it into a string
        _miles = miles.toStringAsFixed(2);
      });
  }
  // Error checking if an event passed into onStepCount is invalid //
  void onStepCountError(error) {
    setState(() {
      _steps = 'Error with Steps';
    });
  }
  //Will initiate the pedometer package //
  void initPlatformState() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    controller = TextEditingController();
    if(!mounted) return;
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Steps Taken:',
                  style: TextStyle(fontSize: 30),
            ),
            Text(
              _steps,
              style: const TextStyle(fontSize: 30),
            ),
            Text(
              'Goal: $goalVal',
               style: const TextStyle(fontSize: 30),
            ),
            TextButton(
              child: const Text(
                'change goal',
                 style: TextStyle(fontSize: 25)
              ),
                onPressed: () async {
                  final goal = await openDialog();
                  if (goal == null || goal.isEmpty) return; // TODO: Toss out invalid values
                  setState(
                      () => goalVal = goal
                  );
                }
            ),
            const Divider(
              height: 100,
              thickness: 0,
              color: Colors.white,
            ),
            Text(
              'You walked $_miles miles',
              style: const TextStyle(fontSize: 30),
            ),
              TextButton(
                    child: const Text(
                        'steps reset',
                        style: TextStyle(fontSize: 30),
              ),
                    onPressed: () async {
                      _steps = '0';
                    },
              )
          ],
        ),
      )
    );
  }
   // This code was adapted from 'Water_page.dart'
    Future<String?> openDialog() => showDialog<String>(
    context: context, builder: (context) => AlertDialog(
    title: const Text('# of steps '),
    content: TextField(
    autofocus: true,                                              // keeps the keyboard open
    decoration: const InputDecoration(hintText: '1000'),
    controller: controller,
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
}