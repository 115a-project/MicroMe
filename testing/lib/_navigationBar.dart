// SRC @ https://www.youtube.com/watch?v=18PVdmBOEQM
import 'package:flutter/material.dart';
import 'package:testing/water.dart';
import 'package:testing/steps.dart';
import 'package:testing/journal.dart';
import 'package:testing/homepage.dart';



class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  // const ({ Key? key }) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {

  // determines which nav_child is being picked: water, journal, ...
  int _currentIndex = 0;
  final List<Widget> navbarChildren =
  [
    const water(),
    const steps(),
    const journal(),
  ];

  // Allows tapping functionality
  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      appBar: AppBar(
            title: const Text('Welcome to the Homepage'),
          actions: <Widget> [
            IconButton(
              icon: const Icon(Icons.settings),
              tooltip: 'Settings',
              onPressed: () {},
            ),
          ],
          leading: IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Return to homepage',
            onPressed: () {
              //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage()));
            },
          )
        ),
      body: navbarChildren[_currentIndex],
      bottomNavigationBar: BottomNavigationBar (
        onTap: onTappedBar, currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            label: "Water",
            icon: Icon(Icons.water_drop),
          ),
          BottomNavigationBarItem(
            label: "Steps",
            icon: Icon(Icons.run_circle_outlined), ),
          BottomNavigationBarItem(
            label: "Journal",
            icon: Icon(Icons.book), ),
        ],
        type: BottomNavigationBarType.fixed,
      )
    );
  } 
}