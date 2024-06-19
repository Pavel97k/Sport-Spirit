import 'package:json_annotation/json_annotation.dart';

part 'administrators.g.dart';

@JsonSerializable()
class Administrator
{
  final int? idAdministrator;

  final String login;

  final String password;

  Administrator({this.idAdministrator, required this.login, required this.password});


  /// Connect the generated [_$AdministratorFromJson] function to the `fromJson`
  /// factory.
  factory Administrator.fromJson(Map<String, dynamic> json) => _$AdministratorFromJson(json);

  /// Connect the generated [_$AdministratorToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AdministratorToJson(this);
}
