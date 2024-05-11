import 'package:json_annotation/json_annotation.dart';

part 'gender.g.dart';

@JsonSerializable()
class Gender {
  final int? idGender;
  final String nameGender;

  Gender({this.idGender, required this.nameGender});

  /// Connect the generated [_$GenderFromJson] function to the `fromJson`
  /// factory.
  factory Gender.fromJson(Map<String, dynamic> json) => _$GenderFromJson(json);

  /// Connect the generated [_$GenderToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GenderToJson(this);
}
