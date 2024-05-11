part of 'exercise_criterions_cubit.dart';

@immutable
sealed class ExerciseCriterionsState {}

final class ExerciseCriterionsInitial extends ExerciseCriterionsState {}

final class ExerciseCriterionsListLoaded extends ExerciseCriterionsState {
  final List<ExercisesCriterions> data;

  ExerciseCriterionsListLoaded(this.data);
}

final class ExerciseCriterionsRepetitionLoaded extends ExerciseCriterionsState {
  final ExercisesCriterions data;

  ExerciseCriterionsRepetitionLoaded(this.data);
}

final class ExerciseCriterionsTimeLoaded extends ExerciseCriterionsState {
  final ExercisesCriterions data;
  final List<int> timeList;

  ExerciseCriterionsTimeLoaded(this.data, this.timeList);
}

final class ExerciseCriterionsError extends ExerciseCriterionsState {
  final Object error;

  ExerciseCriterionsError(this.error);
}
