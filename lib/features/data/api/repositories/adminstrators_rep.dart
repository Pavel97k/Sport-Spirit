import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sport_spirit/features/data/api/models/administrators.dart';
import 'package:sport_spirit/features/data/api/models/token_authorize.dart';
import 'package:sport_spirit/features/data/global_service.dart';

import '../service/service_api.dart';

class AdministratorsRep {
  AdministratorsRep();

  Future<TokenAuthorize> authorization(Administrator authuser) async {
    try {
      final response = await service
          .get<ServiceAPI>()
          .postData('Administrators/authorization', authuser.toJson(), null);
      return TokenAuthorize.fromJson(response.data);
    } on DioException catch (ex) {
      if (kDebugMode) {
        print(ex.message);
      }
      throw ex.response?.data;
    }
  }
}
