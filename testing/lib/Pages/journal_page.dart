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
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JournalPage extends StatefulWidget {
  const JournalPage({Key? key}) : super(key: key);

  @override
  _JournalPageState createState() => _JournalPageState();
}
class _JournalPageState extends State<JournalPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Journal Page"),
    );
  }
}