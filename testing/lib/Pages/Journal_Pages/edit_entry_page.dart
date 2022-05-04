import 'package:flutter/material.dart';
import 'package:testing/Db/microme_db.dart';
import 'package:testing/Models/entry_model.dart';
import 'package:testing/Widgets/entry_form_widget.dart';

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
  Widget build(BuildContext context) => Scaffold(
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

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateEntry,
        child: Text('Save'),
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

  Future updateEntry() async {
    final entry = widget.entry!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
    );

    await MicromeDatabase.instance.update(entry);
  }

  Future addEntry() async {
    final entry = Entry(
      title: title,
      isImportant: true,
      number: number,
      description: description,
      createdTime: DateTime.now(),
    );

    await MicromeDatabase.instance.create(entry);
  }
}