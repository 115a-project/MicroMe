
// Journal Class
// create each bottom nav bar item as their own navigation route
// when pushing new page we push to new navigator stack in main stack.
/*

                                    MAIN
                                     |
                                     |
                       -----------------------------
                       |             |             |
                       |             |             |
                      Water        Steps       ***Journal***
                       |             |             |

*/
import 'package:flutter/material.dart';

class journal extends StatefulWidget {
  const journal({ Key? key }) : super(key: key);

  @override
  _journal_widgetState createState() => _journal_widgetState();
}

class _journal_widgetState extends State<journal> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Center (
        child: new Text("journal"),
      ),
    );
  }
}
