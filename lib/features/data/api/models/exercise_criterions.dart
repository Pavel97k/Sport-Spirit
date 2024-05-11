import 'package:json_annotation/json_annotation.dart';

part 'exercise_criterions.g.dart';

@JsonSerializable()
class ExercisesCriterions {
  final int? idExerciseCriteria;
  final String? executionTime;
  final int? approaches;
  final int? repetition;
  @JsonKey(toJson: _boolToInt)
  final bool? isDeleted;

  ExercisesCriterions(
      {this.idExerciseCriteria,
      this.executionTime,
      this.approaches,
      this.repetition,
      this.isDeleted});

  /// Connect the generated [_$ExercisesCriterionsFromJson] function to the `fromJson`
  /// factory.
  factory ExercisesCriterions.fromJson(Map<String, dynamic> json) =>
      _$ExercisesCriterionsFromJson(json);

  /// Connect the generated [_$ExercisesCriterionsToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ExercisesCriterionsToJson(this);

  static int _boolToInt(bool? value) {
    if (value == null) {
      return 0;
    } else {
      return value ? 1 : 0;
    }
  }
}
