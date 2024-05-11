import 'package:json_annotation/json_annotation.dart';

part 'local_exercises_lite.g.dart';

@JsonSerializable()
class ExercisesLite {
  final int? id;
  final String exerciseName;
  final String? exerciseDescriptions;
  final String muscleGroup;
  final int? collectionServerId;
  final int exerciseCriteriaId;

  ExercisesLite({
    required this.id,
    required this.exerciseName,
    required this.exerciseDescriptions,
    required this.muscleGroup,
    required this.collectionServerId,
    required this.exerciseCriteriaId,
  });

  /// Connect the generated [_$ExercisesLiteFromJson] function to the `fromJson`
  /// factory.
  factory ExercisesLite.fromJson(Map<String, dynamic> json) =>
      _$ExercisesLiteFromJson(json);

  /// Connect the generated [_$ExercisesLiteToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ExercisesLiteToJson(this);
}
