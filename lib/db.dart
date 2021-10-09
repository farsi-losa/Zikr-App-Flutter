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
          'CREATE TABLE dzikirs(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT, qty INTEGER, timer INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> deleteUser(int id) async {
    print(id);
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

  Future<int> updateUser(Dzikir dzikir) async {
    final db = await initializeDB();
    var result = await db.update("dzikirs", dzikir.toMap(),
        where: "id = ?", whereArgs: [dzikir.id]);
    return result;
  }

  Future<List<Dzikir>> retrieveDzikirs() async {
    final Database db = await initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('dzikirs');
    // return queryResult.map((e) => Dzikir.fromMap(e)).toList();
    print(maps);
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

class Dzikir {
  final String name;
  final int qty;
  final int timer;
  final int? id;

  Dzikir({required this.name, required this.qty, required this.timer, this.id});

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'qty': qty,
      'timer': timer,
      'id': id,
    };
  }

  // Implement toString to make it easier to see information about
  @override
  String toString() {
    return 'Dzikir{id: $id, name: $name, qty: $qty, timer: $timer}';
  }
}
