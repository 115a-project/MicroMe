// SRC @ https://www.youtube.com/watch?v=18PVdmBOEQM
import 'package:flutter/material.dart';
import 'package:testing/water.dart';
import 'package:testing/steps.dart';
import 'package:testing/journal.dart';

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
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Screen2()));
            },
          )
        ),
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



class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Screen2()));
            },
          )
        ),

        body: const Center(
          child: Text('Welcome!')
        ),
        bottomNavigationBar: bottom_nav_bar(),
    );
  }
}

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);

  @override
  _Screen2State createState() => _Screen2State();
}
class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Navigate to a new screen on Button click'),
          leading: IconButton(
            icon: const Icon(Icons.redo),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyHomePage()));
            },
          ),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Colors.blue,
                  Colors.green
                ]
              ),
            ),
          ),
      ),
    );
  }
}
