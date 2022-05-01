import 'package:flutter/material.dart';
import 'package:testing/Models/note_model.dart';

/* EditEntryPage Class
   Purpose - Provides the user with a way to create or edit
   an entry within the journal portion of the app. Right now
   it has an extra parameter that must be passed in which is
   the note onject.
 */
class EditEntryPage extends StatefulWidget {
  const EditEntryPage({Key? key, this.note}) : super(key: key);

  final Note? note;

  @override
  State<EditEntryPage> createState() => _EditEntryPageState();
}

class _EditEntryPageState extends State<EditEntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Journal Page"),
      appBar: AppBar(
        title: const Text('Edit test'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          }
        ),
      ),
    );
  }
}
