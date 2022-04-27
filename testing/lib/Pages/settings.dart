import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}
class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* AppBar for settings
        Properties:
        Title - Displays AppBar Title
        Leading - Leading Icon Button at top-left acts as return button
        */
      appBar: AppBar(
          title: const Text('Settings'),
          leading: IconButton(
            icon: const Icon(Icons.redo),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
      ),
      /*
      SettingsList body provides list of settings divided into individual
      sections.
      Uses settings_ui package
      Properties:
      sections - List of different settings sections
       */
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('Section 1'),
            tiles: [
              SettingsTile(
                title: const Text('Example 1'),
                leading: const Icon(Icons.language),
                onPressed: (BuildContext context) {},
              ),
            ],
          ),
          SettingsSection(
            title: const Text('Section 2'),
            tiles: [
              SettingsTile(
                title: const Text('Example 2'),
                leading: const Icon(Icons.lock),
                onPressed: (BuildContext context) {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}