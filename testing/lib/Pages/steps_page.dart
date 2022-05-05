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
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';

class StepsPage extends StatefulWidget {
  const StepsPage({Key? key}) : super(key: key);

  @override
  _StepsPageState createState() => _StepsPageState();
}
class _StepsPageState extends State<StepsPage> {
  // This line connects to the package for steps //
  late Stream<StepCount> _stepCountStream;
  String _steps = '?';
  double miles = 0;
  String _miles = '?';
  @override
  //Will initiate the state of the application (Wrapper function)//
  void initState() {
    super.initState();
    initPlatformState();
  }
  //Function below updates step counter whenever a 'event' occurs //
  void onStepCount(StepCount event) {
      print(event);
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
    print('onStepCountError: $error ');
    setState(() {
      _steps = 'Error with Steps';
    });
  }
  //Will initiate the pedometer package //
  void initPlatformState() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if(!mounted) return;
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
            const Divider(
              height: 100,
              thickness: 0,
              color: Colors.white,
            ),
            Text(
              'You walked $_miles miles',
              style: const TextStyle(fontSize: 30),
            )
          ],
        ),
      )
    );
  }
}