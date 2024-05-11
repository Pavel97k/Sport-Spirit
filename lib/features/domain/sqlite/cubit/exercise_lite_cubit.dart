import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sport_spirit/features/data/api/repositories/exercises_rep.dart';
import 'package:sport_spirit/features/data/global_service.dart';
import 'package:sport_spirit/features/data/sqlite/models/local_exercises_lite.dart';
import 'package:sport_spirit/features/data/sqlite/repositories/local_collection_lite_rep.dart';
import 'package:sport_spirit/features/data/sqlite/repositories/local_exercises_lite_rep.dart';

part 'exercise_lite_state.dart';

class ExercisesLiteCubit extends Cubit<ExercisesLiteState> {
  ExercisesLiteCubit() : super(ExerciseLiteInitial());

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

  Future<void> getExerciseLite(int id) async {
    try {
      ExercisesLite item = await service<ExercisesLiteRep>().getItemById(id);
      emit(ExerciseLiteLoaded(item));
    } catch (ex) {
      emit(ExerciseLiteError(ex));
    }
  }

  Future<void> getAllExercisesLite(
      {required String page,
      required String pageSize,
      required int collectionId}) async {
    try {
      final pageInt = int.parse((page == '' ? 0 : page).toString());
      final pageSizeInt = int.parse((pageSize == '' ? 0 : pageSize).toString());
      List<ExercisesLite> items = await service<ExercisesLiteRep>()
          .getAll(pageInt, pageSizeInt, collectionId);
      if (items.isNotEmpty ||
          pageInt != 0 && pageSizeInt != 0 ||
          collectionId != 0) {
        emit(ExerciseLiteListLoaded(data: items));
      }
    } catch (ex) {
      emit(ExerciseLiteError(ex));
    }
  }

  Future<void> selectInsertExercises(
      {required int page,
      required int pageSize,
      required int collectionId}) async {
    try {
      final exercises = await service<ExercisesRep>()
          .getAllExercises(page, pageSize, collectionId: collectionId);
      List<ExercisesLite> exercisesLite = [];
      if (exercises.isNotEmpty) {
        for (var exercise in exercises) {
          exercisesLite.add(
            ExercisesLite(
                id: exercise.idExercise,
                exerciseName: exercise.exerciseName,
                exerciseDescriptions: exercise.exerciseDescriptions,
                muscleGroup: exercise.muscleGroup,
                collectionServerId: exercise.collectionServerId,
                exerciseCriteriaId: exercise.exerciseCriteriaId),
          );
        }
        service<ExercisesLiteCubit>().insertAllExercisesLite(exercisesLite);
      }
    } catch (e) {
      emit(ExerciseLiteError(e.toString()));
    }
  }

  Future<void> createListBoxExercixes(int collectionId) async {
    List<List<ExercisesLite>> boxExercises = [];
    List<ExercisesLite> groupExercises = [];
    int remainingCount = 0;
    int y = -1;

    List<ExercisesLite> exercises =
        await service<ExercisesLiteRep>().getAll(0, 0, collectionId);

    for (int i = 0; i < musclegroup.length; i++) {
      exercises.shuffle();
      if (y >= 3) {
        y = 0;
      } else {
        y++;
      }
      String currentMuscleGroup = musclegroup[i];

      if (countgroup10.length - 1 >= i) {
        remainingCount = countgroup10[y];
      } else {
        boxExercises.add(groupExercises);
        groupExercises = [];
      }

      for (var exercise in exercises) {
        if (exercise.muscleGroup == currentMuscleGroup) {
          groupExercises.add(exercise);
          remainingCount--;

          if (remainingCount == 0) {
            break;
          }
        }
      }

      if (remainingCount > 0) {
        for (var exercise in exercises) {
          if (exercise.muscleGroup == currentMuscleGroup) {
            groupExercises.add(exercise);
            remainingCount--;

            if (remainingCount == 0) {
              break;
            }
          }
        }
      }
    }

    // Refill the lists in boxExercises until they have 10 items
    for (int i = 0; i < boxExercises.length; i++) {
      while (boxExercises[i].length < 10) {
        for (int j = 0; j < musclegroup.length; j++) {
          j = Random.secure().nextInt(10);
          String currentMuscleGroup = musclegroup[j];
          int remainingCount = 10 - boxExercises[i].length;

          // Add exercises from uniqueExercises until the desired count is reached
          if (remainingCount > 0) {
            for (var exercise in exercises) {
              if (exercise.muscleGroup == currentMuscleGroup) {
                boxExercises[i].add(exercise);
                remainingCount--;

                if (remainingCount == 0) {
                  break;
                }
              }
            }
          }

          if (remainingCount > 0) {
            for (var exercise in exercises) {
              if (exercise.muscleGroup == currentMuscleGroup) {
                boxExercises[i].add(exercise);
                remainingCount--;

                if (remainingCount == 0) {
                  break;
                }
              }
            }
          }
        }
      }
    }

    emit(ExerciseLiteListBoxLoaded(boxExercises: boxExercises));
  }

  Future<void> insertExercisesLite(ExercisesLite data) async {
    try {
      List<ExercisesLite> list = [];
      list.add(data);
      await service<ExercisesLiteRep>().insert(list);
    } catch (ex) {
      emit(ExerciseLiteError(ex));
    }
  }

  Future<void> insertAllExercisesLite(List<ExercisesLite> data) async {
    try {
      await service<ExercisesLiteRep>().insert(data);
    } catch (ex) {
      emit(ExerciseLiteError(ex));
    }
  }

  Future<void> deleteCollectionLite(int id) async {
    try {
      await service<CollectionLiteRep>().delete(id);
      getAllExercisesLite(page: '0', pageSize: '0', collectionId: 0);
    } catch (ex) {
      emit(ExerciseLiteError(ex));
    }
  }
}
