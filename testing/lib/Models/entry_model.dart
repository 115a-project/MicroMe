// Table for the entriesfinal String tableEntries = 'entries';

// Column names for the table
class EntryFields {
  // A list of all the values in the table
  static final List<String> values = [
    id, isImportant, number, title, description, time
  ];

  static final String id = '_id';
  static final String isImportant = 'isImportant';
  static final String number = 'number';
  static final String title = 'title';
  static final String description = 'description';
  static final String time = 'time';
}

// Class for the entries with all its fields

class Entry {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;

  const Entry({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  Entry copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Entry(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number:  number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  // Converting back from json to our entries type
  // createdTime and isImportant are two special cases as their types
  // are not natively supported by json and must be converted
  static Entry fromJson(Map<String, Object?> json) => Entry(
      id: json[EntryFields.id] as int?,
      isImportant: json[EntryFields.isImportant] == 1,
      number: json[EntryFields.number] as int,
      title: json[EntryFields.title] as String,
      description: json[EntryFields.description] as String,
      createdTime: DateTime.parse(json[EntryFields.time] as String)
  );

  // Function to map our values to the columns in the database
  // Converts our entrytype to a json file
  Map<String, Object?> toJson() => {
    EntryFields.id: id,
    EntryFields.title: title,
    EntryFields.isImportant: isImportant ? 1 : 0,
    EntryFields.number:number,
    EntryFields.description: description,
    EntryFields.time: createdTime.toIso8601String(),
  };
}