import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'dzikir_database.db'),
      onCreate: (database, version) async {
        await database.execute(
          'CREATE TABLE dzikirs(id INTEGER PRIMARY KEY, name TEXT, qty INTEGER, timer INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> deleteUser(int id) async {
    final db = await initializeDB();
    await db.delete(
      'dzikirs',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> insertUser(List<Dzikir> dzikirs) async {
    int result = 0;
    final Database db = await initializeDB();
    for (var dzikir in dzikirs) {
      result = await db.insert('dzikirs', dzikir.toMap());
    }
    return result;
  }

  Future<List<Dzikir>> retrieveDzikirs() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('dzikirs');
    // return queryResult.map((e) => Dzikir.fromMap(e)).toList();
    return List.generate(maps.length, (i) {
      return Dzikir(
        id: maps[i]['id'],
        name: maps[i]['name'],
        qty: maps[i]['qty'],
        timer: maps[i]['timer'],
      );
    });
  }
}

// void databaseDzikir() async {
//   // Avoid errors caused by flutter upgrade.
//   // Importing 'package:flutter/widgets.dart' is required.
//   WidgetsFlutterBinding.ensureInitialized();
//   // Open the database and store the reference.
//   final database = openDatabase(
//     // Set the path to the database. Note: Using the `join` function from the
//     // `path` package is best practice to ensure the path is correctly
//     // constructed for each platform.
//     join(await getDatabasesPath(), 'dzikir_database.db'),
//     // When the database is first created, create a table to store dzikirs.
//     onCreate: (db, version) {
//       // Run the CREATE TABLE statement on the database.
//       return db.execute(
//         'CREATE TABLE dzikirs(id INTEGER PRIMARY KEY, name TEXT, qty INTEGER, timer INTEGER)',
//       );
//     },
//     // Set the version. This executes the onCreate function and provides a
//     // path to perform database upgrades and downgrades.
//     version: 1,
//   );

//   Future<void> insertDzikir(Dzikir dzikir) async {
//     // Get a reference to the database.
//     final db = await database;

//     // Insert the Dog into the correct table. You might also specify the
//     // `conflictAlgorithm` to use in case the same dog is inserted twice.
//     //
//     // In this case, replace any previous data.
//     await db.insert(
//       'dzikirs',
//       dzikir.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   Future<List<Dzikir>> dzikirs() async {
//     // Get a reference to the database.
//     final db = await database;

//     // Query the table for all The Dogs.
//     final List<Map<String, dynamic>> maps = await db.query('dzikirs');

//     // Convert the List<Map<String, dynamic> into a List<Dog>.
//     return List.generate(maps.length, (i) {
//       return Dzikir(
//         id: maps[i]['id'],
//         name: maps[i]['name'],
//         qty: maps[i]['qty'],
//         timer: maps[i]['timer'],
//       );
//     });
//   }

//   // Create a Dog and add it to the dogs table
//   var fido = Dzikir(id: 0, name: 'Fido', qty: 35, timer: 1000);

//   await insertDzikir(fido);

//   // Now, use the method above to retrieve all the dogs.
//   print(await dzikirs()); // Prints a list that include Fido.
// }

class Dzikir {
  final int id;
  final String name;
  final int qty;
  final int timer;

  Dzikir({
    required this.id,
    required this.name,
    required this.qty,
    required this.timer,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'qty': qty,
      'timer': timer,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Dzikir{id: $id, name: $name, qty: $qty, timer: $timer}';
  }
}
