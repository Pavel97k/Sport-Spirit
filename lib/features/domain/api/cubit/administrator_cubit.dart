import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sport_spirit/features/data/api/models/administrators.dart';
import 'package:sport_spirit/features/data/api/models/token_authorize.dart';
import 'package:sport_spirit/features/data/api/repositories/adminstrators_rep.dart';
import 'package:sport_spirit/features/data/global_service.dart';

part 'administrator_state.dart';

class AdministratorCubit extends Cubit<AdministratorState> {
  AdministratorCubit() : super(AdministratorInitial());

  Future<void> loginAdministrators(String login, String password) async {
    try {
      final admin = Administrator(login: login, password: password);
      final data = await service.get<AdministratorsRep>().authorization(admin);
      emit(AuthorizationLoaded(data));
    } catch (ex) {
      emit(AuthorizationError());
    }
  }
}
