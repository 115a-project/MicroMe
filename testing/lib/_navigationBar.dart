// SRC @ https://www.youtube.com/watch?v=18PVdmBOEQM
import 'package:flutter/material.dart';
import 'package:flutter_application_1/water.dart';
import 'package:flutter_application_1/steps.dart';
import 'package:flutter_application_1/journal.dart';

class bottom_nav_bar extends StatefulWidget {
  // const ({ Key? key }) : super(key: key);

  @override
  _navigationBar createState() => _navigationBar();
}

class _navigationBar extends State<bottom_nav_bar> {

  // determines which nav_child is being picked: water, journal, ...
  int _currentIndex = 0;
  final List<Widget> _nav_bar_children = 
  [
    water(),
    steps(),
    journal(),
  ];

  // Allows tapping fucntionality
  void onTappedBar(int index) {
    setState() {
      _currentIndex = index;
    }
  }

  @override
  Widget build(BuildContext context) 
  {
    return new Scaffold(
      body: _nav_bar_children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar (

        onTap: onTappedBar, currentIndex: _currentIndex, 

        items: [
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
