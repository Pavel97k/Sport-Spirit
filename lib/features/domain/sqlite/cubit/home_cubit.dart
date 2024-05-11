import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sport_spirit/features/data/global_service.dart';
import 'package:sport_spirit/features/data/sqlite/models/local_collection_lite.dart';
import 'package:sport_spirit/features/data/sqlite/repositories/local_collection_lite_rep.dart';
import 'package:sport_spirit/features/utils/storage/shared_preferences_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getValueKey() async {
    try {
      final id =
          await service<SharedPreferencesHelper>().getInt('Active_program');

      if (id == null) {
        return emit(HomeNaN('id is null'));
      }
      CollectionLite item = await service<CollectionLiteRep>().getItemById(id);
      emit(HomeLoaded(item));
    } on Exception catch (ex) {
      emit(HomeError(ex: ex));
    }
  }
}
