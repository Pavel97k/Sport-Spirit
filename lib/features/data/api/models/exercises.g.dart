// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercises.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercises _$ExercisesFromJson(Map<String, dynamic> json) => Exercises(
      idExercise: (json['idExercise'] as num?)?.toInt(),
      exerciseName: json['exerciseName'] as String,
      exerciseDescriptions: json['exerciseDescriptions'] as String?,
      muscleGroup: json['muscleGroup'] as String,
      collectionServerId: (json['collectionServerId'] as num?)?.toInt(),
      exerciseCriteriaId: (json['exerciseCriteriaId'] as num).toInt(),
      isDeleted: json['isDeleted'] as bool?,
    );

Map<String, dynamic> _$ExercisesToJson(Exercises instance) => <String, dynamic>{
      'idExercise': instance.idExercise,
      'exerciseName': instance.exerciseName,
      'exerciseDescriptions': instance.exerciseDescriptions,
      'muscleGroup': instance.muscleGroup,
      'collectionServerId': instance.collectionServerId,
      'exerciseCriteriaId': instance.exerciseCriteriaId,
      'isDeleted': Exercises._boolToInt(instance.isDeleted),
    };
