import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:testing/Models/entry_model.dart';
import 'package:testing/Models/water_model.dart';
import 'package:testing/Models/steps_model.dart';

// Table names declarations
const String tableJournal = 'entries';
const String tableWater = 'water';
const String tableSteps = 'steps';

/*
  Class MicromeDatabase
  Instantiates the database named Microme and is the interface for all database
  functions. This includes the CRUD methods, opening and closing the database,
  and advanced queries. The Microme database uses all async functions.

  Database queries are built by calling a database function ex: db.delete() and
  adding the necessary parameters needed for that function. SQLite stores the
  database as a text file in the local system so there has to be constant
  conversion of JSON to string and vice versa. This is done using ${object} to
  interpolate the object type into a string in which queries can be done. Each
  model also posses a fromJson() and toJson() function which is required to
  convert from String to Json to use in a Map or Json to String to access a
  single object in the map.

  Example of a read query on tableExample:
    Future<Example> readExample(int id) async {
      // Wait for the instance of the database
      final db = await instance.database;

      // Create a database query with protection from SQL injections by breaking
      // up the id into a where condition and a whereArgs to enforce a required
      // input type
      final maps = await db.query(
        tableExample, // The table to query from
        columns: ExampleFields.values, // What column(s) selected
        where: '${ExampleFields.id} = ?', // The condition
        whereArgs: [id],
      );

      // Check if the query is successful. If the map is empty that means that
      // the query was either poorly written or there was nothing found
      // matching the conditions of the query
      if (maps.isNotEmpty) {
        return Example.fromJson(maps.first);
      } else {
        throw Exception('ID $id not found');
      }
    }// Returns a singular Example object

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
    _database = await _initDB('Microme.db');
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

    await db.execute('''CREATE TABLE $tableJournal ( 
      ${EntryFields.id} $idType,
      ${EntryFields.isImportant} $boolType,
      ${EntryFields.number} $integerType,
      ${EntryFields.title} $textType,
      ${EntryFields.description} $textType,
      ${EntryFields.time} $textType
      )
    ''');

    await db.execute('''CREATE TABLE $tableWater (
      ${WaterFields.id} $idType,
      ${WaterFields.amount} $integerType,
      ${WaterFields.time} $textType
      )    
    ''');

    await db.execute('''CREATE TABLE $tableSteps (
      ${StepFields.id} $idType,
      ${StepFields.steps} $integerType,
      ${StepFields.time} $textType
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

  // Function to create a water object in the water table
  Future<Water> createWater(Water water) async {
    final db = await instance.database;
    final id = await db.insert(tableWater, water.toJson());
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

  Future<int?> returnTotalSum() async {
    final db = await instance.database;
    var value =  Sqflite.firstIntValue(await db.rawQuery('SELECT SUM(amount) FROM water'));
    return value;
  }

  Future<int?> returnTodaySum() async {
    final db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT SUM(amount) FROM water'));
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

  // Function to get the total amount of water

  // Function to create a Step object in the Step table
  Future<Step> createStep(Step step) async {
    final db = await instance.database;
    final id = await db.insert(tableWater, step.toJson());
    return step.copy(id: id);
  }

  // Function to read a Step object from the Step table
  Future<Step> readStep(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableSteps,
      columns: StepFields.values,
      // Secure against SQL injections
      where: '${StepFields.id} = ?',
      whereArgs: [id],
    );
    // Successful query
    if (maps.isNotEmpty) {
      return Step.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  // Updates a Step object that exists within the Step table
  Future<int> updateStep(Step step) async {
    final db = await instance.database;
    return db.update(
      tableSteps,
      step.toJson(),
      where: '${StepFields.id} = ?',
      whereArgs: [step.id],
    );
  }

  // Function to delete a Step object from the Step table
  Future<int> deleteStep(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableSteps,
      where: '${StepFields.id} = ?',
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