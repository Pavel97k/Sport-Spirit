// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_criterions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExercisesCriterions _$ExercisesCriterionsFromJson(Map<String, dynamic> json) =>
    ExercisesCriterions(
      idExerciseCriteria: (json['idExerciseCriteria'] as num?)?.toInt(),
      executionTime: json['executionTime'] as String?,
      approaches: (json['approaches'] as num?)?.toInt(),
      repetition: (json['repetition'] as num?)?.toInt(),
      isDeleted: json['isDeleted'] as bool?,
    );

Map<String, dynamic> _$ExercisesCriterionsToJson(
        ExercisesCriterions instance) =>
    <String, dynamic>{
      'idExerciseCriteria': instance.idExerciseCriteria,
      'executionTime': instance.executionTime,
      'approaches': instance.approaches,
      'repetition': instance.repetition,
      'isDeleted': ExercisesCriterions._boolToInt(instance.isDeleted),
    };
