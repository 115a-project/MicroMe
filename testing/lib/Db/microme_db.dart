import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testing/Models/entry_model.dart';
import 'package:testing/Models/water_model.dart';

// Table names declarations
const String tableJournal = 'entries';
const String tableWater = 'water';

/*
  Class MicromeDatabase
  Instantiates the database named Microme and is the interface for all database
  functions. This includes the CRUD methods, opening and closing the database,
  and advanced queries. The Microme database uses all async functions.
 */
class MicromeDatabase {
  // Creating an instance of the Microme database
  static final MicromeDatabase instance = MicromeDatabase._init();

  // Field for the database
  static Database? _database;

  // Constructor for Microme database
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
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableJournal ( 
  ${EntryFields.id} $idType,
  ${EntryFields.isImportant} $boolType,
  ${EntryFields.number} $integerType,
  ${EntryFields.title} $textType,
  ${EntryFields.description} $textType,
  ${EntryFields.time} $textType
  )
''');

    await db.execute('''
CREATE TABLE $tableWater (
  ${WaterFields.id} $idType,
  ${WaterFields.amount} $integerType,
  ${WaterFields.time} $textType
  )    
''');
  }

  // Function to create an entry object in the journal table
  Future<Entry> createEntry(Entry entry) async {
    final db = await instance.database;
    final id = await db.insert(tableJournal, entry.toJson());
    return entry.copy(id: id);
  }

  // Function to read an entry object from the journal table
  Future<Entry> readEntry(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableJournal,
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

  // Returns all the entries objects in the journal table in descending order
  Future<List<Entry>> readAllEntries() async {
    final db = await instance.database;
    const orderBy = '${EntryFields.time} DESC';
    final result = await db.query(tableJournal, orderBy: orderBy);
    return result.map((json) => Entry.fromJson(json)).toList();
  }

  // Updates an entry object that exists within the journal table
  Future<int> updateEntry(Entry entry) async {
    final db = await instance.database;
    return db.update(
      tableJournal,
      entry.toJson(),
      where: '${EntryFields.id} = ?',
      whereArgs: [entry.id],
    );
  }

  // Function to delete an entry object from the journal table
  Future<int> deleteEntry(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableJournal,
      where: '${EntryFields.id} = ?',
      whereArgs: [id],
    );
  }

  // Function to create an water object in the water table
  Future<Water> createWater(Water water) async {
    final db = await instance.database;
    final id = await db.insert(tableJournal, water.toJson());
    return water.copy(id: id);
  }

  // Function to read a water object from the water table
  Future<Water> readWater(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableWater,
      columns: WaterFields.values,
      // Secure against SQL injections
      where: '${WaterFields.id} = ?',
      whereArgs: [id],
    );
    // Successful query
    if (maps.isNotEmpty) {
      return Water.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  // Returns all the water objects in the water table in ascending order
  Future<List<Water>> readAllWater() async {
    final db = await instance.database;
    const orderBy = '${WaterFields.time} ASC';
    final result = await db.query(tableWater, orderBy: orderBy);
    return result.map((json) => Water.fromJson(json)).toList();
  }

  // Updates a water object that exists within the water table
  Future<int> updateWater(Water water) async {
    final db = await instance.database;
    return db.update(
      tableWater,
      water.toJson(),
      where: '${WaterFields.id} = ?',
      whereArgs: [water.id],
    );
  }

  // Function to delete a water object from the water table
  Future<int> deleteWater(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableWater,
      where: '${WaterFields.id} = ?',
      whereArgs: [id],
    );
  }

  // Function for closing database
  // Fix for database closed error when switching pages
  // https://stackoverflow.com/questions/63812832/error-database-closed-when-using-flutters-sqflite
  Future close() async {
    final db = await instance.database;
    _database = null;
    return db.close();
  }
}