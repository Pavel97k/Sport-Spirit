import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sport_spirit/features/data/api/models/collection_server.dart';
import 'package:sport_spirit/features/data/global_service.dart';
import 'package:sport_spirit/features/data/api/service/service_api.dart';

class CollectionServerRep {
  CollectionServerRep();

  Future<List<CollectionServer>> getAllCollectionServer(
      int page, int pageSize, int gender, bool? logic) async {
    try {
      final response = await service.get<ServiceAPI>().getData(
          'СollectionServer?page=$page&pageSize=$pageSize&gender=$gender&logic=${logic ?? ''}',
          '');
      final List<dynamic> data = response.data;
      return data.map((e) => CollectionServer.fromJson(e)).toList();
    } on DioException catch (ex) {
      if (kDebugMode) {
        print(ex.message);
      }
      throw ex.response?.data;
    }
  }

  Future<CollectionServer> getCollectionServer(int id) async {
    try {
      final response =
          await service.get<ServiceAPI>().getData('CollectionServer/$id', null);
      return CollectionServer.fromJson(response.data);
    } on DioException catch (ex) {
      if (kDebugMode) {
        print(ex.message);
      }
      throw ex.response?.data;
    }
  }

  Future<CollectionServer> deleteLogicCollectionServer(
      int id, String? token) async {
    try {
      final response = await service
          .get<ServiceAPI>()
          .deleteData('СollectionServer/$id?logical=true', token);
      return CollectionServer.fromJson(response.data);
    } on DioException catch (ex) {
      if (kDebugMode) {
        print(ex.message);
      }
      throw ex.response?.data;
    }
  }

  Future<CollectionServer> updateLogicCollectionServer(
      int id, String? token) async {
    try {
      final response = await service
          .get<ServiceAPI>()
          .putLogicData('СollectionServer/logic/$id', token);
      return CollectionServer.fromJson(response.data);
    } on DioException catch (ex) {
      if (kDebugMode) {
        print(ex.message);
      }
      throw ex.response?.data;
    }
  }
}
