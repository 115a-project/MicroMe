
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

class steps extends StatefulWidget {
  const steps({ Key? key }) : super(key: key);

  @override
  _steps_widgetState createState() => _steps_widgetState();
}

class _steps_widgetState extends State<steps> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Center (
        child: new Text("steps"),
      ),
    );
  }
}
