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
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testing/Utils/pedometer.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StepsPage extends StatefulWidget {
  const StepsPage({Key? key}) : super(key: key);

  @override
  _StepsPageState createState() => _StepsPageState();
}
class _StepsPageState extends State<StepsPage> {
  // This line connects to the package for steps //
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late TextEditingController controller;
  late Stream<StepCount> _stepCountStream;
  late Future<int> _store;
  String _steps = '?';
  String _miles = '?';
  String goalVal = '1000';
  String percentString = '?';
  int goalInt = 1000;
  int extSteps = 0;
  int trueStepsGlobal = 0;
  double miles = 0;
  double percentVal = 0;
  @override
  //Will initiate the state of the application (Wrapper function)//
  void initState() {
    super.initState();
    initPlatformState();
    controller = TextEditingController();
  }

  /*
    Function - storeStepsBeforeReset
      This function uses the shared preferences package to store the step count
      that is passed in via the steps parameter. From there, the value in the
      steps parameter is stored using the shared preferences method "setInt."
      It is set with the key 'subSteps' which is later used to refer back to
      this value.
   */
  Future<void> storeStepsBeforeReset(int steps) async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      _store = prefs.setInt('subSteps', steps).then((bool success) {
        return steps;
      });
    });
  }

  double percentCalculation(int ts, int goal) {
    double store = ts / goal;
    if(store >= 1.0) {
      return 1.0;
    }
    else {
      return store;
    }
  }

  String percentToString(double percent) {
    return percent.toString();
  }

  void setDisplay(int trueSteps) async {
    final SharedPreferences prefs = await _prefs;
    int subSteps = prefs.getInt('subSteps') ?? 0;
    trueSteps = trueSteps - subSteps;
    trueStepsGlobal = trueSteps;
    _steps = trueSteps.toString();
    miles = trueSteps / 2000;
    // This function truncates the double 'miles' to two decimal places
    // while also turning it into a string
    _miles = miles.toStringAsFixed(2);
  }

  //Function below updates step counter whenever a 'event' occurs //
  void onStepCount(StepCount event) {
      setState(() {
        extSteps = event.steps;
        int trueSteps = event.steps;
        setDisplay(trueSteps);
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
            LinearPercentIndicator(
              width: MediaQuery.of(context).size.width,
              animation: true,
              lineHeight: 30.0,
              animationDuration: 1000,
              percent: percentCalculation(trueStepsGlobal, goalInt),
              center: Text(percentToString(percentCalculation(trueStepsGlobal, goalInt)) + '%'),
              barRadius: const Radius.circular(16),
              progressColor: Colors.purple,
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
                  goalInt = int.parse(goalVal);
                  // percentVal = extSteps / goalInt;
                  // percentString = percentVal.toString();

                }
            ),
            const Divider(
              height: 100,
              thickness: 0,
              //color: Colors.white,
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
                      storeStepsBeforeReset(extSteps);
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