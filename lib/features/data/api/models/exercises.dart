import 'package:json_annotation/json_annotation.dart';

part 'exercises.g.dart';

@JsonSerializable()
class Exercises {
  final int? idExercise;
  final String exerciseName;
  final String? exerciseDescriptions;
  final String muscleGroup;
  final int? collectionServerId;
  final int exerciseCriteriaId;
  //@JsonKey(toJson: _boolToInt)
  final bool? isDeleted;

  Exercises(
      {this.idExercise,
      required this.exerciseName,
      this.exerciseDescriptions,
      required this.muscleGroup,
      this.collectionServerId,
      required this.exerciseCriteriaId,
      this.isDeleted});

  /// Connect the generated [_$ExercisesFromJson] function to the `fromJson`
  /// factory.
  factory Exercises.fromJson(Map<String, dynamic> json) =>
      _$ExercisesFromJson(json);

  /// Connect the generated [_$ExercisesToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ExercisesToJson(this);

  static int _boolToInt(bool? value) {
    if (value == null) {
      return 0;
    } else {
      return value ? 1 : 0;
    }
  }
}
