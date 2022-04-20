// SRC @ https://www.youtube.com/watch?v=18PVdmBOEQM
import 'package:flutter/material.dart';
import 'package:flutter_testing_env/steps_page.dart';
import 'package:flutter_testing_env/journal_page.dart';
import 'package:flutter_testing_env/water_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  // const ({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _currentIndex = 0;
  final List<Widget> navbarChildren =
  [
    const WaterPage(),
    const StepsPage(),
    const JournalPage(),
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
              onPressed: () {},
            )
        ),
        body: navbarChildren[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTappedBar,
          currentIndex: _currentIndex,
          selectedFontSize: 15,
          selectedIconTheme: const IconThemeData(
            size: 30,
          ),
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.water_drop),
              label: "Water",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.run_circle_outlined),
              label: "Steps",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: "Journal",
            ),
          ],
        )
    );
  }


}