// SRC @ https://www.youtube.com/watch?v=18PVdmBOEQM
import 'package:flutter/material.dart';
import 'package:testing/Pages/steps_page.dart';
import 'package:testing/Pages/journal_page.dart';
import 'package:testing/Pages/water_page.dart';
import 'package:testing/Pages/homepage_page.dart';

/*
HomePage Class
Purpose - The Homepage provides the central scaffolding of the app, constructing
the AppBar and NavBar at the top and bottom respectively. The body changes
according to the specified class in the navbarChildren widget list.
 */
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  // const ({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  int _currentIndex = 0; // Indicates the starting index upon calling homepage
  // List of classes with respective files to populate body
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
    /* Scaffold for homepage
    Properties:
    AppBar - Top of page
    Body - Indexes into list of children. Each child points to separate body
    file
    BottomNavigationBar - Bottom NavBar of Page - Static unless new page opened
     */
    return Scaffold(
        /* AppBar for homepage
        Properties:
        Title - Displays AppBar Title
        Actions - Settings button at top-right
        Leading - Leading Icon Button at top-left
        */
        appBar: AppBar(
            title: const Text('Welcome to the Homepage'),
            actions: <Widget> [
              IconButton(
                icon: Image.asset('assets/settings.png'),
                tooltip: 'Settings',
                onPressed: () {},
              ),
            ],
        ),
        body: navbarChildren[_currentIndex],
        /* Homepage NavBar
        type - Fixes NavBar (needed to allow more than 3 items)
        pnTap - calls function upon tapping anywhere
        currentIndex - Indicates current icon and page to display
        selectedFontSize - Size of selected text
        selectedIconTheme - Uses IconThemeData to resize icon and zoom it upon
        selection
        items - List of BottomNavigationBarItem instances with icon/text
         */
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTappedBar,
          currentIndex: _currentIndex,
          selectedFontSize: 15,
          selectedIconTheme: const IconThemeData(
            size: 50,
          ),
          //selectedItemColor: Colors.red,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          iconSize: 38,
          items: const [
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/home.png'),
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/water.png'),
              ),
              label: "Water",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/steps.png'),
              ),
              label: "Steps",
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/journal.png'),
              ),
              label: "Journal",
            ),
          ],
        )
    );
  }


}