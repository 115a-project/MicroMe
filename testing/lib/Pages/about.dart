import 'package:flutter/material.dart';
import 'package:about/about.dart';
import 'package:testing/Utils/notificationservice.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}
class _SettingsState extends State<Settings> {

  void goalMet(goal)  {
    if (!goal) {
      NotificationService().showNotification(1, "title", "body", 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isIOS = theme.platform == TargetPlatform.iOS;

    return const AboutPage(
      // values: {
      //   'version': '1.0',
      //   'year': DateTime.now().year.toString(),
      // },
      applicationVersion: 'Version 1.0',
      applicationDescription: Text("MicroMe - Taking care of taking care of you"),
      applicationIcon: ImageIcon(
        AssetImage('assets/journal.png'),
        size: 100,
      ),
      children: <Widget>[
        MarkdownPageListTile(
          filename: 'CHANGELOG.md',
          title: Text('Purpose'),
          icon: Icon(Icons.view_list),
        ),
        MarkdownPageListTile(
          filename: 'LICENSE.md',
          title: Text('App Tutorial'),
          icon: Icon(Icons.description),
        ),
        MarkdownPageListTile(
          filename: 'CONTRIBUTING.md',
          title: Text('Contributors'),
          icon: Icon(Icons.share),
        ),
        MarkdownPageListTile(
          filename: 'CODE_OF_CONDUCT.md',
          title: Text('Acknowledgements'),
          icon: Icon(Icons.sentiment_satisfied),
        ),
        MarkdownPageListTile(
          filename: 'README.md',
          title: Text('View Readme'),
          icon: Icon(Icons.all_inclusive),
        ),
      ],
    );
  }
}