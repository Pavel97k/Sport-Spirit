import 'package:flutter/foundation.dart';
import 'package:SportSpirit/features/data/global_service.dart';
import 'package:SportSpirit/features/data/sqlite/service/database.dart';
import 'package:sqflite/sqflite.dart';

import '../models/local_collection_lite.dart';

class CollectionLiteRep {
  CollectionLiteRep();

  Future<CollectionLite> getItemById(int id) async {
    try {
      final data =
          await service<DBHelper>().getDataById(id, 'local_collection_lite');
      return CollectionLite.fromJson(data!);
    } on DatabaseException catch (ex) {
      if (kDebugMode) {
        print(ex.result);
      }
      throw ex.hashCode;
    }
  }

  Future<List<CollectionLite>> getAll(
      int page, int pageSize, int gender) async {
    try {
      final data = await service<DBHelper>()
          .getDataAll('local_collection_lite', page, pageSize, gender: gender);
      return data.map((item) => CollectionLite.fromJson(item)).toList();
    } on DatabaseException catch (ex) {
      if (kDebugMode) {
        print(ex.result);
      }
      throw ex.hashCode;
    }
  }

  Future<void> insert(CollectionLite data) async {
    try {
      List<Map<String, dynamic>> dataList = [data.toJson()];
      return await service<DBHelper>()
          .insertLargeData('local_collection_lite', dataList);
    } on DatabaseException catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<int> update(CollectionLite data, int id) async {
    try {
      return await service<DBHelper>()
          .updateData('local_collection_lite', data.toJson(), id);
    } on DatabaseException catch (ex) {
      print(ex.result);

      throw ex.hashCode;
    }
  }

  Future<int> delete(int id) async {
    try {
      return await service<DBHelper>().deleteData('local_collection_lite', id);
    } on DatabaseException catch (ex) {
      if (kDebugMode) {
        print(ex.result);
      }
      throw ex.hashCode;
    }
  }
}
