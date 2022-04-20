// SRC @ https://www.youtube.com/watch?v=18PVdmBOEQM
import 'package:flutter/material.dart';
import 'package:testing/Pages/steps_page.dart';
import 'package:testing/Pages/journal_page.dart';
import 'package:testing/Pages/water_page.dart';
import 'package:testing/Pages/homepage_page.dart';

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
    const Home(),
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
            color: Colors.blue
          ),
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
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