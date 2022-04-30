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
import 'package:testing/homepage.dart';
import 'package:flutter/material.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({Key? key}) : super(key: key);

  @override
  _JournalPageState createState() => _JournalPageState();
}
class _JournalPageState extends State<JournalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Journal Page"),
      floatingActionButton: FloatingActionButton (
        child: Icon(Icons.add),
      backgroundColor: Colors.blue,
      onPressed: () {
      },
      )
    );
  }
}