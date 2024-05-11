import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sport_spirit/features/data/api/models/exercise_criterions.dart';
import 'package:sport_spirit/features/data/api/service/service_api.dart';
import 'package:sport_spirit/features/data/global_service.dart';

class ExercisesCriterionsRep {
  ExercisesCriterionsRep();

  Future<List<ExercisesCriterions>> getAllExercisesCriterions(
      int page, int pageSize, bool? logic) async {
    try {
      final response = await service.get<ServiceAPI>().getData(
          'ExerciseCriterions?page=$page&pageSize=$pageSize&logic=${logic ?? ''}',
          null);
      final List<dynamic> data = response.data;
      return data.map((e) => ExercisesCriterions.fromJson(e)).toList();
    } on DioException catch (ex) {
      if (kDebugMode) {
        print(ex.message);
      }
      throw ex.response?.data;
    }
  }

  Future<ExercisesCriterions> getExercisesCriterions(int id) async {
    try {
      final response = await service
          .get<ServiceAPI>()
          .getData('ExerciseCriterions/$id', null);
      return ExercisesCriterions.fromJson(response.data);
    } on DioException catch (ex) {
      if (kDebugMode) {
        print(ex.message);
      }
      throw ex.response?.data;
    }
  }

  Future<ExercisesCriterions> deleteLogicExercisesCriterions(
      int id, String token) async {
    try {
      final response = await service
          .get<ServiceAPI>()
          .deleteData('ExerciseCriterions/$id?logical=true', token);
      return ExercisesCriterions.fromJson(response.data);
    } on DioException catch (ex) {
      if (kDebugMode) {
        print(ex.message);
      }
      throw ex.response?.data;
    }
  }

  Future<ExercisesCriterions> updateLogicExercisesCriterions(
      int id, String token) async {
    try {
      final response = await service
          .get<ServiceAPI>()
          .putLogicData('ExerciseCriterions/logic/$id', token);
      return ExercisesCriterions.fromJson(response.data);
    } on DioException catch (ex) {
      if (kDebugMode) {
        print(ex.message);
      }
      throw ex.response?.data;
    }
  }
}
