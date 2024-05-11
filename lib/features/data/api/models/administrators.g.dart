// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'administrators.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Administrator _$AdministratorFromJson(Map<String, dynamic> json) =>
    Administrator(
      idAdministrator: (json['idAdministrator'] as num?)?.toInt(),
      login: json['login'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$AdministratorToJson(Administrator instance) =>
    <String, dynamic>{
      'idAdministrator': instance.idAdministrator,
      'login': instance.login,
      'password': instance.password,
    };
