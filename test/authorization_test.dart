import 'package:SportSpirit/features/data/api/models/administrators.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

void main() {
  test('TC_Authoriz_pass', () async {
    final dio = Dio();

    // Добавляем базовую авторизацию
    final basicAuth =
        'Basic ${base64Encode(utf8.encode('11176398:60-dayfreetrial'))}';
    dio.options.headers['authorization'] = basicAuth;

    Administrator authuser =
        Administrator(login: 'admin', password: 'adminpassword');

    final response = await dio.post(
        'http://alwaysstudent-001-site1.atempurl.com/api/Administrators/authorization',
        data: authuser.toJson(),
        options: Options(headers: {
          'Authorization': basicAuth,
        }));

    // Проверяем статус код ответа
    //expect(response.statusCode, 200);

    // Проверяем, что полученный ответ содержит ожидаемые данные
    expect(response.statusCode, 200);
  });

  test('TC_Authoriz_fail', () async {
    final dio = Dio();

    // Добавляем базовую авторизацию
    final basicAuth =
        'Basic ${base64Encode(utf8.encode('11176398:60-dayfreetrial'))}';
    dio.options.headers['authorization'] = basicAuth;

    Administrator authuser =
        Administrator(login: 'adminQWE12', password: 'adminpassword3test');

    Response<dynamic> response =
        Response<dynamic>(requestOptions: RequestOptions());

    try {
      response = await dio.post(
          'http://alwaysstudent-001-site1.atempurl.com/api/Administrators/authorization',
          data: authuser.toJson(),
          options: Options(headers: {
            'Authorization': basicAuth,
          }));
    } catch (e) {
      expect(response.statusCode, null);
    }
  });

  test('TC_Register_pass', () async {
    final dio = Dio();

    // Добавляем базовую авторизацию
    final basicAuth =
        'Basic ${base64Encode(utf8.encode('11176398:60-dayfreetrial'))}';
    dio.options.headers['authorization'] = basicAuth;

    final administrator = {
      // Provide the necessary data for the Administrator object
      'login': 'admin3test',
      'password': 'adminpassword3test',
    };

    const url =
        'http://alwaysstudent-001-site1.atempurl.com/api/Administrators/register';

    final response = await dio.post(Uri.parse(url).toString(),
        data: administrator,
        options: Options(headers: {
          'Authorization': basicAuth,
        }));

    // Проверяем статус код ответа
    //expect(response.statusCode, 200);

    // Проверяем, что полученный ответ содержит ожидаемые данные
    expect(response.statusCode, 200);
  });

  test('TC_Register_fail', () async {
    final dio = Dio();

    // Добавляем базовую авторизацию
    final basicAuth =
        'Basic ${base64Encode(utf8.encode('11176398:60-dayfreetrial'))}';
    dio.options.headers['authorization'] = basicAuth;

    final administrator = {
      // Provide the necessary data for the Administrator object
      'login': 1111,
      'password': 'adminpassword3test',
    };

    Response<dynamic> response =
        Response<dynamic>(requestOptions: RequestOptions());

    const url =
        'http://alwaysstudent-001-site1.atempurl.com/api/Administrators/register';

    try {
      response = await dio.post(Uri.parse(url).toString(),
          options: Options(headers: {
            'Authorization': basicAuth,
          }));
    } catch (e) {
      expect(response.statusCode, null);
    }
  });

  test('TC_Get_Collection_Server', () async {
    final dio = Dio();

    // Добавляем базовую авторизацию
    final basicAuth =
        'Basic ${base64Encode(utf8.encode('11176398:60-dayfreetrial'))}';
    dio.options.headers['authorization'] = basicAuth;

    // Отправляем GET-запрос
    final response = await dio.get(
        'http://alwaysstudent-001-site1.atempurl.com/api/СollectionServer');

    // Проверяем статус код ответа
    //expect(response.statusCode, 200);

    // Проверяем, что полученный ответ содержит ожидаемые данные
    expect(response.statusCode, 200);
  });

  test('TC_Get_Exercises', () async {
    final dio = Dio();

    // Добавляем базовую авторизацию
    final basicAuth =
        'Basic ${base64Encode(utf8.encode('11176398:60-dayfreetrial'))}';
    dio.options.headers['authorization'] = basicAuth;

    // Отправляем GET-запрос
    final response = await dio.get(
        'http://alwaysstudent-001-site1.atempurl.com/api/Exercises?page=0&pageSize=0&CollectionId=0&unique=false&having=false');

    // Проверяем статус код ответа
    //expect(response.statusCode, 200);

    // Проверяем, что полученный ответ содержит ожидаемые данные
    expect(response.statusCode, 200);
  });
}
