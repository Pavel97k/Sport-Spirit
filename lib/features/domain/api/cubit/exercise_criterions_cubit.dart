import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:SportSpirit/features/data/api/models/exercise_criterions.dart';
import 'package:SportSpirit/features/data/api/repositories/exercise_criterions_rep.dart';
import 'package:SportSpirit/features/data/global_service.dart';

part 'exercise_criterions_state.dart';

class ExerciseCriterionsCubit extends Cubit<ExerciseCriterionsState> {
  ExerciseCriterionsCubit() : super(ExerciseCriterionsInitial());

  Future<void> getAllExerciseCriterios(
      {required String page, required String pageSize, bool? logic}) async {
    try {
      final pageInt = int.parse((page == '' ? 0 : page).toString());
      final pageSizeInt = int.parse((pageSize == '' ? 0 : pageSize).toString());
      final data = await service<ExercisesCriterionsRep>()
          .getAllExercisesCriterions(pageInt, pageSizeInt, logic);
      if (data.isNotEmpty) {
        emit(ExerciseCriterionsListLoaded(data));
      }
    } catch (e) {
      emit(ExerciseCriterionsError(e));
    }
  }

  Future<void> getIdExerciseCriterios(int id) async {
    try {
      List<int> timeList = [];
      final data =
          await service<ExercisesCriterionsRep>().getExercisesCriterions(id);

      if (data.executionTime != null) {
        final time = data.executionTime?.split(':');
        for (var element in time!) {
          timeList.add(int.parse(element));
        }
      }

      if (id != 0) {
        timeList.isEmpty
            ? emit(ExerciseCriterionsRepetitionLoaded(data))
            : emit(ExerciseCriterionsTimeLoaded(data, timeList));
      }
    } catch (ex) {
      emit(ExerciseCriterionsError(ex));
    }
  }

  Future<void> deleteLogicExerciseCriterios(
      {required int id, bool? logic, required String token}) async {
    try {
      await service<ExercisesCriterionsRep>()
          .deleteLogicExercisesCriterions(id, token);
      final data = await service<ExercisesCriterionsRep>()
          .getAllExercisesCriterions(0, 0, logic);

      if (data.isNotEmpty) {
        emit(ExerciseCriterionsListLoaded(data));
      }
    } catch (ex) {
      emit(ExerciseCriterionsInitial());
    }
  }

  Future<void> updateLogicExerciseCriterios(
      {required int id, bool? logic, required String token}) async {
    try {
      await service<ExercisesCriterionsRep>()
          .updateLogicExercisesCriterions(id, token);
      final data = await service<ExercisesCriterionsRep>()
          .getAllExercisesCriterions(0, 0, logic);

      if (data.isNotEmpty) {
        emit(ExerciseCriterionsListLoaded(data));
      }
    } catch (ex) {
      emit(ExerciseCriterionsInitial());
    }
  }
}
