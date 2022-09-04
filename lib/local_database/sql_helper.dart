import 'dart:io';

import 'package:get/get.dart';
import 'package:inbox_clients/util/app_shaerd_data.dart';
import 'package:inbox_clients/util/sh_util.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'model/cart_model.dart';

class SqlHelper {
  //todo this singleton
  SqlHelper._();
  static final SqlHelper instance = SqlHelper._();
  factory SqlHelper() => instance;

  //todo this is column
   final String tableName = "Cart";
   final String id = "id";
   final String userId = "userId";
   final String taskColumn = "task";
   final String boxColumn = "box";
   final String boxItemColumn = "boxItem";
   final String orderTimeColumn = "orderTime";
   final String addressColumn = "address";
   final String titleColumn = "title";
   final String firstPickUpColumn = "isFirstPickUp";

  //todo this is db init
  Database? _db;
  final int dbVersion = 2;
  initDataBase() async {
    if (GetUtils.isNull(_db)) {
      _db = await createDatabase();
    }
    return _db;
  }

  Future<Database> createDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "InboxClintCart.db");
    Database database = await openDatabase(
      path,
      version: dbVersion,
      onCreate: (db, version) => _createTableDatabase(db, version),
      onUpgrade: (db, oldVersion, newVersion) => _onUpgrade(db, oldVersion, newVersion),
      onDowngrade: (db, oldVersion, newVersion) => _onDownGrade(db, oldVersion, newVersion),
    );
    return database;
  }

  _createTableDatabase(Database db, int version) async {
    await db.execute(_crateTableCart().toString());
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) {
    db.execute("DROP TABLE IF EXISTS $tableName");
  }

  _onDownGrade(Database db, int oldVersion, int newVersion) {
    db.execute("DROP TABLE IF EXISTS $tableName");
  }

   String? _crateTableCart() {
    return '''
    CREATE TABLE $tableName(
    $id INTEGER PRIMARY KEY AUTOINCREMENT,
    $userId TEXT,
    $taskColumn Blob NULL,
    $boxColumn Blob NULL,
    $boxItemColumn Blob NULL,
    $orderTimeColumn Blob NULL,
    $addressColumn Blob NULL,
    $titleColumn TEXT NULL,
    $firstPickUpColumn TEXT NULL
    )
 ''';
  }

  //todo this for data
  Future<int> insertDataToDatabase(CartModel data) async {
    try {
      //todo #[conflictAlgorithm]# to remove duplicate
      var remove = data.toJson();
      remove.remove(id);
      return _db!.insert(tableName, remove,  conflictAlgorithm: ConflictAlgorithm.ignore , );
    } catch (e) {
      Logger().d(e);
      snackError(tr.error_occurred, e.toString());
      return -1;
    }
  }



  //todo this for data
  Future<int> updateDataToDatabase(CartModel data) async {
    try {
      return await _db!.update(tableName, data.toJson(), where: "$id=? AND $userId=?", whereArgs: ["${data.id}" , "${SharedPref.instance.getCurrentUserData().id.toString()}"]);
    } catch (e) {
      Logger().d(e);
      snackError(tr.error_occurred, e.toString());
      return -1;
    }
  }

  Future<List<Map<String, Object?>>>? selectAllDataFromDatabase() async {
    try {
      return await _db!.query(tableName , where:"$userId=?" , whereArgs: ["${SharedPref.instance.getCurrentUserData().id.toString()}"],/*distinct: true ,groupBy: boxColumn ,*/);
    } catch (e) {
      Logger().d(e);
      throw Exception(e);
    }
  }

  Future<List<Map<String, Object?>>>? selectAllDataFromDatabaseWhere(var userIdAtt) async {
    try {
      return await _db!.query(tableName, where: "$id=? AND $userId=?", whereArgs: ["$userIdAtt" , "${SharedPref.instance.getCurrentUserData().id.toString()}"]);
    } catch (e) {
      Logger().d(e);
      throw Exception(e);
    }
  }

  Future<int> deleteDataFromDatabase(CartModel data) async {
    try {
      // return await _db!.rawDelete("""
      // DELETE FROM $tableName
      // WHERE $id = ${data.id} AND $userId= ${SharedPref.instance.getCurrentUserData().id.toString()};
      // """,[]);
       return await _db!.delete(tableName, where: "$id=? AND $userId=?", whereArgs: ["${data.id}" , "${SharedPref.instance.getCurrentUserData().id.toString()}"]);
    } catch (e) {
      Logger().d(e);
      throw Exception(e);
    }
  }

  deleteDatabases() async {
    try {
      var count = Sqflite.firstIntValue(
          await _db!.rawQuery('SELECT COUNT(*) FROM $tableName'));
      if (GetUtils.isNull(count) || count == 0) {
        return -1;
      } else {
        return /*await database.delete(tableName,)*/ await _db!
            .execute("delete from " + tableName);
      }
    } catch (e) {
      Logger().d(e);
      throw Exception(e);
    }
  }
}
