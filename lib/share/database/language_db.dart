
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
        ${LanguageField.id} $idType, 
        ${LanguageField.code} $textType,
        ${LanguageField.text} $textType,
        ${LanguageField.is_use} $boolType,
        )
      ''');
  }

  Future<Map> create(Map note) async {
    final db = await instance.database;

    final json = note;
    final columns = '${LanguageField.id}, ${LanguageField.code}, ${LanguageField.text},  ${LanguageField.is_use}';
    final values = '${json[LanguageKey.id]}, ${json[LanguageKey.code]}, ${json[LanguageKey.text]},${json[LanguageKey.isUse]}';

    var data = await db.rawInsert('INSERT INTO $languageTable ($columns) VALUES ($values)');
    print('create: ${data}');
    return json;
  }



  Future<Map> readById(int id) async {
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

  Future<int> update(Map note) async {
    final db = await instance.database;
    return db.update(
      languageTable,
      note,
      where: '${LanguageField.id} = ?',
      whereArgs: [note[LanguageKey.id]],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

}