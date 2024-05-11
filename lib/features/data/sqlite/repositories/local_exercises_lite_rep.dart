import 'package:flutter/foundation.dart';
import 'package:sport_spirit/features/data/api/models/exercises.dart';
import 'package:sport_spirit/features/data/global_service.dart';
import 'package:sport_spirit/features/data/sqlite/models/local_exercises_lite.dart';
import 'package:sport_spirit/features/data/sqlite/service/database.dart';
import 'package:sqflite/sqflite.dart';

class ExercisesLiteRep {
  ExercisesLiteRep();

  Future<ExercisesLite> getItemById(int id) async {
    try {
      final data =
          await service<DBHelper>().getDataById(id, 'local_exercises_lite');
      return ExercisesLite.fromJson(data!);
    } on DatabaseException catch (ex) {
      if (kDebugMode) {
        print(ex.result);
      }
      throw ex.hashCode;
    }
  }

  Future<List<ExercisesLite>> getAll(int page, int pageSize, int collectionId,
      {bool? unique, bool? having}) async {
    try {
      unique ??= false;
      having ??= false;
      final data = await service<DBHelper>().getDataAll(
          'local_exercises_lite', page, pageSize,
          collectionId: collectionId, unique: unique, having: having);
      return data.map((item) => ExercisesLite.fromJson(item)).toList();
    } on DatabaseException catch (ex) {
      if (kDebugMode) {
        print(ex.result);
      }
      throw ex.hashCode;
    }
  }

  Future<void> insert(List<ExercisesLite> data) async {
    try {
      List<Map<String, dynamic>> dataList = [];
      for (var element in data) {
        dataList.add(element.toJson());
      }
      return await service<DBHelper>()
          .insertLargeData('local_exercises_lite', dataList);
    } on DatabaseException catch (ex) {
      if (kDebugMode) {
        print(ex.result);
      }
      rethrow;
    }
  }

  Future<int> update(Exercises data, int id) async {
    try {
      return await service<DBHelper>()
          .updateData('local_exercises_lite', data.toJson(), id);
    } on DatabaseException catch (ex) {
      if (kDebugMode) {
        print(ex.result);
      }

      throw ex.hashCode;
    }
  }

  Future<int> delete(int id) async {
    try {
      return await service<DBHelper>().deleteData('local_exercises_lite', id);
    } on DatabaseException catch (ex) {
      if (kDebugMode) {
        print(ex.result);
      }
      throw ex.hashCode;
    }
  }
}
