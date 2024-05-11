part of 'exercise_lite_cubit.dart';

@immutable
sealed class ExercisesLiteState {}

final class ExerciseLiteInitial extends ExercisesLiteState {}

class ExerciseLiteListLoaded extends ExercisesLiteState {
  final List<ExercisesLite> data;

  ExerciseLiteListLoaded({required this.data});
}

class ExerciseLiteListBoxLoaded extends ExercisesLiteState {
  final List<List<ExercisesLite>> boxExercises;

  ExerciseLiteListBoxLoaded({required this.boxExercises});
}

class ExerciseLiteLoaded extends ExercisesLiteState {
  final ExercisesLite data;

  ExerciseLiteLoaded(this.data);
}

final class ExerciseLiteError extends ExercisesLiteState {
  final Object ex;

  ExerciseLiteError(this.ex);
}
