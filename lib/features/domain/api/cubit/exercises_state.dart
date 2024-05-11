part of 'exercises_cubit.dart';

@immutable
sealed class ExercisesState {}

final class ExercisesInitial extends ExercisesState {}

final class ExercisesLoaded extends ExercisesState {
  final List<Exercises> data;

  ExercisesLoaded(this.data);
}

final class ExercisesBoxLoaded extends ExercisesState {
  final List<List<Exercises>> boxExercises;

  ExercisesBoxLoaded(this.boxExercises);
}

final class ExercisesError extends ExercisesState {
  final Object error;

  ExercisesError(this.error);
}
