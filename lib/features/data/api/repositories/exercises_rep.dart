import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:SportSpirit/features/data/api/models/exercises.dart';
import 'package:SportSpirit/features/data/api/service/service_api.dart';
import 'package:SportSpirit/features/data/global_service.dart';

class ExercisesRep {
  ExercisesRep();

  Future<List<Exercises>> getAllExercises(int page, int pageSize,
      {bool? unique, bool? having, int? collectionId, bool? logic}) async {
    try {
      unique ??= false;
      having ??= false;
      final response = await service.get<ServiceAPI>().getData(
          'Exercises?page=$page&pageSize=$pageSize&CollectionId=$collectionId&unique=$unique&having=$having&logic=${logic ?? ''}',
          null);
      final List<dynamic> data = response.data;
      return data.map((e) => Exercises.fromJson(e)).toList();
    } on DioException catch (ex) {
      if (kDebugMode) {
        print(ex.message);
      }
      throw ex.response?.data;
    }
  }

  Future<Exercises> getExercises(int id) async {
    try {
      final response =
          await service.get<ServiceAPI>().getData('Exercises/$id', null);
      return Exercises.fromJson(response.data);
    } on DioException catch (ex) {
      if (kDebugMode) {
        print(ex.message);
      }
      throw ex.response?.data;
    }
  }

  Future<Exercises> deleteLogicExercises(int id, String token) async {
    try {
      final response = await service
          .get<ServiceAPI>()
          .deleteData('Exercises/$id?logical=true', token);
      return Exercises.fromJson(response.data);
    } on DioException catch (ex) {
      if (kDebugMode) {
        print(ex.message);
      }
      throw ex.response?.data;
    }
  }

  Future<Exercises> updateLogicExercises(int id, String token) async {
    try {
      final response = await service
          .get<ServiceAPI>()
          .putLogicData('Exercises/logic/$id', token);
      return Exercises.fromJson(response.data);
    } on DioException catch (ex) {
      if (kDebugMode) {
        print(ex.message);
      }
      throw ex.response?.data;
    }
  }
}
