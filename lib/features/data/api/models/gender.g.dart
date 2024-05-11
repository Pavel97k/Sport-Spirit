// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gender.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Gender _$GenderFromJson(Map<String, dynamic> json) => Gender(
      idGender: (json['idGender'] as num?)?.toInt(),
      nameGender: json['nameGender'] as String,
    );

Map<String, dynamic> _$GenderToJson(Gender instance) => <String, dynamic>{
      'idGender': instance.idGender,
      'nameGender': instance.nameGender,
    };
