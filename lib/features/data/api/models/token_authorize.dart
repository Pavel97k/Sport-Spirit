import 'package:json_annotation/json_annotation.dart';

part 'token_authorize.g.dart';

@JsonSerializable()
class TokenAuthorize {
  final String token;

  TokenAuthorize({required this.token});

  /// Connect the generated [_$AuthorizationUserFromJson] function to the `fromJson`
  /// factory.
  factory TokenAuthorize.fromJson(Map<String, dynamic> json) =>
      _$TokenAuthorizeFromJson(json);

  /// Connect the generated [_$TokenAuthorizeToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TokenAuthorizeToJson(this);
}
