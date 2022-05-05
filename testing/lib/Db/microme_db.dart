import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testing/Models/entry_model.dart';

// Table for the entries
final String tableEntries = 'entries';

// Creating a entries database class
class MicromeDatabase {
  // Creating an instance of the entries database
  static final MicromeDatabase instance = MicromeDatabase._init();

  // Field for the database
  static Database? _database;

  // Constructor for entries database
  MicromeDatabase._init();

  Future<Database> get database async {
    // Returns the database if it already exists
    if (_database != null) return _database!;

    // Initializes the database if it does not exist and returns it
    _database = await _initDB('entries.db');
    return _database!;
  }

  // Function for initializing the database
  Future<Database> _initDB(String filePath) async {
    // Gets the file path for the databases
    final dbPath = await getDatabasesPath();
    // Creates the entire filepath for the database
    final path = join(dbPath, filePath);

    // Opens the database using the path, version number, and the database schema
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // Creates the database within the system
  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableEntries ( 
  ${EntryFields.id} $idType,
  ${EntryFields.isImportant} $boolType,
  ${EntryFields.number} $integerType,
  ${EntryFields.title} $textType,
  ${EntryFields.description} $textType,
  ${EntryFields.time} $textType
  )
''');
  }


  // Function to create an entry object in the database
  Future<Entry> create(Entry entry) async {
    final db = await instance.database;
    final id = await db.insert(tableEntries, entry.toJson());
    return entry.copy(id: id);
  }


  // Function to read an entry object from the database
  Future<Entry> readEntry(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableEntries,
      columns: EntryFields.values,
      // Secure against SQL injections
      where: '${EntryFields.id} = ?',
      whereArgs: [id],
    );
    // Successful query
    if (maps.isNotEmpty) {
      return Entry.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  // Returns all the entries in the database by descending order
  Future<List<Entry>> readAllEntries() async {
    final db = await instance.database;
    final orderBy = '${EntryFields.time} DESC';
    final result = await db.query(tableEntries, orderBy: orderBy);
    return result.map((json) => Entry.fromJson(json)).toList();
  }

  // Updates an entry that exists within the database
  Future<int> update(Entry entry) async {
    final db = await instance.database;
    return db.update(
      tableEntries,
      entry.toJson(),
      where: '${EntryFields.id} = ?',
      whereArgs: [entry.id],
    );
  }


  // Function to delete an entry from the database
  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableEntries,
      where: '${EntryFields.id} = ?',
      whereArgs: [id],
    );
  }

  // Function for closing our database
  // Fix for database closed error when switching pages
  // https://stackoverflow.com/questions/63812832/error-database-closed-when-using-flutters-sqflite
  Future close() async {
    final db = await instance.database;
    _database = null;
    return db.close();
  }
}