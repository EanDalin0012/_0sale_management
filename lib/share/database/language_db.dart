import 'dart:io';

import 'package:path/path.dart';
import 'package:sale_management/share/model/key/language_key.dart';
import 'package:sale_management/share/model/sqflite_field/language_field.dart';
import 'package:sqflite/sqflite.dart';

class LanguageDataBase {
  static final LanguageDataBase instance = LanguageDataBase._init();
  static Database  _dataBase;
  LanguageDataBase._init();

  Future<Database> get database async {
    if (_dataBase != null) return _dataBase;

    _dataBase = await _initDB('language.db');
    return _dataBase;
  }

  Future<Database> _initDB(String filePath) async {
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
      CREATE TABLE $languageTable ( 
        ${LanguageField.id} $integerType, 
        ${LanguageField.code} $textType,
        ${LanguageField.text} $textType,
        ${LanguageField.is_use} $boolType
        )
      ''');
  }

  static Future<int> create(Map json) async {
    final db = await instance.database;
    var data = await db.rawInsert(
        'INSERT INTO $languageTable(${LanguageField.id}, ${LanguageField.code}, ${LanguageField.text},${LanguageField.is_use}) VALUES(?, ?, ?,?)',
        [json[LanguageKey.id],json[LanguageKey.code], json[LanguageKey.text], json[LanguageKey.isUse]]);
    print('create: ${data}');
    return data;
  }

  static Future<int> update(Map json) async {
    final db = await instance.database;

    int count = await db.rawUpdate(
        'UPDATE  $languageTable SET ${LanguageField.code} = ?, ${LanguageField.text}, ${LanguageField.is_use} = ? WHERE ${LanguageField.id} = ?',
        [json[LanguageKey.code], json[LanguageKey.text], json[LanguageKey.isUse],json[LanguageKey.id] ]);
    print('updated: $count');

    return count;
  }

  static Future<Map> getLanguageById(int id) async {
    final db = await instance.database;
    print('getLanguageById: ${id}');
    List<dynamic> vData = await db.rawQuery('SELECT * FROM $languageTable WHERE id = ?', [id]);
    print('vData: ${vData}');
    if(vData.length == 1) {
      return vData[0];
    } else {
      return vData[0];
    }
  }

  // ignore: missing_return
  static Future<Map> currentSelectedLanguage() async {
    final db = await instance.database;
    final maps = await db.query(languageTable);
    print('currentSelctedLanguage: ${maps}');
    Map elementReturn;
    if(maps.length > 0) {
      maps.forEach((element) {
        print('currentSelctedLanguage: ${element[LanguageField.is_use]}');
        if(element[LanguageField.is_use] == 1) {
          print('element: ${element}');
          elementReturn =  element;
        }
      });
      return elementReturn;
    }
  }

  static Future<List<dynamic>> selectAll() async {
    final db = await instance.database;
    return await db.query(languageTable);
  }


  static Future<Map> readById(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      languageTable,
      columns: [LanguageField.id, LanguageField.code, LanguageField.text, LanguageField.is_use],
      where: '${LanguageField.id} = ?',
      whereArgs: [id],
    );
    if (maps != null && maps.length == 1) {
      return maps[0];
    } else if(maps.length > 1) {
      maps.forEach((element) {
        if(element[LanguageKey.id] == id) {
          return element;
        }
      });
    } else {
      throw Exception('ID $id not found');
    }
  }

  static Future<int> update1(Map note) async {
    Map data = {
      LanguageField.id: note[LanguageKey.id],
      LanguageField.code: note[LanguageKey.code],
      LanguageField.text: note[LanguageKey.text],
      LanguageField.is_use: note[LanguageKey.isUse]
    };

    final db = await instance.database;
    return db.update(
      languageTable,
      data,
      where: '${LanguageField.id} = ?',
      whereArgs: [note[LanguageKey.id]],
    );
  }

  static Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.rawDelete('DELETE FROM $languageTable WHERE id = ?', [id]);
  }

  static Future<int> deleteAll() async {
    final db = await instance.database;
    return await db.rawDelete('DELETE FROM $languageTable');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

}
