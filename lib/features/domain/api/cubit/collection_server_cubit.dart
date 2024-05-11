import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sport_spirit/features/data/api/repositories/collection_server_rep.dart';
import 'package:sport_spirit/features/data/global_service.dart';

import '../../../data/api/models/collection_server.dart';

part 'collection_server_state.dart';

class CollectionServerCubit extends Cubit<CollectionServerState> {
  CollectionServerCubit() : super(CollectionServerInitial());

  Future<void> getAllCollectionServer(
      {required String page,
      required String pageSize,
      required int gender,
      bool? logic}) async {
    try {
      final pageInt = int.parse((page == '' ? 0 : page).toString());
      final pageSizeInt = int.parse((pageSize == '' ? 0 : pageSize).toString());

      final data = await service<CollectionServerRep>()
          .getAllCollectionServer(pageInt, pageSizeInt, gender, logic);

      if (data.isNotEmpty || pageInt != 0 && pageSizeInt != 0 || gender != 0) {
        emit(CollectionServerLoaded(data));
      }
    } catch (ex) {
      emit(CollectionServerError(ex));
    }
  }

  Future<void> deleteLogicCollectionServer(
      {required int id, bool? logic, required String token}) async {
    try {
      await service<CollectionServerRep>()
          .deleteLogicCollectionServer(id, token);
      final data = await service<CollectionServerRep>()
          .getAllCollectionServer(0, 0, 0, logic);

      if (data.isNotEmpty) {
        emit(CollectionServerLoaded(data));
      }
    } catch (ex) {
      emit(CollectionServerError(ex));
    }
  }

  Future<void> updateLogicCollectionServer(
      {required int id, bool? logic, required String token}) async {
    try {
      await service<CollectionServerRep>()
          .updateLogicCollectionServer(id, token);
      final data = await service<CollectionServerRep>()
          .getAllCollectionServer(0, 0, 0, logic);

      if (data.isNotEmpty) {
        emit(CollectionServerLoaded(data));
      }
    } catch (ex) {
      emit(CollectionServerError(ex));
    }
  }
}
