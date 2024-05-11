// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_exercises_lite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExercisesLite _$ExercisesLiteFromJson(Map<String, dynamic> json) =>
    ExercisesLite(
      id: (json['id'] as num?)?.toInt(),
      exerciseName: json['exerciseName'] as String,
      exerciseDescriptions: json['exerciseDescriptions'] as String?,
      muscleGroup: json['muscleGroup'] as String,
      collectionServerId: (json['collectionServerId'] as num?)?.toInt(),
      exerciseCriteriaId: (json['exerciseCriteriaId'] as num).toInt(),
    );

Map<String, dynamic> _$ExercisesLiteToJson(ExercisesLite instance) =>
    <String, dynamic>{
      'id': instance.id,
      'exerciseName': instance.exerciseName,
      'exerciseDescriptions': instance.exerciseDescriptions,
      'muscleGroup': instance.muscleGroup,
      'collectionServerId': instance.collectionServerId,
      'exerciseCriteriaId': instance.exerciseCriteriaId,
    };
