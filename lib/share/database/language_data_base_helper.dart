import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart';
import 'package:sale_management/share/static/language_static.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class LanguageDatabaseHelper {

  // This is the actual database filename that is saved in the docs directory.
  static final _databaseName = "MyDatabase.db";
  // Increment this version when you need to change the schema.
  static final _databaseVersion = 1;

  LanguageDatabaseHelper._privateConstructor();
  static final LanguageDatabaseHelper instance = LanguageDatabaseHelper._privateConstructor();
  // Only allow a single open connection to the database.
  static Database _database;
  Future<Database> get database async {
    try {
      if (_database != null) return _database;
      _database = await _initDatabase();
      return _database;
    } catch (e) {
      Fluttertoast.showToast(
          msg: "database catch:"+e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      throw e;
      }

  }

  // open the database
  _initDatabase() async {
    try {
      // The path_provider plugin gets the right directory for Android or iOS.
      // Directory documentsDirectory = await getApplicationDocumentsDirectory();
      String dir = (await getApplicationDocumentsDirectory()).path;
      String path = join(dir, _databaseName);
      Fluttertoast.showToast(
          msg: "_initDatabase path:"+path.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      MemoryStore.path = path;
      // Open the database. Can also add an onUpdate callback parameter.
      return await openDatabase(path,
          version: _databaseVersion,
          onCreate: _onCreate);
    }catch(e) {
      Fluttertoast.showToast(
          msg: "_initDatabase catch:"+e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      throw e;
    }
  }

  // SQL string to create the database
  Future _onCreate(Database db, int version) async {
    try {
      await db.execute('''
              CREATE TABLE $tableWords (
                $columnId INTEGER PRIMARY KEY,
                $columnWord TEXT NOT NULL,
                $columnFrequency INTEGER NOT NULL
              )
              ''');
    }catch(e) {
      Fluttertoast.showToast(
          msg: "_onCreate catch:"+e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      throw e;
    }

  }

  Future<int> insert(Word word) async {
    try{
      Database db = await database;
      int id = await db.insert(tableWords, word.toMap());
      return id;
    }catch(e) {
      Fluttertoast.showToast(
          msg: "insert catch:"+e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      throw e;
    }

  }

  Future<Word> queryWord(int id) async {
    try{
      Database db = await database;
      List<Map> maps = await db.query(tableWords,
          columns: [columnId, columnWord, columnFrequency],
          where: '$columnId = ?',
          whereArgs: [id]);
      if (maps.length > 0) {
        return Word.fromMap(maps.first);
      }
      return null;
    }catch(e) {
      Fluttertoast.showToast(
          msg: "queryWord catch:"+e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      throw e;
    }

  }


}


// database table and column names
final String tableWords = 'words';
final String columnId = '_id';
final String columnWord = 'word';
final String columnFrequency = 'frequency';

class Word {

  int id;
  String word;
  int frequency;

  Word();

  // convenience constructor to create a Word object
  Word.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    word = map[columnWord];
    frequency = map[columnFrequency];
  }

  // convenience method to create a Map from this Word object
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnWord: word,
      columnFrequency: frequency
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'Word = {id: $id, word: $word, frequency: $frequency}';
  }
}
