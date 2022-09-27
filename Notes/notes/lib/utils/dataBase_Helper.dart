import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:notes/models/note.dart';

class DataBaseHelper {
  static DataBaseHelper _dataBaseHelper; // Singelton DataBaseHelper
  static Database _database; //Singelton database

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  DataBaseHelper._createInstance(); //Named Contructor to create instance of data base helper

  factory DataBaseHelper() {
    if (_dataBaseHelper == null) {
      //create instance of database helper only if it's Null
      _dataBaseHelper =
          DataBaseHelper._createInstance(); //executed only once "Singelton"
    }
    return _dataBaseHelper;
  }

  Future<Database> get dataBase async {
    if (_database == null) {
      _database = await initializeDataBase();
    }
    return _database;
  }

  Future<Database> initializeDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'note.db';

    //create or Open the dataBase at a given path
    var notesDataBase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return notesDataBase;
  }

  void _createDb(Database db, newVersion) async {
    await db.execute(
        'CREATE TABLE $noteTable (£colId INTEGER PRIMARY KEY AUTOINCREMENT ,$colTitle TEXT, $colDescription TEXT , $colPriority INTEGER, $colDate TEXT ) ');
  }

  //FETCH OPERATION : to Get all the note objects from the database
  getNoteMapList() async {
    Database db = await this.dataBase;
    //var result = await db.rawQuery('SELECT * From $noteTable Order By $colPriority ASC ');
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

  //Insert OPERATION : to insert a note objects to the database
  Future<int> insertInto(Note note) async {
    Database db = await this.dataBase;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  //UPDATE OPERATION : to Update a note objects from the database
  Future<int> updateNote(Note note) async {
    Database db = await this.dataBase;
    var result = await db.update(noteTable, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  //DELETE OPERATION : to Delete a note objects from the database
  Future<int> deleteNote(int id) async {
    var db = await this.dataBase;
    int result =
        await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id ');
    return result;
  }

  //Get number Of Note Objects in Database
  Future<int> getCount() async {
    Database db = await this.dataBase;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $noteTable ');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  //get the list of map from the database and convert it into List<Note>
  Future<List<Note>> getNoteList() async {
    var noteMapList = await getNoteMapList(); // get map list from the Database
    int count = noteMapList.length;

    // ignore: deprecated_member_use
    List<Note> noteList = List<Note>();
    //Create 'NoteList' From 'MapList'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }
}
