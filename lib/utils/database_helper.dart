import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  String noteTable = "note_table";
  String colId = "id";
  String colTitle = "title";
  String colDescription = "description";
  String colPriority = "priority";
  String colDate = "date";

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();

    return _databaseHelper!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    // Open/create the database at a given path
    var notesDatabase = openDatabase(path, version: 1, onCreate: _createDb);
    return notesDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        "CREATE TABLE $noteTable ($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate TEXT)");
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await database;

    // var result = await db.rawQuery("SELECT * FROM $noteTable order by $colPriority ASC");
    var result = await db.query(noteTable, orderBy: "$colPriority ASC");

    return result;
  }

  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;

    List<Note> noteList = <Note>[];
    for (Map<String, dynamic> n in noteMapList) {
      noteList.add(Note.fromMapObject(n));
    }
    return noteList;
  }

  // region Insert Operation: Insert a Note object to database
  Future<int> insertNote(Note note) async {
    Database db = await database;

    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  // endregion

  // region Update Operation: Update a Note object and save it to database
  Future<int> updateNote(Note note) async {
    var db = await database;

    var result = await db.update(noteTable, note.toMap(),
        where: "$colId = ?", whereArgs: [note.id]);
    return result;
  }

  // endregion

  // region Delete Operation: Delete a Note object from database
  Future<int> deleteNote(int noteId) async {
    Database db = await database;

    var result =
        await db.delete(noteTable, where: "$colId = ?", whereArgs: [noteId]);
    return result;
  }

  // endregion

  // region Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery("SELECT COUNT (*) from $noteTable");
    int? result = Sqflite.firstIntValue(x);
    return result ?? 0;
  }
// endregion
}
