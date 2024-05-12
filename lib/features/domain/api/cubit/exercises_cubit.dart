import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:SportSpirit/features/data/api/models/exercises.dart';
import 'package:SportSpirit/features/data/api/repositories/exercises_rep.dart';
import 'package:SportSpirit/features/data/global_service.dart';

part 'exercises_state.dart';

class ExercisesCubit extends Cubit<ExercisesState> {
  ExercisesCubit() : super(ExercisesInitial());

  List<String> musclegroup = [
    'Растяжка',
    'Кардио',
    'Ноги',
    'Спина',
    'Грудь',
    'Руки Бицепс',
    'Руки Трицепс',
    'Пресс',
    'Дельты',
    'Функциональное'
  ];

  List<int> countgroup10 = [4, 2, 2, 2];

  Future<void> getAllExercises(int page, int pageSize,
      {int? collectionId, bool? unique, bool? having, bool? logic}) async {
    try {
      final data = await service<ExercisesRep>().getAllExercises(page, pageSize,
          collectionId: collectionId, unique: unique, logic: logic);
      emit(ExercisesLoaded(data));
    } catch (ex) {
      emit(ExercisesError(ex));
    }
  }

  Future<void> deleteLogicExercises(
      {required int id, bool? logic, required String token}) async {
    try {
      await service<ExercisesRep>().deleteLogicExercises(id, token);
      final data =
          await service<ExercisesRep>().getAllExercises(0, 0, logic: logic);

      if (data.isNotEmpty) {
        emit(ExercisesLoaded(data));
      }
    } catch (ex) {
      emit(ExercisesError(ex));
    }
  }

  Future<void> updateLogicExercises(
      {required int id, bool? logic, required String token}) async {
    try {
      await service<ExercisesRep>().updateLogicExercises(id, token);
      final data =
          await service<ExercisesRep>().getAllExercises(0, 0, logic: logic);

      if (data.isNotEmpty) {
        emit(ExercisesLoaded(data));
      }
    } catch (ex) {
      emit(ExercisesError(ex));
    }
  }
}
