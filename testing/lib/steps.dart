// Water Class
// src @ https://www.google.com/search?q=getting+my+bottom+nav+bar+to+point+to+new+screen+flutter&oq=getting+my+bottom+nav+bar+to+point+to+new+screen+flutter&aqs=chrome..69i57.8000j0j4&sourceid=chrome&ie=UTF-8#kpvalbx=_UrtZYt2mLoedkPIPoJC6CA13
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
