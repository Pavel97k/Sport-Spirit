//import 'package:json_annotation/json_annotation.dart';

part 'local_collection_lite.g.dart';

//@JsonSerializable()
class CollectionLite {
  final int? id; // переопределяем поле и указываем определённый тип
  final String collectionName;
  final String collectionType;
  final String collectionMultiplicity;
  //@JsonKey(fromJson: _intToBool, toJson: _boolToInt)
  final bool availabilityBasicEquipment;
  final String genderName;

  CollectionLite(
      {required this.id,
      required this.collectionName,
      required this.collectionType,
      required this.collectionMultiplicity,
      required this.availabilityBasicEquipment,
      required this.genderName});

  /// Connect the generated [_$CollectionLiteFromJson] function to the `fromJson`
  /// factory.
  factory CollectionLite.fromJson(Map<String, dynamic> json) =>
      _$CollectionLiteFromJson(json);

  /// Connect the generated [_$CollectionLiteToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CollectionLiteToJson(this);

  static bool _intToBool(int value) => value == 1;
  static int _boolToInt(bool value) => value ? 1 : 0;
}
