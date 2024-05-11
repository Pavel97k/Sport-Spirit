import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sport_spirit/features/data/global_service.dart';
import 'package:sport_spirit/features/utils/crypto/crypto_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DBHelper {
  static final DBHelper _instance = DBHelper.internal();
  factory DBHelper() => _instance;
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  DBHelper.internal();

  Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'my_sport_spirit.db');
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    var dbInitScript = await rootBundle.loadString('assets/sport_spirit.sql');

    dbInitScript.split(';').forEach((element) async {
      if (element.isNotEmpty) {
        await db.execute(element);
      }
    });
  }

  Future<Map<String, dynamic>?> getDataById(int id, String tableName) async {
    Database database = await db;
    List<Map<String, dynamic>> results = await database.query(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    List<Map<String, dynamic>> decryptedResult = results
        .map((item) => service<EncryptHelper>().decryptData(item))
        .toList();
    if (results.isNotEmpty) {
      return decryptedResult.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getDataAll(
      String tableName, int page, int pageSize,
      {int? gender, int? collectionId, bool? unique, bool? having}) async {
    Database database = await db;
    return await database.transaction((txn) async {
      String whereClause = '';
      if (gender != 0 && gender != null) {
        whereClause = 'genderName = "${gender == 1 ? 'М' : 'Ж'}"';
      } else if (collectionId != 0 && collectionId != null) {
        whereClause = 'collectionServerId = $collectionId';
      }

      String query = 'SELECT * FROM $tableName';
      if (unique != null && unique) {
        query =
            'SELECT DISTINCT id, exerciseName, exerciseDescriptions, muscleGroup, collectionServerId, exerciseCriteriaId FROM $tableName';
      } else if (having != null && having) {
        query =
            'SELECT exerciseName, COUNT(*) FROM $tableName WHERE $whereClause GROUP BY exerciseName HAVING COUNT(*) > 1';
      }
      if (whereClause.isNotEmpty) {
        query += ' WHERE $whereClause';
      }
      if (pageSize != 0 || page != 0) {
        query += ' LIMIT $pageSize OFFSET ${(page - 1) * pageSize};';
      }

      List<Map<String, dynamic>> result = await txn.rawQuery(query);
      List<Map<String, dynamic>> decryptedResult = result
          .map((item) => service<EncryptHelper>().decryptData(item))
          .toList();

      if (kDebugMode) {
        print('$result \n $decryptedResult');
      }
      return decryptedResult;
    });
  }

  Future<void> insertLargeData(
      String tableName, List<Map<String, dynamic>> data) async {
    Database database = await db;
    await database.transaction((txn) async {
      try {
        for (var item in data) {
          var encryptedItem = service<EncryptHelper>().encryptData(item);
          await txn.insert(tableName, encryptedItem);
        }
      } catch (e) {
        print('Произошла ошибка во время транзакции с базой данных: $e');
      }
    });
  }

  Future<int> updateData(
      String tableName, Map<String, dynamic> data, int id) async {
    Database database = await db;
    return await database.transaction((txn) async {
      return await txn.update(
        tableName,
        data,
        where: 'id = ?',
        whereArgs: [id],
      );
    });
  }

  Future<int> deleteData(String tableName, int id) async {
    Database database = await db;
    return await database.transaction((txn) async {
      return await txn.delete(
        tableName,
        where: 'id = ?',
        whereArgs: [id],
      );
    });
  }
}
