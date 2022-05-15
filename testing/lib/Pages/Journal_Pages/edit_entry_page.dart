import 'package:flutter/material.dart';
import 'package:testing/Db/microme_db.dart';
import 'package:testing/Models/entry_model.dart';
import 'package:testing/Widgets/entry_form_widget.dart';

/*
  Class - AddEditEntryPage
  This page is the one that implements the ability to create or edit an
  entry within the journal. Adding a new entry and editing an existing entry
  share the same page because they practically do the same thing.
 */

class AddEditEntryPage extends StatefulWidget {
  final Entry? entry;

  const AddEditEntryPage({
    Key? key,
    this.entry,
  }) : super(key: key);
  @override
  _AddEditEntryPageState createState() => _AddEditEntryPageState();
}

class _AddEditEntryPageState extends State<AddEditEntryPage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    isImportant = widget.entry?.isImportant ?? false;
    number = widget.entry?.number ?? 0;
    title = widget.entry?.title ?? '';
    description = widget.entry?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [buildButton()],
      ),
      body: Form(
        key: _formKey,
        child: EntryFormWidget(
          isImportant: isImportant,
          number: number,
          title: title,
          description: description,
          onChangedImportant: (isImportant) =>
              setState(() => this.isImportant = isImportant),
          onChangedNumber: (number) => setState(() => this.number = number),
          onChangedTitle: (title) => setState(() => this.title = title),
          onChangedDescription: (description) =>
              setState(() => this.description = description),
        ),
      ),
    );
  }

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateEntry,
        child: const Text('Save'),
      ),
    );
  }

  void addOrUpdateEntry() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.entry != null;

      if (isUpdating) {
        await updateEntry();
      } else {
        await addEntry();
      }

      Navigator.of(context).pop();
    }
  }

  /*
  Function - updateEntry
    This function creates an entry of an already existing entry in the journal
    and updates the journal table with the new info provided in the copied
    version of the entry.
   */

  Future updateEntry() async {
    final entry = widget.entry!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
    );

    await MicromeDatabase.instance.update(entry);
  }

  /*
  Function - addEntry
    This function works similarly to updateEntry but instead of creating a copy
    of an existing entry, it creates an entirely new entry object. It then uses
    the createEntry function created in the microme_db file to create a new
    entry inside of the journal table.
   */

  Future addEntry() async {
    final entry = Entry(
      title: title,
      isImportant: true,
      number: number,
      description: description,
      createdTime: DateTime.now(),
    );

    await MicromeDatabase.instance.createEntry(entry);
  }
}