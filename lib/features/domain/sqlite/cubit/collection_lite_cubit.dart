import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:SportSpirit/features/data/global_service.dart';
import 'package:SportSpirit/features/data/sqlite/models/local_collection_lite.dart';
import 'package:SportSpirit/features/data/sqlite/repositories/local_collection_lite_rep.dart';
import 'package:SportSpirit/features/utils/storage/shared_preferences_helper.dart';

part 'collection_lite_state.dart';

class CollectionLiteCubit extends Cubit<CollectionLiteState> {
  CollectionLiteCubit() : super(CollectionLiteInitial());

  Future<void> getCollectionLite(int id) async {
    try {
      CollectionLite item = await service<CollectionLiteRep>().getItemById(id);
      emit(CollectionLiteLoaded(item));
    } catch (ex) {
      emit(CollectionLiteError(ex));
    }
  }

  Future<void> getAllCollectionLite(
      {required String page,
      required String pageSize,
      required int gender}) async {
    try {
      final pageInt = int.parse((page == '' ? 0 : page).toString());
      final pageSizeInt = int.parse((pageSize == '' ? 0 : pageSize).toString());
      List<CollectionLite> items = await service<CollectionLiteRep>()
          .getAll(pageInt, pageSizeInt, gender);
      final id =
          await service<SharedPreferencesHelper>().getInt('Active_program');
      if (items.isNotEmpty || pageInt != 0 && pageSizeInt != 0 || gender != 0) {
        emit(CollectionLiteListLoaded(items, id));
      }
    } catch (ex) {
      emit(CollectionLiteError(ex));
    }
  }

  Future<void> insertCollectionLite(CollectionLite data) async {
    try {
      await service<CollectionLiteRep>().insert(data);
      await getAllCollectionLite(page: '0', pageSize: '0', gender: 0);
    } catch (ex) {
      emit(CollectionLiteError(ex));
    }
  }

  Future<void> deleteCollectionLite(int id) async {
    try {
      await service<CollectionLiteRep>().delete(id);
      await getAllCollectionLite(page: '0', pageSize: '0', gender: 0);
    } catch (ex) {
      emit(CollectionLiteError(ex));
    }
  }
}
