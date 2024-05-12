import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:SportSpirit/features/data/api/core/interceptor_dio.dart';

// Методы для создания, обновления удаления и вывода данных
class ServiceAPI {
  final Dio _dio;
  var basicAuth =
      'Basic ${base64Encode(utf8.encode('11176398:60-dayfreetrial'))}';

  ServiceAPI()
      : _dio = Dio(BaseOptions(
            baseUrl: 'http://alwaysstudent-001-site1.atempurl.com/api/')) {
    _dio.interceptors.add(InterceptorsApp());
  }

  Future<Response> getData(String endpoint, String? token) async {
    try {
      if (token != null || token != '') {
        return await _dio.get(endpoint,
            options: Options(headers: {
              'Authorization': basicAuth,
            }));
      }
      return await _dio.get(endpoint);
    } catch (e) {
      throw Exception('Failed to get data: $e');
    }
  }

  Future<Response> postData(
      String endpoint, Map<String, dynamic> data, String? token) async {
    try {
      if (token != null || token != '') {
        return await _dio.post(endpoint,
            data: data,
            options: Options(headers: {
              'Authorization': basicAuth,
            }));
      }

      return await _dio.post(endpoint, data: data);
    } catch (ex) {
      throw Exception('Failed to post data: $ex');
    }
  }

  Future<Response> putData(
      String endpoint, Map<String, dynamic> data, String? token) async {
    try {
      if (token != null || token != '') {
        return await _dio.put(endpoint,
            data: data,
            options: Options(headers: {
              'Authorization': basicAuth,
            }));
      }
      return await _dio.put(endpoint, data: data);
    } catch (ex) {
      throw Exception('Failed to put data: $ex');
    }
  }

  Future<Response> putLogicData(String endpoint, String? token) async {
    try {
      if (token != null || token != '') {
        return await _dio.put(endpoint,
            options: Options(headers: {
              'Authorization': basicAuth,
            }));
      }
      return await _dio.put(endpoint);
    } catch (ex) {
      throw Exception('Failed to put data: $ex');
    }
  }

  Future<Response> deleteData(String endpoint, String? token) async {
    try {
      if (token != null || token != '') {
        return await _dio.delete(endpoint,
            options: Options(headers: {
              'Authorization': basicAuth,
            }));
      }
      return await _dio.delete(endpoint);
    } catch (ex) {
      throw Exception('Failed to delete data: $ex');
    }
  }
}
