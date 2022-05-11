import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:testing/Db/microme_db.dart';
import 'package:testing/Models/entry_model.dart';
import 'package:testing/Pages/Journal_Pages/edit_entry_page.dart';
import 'package:testing/Pages/Journal_Pages/entry_detail_page.dart';
import 'package:testing/Widgets/entry_card_widget.dart';

/*
  EntriesPage Class
  Purpose - This class serves to build the page that displays all the entries of
  the journal. It is a stateful page and employs many functions in and out of file

 */

class EntriesPage extends StatefulWidget {
  @override
  _EntriesPageState createState() => _EntriesPageState();
}

/*
  _EntriesPageState Class
  Purpose - This class handles the actual execution and manipulation of the state
  of the EntriesPage class. It overrides some of the functions present in the
  state class.
 */

class _EntriesPageState extends State<EntriesPage> {
  late List<Entry> entriesList;
  bool isLoading = false;
  /*
  initState function
  This function is an override of the default initState function, with the
  difference that everytime it is called, the function refreshEntries
  queries the database to display the new state of the journal entries database.
   */

  @override
  void initState() {
    super.initState();

    refreshEntries();
  }

  /*
  dispose function
  This function overrides the default dispose function, with the difference that
  when it is called, it ensures to close the journal entry database.
   */

  @override
  void dispose() {
    MicromeDatabase.instance.close();

    super.dispose();
  }

  Future refreshEntries() async {
    setState(() => isLoading = true);

    this.entriesList = await MicromeDatabase.instance.readAllEntries();

    setState(() => isLoading = false);
  }

  /*
  Widget - build
    Utilizes the scaffold property to build the page for displaying the entries
    It then checks if the list of entries and empty. If the list is not empty
    it utilizes the buildEntries function to pull the list of entries from the
    database.
   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : entriesList.isEmpty
            ? Text(
          'No Entries',
          style: TextStyle(color: Colors.white, fontSize: 24),
        )
            : buildEntries(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => AddEditEntryPage()),
          );

          refreshEntries();
        },
      ),
    );
  }

  /*
  Widget - buildEntries
    This widget utilizes a StaggeredGridView countBuilder counstructor to create
    the display of all the entries. There are three required arguments for
    the constructor: itemBuilder, crossAxisCount, and staggeredTileBuilder.

   */

  Widget buildEntries() {
    return StaggeredGridView.countBuilder(
      padding: EdgeInsets.all(8),
      itemCount: entriesList.length,
      staggeredTileBuilder: (index) => StaggeredTile.fit(2),
      crossAxisCount: 4,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      itemBuilder: (context, index) {
        final entry = entriesList[index];
        return GestureDetector(
          onTap: () async {
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => EntryDetailPage(entryId: entry.id!),
            ));

            refreshEntries();
          },
          child: EntryCardWidget(entry: entry, index: index),
        );
      },
    );
  }
}